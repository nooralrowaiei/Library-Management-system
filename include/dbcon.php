<?php
$host = "projectlibrary.mysql.database.azure.com";
$user = "noor";
$pass = "admin@434";
$db   = "project_library";

$mysqli = mysqli_init();
mysqli_ssl_set($mysqli, NULL, NULL, "/etc/ssl/certs/ca-certificates.crt", NULL, NULL);
if (!mysqli_real_connect($mysqli, $host, $user, $pass, $db, 3306, NULL, MYSQLI_CLIENT_SSL)) {
    die('Connect Error (' . mysqli_connect_errno() . ') ' . mysqli_connect_error());
}
?>
