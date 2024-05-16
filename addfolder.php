<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "lea";

// Tạo kết nối
$conn = new mysqli($servername, $username, $password, $dbname);

// Kiểm tra kết nối
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

header('Content-Type: application/json');

// Hàm để xử lý lỗi và gửi phản hồi JSON
function sendError($message) {
    echo json_encode(['status' => 'error', 'message' => $message]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    if (!$data || !isset($data['name_folders'])) {
        sendError('Invalid input');
    }

    // Thêm trường cố định id_account = 4
    $id_account = 4;

    $name_folders = $data['name_folders'];

    $sql = "INSERT INTO folders (id_account, name_folders) VALUES (?, ?)";
    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("is", $id_account, $name_folders);
        $stmt->execute();

        if ($stmt->affected_rows > 0) {
            echo json_encode(['status' => 'success']);
        } else {
            sendError('Failed to create folder');
        }
    } else {
        sendError('SQL prepare failed: ' . $conn->error);
    }
} else {
    sendError('Invalid request method');
}

$conn->close();
?>