<nav class="navbar navbar-dark bg-info bg-gradient navbar-expand-lg navbar-expand-md my-3">
    <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="nav navbar-nav menus">
                <li class="nav-item"><a class="nav-link" href="index.php" id="index_menu">Inicio</a></li>
                <li class="nav-item"><a class="nav-link" href="customer.php" id="customer_menu">Analistas</a></li>
                <li class="nav-item"><a class="nav-link" href="category.php" id="category_menu">Categorías</a></li>
                <li class="nav-item"><a class="nav-link" href="brand.php" id="brand_menu">Marcas</a></li>
                <li class="nav-item"><a class="nav-link" href="product.php" id="product_menu">Reactivos</a></li>
                <li class="nav-item"><a class="nav-link" href="order.php" id="order_menu">Salidas</a></li>
            </ul>
        </div>
        <!--<ul class="nav navbar-nav">
            <li class="nav-item me-2">
                <button class="btn btn-success btn-sm" id="backupBtn">
                    <i class="fas fa-download"></i> Backup BD
                </button>
            </li>
            <li class="nav-item me-2">
                <button class="btn btn-warning btn-sm" id="restoreBtn">
                    <i class="fas fa-upload"></i> Restaurar BD
                </button>
            </li>-->
            <li class="dropdown position-relative">
                <button type="button" class="badge bg-light border px-3 text-dark rounded-pill dropdown-toggle" id="dropdownMenuButton1" data-bs-toggle="dropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <span class="badge badge-pill bg-danger count"></span>
                    <?php echo $_SESSION['name']; ?>
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                    <li><a class="dropdown-item" href="action.php?action=logout">Cerrar Sesión</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<!-- Modal para Restaurar Base de Datos 
<div class="modal fade" id="restoreModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Restaurar Base de Datos</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="restoreForm">
                    <div class="mb-3">
                        <label for="backupFile" class="form-label">Archivo SQL</label>
                        <input type="file" class="form-control" id="backupFile" accept=".sql" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Contraseña de Administrador</label>
                        <input type="password" class="form-control" id="password" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" id="confirmRestore">Restaurar</button>
            </div>
        </div>
    </div>
</div>-->

<!-- Incluir el archivo JS -->
<script src="js/backup.js"></script>