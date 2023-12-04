<?php
// Set up MySQL connection
include("../config.php");

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $token = $_GET['token'];
    $book_id = $_GET['bookId'];

    // Fetch stud_id from login_master based on the token
    $selectStudIdQuery = "SELECT stud_id FROM login_master WHERE token = ?";
    $stmtSelectStudId = $con->prepare($selectStudIdQuery);
    if (!$stmtSelectStudId) {
        die("Error preparing select query: " . $con->error);
    }

    $stmtSelectStudId->bind_param("s", $token);
    $stmtSelectStudId->execute();
    $stmtSelectStudId->bind_result($stud_id);
    $stmtSelectStudId->fetch();
    $stmtSelectStudId->close(); // Close the statement after fetching

    if ($stud_id) {
        // Check if the record exists in stud_book_map
        $checkRecordQuery = "SELECT COUNT(*) FROM stud_book_map WHERE stud_id = ? AND book_id = ?";
        $stmtCheckRecord = $con->prepare($checkRecordQuery);
        if (!$stmtCheckRecord) {
            die("Error preparing select query: " . $con->error);
        }

        $stmtCheckRecord->bind_param("si", $stud_id, $book_id);
        $stmtCheckRecord->execute();
        $stmtCheckRecord->bind_result($recordCount);
        $stmtCheckRecord->fetch();
        $stmtCheckRecord->close(); // Close the statement after fetching

        if ($recordCount > 0) {
            // Update the existing record
            $updateLikeQuery = "UPDATE stud_book_map SET islike = ? WHERE stud_id = ? AND book_id = ?";
            $stmtUpdateLike = $con->prepare($updateLikeQuery);
            if (!$stmtUpdateLike) {
                die("Error preparing update query: " . $con->error);
            }

            $liked = 0;
            $stmtUpdateLike->bind_param("iii", $liked, $stud_id, $book_id);
            $stmtUpdateLike->execute();
            $stmtUpdateLike->close(); // Close the statement after updating
            $response = array(
                "success" => true,
                "message" => "Book liked successfully!"
            );
        } else {
            // Insert a new record
            $insertLikeQuery = "INSERT INTO stud_book_map (stud_id, book_id, islike) VALUES (?, ?, ?)";
            $stmtInsertLike = $con->prepare($insertLikeQuery);
            if (!$stmtInsertLike) {
                die("Error preparing insert query: " . $con->error);
            }

            $liked = 0;
            $stmtInsertLike->bind_param("sii", $stud_id, $book_id, $liked);
            $stmtInsertLike->execute();
            $stmtInsertLike->close(); // Close the statement after inserting
            $response = array(
                "success" => true,
                "message" => "Book liked successfully!"
            );
        }
    } else {
        $response = array(
            "success" => false,
            "message" => "Invalid token."
        );
    }

    // Send the JSON response
    header('Content-Type: application/json');
    echo json_encode($response);
}

// Close the MySQL connection
$con->close();
?>