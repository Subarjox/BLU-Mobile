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

// Query untuk mengambil data dari users, termasuk status alat (id_device) dan status dari read_data
$query = "SELECT u.id_device, r.status 
          FROM users u 
          LEFT JOIN read_data r ON u.id_device = r.id_device 
          WHERE u.id_user = ?";

$stmt = mysqli_prepare($koneksi, $query);
mysqli_stmt_bind_param($stmt, "s", $userId); // 's' untuk string
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

// Ambil data dan simpan dalam array
$data = mysqli_fetch_assoc($result);

// Cek apakah id_device NULL
if ($data && is_null($data['id_device'])) {
    echo json_encode(['id_device' => 'Belum terhubung', 'status' => 'Belum terhubung']);
} elseif ($data) {
    // Jika id_device ada, kembalikan id_device dan status dari tabel read_data
    echo json_encode(['id_device' => $data['id_device'], 'status' => $data['status']]);
} else {
    echo json_encode(['error' => 'User not found', 'status' => 'Belum terhubung']);
}

// Tutup koneksi
mysqli_stmt_close($stmt);
mysqli_close($koneksi);
?>
