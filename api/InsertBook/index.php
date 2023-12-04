<?php
// // Set up MySQL connection
// include("../config.php");

// // Check connection

// // API endpoint to add a new book
// if ($_SERVER['REQUEST_METHOD'] === 'GET') {
//     $bname = $_GET['bname'];
//     $aname = $_GET['aname'];
//     $price = $_GET['price'];
//     $tags = $_GET['tags'];

//     // Add book to book_master table
//     $insertBookQuery = "INSERT INTO book_master1 (bname, aname, price) VALUES (?, ?, ?)";
//     $stmt = $con->prepare($insertBookQuery);
//     if (!$stmt) {
//         echo "Prepare error: " . $con->error;
//     } else {
//         // Bind the parameters
//         $stmt->bind_param("sss", $bname, $aname, $price);

//         // Execute the statement
//         if ($stmt->execute()) {
//             $bookId = $stmt->insert_id;

//             // Process tags
//             $tagsArr = explode(",", $tags);
//             foreach ($tagsArr as $tag) {
//                 $tag = trim($tag);

//                 if (!empty($tag)) {
//                     // Check if tag already exists in tag_master
//                     $tagId = getTagId($con, $tag);

//                     // If tag doesn't exist, insert into tag_master
//                     if (!$tagId) {
//                         $tagId = insertTag($con, $tag);
//                     }

//                     // Insert tag association into tag_map
//                     if ($tagId) {
//                         insertTagMap($con, $tagId, $bookId);
//                     }
//                 }
//             }

//             echo "True";
//         } else {
//             echo "Execute error: " . $stmt->error;
//         }

//         // Close the statement
//         $stmt->close();
//     }

//     // Close the MySQL connection
//     $con->close();
// }

// function getTagId($con, $tag) {
//     $selectTagIdQuery = "SELECT id FROM tag_master WHERE tag_name = ?";
//     $stmt = $con->prepare($selectTagIdQuery);
//     $stmt->bind_param("s", $tag);
//     $stmt->execute();
//     $stmt->bind_result($tagId);
//     $stmt->fetch();
//     $stmt->close();
//     return $tagId;
// }

// function insertTag($con, $tag) {
//     $insertTagQuery = "INSERT INTO tag_master (tag_name) VALUES (?)";
//     $stmt = $con->prepare($insertTagQuery);
//     $stmt->bind_param("s", $tag);
//     $stmt->execute();
//     $tagId = $stmt->insert_id;
//     $stmt->close();
//     return $tagId;
// }

// function insertTagMap($con, $tagId, $bookId) {
//     $insertTagMapQuery = "INSERT INTO tag_map (tid, bid) VALUES (?, ?)";
//     $stmt = $con->prepare($insertTagMapQuery);
//     $stmt->bind_param("ii", $tagId, $bookId);
//     $stmt->execute();
//     $stmt->close();
// }
?>




<?php
// Set up MySQL connection
include("../config.php");

// Check connection

// API endpoint to add a new book
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $bname = $_GET['bname'];
    $aname = $_GET['aname'];
    $price = $_GET['price'];
    $tags = $_GET['tags'];

    // Add book to book_master table
    $insertBookQuery = "INSERT INTO book_master1 (bname, aname, price) VALUES (?, ?, ?)";
    $stmt = $con->prepare($insertBookQuery);
    if (!$stmt) {
        echo "Prepare error: " . $con->error;
    } else {
        // Bind the parameters
        $stmt->bind_param("sss", $bname, $aname, $price);

        // Execute the statement
        if ($stmt->execute()) {
            $bookId = $stmt->insert_id;

            // Insert book into stud_book_map for all users
            insertBookIntoStudBookMap($con, $bookId);

            // Process tags
            $tagsArr = explode(",", $tags);
            foreach ($tagsArr as $tag) {
                $tag = trim($tag);

                if (!empty($tag)) {
                    // Check if tag already exists in tag_master
                    $tagId = getTagId($con, $tag);

                    // If tag doesn't exist, insert into tag_master
                    if (!$tagId) {
                        $tagId = insertTag($con, $tag);
                    }

                    // Insert tag association into tag_map
                    if ($tagId) {
                        insertTagMap($con, $tagId, $bookId);
                    }
                }
            }

            echo "True";
        } else {
            echo "Execute error: " . $stmt->error;
        }

        // Close the statement
        $stmt->close();
    }

    // Close the MySQL connection
    $con->close();
}

function insertBookIntoStudBookMap($con, $bookId) {
    // Get all stud_ids from stud_details_master
    $selectStudIdsQuery = "SELECT student_id FROM student_details_master";
    $result = $con->query($selectStudIdsQuery);

    if ($result) {
        // Insert book into stud_book_map for each user
        while ($row = $result->fetch_assoc()) {
            $studId = $row['student_id'];
            $islike = 0;

            $insertStudBookMapQuery = "INSERT INTO stud_book_map (stud_id, book_id, islike) VALUES (?, ?, ?)";
            $stmt = $con->prepare($insertStudBookMapQuery);
            $stmt->bind_param("sii", $studId, $bookId, $islike);
            $stmt->execute();
            $stmt->close();
        }

        $result->free(); // Free the result set
    } else {
        echo "Error fetching stud_ids: " . $con->error;
    }
}

function getTagId($con, $tag) {
    $selectTagIdQuery = "SELECT id FROM tag_master WHERE tag_name = ?";
    $stmt = $con->prepare($selectTagIdQuery);
    $stmt->bind_param("s", $tag);
    $stmt->execute();
    $stmt->bind_result($tagId);
    $stmt->fetch();
    $stmt->close();
    return $tagId;
}

function insertTag($con, $tag) {
    $insertTagQuery = "INSERT INTO tag_master (tag_name) VALUES (?)";
    $stmt = $con->prepare($insertTagQuery);
    $stmt->bind_param("s", $tag);
    $stmt->execute();
    $tagId = $stmt->insert_id;
    $stmt->close();
    return $tagId;
}

function insertTagMap($con, $tagId, $bookId) {
    $insertTagMapQuery = "INSERT INTO tag_map (tid, bid) VALUES (?, ?)";
    $stmt = $con->prepare($insertTagMapQuery);
    $stmt->bind_param("ii", $tagId, $bookId);
    $stmt->execute();
    $stmt->close();
}
?>
