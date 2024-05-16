<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "lea";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$type = $_GET['type'];

if ($type == 'folders') {
    $sql = "SELECT * FROM folders";
    $result = $conn->query($sql);

    $folders = array();
    while ($row = $result->fetch_assoc()) {
        $folders[] = $row;
    }
    echo json_encode($folders);
} else if ($type == 'topics') {
    $id_folder = $_GET['id_folder'];
    $sql = "SELECT * FROM topics WHERE id_folder = $id_folder";
    $result = $conn->query($sql);

    $topics = array();
    while ($row = $result->fetch_assoc()) {
        $topics[] = $row;
    }
    echo json_encode($topics);
} else if ($type == 'vocabulary') {
    $id_topic = $_GET['id_topic'];
    $sql = "SELECT * FROM vocabulary WHERE id_topic = $id_topic";
    $result = $conn->query($sql);

    $vocabulary = array();
    while ($row = $result->fetch_assoc()) {
        $vocabulary[] = $row;
    }
    echo json_encode($vocabulary);
}

$conn->close();
?>