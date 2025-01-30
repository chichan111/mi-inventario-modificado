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
<script src="js/product.js"></script>
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
                            <h3 class="card-title">Lista de Productos</h3>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-4 col-xs-6 text-end">
                            <button type="button" name="add" id="addProduct" class="btn btn-primary bg-gradient rounded-0 btn-sm"><i class="far fa-plus-square"></i> Agregar Producto</button>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-12 table-responsive">
                        <table id="productList" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Lote</th>
                                    <th>Fórmula</th>
                                    <th>Marca</th>
                                    <th>Categoría</th>
                                    <th>Cantidad</th>
                                    <th>Unidad</th>
                                    <th class="text-center">Estado Stock</th>
                                    <th>Fecha de Vencimiento</th>
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

    <div id="productModal" class="modal fade">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><i class="fa fa-plus"></i> Agregar Producto</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form method="post" id="productForm">
                        <input type="hidden" name="pid" id="pid" />
                        <input type="hidden" name="btn_action" id="btn_action" />
                        <!-- Campos ocultos con valores por defecto -->
                        <input type="hidden" name="base_price" id="base_price" value="0" />
                        <input type="hidden" name="tax" id="tax" value="0" />
                        <input type="hidden" name="supplierid" id="supplierid" value="1" />
                        <div class="form-group mb-3">
                            <label>Marca</label>
                            <select name="brandid" id="brandid" class="form-select rounded-0" required>
                                <option value="">Seleccionar Marca</option>
                                <?php echo $inventory->brandDropdownList(); ?>
                            </select>
                        </div>
                        <div class="form-group mb-3">
                            <label>Categoría</label>
                            <select name="categoryid" id="categoryid" class="form-select rounded-0" required>
                                <option value="">Seleccionar Categoría</option>
                                <?php echo $inventory->categoryDropdownList(); ?>
                            </select>
                        </div>
                        <div class="form-group mb-3">
                            <label>Nombre</label>
                            <input type="text" name="pname" id="pname" class="form-control rounded-0" required />
                        </div>
                        <div class="form-group mb-3">
                            <label>Lote</label>
                            <input type="text" name="pmodel" id="pmodel" class="form-control rounded-0" required />
                        </div>
                        <div class="form-group mb-3">
                            <label>Fórmula</label>
                            <textarea name="description" id="description" class="form-control rounded-0" rows="5" required></textarea>
                        </div>
                        <div class="form-group mb-3">
                            <label>Cantidad</label>
                            <div class="input-group">
                                <input type="text" name="quantity" id="quantity" class="form-control rounded-0" required pattern="[+-]?([0-9]*[.])?[0-9]+" />
                                <select name="unit" class="form-select rounded-0" id="unit" required>
                                    <option value="">Seleccionar Unidad</option>
                                    <option value="Bolsos">Bolsos</option>
                                    <option value="Botellas">Botellas</option>
                                    <option value="Cajas">Cajas</option>
                                    <option value="Unidades">Unidades</option>
                                    <option value="Kg">Kilos</option>
                                    <option value="Litros">Litros</option>
                                    <option value="Gramos">Gramos</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <label>Fecha de Vencimiento</label>
                            <input type="date" name="date" id="date" class="form-control rounded-0" required />
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <input type="submit" name="action" id="action" class="btn btn-primary rounded-0 btn-sm" value="Agregar" form="productForm" />
                    <button type="button" class="btn btn-default border rounded-0 btn-sm" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <div id="productViewModal" class="modal fade">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><i class="fa fa-th-list"></i> Información de Producto</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div id="productDetails"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default border rounded-0 btn-sm" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

</div>
<?php include('inc/footer.php'); ?>