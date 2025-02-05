<?php
    header('Access-Control-Allow-Origin: *'); // Izinkan semua domain
    header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
    header('Access-Control-Allow-Headers: Content-Type, Authorization');

    include 'koneksi.php';

    // Pastikan koneksi ke database berhasil
    if (!$koneksi) {
        die(json_encode(["status" => "error", "message" => "Koneksi database gagal"]));
    }

    // Cek apakah id_air ada dalam POST request
    if (isset($_POST['id_air']) && !empty($_POST['id_air'])) {
        $id_air = $_POST['id_air'];

        // Siapkan query DELETE
        $stmt = $koneksi->prepare("DELETE FROM air WHERE id_air = ?");
        $stmt->bind_param("s", $id_air); // Gunakan $id_air yang benar

        // Eksekusi query
        if ($stmt->execute()) {
            echo json_encode(["status" => "success", "message" => "Data berhasil dihapus"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Error: " . $stmt->error]);
        }

        // Menutup statement dan koneksi
        $stmt->close();
    } else {
        echo json_encode(["status" => "error", "message" => "id_air tidak ditemukan atau kosong"]);
    }

    // Menutup koneksi
    $koneksi->close();
?>
