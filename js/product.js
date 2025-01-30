$(document).ready(function() {
    var productData = $('#productList').DataTable({
        "lengthChange": false,
        "processing": true,
        "serverSide": true,
        "order": [],
        "ajax": {
            url: "action.php",
            type: "POST",
            data: { action: 'listProduct' },
            dataType: "json"
        },
        "columnDefs": [{
            "targets": [0, 7, 10],
            "orderable": false,
        }],
        "pageLength": 10,
        'rowCallback': function(row, data, index) {
            $(row).find('td').addClass('align-middle')
            $(row).find('td:eq(0), td:eq(7), td:eq(10)').addClass('text-center')
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

    $('#addProduct').click(function() {
        $('#productModal').modal('show');
        $('#productForm')[0].reset();
        $('.modal-title').html("<i class='fa fa-plus'></i> Agregar Producto");
        $('#action').val("Agregar");
        $('#btn_action').val("addProduct");
    });

    $(document).on('submit', '#productForm', function(event) {
        event.preventDefault();
        
        // Validar campos requeridos
        if(!$('#pname').val() || !$('#pmodel').val() || !$('#description').val() || 
           !$('#quantity').val() || !$('#unit').val() || !$('#date').val() ||
           !$('#brandid').val() || !$('#categoryid').val()) {
            Swal.fire({
                title: 'Atención',
                text: 'Por favor complete todos los campos requeridos',
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
                $('#productForm')[0].reset();
                $('#productModal').modal('hide');
                $('#action').attr('disabled', false);
                
                Swal.fire({
                    title: $('#btn_action').val() == "addProduct" ? "¡Producto Agregado!" : "¡Producto Actualizado!",
                    text: $('#btn_action').val() == "addProduct" ? 
                          "El producto ha sido agregado exitosamente" : 
                          "El producto ha sido actualizado exitosamente",
                    icon: "success",
                    confirmButtonText: "Aceptar",
                    confirmButtonColor: '#3085d6'
                });
                
                productData.ajax.reload();
            },
            error: function() {
                Swal.fire({
                    title: "Error",
                    text: "Ocurrió un error al procesar la solicitud",
                    icon: "error",
                    confirmButtonText: "Aceptar",
                    confirmButtonColor: '#3085d6'
                });
                $('#action').attr('disabled', false);
            }
        });
    });

    $(document).on('click', '.view', function() {
        var pid = $(this).attr("id");
        var btn_action = 'viewProduct';
        $.ajax({
            url: "action.php",
            method: "POST",
            data: { pid: pid, btn_action: btn_action },
            success: function(data) {
                $('#productViewModal').modal('show');
                $('#productDetails').html(data);
            }
        })
    });

    $(document).on('click', '.update', function() {
        var pid = $(this).attr("id");
        var btn_action = 'getProductDetails';
        $.ajax({
            url: "action.php",
            method: "POST",
            data: { pid: pid, btn_action: btn_action },
            dataType: "json",
            success: function(data) {
                $('#productModal').modal('show');
                $('#categoryid').val(data.categoryid);
                $('#brandid').val(data.brandid);
                $('#pname').val(data.pname);
                $('#pmodel').val(data.model);
                $('#description').val(data.description);
                $('#quantity').val(data.quantity);
                $('#unit').val(data.unit);
                $('#date').val(data.date);
                $('.modal-title').html("<i class='fa fa-edit'></i> Editar Producto");
                $('#pid').val(pid);
                $('#action').val("Editar");
                $('#btn_action').val("updateProduct");
            },
            error: function() {
                Swal.fire({
                    title: "Error",
                    text: "No se pudo cargar la información del producto",
                    icon: "error",
                    confirmButtonText: "Aceptar",
                    confirmButtonColor: '#3085d6'
                });
            }
        });
    });

    $(document).on('click', '.delete', function() {
        var pid = $(this).attr("id");
        Swal.fire({
            title: "¿Está seguro?",
            text: "¿Desea eliminar este producto?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Sí, eliminar",
            cancelButtonText: "Cancelar"
        }).then((result) => {
            if (result.isConfirmed) {
                var btn_action = 'deleteProduct';
                $.ajax({
                    url: "action.php",
                    method: "POST",
                    data: { pid: pid, btn_action: btn_action },
                    success: function(data) {
                        Swal.fire({
                            title: "¡Eliminado!",
                            text: "El producto ha sido eliminado exitosamente",
                            icon: "success",
                            confirmButtonText: "Aceptar",
                            confirmButtonColor: '#3085d6'
                        });
                        productData.ajax.reload();
                    },
                    error: function() {
                        Swal.fire({
                            title: "Error",
                            text: "No se pudo eliminar el producto",
                            icon: "error",
                            confirmButtonText: "Aceptar",
                            confirmButtonColor: '#3085d6'
                        });
                    }
                });
            }
        });
    });
});