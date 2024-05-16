<?php
header("Content-Type: application/json; charset=UTF-8");
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "lea";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode(['error' => 'Database connection failed']));
}

$id_vocabulary = $_GET['id_vocabulary'];
$sql = "SELECT id_vocabulary, eng_vocabulary, vn_vocabulary, audio_url FROM vocabularies WHERE id_vocabulary = $id_vocabulary";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo json_encode($row);
} else {
    echo json_encode(['error' => 'No vocabulary found']);
}

$conn->close();
?>