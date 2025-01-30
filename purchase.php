<?php
ob_start();
session_start();
include('inc/header.php');
include 'Inventory.php';
$inventory = new Inventory();
$inventory->checkLogin();
?>

<script src="js/jquery.dataTables.min.js"></script>
<script src="js/dataTables.bootstrap.min.js"></script>
<link rel="stylesheet" href="css/dataTables.bootstrap.min.css" />
<!-- Select2 -->
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<!-- SweetAlert2 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>

<script src="js/purchase.js"></script>
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
                            <h3 class="card-title">Lista de Compras</h3>
                        </div>

                        <div class="col-lg-2 col-md-2 col-sm-4 col-xs-6 text-end">
                            <button type="button" name="addPurchase" id="addPurchase" class="btn btn-primary btn-sm rounded-0"><i class="far fa-plus-square"></i> Agregar Compra</button>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-12 table-responsive">
                            <table id="purchaseList" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Producto</th>
                                        <th>Cantidad</th>
                                        <th>Proveedor</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="purchaseModal" class="modal fade">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><i class="fa fa-plus"></i> Agregar Compra</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form method="post" id="purchaseForm">
                        <input type="hidden" name="purchase_id" id="purchase_id" />
                        <input type="hidden" name="btn_action" id="btn_action" />
                        <input type="hidden" name="supplierid" id="supplierid" value="1" />
                        <div class="mb-3">
                            <label>Nombre de Producto</label>
                            <select name="product" id="product" class="form-select select2 rounded-0" required style="width: 100%">
                                <option value="">Buscar Producto...</option>
                                <?php echo $inventory->productDropdownList(); ?>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label>Cantidad</label>
                            <div class="input-group">
                                <input type="number" name="quantity" id="quantity" class="form-control rounded-0" required min="1"/>
                                <span class="input-group-text" id="unit-text">unidades</span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <input type="submit" name="action" id="action" class="btn btn-primary rounded-0" value="Agregar" form="purchaseForm" />
                    <button type="button" class="btn btn-default border rounded-0" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
</div>
<?php include('inc/footer.php'); ?>