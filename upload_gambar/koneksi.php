<?php
$koneksi = mysqli_connect("Localhost", "root", "", "db_klinik");
if (mysqli_connect_errno()) {
  echo "Koneksi ke Database Gagal";
}
