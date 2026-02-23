<?php
header('Content-Type: application/json');
error_reporting(0); 

include "konekdb.php";


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    
    $nama    = isset($_POST['nama']) ? $_POST['nama'] : '';
    $nis     = isset($_POST['nis']) ? $_POST['nis'] : '';
    $tplahir = isset($_POST['tplahir']) ? $_POST['tplahir'] : '';
    $tglahir = isset($_POST['tglahir']) ? $_POST['tglahir'] : '';
    $kelamin = isset($_POST['kelamin']) ? $_POST['kelamin'] : '';
    $agama   = isset($_POST['agama']) ? $_POST['agama'] : '';
    $alamat  = isset($_POST['alamat']) ? $_POST['alamat'] : '';

    try {
        $stmt = $db->prepare("INSERT INTO siswa (nama, nis, tplahir, tglahir, kelamin, agama, alamat) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $result = $stmt->execute([$nama, $nis, $tplahir, $tglahir, $kelamin, $agama, $alamat]);

        if ($result) {
            echo json_encode([
                'success' => true,
                'message' => 'Data berhasil disimpan'
            ]);
        } else {
            echo json_encode([
                'success' => false,
                'message' => 'Gagal mengeksekusi perintah database'
            ]);
        }
    } catch (PDOException $e) {
        echo json_encode([
            'success' => false,
            'message' => 'Error Database: ' . $e->getMessage()
        ]);
    }

} else {
    echo json_encode([
        'success' => false,
        'message' => 'Metode pengiriman salah (Harus POST)'
    ]);
}
?>