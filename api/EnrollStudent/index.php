<?php
// Set up MySQL connection
include("../config.php");

// Function to register a new student
function registerStudent($sid, $fname, $lname, $smob, $status, $con)
{
    $sql = "INSERT INTO student_details_master (student_id, stud_firstname, stud_lastname, stud_mobile, stud_status) VALUES (?, ?, ?, ?, ?)";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("ssssi", $sid, $fname, $lname, $smob, $status);
    
    
    if ($stmt->execute()) {
        // Insert a record in the login_master table with default password "123"
        $insertLoginQuery = "INSERT INTO login_master (stud_id, password) VALUES (?, '123')";
        $stmtInsertLogin = $con->prepare($insertLoginQuery);
        $stmtInsertLogin->bind_param("s", $sid);

        if ($stmtInsertLogin->execute()) {
            $stmtInsertLogin->close();
            return true;
        } else {
            $stmtInsertLogin->close();
            return false;
        }
    } else {
        return false;
    }//change upto this part  table is added to the database.txt
}


if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    
    $sid = $_GET['studid'];
    $fname = $_GET['fname'];
    $lname = $_GET['lname'];
    $smob = $_GET['studmob'];
    
    $registrationStatus = registerStudent($sid, $fname, $lname, $smob, 1, $con);
    
    $response = array();
    if ($registrationStatus) {
        $response['success'] = true;
        $response['message'] = "Student registered successfully!";
    } else {
        $response['success'] = false;
        $response['message'] = "Failed to register student.";
    }

    // Send the JSON response
    header('Content-Type: application/json');
    echo json_encode($response);
}

// Close the MySQL connection
$con->close();
?>