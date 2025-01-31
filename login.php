<?php
ob_start();
session_start();
$loginError = '';
if (!empty($_POST['email']) && !empty($_POST['pwd'])) {
    include 'Inventory.php';
    $inventory = new Inventory();
    $login = $inventory->login($_POST['email'], $_POST['pwd']);
    if (!empty($login)) {
        $_SESSION['userid'] = $login[0]['userid'];
        $_SESSION['name'] = $login[0]['name'];
        header("Location:index.php");
    } else {
        $loginError = "¡Email o contraseña incorrectos!";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Login - Sistema de Inventario</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    
    <!-- Estilos personalizados -->
    <style>
        html, body {
            height: 100%;
            background: linear-gradient(135deg, #075985 0%, #0284c7 100%);
        }
        
        .login-container {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 20px;
        }
        
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .card-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #eee;
            border-radius: 10px 10px 0 0 !important;
        }
        
        .form-control {
            border-radius: 5px;
            padding: 12px;
            height: auto;
        }
        
        .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(7, 89, 133, 0.25);
        }
        
        .btn-primary {
            background-color: #075985;
            border-color: #075985;
            padding: 12px;
        }
        
        .btn-primary:hover {
            background-color: #0284c7;
            border-color: #0284c7;
        }
        
        .system-title {
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            margin-bottom: 2rem;
        }
        
        @media (max-width: 576px) {
            .login-container {
                padding: 15px;
            }
            
            .system-title {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="container">
            <h1 class="text-center system-title">Inventario de Reactivos</h1>
            <div class="row justify-content-center">
                <div class="col-lg-4 col-md-6 col-sm-10">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="text-center mb-0">Iniciar Sesión</h3>
                        </div>
                        <div class="card-body">
                            <?php if ($loginError) { ?>
                                <div class="alert alert-danger py-2 mb-3">
                                    <i class="fas fa-exclamation-circle me-2"></i>
                                    <?php echo $loginError; ?>
                                </div>
                            <?php } ?>
                            <form method="post" action="">
                                <div class="mb-3">
                                    <label for="email" class="form-label">
                                        <i class="fas fa-envelope me-2"></i>Correo electrónico
                                    </label>
                                    <input type="email" 
                                           class="form-control" 
                                           id="email" 
                                           name="email" 
                                           value="<?= isset($_POST['email']) ? htmlspecialchars($_POST['email']) : '' ?>"
                                           placeholder="Ingresa tu correo" 
                                           required>
                                </div>
                                <div class="mb-4">
                                    <label for="pwd" class="form-label">
                                        <i class="fas fa-lock me-2"></i>Contraseña
                                    </label>
                                    <input type="password" 
                                           class="form-control" 
                                           id="pwd" 
                                           name="pwd" 
                                           placeholder="Ingresa tu contraseña" 
                                           required>
                                </div>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-sign-in-alt me-2"></i>Ingresar
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle con Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>