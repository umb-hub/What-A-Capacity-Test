<?php
 
error_reporting(E_ALL);
ini_set('display_errors', 'on');

function handle_error ($errno, $errstr, $errfile, $errline){
    header('HTTP/1.1 500 Internal Server Error');
    exit(0);
}

set_error_handler("handle_error");
 
$dbhost = getenv('DB_HOST');
$dbuser = getenv('DB_USER');
$dbpass = getenv('DB_PASS');
 
$conn = mysqli_connect($dbhost, $dbuser, $dbpass);
mysqli_select_db($conn, "dbapp");
if (!$conn) {
   header($_SERVER['SERVER_PROTOCOL'] . ' 500 Internal Server Error', true, 500);
   var_dump("Connection failed: ".mysqli_connect_error());
   die('bye');
}


if(isset($_GET['read']))
{
   $sql = "SELECT * FROM tblone ORDER BY RAND() LIMIT ".intval($_GET['read']);  
}elseif(isset($_GET['write'])){
   for($i=0;$i<intval($_GET['write']);$i++){
      $result = md5(rand());
      $insert_sql = "INSERT INTO tblone (name, value) VALUES('".$result."', '".round((float)rand() / (float)getrandmax()*100, 2)."')";
      if ($conn->query($insert_sql) === false) {
         header($_SERVER['SERVER_PROTOCOL'] . ' 500 Internal Server Error', true, 500);
      }
   }
   $sql = "SELECT * FROM tblone ORDER BY RAND() LIMIT 20";
}else{
   $sql = "SELECT * FROM tblone ORDER BY RAND() LIMIT 20";
}

$result = $conn->query($sql);

if ($result->num_rows > 0) {
   echo "<table><tr><th>ID</th><th>Name</th><th>Value</th><th>Timestamp</th></tr>";
   // output data of each row
   while($row = $result->fetch_assoc()) {
       echo "<tr><td>".$row["id"]."</td><td>".$row["name"]."</td><td>".$row["value"]."</td><td>".$row["timestamp"]."</td></tr>";
   }
   echo "</table>";
} else {
   header($_SERVER['SERVER_PROTOCOL'] . ' 500 Internal Server Error', true, 500);
}

$conn->close();

?>