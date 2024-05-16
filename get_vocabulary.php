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

$topicId = $_GET['id_topic'];

$sql = "SELECT * FROM vocabulary WHERE topic_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $topicId);
$stmt->execute();
$result = $stmt->get_result();

$vocabulary = array();
while($row = $result->fetch_assoc()) {
    $vocabulary[] = $row;
}

echo json_encode($vocabulary);

$stmt->close();
$conn->close();
?>