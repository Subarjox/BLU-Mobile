<?php
header('Access-Control-Allow-Origin: *'); // Izinkan semua domain
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Include koneksi database
include 'koneksi.php';

// Ambil parameter id_user dari body request (POST)
$idUser = isset($_POST['id_user']) ? $_POST['id_user'] : '';

// Pastikan id_user tidak kosong
if (empty($idUser)) {
    echo json_encode(['error' => 'ID User diperlukan']);
    exit;
}

// Cek apakah user dengan id_user ada di database
$query = "SELECT id_device FROM users WHERE id_user = ?";
$stmt = mysqli_prepare($koneksi, $query);
mysqli_stmt_bind_param($stmt, "s", $idUser);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);
$data = mysqli_fetch_assoc($result);

// Jika user ditemukan
if ($data) {
    // Hapus id_device dari user
    $updateQuery = "UPDATE users SET id_device = NULL WHERE id_user = ?";
    $updateStmt = mysqli_prepare($koneksi, $updateQuery);
    mysqli_stmt_bind_param($updateStmt, "s", $idUser);
    
    if (mysqli_stmt_execute($updateStmt)) {
        echo json_encode([
            'message' => 'ID Device berhasil dihapus dari user',
            'id_user' => $idUser,
        ]);
    } else {
        echo json_encode(['error' => 'Gagal menghapus ID Device']);
    }

    // Tutup prepared statement untuk update
    mysqli_stmt_close($updateStmt);
} else {
    // Jika user tidak ditemukan
    echo json_encode(['error' => 'User tidak ditemukan']);
}

// Tutup prepared statement untuk select
mysqli_stmt_close($stmt);

// Tutup koneksi database
mysqli_close($koneksi);
?>
