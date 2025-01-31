<?php
ob_start();
session_start();
include('inc/header.php');
include 'Inventory.php';
$inventory = new Inventory();
$inventory->checkLogin();
?>

<!-- DataTables Original -->
<script src="js/jquery.dataTables.min.js"></script>
<script src="js/dataTables.bootstrap.min.js"></script>
<link rel="stylesheet" href="css/dataTables.bootstrap.min.css" />

<!-- Nuevas librerías para exportación -->
<script src="js/export/dataTables.buttons.min.js"></script>
<script src="js/export/buttons.html5.min.js"></script>
<script src="js/export/buttons.print.min.js"></script>
<script src="js/export/jszip.min.js"></script>
<script src="js/export/pdfmake.min.js"></script>
<script src="js/export/vfs_fonts.js"></script>
<!-- SheetJS -->
<script src="js/export/xlsx.full.min.js"></script>
<script src="js/export/exceljs.min.js"></script>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<link rel="stylesheet" href="css/style.css" />
<script src="js/common.js"></script>

<?php include('inc/container.php'); ?>
<div class="container">
    <?php include("menus.php"); ?>
    <div class="row">
        <div class="col-lg-12">
            <div class="card card-default rounded-0 shadow">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-10 col-md-10 col-sm-8 col-xs-6">
                            <h3 class="card-title">Estado del Inventario</h3>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-md-3">
                            <select id="categoryFilter" class="form-select">
                                <option value="">Filtrar por Categoría</option>
                                <?php echo $inventory->getCategoryFilterOptions(); ?>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select id="stockFilter" class="form-select">
                                <option value="">Filtrar por Stock</option>
                                <option value="ok">Stock OK</option>
                                <option value="bajo">Stock Bajo</option>
                                <option value="critico">Stock Crítico</option>
                                <option value="sin_stock">Sin Stock</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select id="expirationFilter" class="form-select">
                                <option value="">Filtrar por Vencimiento</option>
                                <option value="ok">OK</option>
                                <option value="proximo">Próximo a Vencer</option>
                                <option value="vencido">Vencido</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 table-responsive">
                        <table id="inventoryDetails" class="table table-bordered table-striped">
                            <thead>
                                <tr> 
                                    <th>ID</th>
                                    <th>Producto</th>
                                    <th>Lote</th>
                                    <th>Formula</th>
                                    <th>Marca</th>         <!-- Nueva columna agregada -->
                                    <th>Categoría</th>
                                    <th>Cantidad</th>
                                    <th>Unidad</th>
                                    <th class="text-center">Estado Stock</th>
                                    <th class="text-center">Fecha Vencimiento</th>
                                </tr>
                            </thead>
                        </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php include('inc/footer.php'); ?>