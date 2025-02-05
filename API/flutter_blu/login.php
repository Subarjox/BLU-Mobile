<?php
header('Access-Control-Allow-Origin: *'); // Izinkan semua domain
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

session_start();
include "koneksi.php";

$email = isset($_POST['email']) ? mysqli_real_escape_string($koneksi, $_POST['email']) : '';
$password = isset($_POST['password']) ? mysqli_real_escape_string($koneksi, $_POST['password']) : '';

$query = "SELECT * FROM users WHERE email = '$email' AND password = '$password'";
$result = mysqli_query($koneksi, $query);

header('Content-Type: application/json'); // Pastikan respons adalah JSON

if ($result && mysqli_num_rows($result) > 0) {
    $user = mysqli_fetch_assoc($result);

    $response = [
        'status' => 'success',
        'message' => 'Login berhasil',// 'guru' atau 'siswa'
        'id_user' => $user['id_user']
    ];
} else {
    $response = [
        'status' => 'error',
        'message' => 'Email atau password salah',
    ];
}

echo json_encode($response);
exit();
?>
