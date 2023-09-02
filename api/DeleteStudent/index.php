<?php

include("../config.php");

if(isset($_GET["id"]))
{
 $query="update student_details_master set stud_status=0 where id=".$_GET["id"]."";
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