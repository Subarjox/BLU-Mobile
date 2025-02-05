<?php
header('Access-Control-Allow-Origin: *'); // Izinkan semua domain
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Include koneksi database
include 'koneksi.php';

// Ambil parameter id_user dari URL
$id_user = isset($_GET['id_user']) ? $_GET['id_user'] : '';

// Pastikan id_user ada
if (empty($id_user)) {
    echo json_encode(['error' => 'ID User is required']);
    exit;
}

// Gunakan prepared statement untuk keamanan
$query = "
    SELECT 
        read_data.* 
    FROM 
        read_data 
    INNER JOIN 
        users 
    ON 
        read_data.id_device = users.id_device 
    WHERE 
        users.id_user = ?
";

$stmt = mysqli_prepare($koneksi, $query);
mysqli_stmt_bind_param($stmt, "s", $id_user); // 's' untuk string
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

// Ambil data dan simpan dalam array
$dataArray = [];
while ($data = mysqli_fetch_assoc($result)) {
    $dataArray[] = $data;
}

// Kirimkan data dalam format JSON
if (!empty($dataArray)) {
    echo json_encode($dataArray);
} else {
    echo json_encode(['message' => 'No data found for the given ID User']);
}

// Tutup koneksi
mysqli_stmt_close($stmt);
mysqli_close($koneksi);
?>
