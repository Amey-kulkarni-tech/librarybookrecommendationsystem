<?php

include("../config.php");

if(isset($_GET["fname"]) && isset($_GET["studid"]) && isset($_GET["studmob"]) && isset($_GET["lname"]))
{
 $query="insert into student_details_master(student_id,stud_firstname,stud_lastname,stud_mobile,stud_status) values('".$_GET["studid"]."','".$_GET["fname"]."','".$_GET["lname"]."','".$_GET["studmob"]."',1);";

 if(mysqli_query($con,$query))
 {
    echo "True";
 }
  else {
    echo "False";
  }

}
else
{
    echo "False";
}








?>