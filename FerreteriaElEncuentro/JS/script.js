$(document).ready(function () {
    let contador = localStorage.getItem('contador') ? parseInt(localStorage.getItem('contador')) : 0;
    let productosSeleccionados = localStorage.getItem('productosSeleccionados') ? JSON.parse(localStorage.getItem('productosSeleccionados')) : {};

    $('#contador-productos').text(`(${contador})`);
    $('.Boton_compra').each(function () {
        let productoNombre = $(this).siblings('p').eq(1).text();
        if (productosSeleccionados[productoNombre]) {
            $(this).text('Agregado');
            $(this).prop('disabled', true);
            $(this).css('background-color', 'green');
            $(this).css('color', 'white');
        }
    });

    if (window.location.pathname === '/Pagos') {
        actualizarTablaPagos();
    }

    $('.Boton_compra').click(function () {
        let productoNombre = $(this).siblings('p').eq(1).text();
        let productoPrecio = $(this).siblings('p').eq(2).text().replace('₡ ', '');
        let productoCodigo = $(this).closest('.producto').data('codigo');

        $(this).text('Agregado');
        $(this).prop('disabled', true);
        $(this).css('background-color', 'green');
        $(this).css('color', 'white');

        contador++;
        $('#contador-productos').text(`(${contador})`);
        localStorage.setItem('contador', contador);
        if (productosSeleccionados[productoNombre]) {
            productosSeleccionados[productoNombre].cantidad += 1;
        } else {
            productosSeleccionados[productoNombre] = {
                codigo: productoCodigo,
                cantidad: 1,
                precio: productoPrecio
            };
        }

        localStorage.setItem('productosSeleccionados', JSON.stringify(productosSeleccionados));
        actualizarTablaPagos();
    });

    function actualizarTablaPagos() {
        let tablaCuerpo = $('#tabla-productos tbody');
        let total = 0;
        tablaCuerpo.empty();

        $.each(productosSeleccionados, function (nombre, datos) {
            let fila = `
                <tr>
                    <td>${datos.codigo}</td>
                    <td>${nombre}</td>
                    <td>${datos.precio}</td>
                    <td>${datos.cantidad}</td>
                    <td><button class="eliminar-producto btn btn-danger" data-nombre="${nombre}"><i class="fa-solid fa-trash"></i></button></td>
                </tr>
            `;
            tablaCuerpo.append(fila);

            total += datos.cantidad * parseFloat(datos.precio);
        });

        $('.texto_compra').text(`Total: ₡ ${total.toFixed(2)}`);
        $('#btn-comprar').prop('disabled', total <= 0);

        $('.eliminar-producto').click(function () {
            let nombreProducto = $(this).data('nombre');
            eliminarProducto(nombreProducto);
        });
    }

    function eliminarProducto(nombre) {
        delete productosSeleccionados[nombre];
        contador--;

        if (Object.keys(productosSeleccionados).length === 0) {
            contador = 0;
        }

        $('#contador-productos').text(`(${contador})`);
        localStorage.setItem('contador', contador);
        localStorage.setItem('productosSeleccionados', JSON.stringify(productosSeleccionados));

        actualizarTablaPagos();
    }

    $('#btn-comprar').click(function () {
        let productosSeleccionados = JSON.parse(localStorage.getItem('productosSeleccionados') || '{}');
        let productos = Object.keys(productosSeleccionados).map(key => {
            return {
                cod_producto: productosSeleccionados[key].codigo,
                nombre: key,
                precio: productosSeleccionados[key].precio,
                cantidad: productosSeleccionados[key].cantidad
            };
        });

        $.ajax({
            url: '/pagos',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ productos: productos }),
            success: function (response) {
                if (response.success) {
                    alert('Compra realizada con éxito');
                    localStorage.removeItem('productosSeleccionados');
                    localStorage.removeItem('contador');
                    productosSeleccionados = {};
                    contador = 0;
                    $('#contador-productos').text(`(${contador})`);
                    $('#tabla-productos tbody').empty();
                    $('.texto_compra').text('Total: ₡ 0.00');
                    $('#btn-comprar').prop('disabled', true);
                } else {
                    alert('Error al procesar la compra: ' + response.error);
                }
            },
            error: function (xhr, status, error) {
                alert('Error en la solicitud: ' + error);
            }
        });
    });

    $('#btn-historial').click(function () {
        $.ajax({
            url: '/pagos/historial',
            type: 'GET',
            success: function (response) {
                if (response.success) {
                    console.log('Datos recibidos:', response.data);
                    let tablaCuerpo = $('#historial-table tbody');
                    tablaCuerpo.empty();
                    $.each(response.data, function (index, item) {
                        console.log('Item:', item);
                        let fechaCompra = item.FECHA_COMPRA ? new Date(item.FECHA_COMPRA).toLocaleDateString() : 'N/A';
                        let precio = item.PRECIO ? `₡${item.PRECIO.toLocaleString()}` : 'N/A';
                        let fila = `
                            <tr>
                                <td>${item.COD_PRODUCTO || 'N/A'}</td>
                                <td>${item.NOMBRE || 'N/A'}</td>
                                <td>${precio}</td>
                                <td>${fechaCompra}</td>
                            </tr>
                        `;
                        tablaCuerpo.append(fila);
                    });
                    $('#modalHistorial').modal('show');
                } else {
                    alert('Error al cargar el historial de compras: ' + (response.error || 'Desconocido'));
                }
            },
            error: function (xhr, status, error) {
                alert('Error en la solicitud: ' + error);
            }
        });
    });


    $('#btn-TotalProductos').click(function () {
        $.ajax({
            url: '/productos/total_productos',
            type: 'GET',
            success: function (response) {
                if (response.success) {
                    let mensaje = `Total de productos en stock: ${response.total_stock}\nTotal de precio de todos los productos en stock: ₡ ${response.total_precio.toFixed(2)}`;
                    alert(mensaje);
                } else {
                    alert('Error al obtener los datos: ' + response.error);
                }
            },
            error: function (xhr, status, error) {
                alert('Error en la solicitud: ' + error);
            }
        });
    });

    $('#btn-auditoria').click(function () {
        $.ajax({
            url: '/productos/auditoria',
            type: 'GET',
            success: function (response) {
                if (response.success) {
                    console.log('Datos recibidos:', response.data);
                    let tablaCuerpo = $('#auditoria-table tbody');
                    tablaCuerpo.empty();
                    $.each(response.data, function (index, item) {
                        let fechaEvento = item.FECHA_EVENTO ? new Date(item.FECHA_EVENTO).toLocaleString() : 'N/A';
                        let fila = `
                            <tr>
                                <td>${item.COD_PRODUCTO || 'N/A'}</td>
                                <td>${item.NOMBRE || 'N/A'}</td>
                                <td>${item.STOCK || 'N/A'}</td>
                                <td>${item.TIPO_EVENTO || 'N/A'}</td>
                                <td>${fechaEvento}</td>
                            </tr>
                        `;
                        tablaCuerpo.append(fila);
                    });
                    $('#modalAuditoria').modal('show');
                } else {
                    alert('Error al cargar la auditoría de productos: ' + (response.error || 'Desconocido'));
                }
            },
            error: function (xhr, status, error) {
                alert('Error en la solicitud: ' + error);
            }
        });
    });


    $('#btn-actualizar').on('click', function () {
        $('#updateProductModal').modal('show');
    });

    $('#updateProductForm').on('submit', function (e) {
        var formData = {
            cod_producto: $('#updateCodProducto').val(),
            nombre: $('#updateNombre').val(),
            precio: $('#updatePrecio').val(),
            stock: $('#updateStock').val(),
            imagen: $('#updateImagen').val(),
        };

        $.ajax({
            url: '/productos/actualizar_producto',
            type: 'POST',
            data: formData,
            success: function (response) {
                alert('Producto actualizado con éxito.');
                $('#updateProductModal').modal('hide');
            },
            error: function (xhr, status, error) {
                alert('Error al actualizar el producto: ' + error);
            }
        });
    });




});
