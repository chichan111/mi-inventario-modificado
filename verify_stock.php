<?php
include 'Inventory.php';
$inventory = new Inventory();

$response = array();
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $productId = isset($_POST['product_id']) ? $_POST['product_id'] : '';
    $quantity = isset($_POST['quantity']) ? intval($_POST['quantity']) : 0;
    
    if ($productId && $quantity) {
        $response = $inventory->verifyStock($productId, $quantity);
    } else {
        $response = array('status' => 'error', 'message' => 'Datos inválidos');
    }
}

header('Content-Type: application/json');
echo json_encode($response);
?>