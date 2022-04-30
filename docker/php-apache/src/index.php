<?php
 
var_dump("Hi, you're on ".getenv('APP_URL'));
 
$dbhost = getenv('DB_HOST');
$dbuser = getenv('DB_USER');
$dbpass = getenv('DB_PASS');
 
$conn = mysqli_connect($dbhost, $dbuser, $dbpass);
mysqli_select_db($conn, "dbapp");
if (!$conn) {
   var_dump("Connection failed: ".mysqli_connect_error());
   exit('bye');
}

var_dump("Successful database connection!");


if(isset($_GET['view']))
{
   $sql = "SELECT * FROM tblone ORDER BY RAND() LIMIT ".intval($_GET['view']);  
}else{
   $result = md5(rand());
   $insert_sql = "INSERT INTO tblone (name, value) VALUES('".$result."', '".round((float)rand() / (float)getrandmax()*100, 2)."')";
   if ($conn->query($insert_sql) === TRUE) {
      echo "New record created successfully";
    } else {
      echo "Error: " . $sql . "<br>" . $conn->error;
    }
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
   echo "No results";
}

$conn->close();

?>