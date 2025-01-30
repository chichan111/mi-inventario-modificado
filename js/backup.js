$(document).ready(function() {
    // Backup de Base de Datos
    $('#backupBtn').click(function() {
        Swal.fire({
            title: 'Generando Backup',
            text: 'Por favor espere...',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
                $.ajax({
                    url: 'backup_db.php',
                    method: 'POST',
                    success: function(response) {
                        try {
                            let result = JSON.parse(response);
                            if(result.success) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Éxito',
                                    text: 'Backup generado correctamente en la carpeta backups: ' + result.filename
                                });
                            } else {
                                console.error('Error response:', response);
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: result.message || 'Error al generar el backup'
                                });
                            }
                        } catch(e) {
                            console.error('Parse error:', e, response);
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Error al procesar la respuesta del servidor'
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Error en la petición:", error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Error al generar el backup: ' + error
                        });
                    }
                });
            }
        });
    });
 
    // Modal de Restauración
    $('#restoreBtn').click(function() {
        // Limpiar el formulario antes de mostrar el modal
        $('#restoreForm')[0].reset();
        $('#restoreModal').modal('show');
    });
 
    // Proceso de Restauración
    $('#confirmRestore').click(function() {
        let formData = new FormData();
        let file = $('#backupFile')[0].files[0];
        let password = $('#password').val();
 
        if(!file || !password) {
            Swal.fire({
                icon: 'warning',
                title: 'Campos requeridos',
                text: 'Por favor complete todos los campos'
            });
            return;
        }
 
        // Verificar extensión del archivo
        if (!file.name.toLowerCase().endsWith('.sql')) {
            Swal.fire({
                icon: 'error',
                title: 'Archivo inválido',
                text: 'Por favor seleccione un archivo .sql'
            });
            return;
        }
 
        formData.append('file', file);
        formData.append('password', password);
 
        Swal.fire({
            title: 'Restaurando Base de Datos',
            text: 'Por favor espere...',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
                $.ajax({
                    url: 'restore_db.php',
                    method: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        try {
                            let result = JSON.parse(response);
                            if(result.success) {
                                $('#restoreModal').modal('hide');
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Éxito',
                                    text: 'Base de datos restaurada correctamente',
                                    confirmButtonText: 'OK'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        window.location.reload();
                                    }
                                });
                            } else {
                                console.error('Error response:', response);
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: result.message || 'Error al restaurar la base de datos'
                                });
                            }
                        } catch(e) {
                            console.error('Parse error:', e, response);
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Error al procesar la respuesta del servidor'
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Error en la petición:", error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Error al restaurar la base de datos: ' + error
                        });
                    }
                });
            }
        });
    });
 
    // Validación de archivo
    $('#backupFile').change(function() {
        let file = this.files[0];
        if (file && !file.name.toLowerCase().endsWith('.sql')) {
            Swal.fire({
                icon: 'error',
                title: 'Archivo inválido',
                text: 'Por favor seleccione un archivo .sql'
            });
            this.value = '';
        }
    });
 
    // Limpiar modal al cerrar
    $('#restoreModal').on('hidden.bs.modal', function () {
        $('#restoreForm')[0].reset();
    });
 });