$(document).ready(function() {
    $('#addBrand').click(function() {
        $('#brandModal').modal('show');
        $('#brandForm')[0].reset();
        $('#action').prop('disabled', false);
        $('.modal-title').html("<i class='fa fa-plus'></i> Agregar Marca");
        $('#action').val('Agregar');
        $('#btn_action').val('addBrand');
        $('#id').val('');
    });

    var branddataTable = $('#brandList').DataTable({
        "lengthChange": false,
        "processing": true,
        "serverSide": true,
        "order": [],
        "ajax": {
            url: "action.php",
            type: "POST",
            data: { action: 'listBrand' },
            dataType: "json",
            error: function(xhr, error, thrown) {
                console.error('Error en DataTables:', error);
            }
        },
        "columnDefs": [{
            "targets": [0, 3],
            "orderable": false
        }],
        "pageLength": 25,
        'rowCallback': function(row, data, index) {
            $(row).find('td').addClass('align-middle');
            $(row).find('td:eq(0), td:eq(3)').addClass('text-center');
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

    $(document).on('submit', '#brandForm', function(event) {
        event.preventDefault();
        
        // Validar campos requeridos
        if(!$('#bname').val()) {
            Swal.fire({
                title: 'Atención',
                text: 'Por favor complete todos los campos requeridos',
                icon: 'warning',
                confirmButtonText: 'Aceptar',
                confirmButtonColor: '#3085d6'
            });
            return false;
        }

        var formData = $(this).serialize();
        $.ajax({
            url: "action.php",
            method: "POST",
            data: formData,
            success: function(data) {
                $('#brandForm')[0].reset();
                $('#brandModal').modal('hide');
                
                var action = $('#btn_action').val();
                var title = action === 'addBrand' ? '¡Marca Agregada!' : '¡Marca Actualizada!';
                var text = action === 'addBrand' ? 
                    'La marca ha sido agregada correctamente' : 
                    'La marca ha sido actualizada correctamente';
                
                Swal.fire({
                    title: title,
                    text: text,
                    icon: 'success',
                    confirmButtonText: 'Aceptar',
                    confirmButtonColor: '#3085d6'
                });
                
                branddataTable.ajax.reload();
            },
            error: function() {
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

    $(document).on('click', '.update', function() {
        var id = $(this).attr("id");
        var btn_action = 'getBrand';
        $.ajax({
            url: 'action.php',
            method: "POST",
            data: { id: id, btn_action: btn_action },
            dataType: "json",
            success: function(data) {
                $('#brandModal').modal('show');
                $('#bname').val(data.bname);
                $('.modal-title').html("<i class='fa fa-edit'></i> Editar Marca");
                $('#id').val(id);
                $('#action').val('Editar');
                $('#btn_action').val('updateBrand');
                $('#action').prop('disabled', false);
            },
            error: function() {
                Swal.fire({
                    title: 'Error',
                    text: 'No se pudo cargar la información de la marca',
                    icon: 'error',
                    confirmButtonText: 'Aceptar',
                    confirmButtonColor: '#3085d6'
                });
            }
        });
    });

    $(document).on('click', '.delete', function() {
        var id = $(this).attr("id");
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
                var btn_action = 'deleteBrand';
                $.ajax({
                    url: "action.php",
                    method: "POST",
                    data: { id: id, btn_action: btn_action },
                    success: function(data) {
                        Swal.fire({
                            title: '¡Eliminado!',
                            text: 'La marca ha sido eliminada correctamente',
                            icon: 'success',
                            confirmButtonText: 'Aceptar',
                            confirmButtonColor: '#3085d6'
                        });
                        branddataTable.ajax.reload();
                    },
                    error: function() {
                        Swal.fire({
                            title: 'Error',
                            text: 'No se pudo eliminar la marca',
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