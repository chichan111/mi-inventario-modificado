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
<!-- SweetAlert2 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>

<script src="js/customer.js"></script>
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
                            <h3 class="card-title">Lista de Usuarios</h3>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-4 col-xs-6 text-end">
                            <button type="button" name="add" id="addCustomer" class="btn btn-primary btn-sm rounded-0"><i class="far fa-plus-square"></i> Agregar Usuario</button>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-12 table-responsive">
                            <table id="customerList" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Cargo</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="customerModal" class="modal">
            <div class="modal-dialog modal-dialog-centered rounded-0">
                <div class="modal-content rounded-0">
                    <div class="modal-header">
                        <h4 class="modal-title"><i class="fa fa-plus"></i> Agregar Usuario</h4>
                        <button type="button" class="btn-close text-xs" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container-fluid">
                            <form method="post" id="customerForm">
                                <input type="hidden" name="userid" id="userid" />
                                <input type="hidden" name="btn_action" id="btn_action" value="customerAdd" />
                                <!-- Campos ocultos con valores por defecto -->
                                <input type="hidden" name="mobile" id="mobile" value="0" />
                                <input type="hidden" name="balance" id="balance" value="0" />
                                <div class="mb-3">
                                    <label class="control-label">Nombre</label>
                                    <input type="text" name="cname" id="cname" class="form-control rounded-0" required />
                                </div>
                                <div class="mb-3">
                                    <label class="control-label">Cargo</label>
                                    <input type="text" name="address" id="address" class="form-control rounded-0" required />
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" name="action" id="action" class="btn btn-sm rounded-0 btn-primary" form="customerForm">Guardar</button>
                        <button type="button" class="btn btn-sm rounded-0 btn-default border" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php include('inc/footer.php'); ?>