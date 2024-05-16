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

$folderId = $_GET['id_folder'];

$sql = "SELECT * FROM topics WHERE folder_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $folderId);
$stmt->execute();
$result = $stmt->get_result();

$topics = array();
while($row = $result->fetch_assoc()) {
    $topics[] = $row;
}

echo json_encode($topics);

$stmt->close();
$conn->close();
?>