<?php
session_start();
include 'Inventory.php';
$inventory = new Inventory();

if(!isset($_SESSION['userid'])) {
    die(json_encode(['success' => false, 'message' => 'Acceso no autorizado']));
}

try {
    // Verificar contraseña
    $password = md5($_POST['password']);
    $sqlCheck = "SELECT userid FROM " . $inventory->userTable . " WHERE password = '" . $password . "' AND type = 'admin' AND status = 'Active'";
    $result = mysqli_query($inventory->dbConnect, $sqlCheck);
    
    if(mysqli_num_rows($result) === 0) {
        die(json_encode(['success' => false, 'message' => 'Contraseña incorrecta']));
    }

    // Verificar archivo
    if(!isset($_FILES['file']) || $_FILES['file']['error'] !== UPLOAD_ERR_OK) {
        die(json_encode(['success' => false, 'message' => 'Error al subir el archivo']));
    }

    // Verificar extensión del archivo
    $fileInfo = pathinfo($_FILES['file']['name']);
    if($fileInfo['extension'] !== 'sql') {
        die(json_encode(['success' => false, 'message' => 'El archivo debe ser .sql']));
    }

    // Configuración de la base de datos
    $host = $inventory->host;
    $user = $inventory->user;
    $password = $inventory->password;
    $database = $inventory->database;

    // Mover archivo a directorio temporal
    $tempFile = 'backups/temp_' . time() . '.sql';
    if(!move_uploaded_file($_FILES['file']['tmp_name'], $tempFile)) {
        die(json_encode(['success' => false, 'message' => 'Error al procesar el archivo']));
    }

    // Restaurar base de datos
    $command = sprintf(
        'mysql -h %s -u %s --password="%s" %s < %s',
        escapeshellarg($host),
        escapeshellarg($user),
        escapeshellarg($password),
        escapeshellarg($database),
        escapeshellarg($tempFile)
    );

    system($command, $return_var);

    // Eliminar archivo temporal
    unlink($tempFile);

    if($return_var === 0) {
        echo json_encode([
            'success' => true,
            'message' => 'Base de datos restaurada correctamente'
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Error al restaurar la base de datos'
        ]);
    }
} catch(Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ]);
}
?>