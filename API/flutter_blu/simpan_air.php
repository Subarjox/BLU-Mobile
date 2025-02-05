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

// Pastikan semua parameter ada
if (empty($namaAir) || empty($deskripsiAir) || empty($kualitas) || empty($phAir) || empty($turbidityAir) || empty($tdsAir) || empty($idUser)) {
    echo json_encode(['error' => 'Semua parameter diperlukan']);
    exit;
}

// Cek apakah data air sudah ada untuk user ini
$query = "SELECT id_user FROM air WHERE id_user = ? AND nama_air = ?";
$stmt = mysqli_prepare($koneksi, $query);
mysqli_stmt_bind_param($stmt, "ss", $idUser, $namaAir);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

if (mysqli_num_rows($result) > 0) {
    // Jika data air sudah ada, beri respons
    echo json_encode(['message' => 'Data air ini sudah ada']);
} else {
    // Jika data air belum ada, simpan data ke database
    $insertQuery = "INSERT INTO air (nama_air, deskripsi_air, kualitas, ph_air, turbidity_air, tds_air, id_user) 
                    VALUES (?, ?, ?, ?, ?, ?, ?)";
    $insertStmt = mysqli_prepare($koneksi, $insertQuery);
    mysqli_stmt_bind_param($insertStmt, "sssssss", $namaAir, $deskripsiAir, $kualitas, $phAir, $turbidityAir, $tdsAir, $idUser);

    if (mysqli_stmt_execute($insertStmt)) {
        echo json_encode([
            'message' => 'Data air berhasil disimpan',
            'nama_air' => $namaAir,
            'deskripsi_air' => $deskripsiAir,
            'kualitas' => $kualitas,
            'ph_air' => $phAir,
            'turbidity_air' => $turbidityAir,
            'tds_air' => $tdsAir,
            'id_user' => $idUser
        ]);
    } else {
        echo json_encode(['error' => 'Gagal menyimpan data air']);
    }

    // Tutup prepared statement untuk insert
    mysqli_stmt_close($insertStmt);
}

// Tutup prepared statement untuk cek data
mysqli_stmt_close($stmt);

// Tutup koneksi
mysqli_close($koneksi);
?>
