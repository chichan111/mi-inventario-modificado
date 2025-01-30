$(document).ready(function() {
    var inventoryTable;
    // Verifica si la tabla existe antes de inicializarla
    if ($.fn.DataTable.isDataTable('#inventoryDetails')) {
        $('#inventoryDetails').DataTable().destroy();
    }
    
    if ($('#inventoryDetails').length) {
        inventoryTable = $('#inventoryDetails').DataTable({
            "lengthChange": false,
            "processing": true,
            "serverSide": true,
            "order": [],
            "ajax": {
                    url: "action.php",
                    type: "POST",
                    data: function(d) {
                        d.action = 'getInventoryDetails';
                        d.categoryFilter = $('#categoryFilter').val();
                        d.stockFilter = $('#stockFilter').val();
                        d.expirationFilter = $('#expirationFilter').val();
                },
                dataType: "json",
                error: function (xhr, error, thrown) {
                    console.error('Error en DataTables:', error);
                }
            },
            "pageLength": 10,
            'rowCallback': function(row, data, index) {
                $(row).find('td').addClass('align-middle')
            },
            dom: '<"row mb-3"<"col-sm-12 col-md-6"f><"col-sm-12 col-md-6 text-end"B>><"row"<"col-sm-12"tr>><"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
            buttons: [ 
                {
                    
                    text: '<i class="fas fa-file-excel"></i> Excel',
    className: 'btn btn-success btn-sm',
    action: function(e, dt, button, config) {
        $.ajax({
            url: 'action.php',
            type: 'POST',
            data: {
                action: 'exportInventory',
                format: 'excel',
                categoryFilter: $('#categoryFilter').val(),
                stockFilter: $('#stockFilter').val(),
                expirationFilter: $('#expirationFilter').val(),
                search: { value: $('.dataTables_filter input').val() }
            },
            success: async function(response) {
                let data = JSON.parse(response);
                
                const workbook = new ExcelJS.Workbook();
                const worksheet = workbook.addWorksheet('Inventario');

                // Definir las columnas
                worksheet.columns = [
                    { header: 'ID', key: 'id', width: 8 },
                    { header: 'Producto', key: 'producto', width: 40 },
                    { header: 'Lote', key: 'lote', width: 15 },
                    { header: 'Fórmula', key: 'formula', width: 40 },
                    { header: 'Marca', key: 'marca', width: 20 },
                    { header: 'Categoría', key: 'categoria', width: 20 },
                    { header: 'Cantidad', key: 'cantidad', width: 12 },
                    { header: 'Unidad', key: 'unidad', width: 12 },
                    { header: 'Estado Stock', key: 'estado', width: 15 },
                    { header: 'Fecha Vencimiento', key: 'fecha', width: 25 }
                ];

                // Agregar datos
                data.forEach(row => {
                    worksheet.addRow({
                        id: row.ID,
                        producto: row.Producto,
                        lote: row.Lote,
                        formula: row.Fórmula,
                        marca: row.Marca,
                        categoria: row.Categoría,
                        cantidad: row.Cantidad,
                        unidad: row.Unidad,
                        estado: row['Estado Stock'],
                        fecha: row['Fecha Vencimiento']
                    });
                });

                // Estilo para el encabezado
                worksheet.getRow(1).eachCell(cell => {
                    cell.fill = {
                        type: 'pattern',
                        pattern: 'solid',
                        fgColor: { argb: 'FF075985' }
                    };
                    cell.font = {
                        bold: true,
                        color: { argb: 'FFFFFFFF' },
                        size: 11
                    };
                    cell.alignment = {
                        vertical: 'middle',
                        horizontal: 'center'
                    };
                });

                // Aplicar estilos a las celdas de datos
                for(let i = 2; i <= worksheet.rowCount; i++) {
                    // Estado Stock (columna 9)
                    const estadoCell = worksheet.getCell(`I${i}`);
                    if (estadoCell.value) {
                        const estadoValue = estadoCell.value.toString().trim();
                        
                        if (estadoValue === 'OK') {
                            estadoCell.fill = {
                                type: 'pattern',
                                pattern: 'solid',
                                fgColor: { argb: 'FFE8F5E9' } // Verde claro
                            };
                            estadoCell.font = {
                                color: { argb: 'FF008000' }, // Verde
                                size: 11
                            };
                        } else if (estadoValue === 'BAJO') {
                            estadoCell.fill = {
                                type: 'pattern',
                                pattern: 'solid',
                                fgColor: { argb: 'FFFFF2CC' } // Amarillo claro
                            };
                            estadoCell.font = {
                                color: { argb: 'FFB8860B' }, // Amarillo oscuro
                                size: 11
                            };
                        } else if (estadoValue === 'CRÍTICO') {
                            estadoCell.fill = {
                                type: 'pattern',
                                pattern: 'solid',
                                fgColor: { argb: 'FFFFD7B5' } // Naranja claro
                            };
                            estadoCell.font = {
                                color: { argb: 'FFFF8C00' }, // Naranja
                                size: 11
                            };
                        } else if (estadoValue === 'SIN STOCK') {
                            estadoCell.fill = {
                                type: 'pattern',
                                pattern: 'solid',
                                fgColor: { argb: 'FFFFC7CE' } // Rojo claro
                            };
                            estadoCell.font = {
                                color: { argb: 'FFFF0000' }, // Rojo
                                size: 11
                            };
                        }
                    }

                    // Fecha Vencimiento (columna 10)
                    const fechaCell = worksheet.getCell(`J${i}`);
                    if (fechaCell.value) {
                        const fechaValue = fechaCell.value.toString().trim();
                        
                        if (fechaValue.includes('OK')) {
                            fechaCell.fill = {
                                type: 'pattern',
                                pattern: 'solid',
                                fgColor: { argb: 'FFE8F5E9' } // Verde claro
                            };
                            fechaCell.font = {
                                color: { argb: 'FF008000' }, // Verde
                                size: 11
                            };
                        } else if (fechaValue.includes('PRÓXIMO')) {
                            fechaCell.fill = {
                                type: 'pattern',
                                pattern: 'solid',
                                fgColor: { argb: 'FFFFD7B5' } // Naranja claro
                            };
                            fechaCell.font = {
                                color: { argb: 'FFFF8C00' }, // Naranja
                                size: 11
                            };
                        } else if (fechaValue.includes('VENCIDO')) {
                            fechaCell.fill = {
                                type: 'pattern',
                                pattern: 'solid',
                                fgColor: { argb: 'FFFFC7CE' } // Rojo claro
                            };
                            fechaCell.font = {
                                color: { argb: 'FFFF0000' }, // Rojo
                                size: 11
                            };
                        }
                    }

                    // Alineación central para todas las celdas de la fila
                    worksheet.getRow(i).eachCell(cell => {
                        cell.alignment = {
                            vertical: 'middle',
                            horizontal: 'center'
                        };
                    });
                }

                // Agregar bordes a todas las celdas
                worksheet.eachRow(row => {
                    row.eachCell(cell => {
                        cell.border = {
                            top: { style: 'thin' },
                            left: { style: 'thin' },
                            bottom: { style: 'thin' },
                            right: { style: 'thin' }
                        };
                    });
                });

                // Ajustar altura de filas
                worksheet.eachRow(row => {
                    row.height = 25;
                });

                // Generar el archivo
                const buffer = await workbook.xlsx.writeBuffer();
                const blob = new Blob([buffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
                const url = window.URL.createObjectURL(blob);
                const anchor = document.createElement('a');
                anchor.href = url;
                anchor.download = 'Reporte_Inventario_' + new Date().toLocaleDateString('es-CO', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit'
                }) + '.xlsx';
                anchor.click();
                window.URL.revokeObjectURL(url);
            },
            error: function(xhr, status, error) {
                console.error("Error en la exportación:", error);
                alert("Error al generar el reporte Excel");
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
                                action: 'exportInventory',
                                format: 'pdf',
                                categoryFilter: $('#categoryFilter').val(),
                                stockFilter: $('#stockFilter').val(),
                                expirationFilter: $('#expirationFilter').val(),
                                search: { value: $('.dataTables_filter input').val() }
                            },
                            success: function(response) {
                                let data = JSON.parse(response);
                                
                                let docDefinition = {
                                    pageOrientation: 'landscape',
                                    pageSize: 'LEGAL',
                                    content: [
                                        {
                                            text: 'Reporte de Inventario',
                                            style: 'header'
                                        },
                                        {
                                            table: {
                                                headerRows: 1,
                                                widths: ['5%', '15%', '8%', '12%', '10%', '10%', '7%', '7%', '11%', '15%'],
                                                body: [
                                                    [
                                                        { text: 'ID', style: 'tableHeader' },
                                                        { text: 'Producto', style: 'tableHeader' },
                                                        { text: 'Lote', style: 'tableHeader' },
                                                        { text: 'Fórmula', style: 'tableHeader' },
                                                        { text: 'Marca', style: 'tableHeader' },
                                                        { text: 'Categoría', style: 'tableHeader' },
                                                        { text: 'Cantidad', style: 'tableHeader' },
                                                        { text: 'Unidad', style: 'tableHeader' },
                                                        { text: 'Estado Stock', style: 'tableHeader' },
                                                        { text: 'Fecha Vencimiento', style: 'tableHeader' }
                                                    ],
                                                    ...data.map(row => [
                                                        { text: row.ID, style: 'tableCell' },
                                                        { text: row.Producto, style: 'tableCell' },
                                                        { text: row.Lote, style: 'tableCell' },
                                                        { text: row.Fórmula || '', style: 'tableCell' },
                                                        { text: row.Marca, style: 'tableCell' },
                                                        { text: row.Categoría, style: 'tableCell' },
                                                        { text: row.Cantidad, style: 'tableCell' },
                                                        { text: row.Unidad, style: 'tableCell' },
                                                        { 
                                                            text: row['Estado Stock'],
                                                            style: 'tableCell',
                                                            color: row['Estado Stock'].includes('OK') ? '#28a745' :
                                                                  row['Estado Stock'].includes('BAJO') ? '#ffc107' :
                                                                  row['Estado Stock'].includes('CRÍTICO') ? '#fd7e14' : '#dc3545',
                                                            fillColor: row['Estado Stock'].includes('OK') ? '#e8f5e9' :
                                                                      row['Estado Stock'].includes('BAJO') ? '#fff3cd' :
                                                                      row['Estado Stock'].includes('CRÍTICO') ? '#ffe5d0' : '#f8d7da'
                                                        },
                                                        { 
                                                            text: row['Fecha Vencimiento'],
                                                            style: 'tableCell',
                                                            color: row['Fecha Vencimiento'].includes('OK') ? '#28a745' :
                                                                  row['Fecha Vencimiento'].includes('PRÓXIMO') ? '#fd7e14' : '#dc3545',
                                                            fillColor: row['Fecha Vencimiento'].includes('OK') ? '#e8f5e9' :
                                                                      row['Fecha Vencimiento'].includes('PRÓXIMO') ? '#ffe5d0' : '#f8d7da'
                                                        }
                                                    ])
                                                ]
                                            }
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
                                    },
                                    defaultStyle: {
                                        fontSize: 10
                                    },
                                    footer: function(currentPage, pageCount) {
                                        return {
                                            text: 'Página ' + currentPage.toString() + ' de ' + pageCount,
                                            alignment: 'center',
                                            fontSize: 8,
                                            margin: [0, 10, 0, 0]
                                        };
                                    }
                                };
            
                                // Agregar información de filtros si existen
                                let filters = [];
                                if($('#categoryFilter').val()) filters.push('Categoría: ' + $('#categoryFilter option:selected').text());
                                if($('#stockFilter').val()) filters.push('Stock: ' + $('#stockFilter option:selected').text());
                                if($('#expirationFilter').val()) filters.push('Vencimiento: ' + $('#expirationFilter option:selected').text());
                                
                                if(filters.length > 0) {
                                    docDefinition.content.splice(1, 0, {
                                        text: 'Filtros aplicados: ' + filters.join(', '),
                                        style: {
                                            fontSize: 10,
                                            italics: true,
                                            margin: [0, 0, 0, 10]
                                        }
                                    });
                                }
            
                                // Agregar fecha de generación
                                docDefinition.content.push({
                                    text: 'Fecha de generación: ' + new Date().toLocaleString(),
                                    style: {
                                        fontSize: 8,
                                        alignment: 'right',
                                        margin: [0, 10, 0, 0]
                                    }
                                });
            
                                // Generar y descargar el PDF
                                pdfMake.createPdf(docDefinition).download('Reporte_Inventario_' + new Date().toISOString().slice(0,10) + '.pdf');
                            },
                            error: function(xhr, status, error) {
                                console.error("Error en la exportación:", error);
                                alert("Error al generar el reporte PDF");
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
           },
           "columnDefs": [{
            "targets": [6, 7],  // Ajusta los índices según la nueva columna
            "orderable": false
        }]
       });

       // Eventos para los filtros
       $('#categoryFilter, #stockFilter, #expirationFilter').change(function() {
           inventoryTable.ajax.reload();
       });
   }

   var url = window.location.pathname.split("/").pop();
   var page = url.substr(0, url.lastIndexOf('.'));
   $("a#" + page + "_menu").css({ 'color': '#FFF' });
});