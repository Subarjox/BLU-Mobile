<?php
header('Access-Control-Allow-Origin: *'); // Izinkan semua domain
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS'); // Tambahkan OPTIONS
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Access-Control-Allow-Credentials: true'); // Jika menggunakan sesi

session_start();
include "koneksi.php";

header('Content-Type: application/json'); // Pastikan respons adalah JSON

// Validasi Input
$id_user = isset($_POST['id_user']) ? trim($_POST['id_user']) : '';
$nama = isset($_POST['nama']) ? trim($_POST['nama']) : '';
$email = isset($_POST['email']) ? trim($_POST['email']) : '';
$password = isset($_POST['password']) ? trim($_POST['password']) : '';

// Validasi ID User
if (empty($id_user)) {
    echo json_encode([
        'status' => 'error',
        'message' => 'ID User harus disertakan.',
    ]);
    exit();
}

// Validasi Data Input
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

// Update Data di Database
$query = "UPDATE users SET nama = ?, email = ?, password = ? WHERE id_user = ?";
$stmt = $koneksi->prepare($query);

if ($stmt) {
    $stmt->bind_param("sssi", $nama, $email, $password, $id_user); // Gunakan prepared statement
    $result = $stmt->execute();

    if ($result) {
        if ($stmt->affected_rows > 0) {
            echo json_encode([
                'status' => 'success',
                'message' => 'Data user berhasil diperbarui.',
            ]);
        } else {
            echo json_encode([
                'status' => 'error',
                'message' => 'Tidak ada data yang diperbarui. Pastikan ID User benar.',
            ]);
        }
    } else {
        echo json_encode([
            'status' => 'error',
            'message' => 'Terjadi kesalahan saat memperbarui data.',
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
