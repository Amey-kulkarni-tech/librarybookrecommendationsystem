<?php
// Set up MySQL connection
include("../config.php");

// Include JWT library
require 'vendor/autoload.php'; // Make sure to include the correct path to the JWT library

use Firebase\JWT\JWT;

// Function to check student login and generate JWT token
function studentLogin($stud_id, $password, $con)
{
    // Check student login
    $checkLoginQuery = "SELECT stud_id, password FROM login_master WHERE stud_id = ?";
    $stmtCheckLogin = $con->prepare($checkLoginQuery);
    $stmtCheckLogin->bind_param("s", $stud_id);
    $stmtCheckLogin->execute();
    $result = $stmtCheckLogin->get_result();

    if ($result->num_rows === 1) {
        $row = $result->fetch_assoc();
        if ($password === $row['password']) {
            // Student login is valid, generate JWT token
            $secret_key = "your_secret_key"; // Change this to your own secret key
            $payload = array(
                "stud_id" => $stud_id
            );
            $token = JWT::encode($payload, $secret_key, 'HS256'); // Use appropriate algorithm

            // Update login_master table with the generated token
            $updateTokenQuery = "UPDATE login_master SET token = ? WHERE stud_id = ?";
            $stmtUpdateToken = $con->prepare($updateTokenQuery);
            $stmtUpdateToken->bind_param("ss", $token, $stud_id);
            $stmtUpdateToken->execute();

            return $token;
        }
    }

    return false;
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    
    $stud_id = $_GET['stud_id'];
    $password = $_GET['password'];
    
    $token = studentLogin($stud_id, $password, $con);
    
    $response = array();
    if ($token) {

        $retrieveStudentQuery = "SELECT student_id,stud_firstname, stud_lastname, stud_mobile FROM student_details_master WHERE student_id = ?";
        $stmtRetrieveStudent = $con->prepare($retrieveStudentQuery);
        $stmtRetrieveStudent->bind_param("s", $stud_id);
        $stmtRetrieveStudent->execute();
        $stmtRetrieveStudent->bind_result($sid,$fname, $lname, $mob);
        $stmtRetrieveStudent->fetch();
        $stmtRetrieveStudent->close();


        $response['success'] = true;
        $response['message'] = "Login successful!";
        $response['token'] = $token;
        $response['student_details'] = array(
            "sid"=> $sid,
            "fname" => $fname,
            "lname" => $lname,
            "mob" => $mob
        );
    } else {
        $response['success'] = false;
        $response['message'] = "Login failed.";
    }

    // Send the JSON response
    header('Content-Type: application/json');
    echo json_encode($response);
}

// Close the MySQL connection
$con->close();
?>