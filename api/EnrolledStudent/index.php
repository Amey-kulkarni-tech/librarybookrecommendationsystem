<?php

include("../config.php");

// Query to fetch student details
$sql = "SELECT id, student_id, stud_firstname, stud_lastname, stud_mobile FROM student_details_master where stud_status=1 order by RAND()";

$result = $con->query($sql);

// Initialize an array to store student data
$students = array();

if ($result->num_rows > 0) {
    // Fetch rows and add to the students array
    while ($row = $result->fetch_assoc()) {
        $students[] = $row;
    }
}

// Close the database connection
$con->close();

// Set the response header to indicate JSON content
header('Content-Type: application/json');

// Return the student data as JSON
echo json_encode($students);

?>