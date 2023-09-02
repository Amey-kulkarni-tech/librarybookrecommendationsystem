<?php

session_start();
$con="";
$db="lradatabase";
$server="localhost";
$pwd="abc12345";
$usr="root";
$port=3306;
$con=mysqli_connect($server,$usr,$pwd,$db,$port);
if(mysqli_connect_error())
{
    echo "<script>alert('Falied to load');</script>";
    exit();
}


?>