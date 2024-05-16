<?php
header('Content-Type: application/json');

// Kết nối đến cơ sở dữ liệu MySQL
$servername = "localhost";
$username = "root";
$password = "";
$database = "lea";
$conn = new mysqli($servername, $username, $password, $database);

// Kiểm tra kết nối
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Nhận dữ liệu từ ứng dụng Flutter
$data = json_decode(file_get_contents('php://input'), true);
$email = $data['email'];
$password = $data['password'];

// Kiểm tra xem email đã tồn tại chưa
$sql_check = "SELECT * FROM account WHERE email=?";
$stmt_check = $conn->prepare($sql_check);
$stmt_check->bind_param("s", $email);
$stmt_check->execute();
$result_check = $stmt_check->get_result();

if ($result_check->num_rows > 0) {
    // Email đã tồn tại
    $response = array('status' => 'error', 'message' => 'Email already exists');
} else {
    // Email không tồn tại, thêm người dùng mới
    $sql_insert = "INSERT INTO account (email, password) VALUES (?, ?)";
    $stmt_insert = $conn->prepare($sql_insert);
    $stmt_insert->bind_param("ss", $email, $password);
    
    if ($stmt_insert->execute()) {
        // Đăng ký thành công
        $response = array('status' => 'success');
    } else {
        // Đăng ký thất bại
        $response = array('status' => 'error', 'message' => 'Registration failed');
    }

    $stmt_insert->close();
}

// Trả kết quả về cho ứng dụng Flutter
echo json_encode($response);

$stmt_check->close();
$conn->close();
?>