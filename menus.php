<?php
// Verificar si el usuario está logueado
if(!isset($_SESSION['userid'])) {
    header("Location:login.php");
    exit();
}
?>

<nav class="navbar navbar-dark bg-info bg-gradient navbar-expand-lg my-3">
    <div class="container-fluid px-3">
        <!-- Botón hamburguesa para móvil -->
        <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Menú colapsable -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <!-- Menús principales -->
            <ul class="nav navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link rounded-0" href="index.php" id="index_menu">
                        <i class="fas fa-home me-2"></i>Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link rounded-0" href="customer.php" id="customer_menu">
                        <i class="fas fa-users me-2"></i>Analistas
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link rounded-0" href="category.php" id="category_menu">
                        <i class="fas fa-tags me-2"></i>Categorías
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link rounded-0" href="brand.php" id="brand_menu">
                        <i class="fas fa-industry me-2"></i>Marcas
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link rounded-0" href="product.php" id="product_menu">
                        <i class="fas fa-flask me-2"></i>Reactivos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link rounded-0" href="order.php" id="order_menu">
                        <i class="fas fa-shopping-cart me-2"></i>Salidas
                    </a>
                </li>
            </ul>

            <!-- Perfil de usuario -->
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <button type="button" 
                            class="btn btn-light d-flex align-items-center gap-2 rounded-pill px-3 py-2 shadow-none" 
                            data-bs-toggle="dropdown" 
                            aria-expanded="false">
                        <i class="fas fa-user-circle"></i>
                        <span class="d-none d-md-inline"><?php echo htmlspecialchars($_SESSION['name']); ?></span>
                        <i class="fas fa-chevron-down ms-1 small"></i>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end mt-2 rounded-0 shadow">
                        <li>
                            <a class="dropdown-item py-2" href="action.php?action=logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Script para marcar el menú activo -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Obtener la página actual
    var currentPage = window.location.pathname.split("/").pop().split(".")[0];
    
    // Si no hay página específica, estamos en el inicio
    if(currentPage === "") currentPage = "index";
    
    // Marcar el menú activo
    var activeMenu = document.getElementById(currentPage + "_menu");
    if(activeMenu) {
        activeMenu.classList.add("active", "bg-white", "text-info");
    }
    
    // Cerrar menú al hacer clic en un enlace (en móviles)
    document.querySelectorAll('.navbar-nav .nav-link').forEach(function(link) {
        link.addEventListener('click', function() {
            var navbarCollapse = document.querySelector('.navbar-collapse');
            if(navbarCollapse.classList.contains('show')) {
                navbarCollapse.classList.remove('show');
            }
        });
    });
});
</script>

<!-- Estilos específicos para el menú -->
<style>
@media (max-width: 991px) {
    .navbar-collapse {
        padding: 1rem 0;
    }
    
    .nav-link {
        padding: 0.8rem 1rem !important;
        border-radius: 0.25rem !important;
        margin: 0.2rem 0;
    }
    
    .navbar-nav .dropdown-menu {
        border: none;
        padding: 0;
        margin-top: 0.5rem;
    }
    
    .dropdown-item {
        padding: 0.8rem 1rem;
    }
}

/* Efectos hover en desktop */
@media (min-width: 992px) {
    .nav-link {
        position: relative;
        transition: all 0.3s ease;
    }
    
    .nav-link:not(.active):hover {
        background-color: rgba(255, 255, 255, 0.1);
    }
    
    .nav-link.active::after {
        content: '';
        position: absolute;
        bottom: -2px;
        left: 1rem;
        right: 1rem;
        height: 2px;
        background-color: #fff;
    }
}

/* Mejoras visuales generales */
.nav-link {
    position: relative;
    white-space: nowrap;
    transition: all 0.2s ease-in-out;
}

.dropdown-menu {
    border: none;
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
}

.dropdown-item:active {
    background-color: var(--bs-info);
}
</style> 