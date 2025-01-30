$(document).ready(function() {
    // Inicializar el botón de agregar categoría
    $('#categoryAdd').click(function() {
        $('#categoryForm')[0].reset();
        $('.modal-title').html("<i class='fa fa-plus'></i> Agregar Categoría");
        $('#action').val('Agregar');
        $('#btn_action').val('categoryAdd');
    });

    // Inicializar DataTable
    var categoryData = $('#categoryList').DataTable({
        "lengthChange": false,
        "processing": true,
        "serverSide": true,
        "order": [],
        "ajax": {
            url: "action.php",
            type: "POST",
            data: { action: 'categoryList' },
            dataType: "json"
        },
        "columnDefs": [{
            "targets": [0, 3],
            "orderable": false,
        }],
        "pageLength": 25,
        'rowCallback': function(row, data, index) {
            $(row).find('td').addClass('align-middle')
            $(row).find('td:eq(0), td:eq(3)').addClass('text-center')
        },
        "language": {
            "processing": "Procesando...",
            "search": "Buscar:",
            "lengthMenu": "Mostrar _MENU_ registros",
            "info": "Mostrando _START_ a _END_ de _TOTAL_ registros",
            "infoEmpty": "Mostrando 0 a 0 de 0 registros",
            "infoFiltered": "(filtrado de _MAX_ registros totales)",
            "zeroRecords": "No se encontraron resultados",
            "emptyTable": "Ningún dato disponible en esta tabla",
            "paginate": {
                "first": "Primero",
                "last": "Último",
                "next": "Siguiente",
                "previous": "Anterior"
            }
        }
    });

    // Manejar el envío del formulario
    $(document).on('submit', '#categoryForm', function(event) {
        event.preventDefault();
        
        // Validar que el campo de categoría no esté vacío
        if(!$('#category').val().trim()) {
            Swal.fire({
                title: 'Atención',
                text: 'Por favor ingrese el nombre de la categoría',
                icon: 'warning',
                confirmButtonText: 'Aceptar',
                confirmButtonColor: '#3085d6'
            });
            return false;
        }

        $('#action').attr('disabled', 'disabled');
        var formData = $(this).serialize();
        
        $.ajax({
            url: "action.php",
            method: "POST",
            data: formData,
            success: function(data) {
                $('#categoryForm')[0].reset();
                $('#categoryModal').modal('hide');
                
                var action = $('#btn_action').val();
                var title = action === 'categoryAdd' ? '¡Categoría Agregada!' : '¡Categoría Actualizada!';
                var text = action === 'categoryAdd' ? 
                    'La categoría ha sido agregada correctamente' : 
                    'La categoría ha sido actualizada correctamente';
                
                Swal.fire({
                    title: title,
                    text: text,
                    icon: 'success',
                    confirmButtonText: 'Aceptar',
                    confirmButtonColor: '#3085d6'
                });
                
                $('#action').attr('disabled', false);
                categoryData.ajax.reload();
            },
            error: function() {
                $('#action').attr('disabled', false);
                Swal.fire({
                    title: 'Error',
                    text: 'Hubo un error al procesar la solicitud',
                    icon: 'error',
                    confirmButtonText: 'Aceptar',
                    confirmButtonColor: '#3085d6'
                });
            }
        });
    });

    // Manejar el botón de actualizar
    $(document).on('click', '.update', function() {
        var categoryId = $(this).attr("id");
        var btnAction = 'getCategory';
        
        $.ajax({
            url: "action.php",
            method: "POST",
            data: { categoryId: categoryId, btn_action: btnAction },
            dataType: "json",
            success: function(data) {
                $('#categoryModal').modal('show');
                $('#category').val(data.name);
                $('.modal-title').html("<i class='fa fa-edit'></i> Editar Categoría");
                $('#categoryId').val(categoryId);
                $('#action').val('Editar');
                $('#btn_action').val("updateCategory");
            },
            error: function() {
                Swal.fire({
                    title: 'Error',
                    text: 'No se pudo cargar la información de la categoría',
                    icon: 'error',
                    confirmButtonText: 'Aceptar',
                    confirmButtonColor: '#3085d6'
                });
            }
        });
    });

    // Manejar el botón de eliminar
    $(document).on('click', '.delete', function() {
        var categoryId = $(this).attr('id');
        var status = $(this).data("status");
        var btn_action = 'deleteCategory';
        
        Swal.fire({
            title: '¿Está seguro?',
            text: "Esta acción no se puede revertir",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "action.php",
                    method: "POST",
                    data: { categoryId: categoryId, status: status, btn_action: btn_action },
                    success: function(data) {
                        Swal.fire({
                            title: '¡Eliminado!',
                            text: 'La categoría ha sido eliminada correctamente',
                            icon: 'success',
                            confirmButtonText: 'Aceptar',
                            confirmButtonColor: '#3085d6'
                        });
                        categoryData.ajax.reload();
                    },
                    error: function() {
                        Swal.fire({
                            title: 'Error',
                            text: 'No se pudo eliminar la categoría',
                            icon: 'error',
                            confirmButtonText: 'Aceptar',
                            confirmButtonColor: '#3085d6'
                        });
                    }
                });
            }
        });
    });
});