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

<script src="js/brand.js"></script>
<script src="js/common.js"></script>
<?php include('inc/container.php'); ?>
<div class="container">
    <?php include("menus.php"); ?>
    <div class="row">
        <div class="col-lg-12">
            <div class="card card-default rounded-0 shadow">
                <div class="card-header">
                    <div class="row">
                        <div class="col-md-9">
                            <h3 class="card-title">Listado de Marcas</h3>
                        </div>
                        <div class="col-md-3 text-end">
                            <button type="button" name="add" id="addBrand" class="btn btn-primary bg-gradient btn-sm rounded-0"><i class="far fa-plus-square"></i> Agregar Marca</button>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <table id="brandList" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Marca</th>
                                <th>Estado</th>
                                <th>Acción</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
        <div id="brandModal" class="modal fade">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-0">
                    <div class="modal-header">
                        <h4 class="modal-title"><i class="fa fa-plus"></i> Agregar Marca</h4>
                        <button type="button" class="btn-close text-xs" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container-fluid">
                            <form method="post" id="brandForm">
                                <input type="hidden" name="id" id="id" />
                                <input type="hidden" name="btn_action" id="btn_action" />
                                <div class="mb-3">
                                    <label class="control-label">Nombre de la Marca</label>
                                    <input type="text" name="bname" id="bname" class="form-control rounded-0" required />
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" name="action" id="action" class="btn btn-sm rounded-0 btn-primary" form="brandForm">Guardar</button>
                        <button type="button" class="btn btn-sm rounded-0 btn-default border" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php include('inc/footer.php'); ?>