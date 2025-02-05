<?php
header('Access-Control-Allow-Origin: *'); // Izinkan semua domain
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Include koneksi database
include 'koneksi.php';

// Ambil parameter userId dari URL
$userId = isset($_GET['userId']) ? $_GET['userId'] : '';

// Pastikan userId ada
if (empty($userId)) {
    echo json_encode(['error' => 'User ID is required']);
    exit;
}

// Gunakan prepared statement untuk keamanan
$query = "SELECT * FROM users WHERE id_user = ?";
$stmt = mysqli_prepare($koneksi, $query);
mysqli_stmt_bind_param($stmt, "s", $userId); // 's' untuk string
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

// Ambil data dan simpan dalam array
$temp = [];
while ($data = mysqli_fetch_assoc($result)) {
    $temp[] = $data;
}

// Kirimkan data dalam format JSON
echo json_encode($temp);

// Tutup koneksi
mysqli_stmt_close($stmt);
mysqli_close($koneksi);
?>
