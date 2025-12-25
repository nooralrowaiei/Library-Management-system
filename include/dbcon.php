<?php
$host = "projectlibrary.database.windows.net";
$user = "noor";
$pass = "admin@434";
$db   = "project_library";

$mysqli = mysqli_init();
mysqli_ssl_set($mysqli, NULL, NULL, "/etc/ssl/certs/ca-certificates.crt", NULL, NULL);
mysqli_real_connect($mysqli, $host, $user, $pass, $db, 3306, NULL, MYSQLI_CLIENT_SSL);

