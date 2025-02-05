<?php
header('Access-Control-Allow-Origin: *'); // Izinkan semua domain
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS'); // Tambahkan OPTIONS
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Access-Control-Allow-Credentials: true'); // Jika menggunakan sesi

session_start();
include "koneksi.php";

header('Content-Type: application/json'); // Pastikan respons adalah JSON

// Validasi Input
$nama = isset($_POST['nama']) ? trim($_POST['nama']) : '';
$email = isset($_POST['email']) ? trim($_POST['email']) : '';
$password = isset($_POST['password']) ? trim($_POST['password']) : '';

if (empty($nama) || empty($email) || empty($password)) {
    echo json_encode([
        'status' => 'error',
        'message' => 'Semua field harus diisi.',
    ]);
    exit();
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode([
        'status' => 'error',
        'message' => 'Email tidak valid.',
    ]);
    exit();
}

// Simpan Data ke Database
$query = "INSERT INTO users (nama, email, password) VALUES (?, ?, ?)";
$stmt = $koneksi->prepare($query);

if ($stmt) {
    $stmt->bind_param("sss", $nama, $email, $password); // Gunakan prepared statement
    $result = $stmt->execute();

    if ($result) {
        echo json_encode([
            'status' => 'success',
            'message' => 'Berhasil daftar.',
        ]);
    } else {
        echo json_encode([
            'status' => 'error',
            'message' => 'Terjadi kesalahan saat menyimpan data.',
        ]);
    }

    $stmt->close();
} else {
    echo json_encode([
        'status' => 'error',
        'message' => 'Kesalahan pada server.',
    ]);
}

$koneksi->close();
exit();
?>
