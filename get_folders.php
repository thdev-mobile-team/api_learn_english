<?php
header('Content-Type: application/json');

$servername = "localhost";
$username = "root";
$password = "";
$database = "lea";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM folders";
$result = $conn->query($sql);

$folders = array();
while($row = $result->fetch_assoc()) {
    $folders[] = $row;
}

echo json_encode($folders);

$conn->close();
?>