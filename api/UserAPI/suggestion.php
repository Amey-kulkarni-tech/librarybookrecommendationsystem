<?php
// Set up MySQL connection
include("../config.php");

// Check connection
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $count = 1;
    $token = $_GET['token'];

    // Fetch stud_id from login_master based on the token
    $selectStudIdQuery = "SELECT stud_id FROM library.login_master WHERE token = ?";
    $stmtSelectStudId = $con->prepare($selectStudIdQuery);
    if (!$stmtSelectStudId) {
        die("Error preparing select query: " . $con->error);
    }

    $stmtSelectStudId->bind_param("s", $token);
    $stmtSelectStudId->execute();
    $stmtSelectStudId->bind_result($stud_id);
    $stmtSelectStudId->fetch();
    $stmtSelectStudId->close(); // Close the statement after fetching

    $book_ids = array(); // Array to store multiple book_id values

    if ($stud_id) {
        // Fetch book_ids and islike from stud_book_map based on the stud_id
        $selectBookIdsQuery = "SELECT book_id, islike FROM library.stud_book_map WHERE stud_id = ?";
        $stmtSelectBookIds = $con->prepare($selectBookIdsQuery);
        if (!$stmtSelectBookIds) {
            die("Error preparing select query: " . $con->error);
        }

        $stmtSelectBookIds->bind_param("i", $stud_id);
        $stmtSelectBookIds->execute();
        $resultBookIds = $stmtSelectBookIds->get_result();
        echo " ";

        // Fetch and store multiple book_ids and their islike status
        $book_likes = array();
        while ($rowBookId = $resultBookIds->fetch_assoc()) {
            $book_likes[] = array(
                "book_id" => $rowBookId['book_id'],
                "islike" => $rowBookId['islike']
            );
        }

        $stmtSelectBookIds->close(); // Close the statement after fetching
        $book_ids = array_unique(array_column($book_likes, 'book_id'));

        // Fetch related book suggestions based on the list of likedBookIds and similar tags
        $relatedBooks = array();

        foreach ($book_ids as $likedBookId) {
            // Fetch similar books based on tags
            $tagsQuery = "SELECT tag_master.id, tag_name FROM library.tag_master INNER JOIN library.tag_map ON tag_master.id = tag_map.tid WHERE tag_map.bid = ?";
            $stmtTags = $con->prepare($tagsQuery);
            if (!$stmtTags) {
                die("Error preparing tags query: " . $con->error);
            }

            $stmtTags->bind_param("i", $likedBookId);
            $stmtTags->execute();
            $resultTags = $stmtTags->get_result();
            $tags = [];
            $tagIds = []; // Array to store tag IDs

            while ($tagRow = $resultTags->fetch_assoc()) {
                $tags[] = array(
                    "id" => $tagRow['id'],
                    "tag_name" => $tagRow['tag_name']
                );
                $tagIds[] = $tagRow['id'];
                //echo "<script>alert('Tag ID: $tagIds');</script>";
            }

            $stmtTags->close(); // Close the statement after fetching tags
        

            // Fetch related books based on tags
            $relatedBooksQuery = "SELECT bm.*
            FROM library.book_master1 bm
            INNER JOIN library.tag_map tm ON bm.id = tm.bid
            INNER JOIN library.tag_master t ON tm.tid = t.id
            WHERE t.id IN (" . implode(',', array_fill(0, count($tagIds), '?')) . ")";
            $stmtRelatedBooks = $con->prepare($relatedBooksQuery);
       
            // Bind the tag IDs as parameters
            $tagTypes = str_repeat('i', count($tagIds));
            $stmtRelatedBooks->bind_param($tagTypes, ...$tagIds);

            $stmtRelatedBooks->execute();
            $resultRelatedBooks = $stmtRelatedBooks->get_result();

            while ($rowRelatedBook = $resultRelatedBooks->fetch_assoc()) {
                $relatedBooks[] = array(
                    "id" => $rowRelatedBook['id'],
                    "bname" => $rowRelatedBook['bname'],
                    "aname" => $rowRelatedBook['aname'],
                    "price" => $rowRelatedBook['price'],
                    "tags" => $tags, // Use the fetched tags here
                    "islike" => getIsLikeStatus($book_likes, $rowRelatedBook['id']) // Set islike status to 0 for related books
                );
            }

            $stmtRelatedBooks->close(); // Close the statement after fetching related books
        }

        // Shuffle the related books array
        shuffle($relatedBooks);

        // // Fetch remaining books that are not in the suggested book_ids
        // $remainingBooksQuery = "SELECT * FROM library.book_master1 WHERE id NOT IN (" . implode(",", $book_ids) . ")";

        $remainingBooksQuery = "SELECT * FROM library.book_master1";

        $resultRemainingBooks = mysqli_query($con, $remainingBooksQuery);

        $remainingBooks = array();
        while ($rowRemainingBook = mysqli_fetch_assoc($resultRemainingBooks)) {
            // Fetch associated tags for each remaining book
            $remainingTagsQuery = "SELECT tag_master.id, tag_name FROM library.tag_master INNER JOIN library.tag_map ON tag_master.id = tag_map.tid WHERE tag_map.bid = " . $rowRemainingBook['id'];
            $resultRemainingTags = mysqli_query($con, $remainingTagsQuery);

            $remainingTags = [];
            while ($tagRow = mysqli_fetch_assoc($resultRemainingTags)) {
                $remainingTags[] = array(
                    "id" => $tagRow['id'],
                    "tag_name" => $tagRow['tag_name']
                );
            }

            // Get islike status for the current remaining book_id
            $islike = getIsLikeStatus($book_likes, $rowRemainingBook['id']);

            // Store remaining book details and associated tags in the remainingBooks array
            $remainingBooks[] = array(
                "id" => $rowRemainingBook['id'],
                "bname" => $rowRemainingBook['bname'],
                "aname" => $rowRemainingBook['aname'],
                "price" => $rowRemainingBook['price'],
                "tags" => $remainingTags,
                "islike" => $islike
            );
        }

        // Shuffle the remaining books array
        shuffle($remainingBooks);

        // Merge related books and remaining books into the response array
        $response = array(
            "success" => true,
            "message" => "Book suggestions fetched successfully!",
            "suggestions" => $relatedBooks,
            "data" => $remainingBooks
        );

        // Send the JSON response
        header('Content-Type: application/json');
        echo json_encode($response);

        // Close the MySQL connection
        $con->close();
    } else {
        $response = array(
            "success" => false,
            "message" => "Invalid token."
        );

        // Send the JSON response for invalid token
        header('Content-Type: application/json');
        echo json_encode($response);
    }
}

// Function to get the islike status for a specific book_id
function getIsLikeStatus($book_likes, $book_id)
{
    foreach ($book_likes as $book_like) {
        if ($book_like["book_id"] == $book_id) {
            return $book_like["islike"];
        }
    }
    return 0; // Return 0 if the book_id is not found in the array
}
?>
