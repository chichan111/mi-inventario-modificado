$(document).ready(function() {
    // Inicialización de Select2
    $('#product').select2({
        theme: 'bootstrap-5',
        width: '100%',
        placeholder: 'Buscar producto...',
        language: {
            noResults: function() {
                return "No se encontraron resultados";
            },
            searching: function() {
                return "Buscando...";
            }
        },
        dropdownParent: $('#purchaseModal')
    }).on('select2:open', function() {
        document.querySelector('.select2-search__field').focus();
    });

    var purchaseData = $('#purchaseList').DataTable({
        "lengthChange": false,
        "processing": true,
        "serverSide": true,
        "order": [],
        "ajax": {
            url: "action.php",
            type: "POST",
            data: { action: 'listPurchase' },
            dataType: "json",
            error: function(xhr, error, thrown) {
                console.error('Error en DataTables:', error);
            }
        },
        "pageLength": 10,
        "columnDefs": [{
            "targets": [0, 4],
            "orderable": false
        }],
        'rowCallback': function(row, data, index) {
            $(row).find('td').addClass('align-middle');
            $(row).find('td:eq(0), td:eq(4)').addClass('text-center');
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

    $('#addPurchase').click(function() {
        $('#purchaseModal').modal('show');
        $('#purchaseForm')[0].reset();
        $('.modal-title').html("<i class='fa fa-plus'></i> Agregar Compra");
        $('#action').val("Agregar");
        $('#btn_action').val("addPurchase");
        $('#product').val('').trigger('change');
    });

    // Actualizar unidad cuando cambia el producto
    $('#product').on('change', function() {
        var selectedOption = $(this).find('option:selected');
        var unit = selectedOption.data('unit') || 'unidades';
        $('#unit-text').text(unit);
    });

    $(document).on('submit', '#purchaseForm', function(event) {
        event.preventDefault();
        $('#action').attr('disabled', 'disabled');
        var formData = $(this).serialize();
        $.ajax({
            url: "action.php",
            method: "POST",
            data: formData,
            success: function(data) {
                if(data.includes('Error')) {
                    Swal.fire({
                        title: 'Error',
                        text: data,
                        icon: 'error',
                        confirmButtonText: 'Aceptar'
                    });
                    $('#action').attr('disabled', false);
                } else {
                    $('#purchaseForm')[0].reset();
                    $('#purchaseModal').modal('hide');
                    $('#action').attr('disabled', false);
                    Swal.fire({
                        title: '¡Éxito!',
                        text: 'La compra ha sido registrada correctamente',
                        icon: 'success',
                        confirmButtonText: 'Aceptar'
                    });
                    purchaseData.ajax.reload();
                }
            },
            error: function() {
                Swal.fire({
                    title: 'Error',
                    text: 'Hubo un error al procesar la compra',
                    icon: 'error',
                    confirmButtonText: 'Aceptar'
                });
                $('#action').attr('disabled', false);
            }
        });
    });

    $(document).on('click', '.update', function() {
        var purchase_id = $(this).attr("id");
        var btn_action = 'getPurchaseDetails';
        $.ajax({
            url: "action.php",
            method: "POST",
            data: { purchase_id: purchase_id, btn_action: btn_action },
            dataType: "json",
            success: function(data) {
                $('#purchaseModal').modal('show');
                $('#product').val(data.product_id).trigger('change');
                $('#quantity').val(data.quantity);
                $('.modal-title').html("<i class='fa fa-edit'></i> Editar Compra");
                $('#purchase_id').val(purchase_id);
                $('#action').val("Editar");
                $('#btn_action').val("updatePurchase");
            }
        });
    });

    $(document).on('click', '.delete', function() {
        var purchase_id = $(this).attr("id");
        var btn_action = 'deletePurchase';
        Swal.fire({
            title: '¿Está seguro?',
            text: "¿Desea eliminar esta compra? Esto afectará el inventario del producto.",
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
                    data: { purchase_id: purchase_id, btn_action: btn_action },
                    success: function(data) {
                        Swal.fire(
                            '¡Eliminado!',
                            'La compra ha sido eliminada y el inventario actualizado.',
                            'success'
                        );
                        purchaseData.ajax.reload();
                    },
                    error: function() {
                        Swal.fire(
                            'Error',
                            'Hubo un error al eliminar la compra.',
                            'error'
                        );
                    }
                });
            }
        });
    });

    // Validación del formulario
    $('#quantity').on('input', function() {
        this.value = this.value.replace(/[^0-9]/g, '');
        if(this.value <= 0) this.value = '';
    });
});