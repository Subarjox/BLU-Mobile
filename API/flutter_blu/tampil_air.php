<?php
header('Access-Control-Allow-Origin: *'); // Izinkan semua domain
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Include koneksi database
include 'koneksi.php';

// Ambil parameter id_user dari query string (GET)
$idUser = isset($_GET['id_user']) ? $_GET['id_user'] : '';

// Pastikan id_user ada
if (empty($idUser)) {
    echo json_encode(['error' => 'ID User diperlukan']);
    exit;
}

// Query untuk mengambil daftar air yang terkait dengan id_user
$query = "SELECT nama_air, id_air, deskripsi_air, kualitas, ph_air, turbidity_air, tds_air FROM air WHERE id_user = ?";
$stmt = mysqli_prepare($koneksi, $query);
mysqli_stmt_bind_param($stmt, "s", $idUser);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

// Cek apakah ada data air yang ditemukan
if (mysqli_num_rows($result) > 0) {
    // Ambil semua data air dan masukkan ke dalam array
    $airList = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $airList[] = $row;
    }

    // Kembalikan data dalam format JSON tanpa membungkus dalam array
    echo json_encode($airList);
} else {
    echo json_encode(['message' => 'Tidak ada data air untuk ID User ini']);
}

// Tutup prepared statement dan koneksi
mysqli_stmt_close($stmt);
mysqli_close($koneksi);
?>
