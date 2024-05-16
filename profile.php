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
    echo json_encode(['error' => $message]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $id = 4; // ID của người dùng cần lấy thông tin

    $sql = "SELECT username, email, password FROM account WHERE id_account = ?";
    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();

        if ($user) {
            echo json_encode($user);
        } else {
            sendError('User not found');
        }
    } else {
        sendError('SQL prepare failed: ' . $conn->error);
    }
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    if (!$data || !isset($data['username']) || !isset($data['currentPassword']) || !isset($data['newPassword'])) {
        sendError('Invalid input');
    }

    $id = 4; // ID của người dùng cần cập nhật
    $username = $data['username'];
    $currentPassword = $data['currentPassword'];
    $newPassword = $data['newPassword'];

    // Kiểm tra mật khẩu hiện tại
    $sql = "SELECT password FROM account WHERE id_account = ?";
    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();

        if ($user && $user['password'] === $currentPassword) {
            // Cập nhật thông tin người dùng
            $sql = "UPDATE account SET username = ?, password = ? WHERE id_account = ?";
            if ($stmt = $conn->prepare($sql)) {
                $stmt->bind_param("ssi", $username, $newPassword, $id);
                $stmt->execute();

                if ($stmt->affected_rows > 0) {
                    echo json_encode(['status' => 'success']);
                } else {
                    sendError('Update failed or no changes made');
                }
            } else {
                sendError('SQL prepare failed: ' . $conn->error);
            }
        } else {
            sendError('Current password is incorrect');
        }
    } else {
        sendError('SQL prepare failed: ' . $conn->error);
    }
}

$conn->close();
?>