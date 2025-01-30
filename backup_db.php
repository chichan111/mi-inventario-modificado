<?php
session_start();
include 'Inventory.php';
$inventory = new Inventory();

if(!isset($_SESSION['userid'])) {
    die(json_encode(['success' => false, 'message' => 'Acceso no autorizado']));
}

try {
    // Configuración de la base de datos desde la clase Inventory
    $host = $inventory->host;
    $user = $inventory->user;
    $password = $inventory->password;
    $database = $inventory->database;

    // Nombre del archivo
    $backupDir = 'backups/'; // Directorio para los backups
    if (!file_exists($backupDir)) {
        mkdir($backupDir, 0777, true);
    }

    $filename = 'backup_' . date('Y-m-d_H-i-s') . '.sql';
    $filepath = $backupDir . $filename;

    // Comando para mysqldump
    $command = sprintf(
        'mysqldump --opt -h %s -u %s --password="%s" %s > %s',
        escapeshellarg($host),
        escapeshellarg($user),
        escapeshellarg($password),
        escapeshellarg($database),
        escapeshellarg($filepath)
    );
    
    // Ejecutar comando
    system($command, $return_var);

    if($return_var === 0 && file_exists($filepath)) {
        echo json_encode([
            'success' => true,
            'filename' => $filename,
            'message' => 'Backup creado exitosamente'
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Error al generar el backup'
        ]);
    }
} catch(Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ]);
}
?>