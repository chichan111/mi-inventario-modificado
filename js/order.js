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
        dropdownParent: $('#orderModal'),
        minimumInputLength: 1
    }).on('select2:open', function() {
        document.querySelector('.select2-search__field').focus();
    });

    // Inicialización de Select2 para el filtro de analista
    $('#analyzerFilter').select2({
        theme: 'bootstrap-5',
        width: '100%',
        placeholder: 'Todos los Analistas',
        allowClear: true,
        language: {
            noResults: function() {
                return "No se encontraron resultados";
            },
            searching: function() {
                return "Buscando...";
            }
        }
    }).on('select2:open', function() {
        document.querySelector('.select2-search__field').focus();
    });

    // Manejadores para limpiar fechas
    $('.clear-date').click(function() {
        const targetId = $(this).data('target');
        $('#' + targetId).val('').trigger('change');
    });

    // Configurar fechas máximas
    var today = new Date().toISOString().split('T')[0];
    $('#dateToFilter').attr('max', today);
    $('#dateFromFilter').attr('max', today);

    // Evento para actualizar fecha máxima del from
    $('#dateToFilter').on('change', function() {
        $('#dateFromFilter').attr('max', $(this).val() || today);
    });

    // Evento para actualizar fecha mínima del to
    $('#dateFromFilter').on('change', function() {
        $('#dateToFilter').attr('min', $(this).val());
    });

    var orderData = $('#orderList').DataTable({
        "lengthChange": false,
        "processing": true,
        "serverSide": true,
        "order": [],
        "ajax": {
            url: "action.php",
            type: "POST",
            data: function(d) {
                d.action = 'listOrder';
                d.analyzerFilter = $('#analyzerFilter').val();
                d.dateFromFilter = $('#dateFromFilter').val();
                d.dateToFilter = $('#dateToFilter').val();
            },
            dataType: "json",
            error: function (xhr, error, thrown) {
                console.error('Error en DataTables:', error);
            }
        },
        "columnDefs": [{
            "targets": [0, 5],
            "orderable": false
        }],
        "pageLength": 10,
        'rowCallback': function(row, data, index) {
            $(row).find('td').addClass('align-middle');
            $(row).find('td:eq(0), td:eq(5)').addClass('text-center');
        },
        dom: '<"row mb-3"<"col-sm-12 col-md-6"f><"col-sm-12 col-md-6 text-end"B>><"row"<"col-sm-12"tr>><"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
        buttons: [
            {
                text: '<i class="fas fa-file-excel"></i> Excel',
                className: 'btn btn-success btn-sm',
                action: function(e, dt, button, config) {
                    Swal.fire({
                        title: 'Generando Excel',
                        text: 'Por favor espere...',
                        allowOutsideClick: false,
                        allowEscapeKey: false,
                        allowEnterKey: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });

                    $.ajax({
                        url: 'action.php',
                        type: 'POST',
                        data: {
                            action: 'exportOrders',
                            format: 'excel',
                            analyzerFilter: $('#analyzerFilter').val(),
                            dateFromFilter: $('#dateFromFilter').val(),
                            dateToFilter: $('#dateToFilter').val(),
                            search: { value: $('.dataTables_filter input').val() }
                        },
                        success: async function(response) {
                            try {
                                let data = JSON.parse(response);
                                
                                if (!Array.isArray(data) || data.length === 0) {
                                    Swal.fire({
                                        icon: 'info',
                                        title: 'Sin datos',
                                        text: 'No hay datos para exportar'
                                    });
                                    return;
                                }

                                const workbook = new ExcelJS.Workbook();
                                const worksheet = workbook.addWorksheet('Salidas');

                                // Definir columnas
                                worksheet.columns = [
                                    { header: 'ID', key: 'id', width: 10 },
                                    { header: 'Analista', key: 'analista', width: 25 },
                                    { header: 'Producto', key: 'producto', width: 40 },
                                    { header: 'Cantidad', key: 'cantidad', width: 15 },
                                    { header: 'Fecha', key: 'fecha', width: 20 }
                                ];

                                // Agregar datos
                                data.forEach(row => {
                                    worksheet.addRow({
                                        id: row.ID,
                                        analista: row.Analista,
                                        producto: row.Producto,
                                        cantidad: row.Cantidad,
                                        fecha: row.Fecha
                                    });
                                });

                                // Estilo para encabezados
                                worksheet.getRow(1).eachCell(cell => {
                                    cell.fill = {
                                        type: 'pattern',
                                        pattern: 'solid',
                                        fgColor: { argb: 'FF075985' }
                                    };
                                    cell.font = {
                                        bold: true,
                                        color: { argb: 'FFFFFFFF' },
                                        size: 12
                                    };
                                    cell.alignment = {
                                        vertical: 'middle',
                                        horizontal: 'center'
                                    };
                                    cell.border = {
                                        top: { style: 'thin' },
                                        left: { style: 'thin' },
                                        bottom: { style: 'thin' },
                                        right: { style: 'thin' }
                                    };
                                });

                                // Estilos para celdas de datos
                                worksheet.eachRow((row, rowNumber) => {
                                    if (rowNumber > 1) {
                                        row.eachCell(cell => {
                                            cell.alignment = {
                                                vertical: 'middle',
                                                horizontal: 'center'
                                            };
                                            cell.border = {
                                                top: { style: 'thin' },
                                                left: { style: 'thin' },
                                                bottom: { style: 'thin' },
                                                right: { style: 'thin' }
                                            };
                                        });
                                    }
                                    row.height = 25;
                                });

                                // Generar y descargar el archivo
                                const buffer = await workbook.xlsx.writeBuffer();
                                const blob = new Blob([buffer], { 
                                    type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' 
                                });
                                const url = window.URL.createObjectURL(blob);
                                const anchor = document.createElement('a');
                                anchor.href = url;
                                anchor.download = 'Reporte_Salidas_' + new Date().toLocaleDateString('es-CO', {
                                    year: 'numeric',
                                    month: '2-digit',
                                    day: '2-digit'
                                }) + '.xlsx';
                                anchor.click();
                                window.URL.revokeObjectURL(url);

                                // Cerrar el indicador de carga
                                Swal.close();
                            } catch (error) {
                                console.error('Error al generar Excel:', error);
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: 'Error al generar el archivo Excel'
                                });
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error("Error en la exportación:", error);
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Error al generar el reporte Excel'
                            });
                        }
                    });
                }
            },

            {
                text: '<i class="fas fa-file-pdf"></i> PDF',
                className: 'btn btn-danger btn-sm ms-2',
                action: function(e, dt, button, config) {
                    $.ajax({
                        url: 'action.php',
                        type: 'POST',
                        data: {
                            action: 'exportOrders',
                            format: 'pdf',
                            analyzerFilter: $('#analyzerFilter').val(),
                            dateFromFilter: $('#dateFromFilter').val(),
                            dateToFilter: $('#dateToFilter').val(),
                            search: { value: $('.dataTables_filter input').val() }
                        },
                        success: function(response) {
                            let data = JSON.parse(response);
                            
                            let docDefinition = {
                                pageOrientation: 'landscape',
                                pageSize: 'LEGAL',
                                content: [
                                    {
                                        text: 'Reporte de Salidas',
                                        style: 'header'
                                    }
                                ],
                                styles: {
                                    header: {
                                        fontSize: 18,
                                        bold: true,
                                        alignment: 'center',
                                        margin: [0, 0, 0, 10]
                                    },
                                    tableHeader: {
                                        fontSize: 10,
                                        bold: true,
                                        fillColor: '#075985',
                                        color: 'white',
                                        alignment: 'center',
                                        margin: [0, 5, 0, 5]
                                    },
                                    tableCell: {
                                        fontSize: 9,
                                        alignment: 'center',
                                        margin: [0, 5, 0, 5]
                                    }
                                }
                            };

                            // Agregar información de filtros si existen
                            let filters = [];
                            if ($('#analyzerFilter').val()) {
                                filters.push('Analista: ' + $('#analyzerFilter option:selected').text());
                            }
                            if ($('#dateFromFilter').val() || $('#dateToFilter').val()) {
                                filters.push('Período: ' + ($('#dateFromFilter').val() || 'inicio') + 
                                           ' al ' + ($('#dateToFilter').val() || 'fin'));
                            }

                            if (filters.length > 0) {
                                docDefinition.content.push({
                                    text: 'Filtros aplicados: ' + filters.join(', '),
                                    style: {
                                        fontSize: 10,
                                        italics: true,
                                        margin: [0, 0, 0, 10]
                                    }
                                });
                            }

                            // Agregar tabla
                            let tableBody = [
                                [
                                    { text: 'ID', style: 'tableHeader' },
                                    { text: 'Analista', style: 'tableHeader' },
                                    { text: 'Producto', style: 'tableHeader' },
                                    { text: 'Cantidad', style: 'tableHeader' },
                                    { text: 'Fecha', style: 'tableHeader' }
                                ]
                            ];

                            data.forEach(row => {
                                tableBody.push([
                                    { text: row.ID, style: 'tableCell' },
                                    { text: row.Analista, style: 'tableCell' },
                                    { text: row.Producto, style: 'tableCell' },
                                    { text: row.Cantidad, style: 'tableCell' },
                                    { text: row.Fecha, style: 'tableCell' }
                                ]);
                            });

                            docDefinition.content.push({
                                table: {
                                    headerRows: 1,
                                    widths: ['10%', '25%', '30%', '15%', '20%'],
                                    body: tableBody
                                }
                            });

                            // Agregar fecha de generación
                            docDefinition.content.push({
                                text: 'Fecha de generación: ' + new Date().toLocaleString(),
                                style: {
                                    fontSize: 8,
                                    alignment: 'right',
                                    margin: [0, 10, 0, 0]
                                }
                            });

                            pdfMake.createPdf(docDefinition).download(
                                'Reporte_Salidas_' + new Date().toISOString().slice(0,10) + '.pdf'
                            );
                        },
                        error: function(xhr, status, error) {
                            console.error("Error en la exportación:", error);
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Error al generar el reporte PDF'
                            });
                        }
                    });
                }
            }
        ],
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

    // Eventos para los filtros
    $('#analyzerFilter, #dateFromFilter, #dateToFilter').change(function() {
        orderData.ajax.reload();
    });

    // Función para verificar stock
    function verifyStock(callback) {
        const productId = $('#product').val();
        const quantity = parseInt($('#shipped').val()) || 0;
        
        if (!productId || !quantity) return;

        $.ajax({
            url: 'verify_stock.php',
            method: 'POST',
            data: {
                product_id: productId,
                quantity: quantity
            },
            success: function(response) {
                if (response.status === 'error') {
                    Swal.fire({
                        title: '¡ALERTA DE STOCK!',
                        text: response.message,
                        icon: 'warning',
                        confirmButtonText: 'Aceptar',
                        confirmButtonColor: '#3085d6'
                    });
                    $('#action').prop('disabled', true);
                    if (response.available) {
                        $('#shipped').val(response.available);
                    }
                } else {
                    $('#action').prop('disabled', false);
                }
                if (callback) callback(response.status === 'success');
            },
            error: function() {
                Swal.fire({
                    title: '¡ALERTA DE STOCK!',
                    text: 'Error al verificar el stock',
                    icon: 'error',
                    confirmButtonText: 'Aceptar',
                    confirmButtonColor: '#3085d6'
                });
                if (callback) callback(false);
            }
        });
    }

    // Eventos para verificación de stock
    $('#shipped').on('input', function() {
        verifyStock();
    });

    $('#product').on('change', function() {
        if ($('#shipped').val()) {
            verifyStock();
        }
        var selectedOption = $(this).find('option:selected');
        var unit = selectedOption.data('unit') || 'unidades';
        $('#unit-text').text(unit);
    });

    $('#addOrder').click(function() {
        // Primero actualizamos la lista de productos
        $.ajax({
            url: "action.php",
            method: "POST",
            data: { btn_action: 'refreshProductList' },
            success: function(data) {
                $('#product').html('<option value="">Buscar producto...</option>' + data);
                $('#product').val('').trigger('change');
                
                // Luego mostramos el modal y reseteamos el formulario
                $('#orderModal').modal('show');
                $('#orderForm')[0].reset();
                $('.modal-title').html("<i class='fa fa-plus'></i> Agregar Salida");
                $('#action').val("Agregar");
                $('#btn_action').val("addOrder");
                $('#action').prop('disabled', false);
            }
        });
    });

    $(document).on('submit', '#orderForm', function(event) {
        event.preventDefault();
        var formData = $(this).serialize();
        verifyStock(function(isValid) {
            if (isValid) {
                $('#action').attr('disabled', 'disabled');
                $.ajax({
                    url: "action.php",
                    method: "POST",
                    data: formData,
                    success: function(data) {
                        if (data.includes('Error:')) {
                            Swal.fire({
                                title: '¡ALERTA DE STOCK!',
                                text: data,
                                icon: 'error',
                                confirmButtonText: 'Aceptar',
                                confirmButtonColor: '#3085d6'
                            });
                            $('#action').prop('disabled', false);
                        } else {
                            $('#orderForm')[0].reset();
                            $('#orderModal').modal('hide');
                            Swal.fire({
                                title: '¡Éxito!',
                                text: 'La salida ha sido registrada correctamente',
                                icon: 'success',
                                confirmButtonText: 'Aceptar'
                            });
                            orderData.ajax.reload();
                            $('#action').prop('disabled', false);
                        }
                    }
                });
            }
        });
    });

    $(document).on('click', '.update', function() {
        var order_id = $(this).attr("id");
        var btn_action = 'getOrderDetails';
        $.ajax({
            url: "action.php",
            method: "POST",
            data: { order_id: order_id, btn_action: btn_action },
            dataType: "json",
            success: function(data) {
                $('#orderModal').modal('show');
                
                // Si hay opciones de producto actualizadas, las usamos
                if(data.product_options) {
                    $('#product').html(data.product_options);
                }
                
                // Actualizamos los valores y disparamos los eventos necesarios
                $('#product').val(data.product_id).trigger('change');
                $('#shipped').val(data.total_shipped);
                $('#customer').val(data.customer_id);
                
                $('.modal-title').html("<i class='fa fa-edit'></i> Editar Salida");
                $('#order_id').val(order_id);
                $('#action').val("Editar");
                $('#btn_action').val("updateOrder");
                
                // Verificamos el stock después de cargar los datos
                verifyStock();
            },
            error: function() {
                Swal.fire({
                    title: 'Error',
                    text: 'No se pudieron cargar los detalles de la orden',
                    icon: 'error',
                    confirmButtonText: 'Aceptar'
                });
            }
        });
    });

    $(document).on('click', '.delete', function() {
        var order_id = $(this).attr("id");
        Swal.fire({
            title: '¿Está seguro?',
            text: "¿Desea eliminar esta salida?",
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
                    data: { order_id: order_id, btn_action: 'deleteOrder' },
                    success: function() {
                        Swal.fire(
                            '¡Eliminado!',
                            'La salida ha sido eliminada.',
                            'success'
                        );
                        orderData.ajax.reload();
                    },
                    error: function() {
                        Swal.fire(
                            'Error',
                            'No se pudo eliminar la salida.',
                            'error'
                        );
                    }
                });
            }
        });
    });

    // Validación del formulario
    $('#shipped').on('input', function() {
        this.value = this.value.replace(/[^0-9]/g, '');
        if(this.value <= 0) this.value = '';
    });

    // Eventos para verificación de stock
    $('#shipped').on('input', function() {
        verifyStock();
    });

    // Configura validación al cambio del producto
    $('#product').on('change', function() {
        if ($('#shipped').val()) {
            verifyStock();
        }
        var selectedOption = $(this).find('option:selected');
        var unit = selectedOption.data('unit') || 'unidades';
        $('#unit-text').text(unit);
    });

    // Soporte para tecla Enter en campos Select2
    $(document).on('keypress', '.select2-search__field', function(event) {
        if (event.which === 13) {
            event.preventDefault();
            var select = $(this).closest('.select2-container').siblings('select');
            if (select.find('option:visible').length === 1) {
                select.val(select.find('option:visible').val()).trigger('change');
                select.select2('close');
            }
        }
    });
});