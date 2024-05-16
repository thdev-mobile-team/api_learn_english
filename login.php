<?php
header('Content-Type: application/json');

// Kết nối đến cơ sở dữ liệu MySQL
$servername = "localhost";
$email = "root";
$password = "";
$database = "lea";
$conn = new mysqli($servername, $email, $password, $database);

// Kiểm tra kết nối
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Nhận dữ liệu từ ứng dụng Flutter
$data = json_decode(file_get_contents('php://input'), true);
$email = $data['email'];
$password = $data['password'];

// Bảo mật: Sử dụng câu lệnh truy vấn tham số để tránh tấn công SQL Injection
$sql = "SELECT * FROM account WHERE email=? AND password=?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $email, $password);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    // Đăng nhập thành công
    $response = array('status' => 'success');
} else {
    // Đăng nhập thất bại
    $response = array('status' => 'error', 'message' => 'Invalid email or password');
}

// Trả kết quả về cho ứng dụng Flutter
echo json_encode($response);

$stmt->close();
$conn->close();
?>