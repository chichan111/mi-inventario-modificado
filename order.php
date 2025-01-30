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

<!-- Librerías para exportación -->
<script src="js/export/jszip.min.js"></script>
<script src="js/export/exceljs.min.js"></script>

<!-- SweetAlert2 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>

<!-- Select2 -->
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<script src="js/order.js"></script>
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
                            <h3 class="card-title">Gestionar Salidas</h3>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-4 col-xs-6 text-end">
                            <button type="button" name="add" id="addOrder" class="btn btn-primary btn-sm rounded-0">
                                <i class="far fa-plus-square"></i> Agregar Salida
                            </button>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                <div class="row mb-3">
                <div class="col-md-4">
                    <select id="analyzerFilter" class="form-select" data-placeholder="Todos los Analistas">
                        <option value=""></option>
                        <?php echo $inventory->customerDropdownList(); ?>
                    </select>
                </div>
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text">Del</span>
                        <input type="date" id="dateFromFilter" class="form-control">
                        <button class="btn btn-outline-secondary clear-date" type="button" data-target="dateFromFilter">
                            <i class="fa fa-times"></i>
                        </button>
                        <span class="input-group-text">Al</span>
                        <input type="date" id="dateToFilter" class="form-control">
                        <button class="btn btn-outline-secondary clear-date" type="button" data-target="dateToFilter">
                            <i class="fa fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>
                    <div class="row">
                        <div class="col-sm-12 table-responsive">
                            <table id="orderList" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Reactivo</th>
                                        <th>Producto</th>
                                        <th>Analista</th>
                                        <th>Fecha</th>
                                        <th>Eliminar</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal solo para agregar -->
    <div id="orderModal" class="modal fade">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><i class="fa fa-plus"></i> Agregar Salida</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form method="post" id="orderForm">
                        <input type="hidden" name="btn_action" id="btn_action" value="addOrder" />
                        <div class="mb-3">
                            <label>Nombre del Producto</label>
                            <select name="product" id="product" class="form-select select2 rounded-0" required style="width: 100%">
                                <option value="">Buscar Producto...</option>
                                <?php echo $inventory->productDropdownList(); ?>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label>Cantidad</label>
                            <div class="input-group">
                                <input type="number" name="shipped" id="shipped" class="form-control rounded-0" required />
                                <span class="input-group-text" id="unit-text">unidades</span>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label>Nombre del Analista</label>
                            <select name="customer" id="customer" class="form-select rounded-0" required>
                                <option value="">Selecciona Analista</option>
                                <?php echo $inventory->customerDropdownList(); ?>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <input type="submit" name="action" id="action" class="btn btn-primary rounded-0" value="Agregar" form="orderForm" />
                    <button type="button" class="btn btn-default border rounded-0" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
/* Estilos para mejorar la apariencia de los filtros */
.select2-container--bootstrap-5 .select2-selection {
    border-radius: 0;
}
.input-group > .form-control {
    border-radius: 0;
}
.input-group > .input-group-text {
    background-color: #f8f9fa;
}
/* Estilos para alinear los filtros */
.filter-section {
    display: flex;
    gap: 1rem;
    align-items: center;
}
/* Estilos para los campos de fecha */
input[type="date"] {
    height: 38px;
}
/* Ajuste para el responsive */
@media (max-width: 768px) {
    .filter-section {
        flex-direction: column;
    }
    .col-md-8 .input-group {
        margin-top: 1rem;
    }
}
</style>

<?php include('inc/footer.php'); ?>