<?php
header('Access-Control-Allow-Origin: *'); // Izinkan semua domain
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Include koneksi database
include 'koneksi.php';

// Ambil parameter dari body request (POST)
$namaAir = isset($_POST['nama_air']) ? $_POST['nama_air'] : '';
$deskripsiAir = isset($_POST['deskripsi_air']) ? $_POST['deskripsi_air'] : '';
$kualitas = isset($_POST['kualitas']) ? $_POST['kualitas'] : '';
$phAir = isset($_POST['ph_air']) ? $_POST['ph_air'] : '';
$turbidityAir = isset($_POST['turbidity_air']) ? $_POST['turbidity_air'] : '';
$tdsAir = isset($_POST['tds_air']) ? $_POST['tds_air'] : '';
$idUser = isset($_POST['id_user']) ? $_POST['id_user'] : '';
$idAir = isset($_POST['id_air']) ? $_POST['id_air'] : ''; // Menambahkan id_air

// Pastikan semua parameter ada
if (empty($idAir) || empty($namaAir) || empty($deskripsiAir) || empty($kualitas) || empty($phAir) || empty($turbidityAir) || empty($tdsAir) || empty($idUser)) {
    echo json_encode(['error' => 'Semua parameter diperlukan']);
    exit;
}

// Cek apakah data air sudah ada untuk user ini
$query = "SELECT id_air FROM air WHERE id_user = ? AND id_air = ?"; // Memperbaiki query untuk menggunakan id_air
$stmt = mysqli_prepare($koneksi, $query);
mysqli_stmt_bind_param($stmt, "ss", $idUser, $idAir); // Menggunakan id_air sebagai pencarian
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

if (mysqli_num_rows($result) > 0) {
    // Jika data air ditemukan, lakukan update
    $updateQuery = "UPDATE air SET nama_air = ?, deskripsi_air = ?, kualitas = ?, ph_air = ?, turbidity_air = ?, tds_air = ? 
                    WHERE id_air = ?"; // Menggunakan id_air sebagai identifier
    $updateStmt = mysqli_prepare($koneksi, $updateQuery);
    mysqli_stmt_bind_param($updateStmt, "sssssss", $namaAir, $deskripsiAir, $kualitas, $phAir, $turbidityAir, $tdsAir, $idAir); // Menggunakan id_air

    if (mysqli_stmt_execute($updateStmt)) {
        echo json_encode([
            'message' => 'Data air berhasil diperbarui',
            'id_air' => $idAir,
            'nama_air' => $namaAir,
            'deskripsi_air' => $deskripsiAir,
            'kualitas' => $kualitas,
            'ph_air' => $phAir,
            'turbidity_air' => $turbidityAir,
            'tds_air' => $tdsAir,
            'id_user' => $idUser
        ]);
    } else {
        echo json_encode(['error' => 'Gagal memperbarui data air']);
    }

    // Tutup prepared statement untuk update
    mysqli_stmt_close($updateStmt);
} else {
    // Jika data air tidak ditemukan, beri respons
    echo json_encode(['message' => 'Data air tidak ditemukan untuk diperbarui']);
}

// Tutup prepared statement untuk cek data
mysqli_stmt_close($stmt);

// Tutup koneksi
mysqli_close($koneksi);
?>
