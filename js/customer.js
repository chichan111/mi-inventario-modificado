$(document).ready(function() {
    $('#addCustomer').click(function() {
        $('#customerModal').modal('show');
        $('#customerForm')[0].reset();
        $('#action').prop('disabled', false);
        $('.modal-title').html("<i class='fa fa-plus'></i> Agregar Usuario");
        $('#btn_action').val('customerAdd');
        $('#userid').val('');
    });

    var userdataTable = $('#customerList').DataTable({
        "lengthChange": false,
        "processing": true,
        "serverSide": true,
        "order": [],
        "ajax": {
            url: "action.php",
            type: "POST",
            data: { action: 'customerList' },
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

    $(document).on('submit', '#customerForm', function(event) {
        event.preventDefault();
        
        // Validar campos requeridos
        if(!$('#cname').val() || !$('#address').val()) {
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
                $('#customerForm')[0].reset();
                $('#customerModal').modal('hide');
                
                var action = $('#btn_action').val();
                var title = action === 'customerAdd' ? '¡Usuario Agregado!' : '¡Usuario Actualizado!';
                var text = action === 'customerAdd' ? 
                    'El usuario ha sido agregado correctamente' : 
                    'El usuario ha sido actualizado correctamente';
                
                Swal.fire({
                    title: title,
                    text: text,
                    icon: 'success',
                    confirmButtonText: 'Aceptar',
                    confirmButtonColor: '#3085d6'
                });
                
                userdataTable.ajax.reload();
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
        var userid = $(this).attr("id");
        var btn_action = 'getCustomer';
        $.ajax({
            url: "action.php",
            method: "POST",
            data: { userid: userid, btn_action: btn_action },
            dataType: "json",
            success: function(data) {
                $('#customerModal').modal('show');
                $('#cname').val(data.name);
                $('#address').val(data.address);
                $('.modal-title').html("<i class='fa fa-edit'></i> Editar Usuario");
                $('#userid').val(userid);
                $('#btn_action').val('customerUpdate');
                $('#action').prop('disabled', false);
            },
            error: function() {
                Swal.fire({
                    title: 'Error',
                    text: 'No se pudo cargar la información del usuario',
                    icon: 'error',
                    confirmButtonText: 'Aceptar',
                    confirmButtonColor: '#3085d6'
                });
            }
        });
    });

    $(document).on('click', '.delete', function() {
        var userid = $(this).attr("id");
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
                    data: { userid: userid, btn_action: 'customerDelete' },
                    success: function(response) {
                        Swal.fire({
                            title: '¡Eliminado!',
                            text: 'El usuario ha sido eliminado correctamente',
                            icon: 'success',
                            confirmButtonText: 'Aceptar',
                            confirmButtonColor: '#3085d6'
                        });
                        userdataTable.ajax.reload();
                    },
                    error: function() {
                        Swal.fire({
                            title: 'Error',
                            text: 'No se pudo eliminar el usuario',
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