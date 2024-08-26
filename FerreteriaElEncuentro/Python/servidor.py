from flask import Flask, render_template, request, jsonify, send_from_directory, request, redirect, url_for, flash
import cx_Oracle
import random

app = Flask(
    __name__,
    template_folder='D:/Universidad/V Cuatrimestre/Lenguajes De Base De Datos/Proyecto/Lenguaje-de-BD/FerreteriaElEncuentro/HTML',
    static_folder=None
)

app.secret_key = '123456'

cx_Oracle.init_oracle_client(lib_dir= r"C:\oracle\instantclient_19_8\instantclient_23_4")

class Config:
    ORACLE_USER = 'proyecto'
    ORACLE_PASSWORD = 'admin123'
    ORACLE_DSN = 'localhost/orcl'

def get_db_connection():
    connection = cx_Oracle.connect(
        user=Config.ORACLE_USER,
        password=Config.ORACLE_PASSWORD,
        dsn=Config.ORACLE_DSN
    )
    return connection

@app.route("/")
def index():
    return render_template("index.html")

#####################Clientes#####################
@app.route("/clientes", methods=['GET', 'POST'])
@app.route("/Clientes", methods=['GET', 'POST'])
def clientes():
    connection = get_db_connection()
    cursor = connection.cursor()

    if request.method == 'POST':
        cod_cliente = request.form['cod_cliente']
        nombre = request.form['nombre']
        primer_apellido = request.form['primer_apellido']
        segundo_apellido = request.form['segundo_apellido']
        numero = request.form['numero']
        correo = request.form['correo']
        numero_factura = request.form['numero_factura']
        num_transaccion = request.form['num_transaccion']

        try:
            cursor.execute(
                "INSERT INTO CLIENTES (cod_cliente, Nombre, primerApellido, segundoApellido, Numero, Correo, numero_factura, num_transaccion) "
                "VALUES (:1, :2, :3, :4, :5, :6, :7, :8)",
                (cod_cliente, nombre, primer_apellido, segundo_apellido, numero, correo, numero_factura, num_transaccion)
            )
            connection.commit()
            flash('Cliente registrado con éxito', 'success')
        except cx_Oracle.IntegrityError:
            flash('Número de factura o de transacción no encontrados', 'danger')
        except Exception as e:
            flash(f'Error al registrar el cliente: {str(e)}', 'danger')
        return redirect(url_for('clientes'))

    try:
        cursor.execute("SELECT * FROM CLIENTES")
        clientes = cursor.fetchall()
        if not clientes:
            flash('No se encontraron clientes en la base de datos.', 'warning')
    except Exception as e:
        flash(f'Error al obtener la lista de clientes: {str(e)}', 'danger')
        clientes = []
    finally:
        cursor.close()
        connection.close()

    return render_template("Clientes.html", clientes=clientes)

@app.route("/clientes/edit/<cod_cliente>", methods=['POST'])
def edit_cliente(cod_cliente):
    nombre = request.form['nombre']
    primer_apellido = request.form['primer_apellido']
    segundo_apellido = request.form['segundo_apellido']
    numero = request.form['numero']
    correo = request.form['correo']
    numero_factura = request.form['numero_factura']
    num_transaccion = request.form['num_transaccion']

    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        cursor.execute(
            "UPDATE CLIENTES SET Nombre = :1, primerApellido = :2, segundoApellido = :3, Numero = :4, Correo = :5, "
            "numero_factura = :6, num_transaccion = :7 WHERE cod_cliente = :8",
            (nombre, primer_apellido, segundo_apellido, numero, correo, numero_factura, num_transaccion, cod_cliente)
        )
        connection.commit()
        flash('Cliente actualizado con éxito', 'success')
    except cx_Oracle.IntegrityError:
        flash('Número de factura o de transacción no encontrados', 'danger')
    except Exception as e:
        flash(f'Error al actualizar el cliente: {str(e)}', 'danger')
    finally:
        cursor.close()
        connection.close()

    return redirect(url_for('clientes'))

@app.route("/clientes/delete/<cod_cliente>", methods=['POST'])
def delete_cliente(cod_cliente):
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        cursor.execute("DELETE FROM CLIENTES WHERE cod_cliente = :1", (cod_cliente,))
        connection.commit()
        flash('Cliente eliminado con éxito', 'success')
    except cx_Oracle.IntegrityError:
        flash('No se puede eliminar el cliente debido a una violación de restricción de integridad.', 'danger')
    except Exception as e:
        flash(f'Error al eliminar el cliente: {str(e)}', 'danger')
    finally:
        cursor.close()
        connection.close()

    return redirect(url_for('clientes'))

#####################Departamentos#####################
@app.route("/departamentos", methods=['GET'])
@app.route("/Departamentos", methods=['GET'])
def departamentos():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT cod_departamento, nombre_departamento, descrip_departamento FROM departamentos")
    departamentos = cursor.fetchall()
    cursor.close()
    connection.close()
    return render_template('departamentos.html', departamentos=departamentos)

@app.route('/updateDepartamento/<codigo>', methods=['GET', 'POST'])
def update_departamento(codigo):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Obtener el departamento por su código
    if request.method == 'GET':
        cursor.execute(
            "SELECT nombre_departamento, descrip_departamento FROM departamentos WHERE cod_departamento = :1",
            (codigo,))
        departamento = cursor.fetchone()
        cursor.close()
        connection.close()
        return render_template('updateDepartamento.html', departamento=departamento)

    # Actualizar el departamento
    elif request.method == 'POST':
        nombre = request.form['nombre_departamento']
        descripcion = request.form['descripcion']
        cursor.callproc('actualizar_departamento', [codigo, nombre, descripcion])
        connection.commit()
        cursor.close()
        connection.close()
        return redirect('/departamentos')

@app.route('/eliminarDepartamento/<codigo>')
def eliminar_departamento(codigo):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.callproc('eliminar_departamento', [codigo])
    connection.commit()
    cursor.close()
    connection.close()

    return redirect('/departamentos')

@app.route('/addDepartamento', methods=['GET', 'POST'])
def add_departamento():
    if request.method == 'GET':
        return render_template('addDepartamento.html')

    if request.method == 'POST':
        nombre = request.form['nombre']
        descripcion = request.form['descripcion']
        codigo = generate_unique_code()

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.callproc('insertar_departamento', [codigo, nombre, descripcion])
        connection.commit()
        cursor.close()
        connection.close()

        return redirect('/departamentos')

def get_departamentos_eliminados():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT audit_id, cod_departamento, nombre_departamento, descrip_departamento, audit_timestamp, audit_operation FROM Departamentos_Audit ORDER BY audit_timestamp DESC")
    departamentos = cursor.fetchall()
    cursor.close()
    connection.close()
    return departamentos

@app.route('/verDepartamentosEliminados')
def ver_departamentos_eliminados():
    departamentos_eliminados = get_departamentos_eliminados()
    return render_template('ver_departamentos_eliminados.html', departamentos=departamentos_eliminados)

@app.route('/sucursal_departamentos')
def sucursal_departamentos():
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        # Llamar a la función que devuelve el cursor
        p_cursor = cursor.callfunc('FN_VISTA_SUCURSAL_DEPARTAMENTOS', cx_Oracle.CURSOR)
        sucursal_departamentos = p_cursor.fetchall()
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        print(f"Error: {error.message}")
        sucursal_departamentos = []

    cursor.close()
    connection.close()
    
    return render_template('sucursal_departamentos.html', sucursal_departamentos=sucursal_departamentos)


@app.route('/vista_sucursal_descripcion')
def vista_sucursal_descripcion():
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        cursor.execute("SELECT * FROM VISTA_SUCURSAL_DESCRIPCION")
        sucursales_descripcion = cursor.fetchall()
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        print(f"Error: {error.message}")
        sucursales_descripcion = []

    cursor.close()
    connection.close()
    
    return render_template('vista_sucursal_descripcion.html', sucursales_descripcion=sucursales_descripcion)

#####################Empleados#####################
@app.route("/empleados", methods=['GET', 'POST'])
@app.route("/Empleados", methods=['GET', 'POST'])
def empleados():
    if request.method == 'POST':
        cod_empleado = request.form.get('cod_empleado')
        nombre = request.form.get('nombre')
        primer_apellido = request.form.get('primer_apellido')
        segundo_apellido = request.form.get('segundo_apellido')
        correo = request.form.get('correo')
        numero = request.form.get('numero')
        departamento = request.form.get('departamento')

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.callproc('insertar_empleado', [cod_empleado, nombre, primer_apellido, segundo_apellido, correo, numero, departamento])
        connection.commit()

        cursor.close()
        connection.close()
        return redirect(url_for('empleados'))

    connection = get_db_connection()
    cursor = connection.cursor()
    empleados_cursor = connection.cursor()
    cursor.callproc('obtener_todos_empleados', [empleados_cursor])
    empleados = empleados_cursor.fetchall()


    cursor.execute("SELECT * FROM Departamentos")
    departamentos = cursor.fetchall()
    empleados_cursor.close()
    cursor.close()
    connection.close()

    return render_template("empleados.html", empleados=empleados, departamentos=departamentos)


@app.route("/empleados/delete/<int:cod_empleado>", methods=['POST'])
def delete_empleado(cod_empleado):
    connection = get_db_connection()
    cursor = connection.cursor()

    cursor.callproc('eliminar_empleado', [cod_empleado])
    connection.commit()
    cursor.close()
    connection.close()

    return redirect(url_for('empleados'))


@app.route("/empleados/edit/<int:cod_empleado>", methods=['POST'])
def edit_empleado(cod_empleado):
    nombre = request.form.get('nombre')
    primer_apellido = request.form.get('primer_apellido')
    segundo_apellido = request.form.get('segundo_apellido')
    correo = request.form.get('correo')
    numero = request.form.get('numero')
    departamento = request.form.get('departamento')

    connection = get_db_connection()
    cursor = connection.cursor()

    cursor.callproc('Actualizar_Empleado', [
        cod_empleado, nombre, primer_apellido, segundo_apellido, correo, numero, departamento
    ])
    connection.commit()

    cursor.close()
    connection.close()

    return redirect(url_for('empleados'))



#####################Envios#####################
@app.route("/envios", methods=['GET', 'POST'])
@app.route("/Envios", methods=['GET', 'POST'])
def envios():
    if request.method == 'POST':
        codigo_envio = request.form['codigoEnvio']
        cliente = request.form['cliente']
        direccion = request.form['direccion']

        connection = get_db_connection()
        cursor = connection.cursor()
        try:
            # Insertar en la tabla Envios
            cursor.execute(
                "INSERT INTO Envios (numero_envio, Direccion) VALUES (:1, :2)",
                (codigo_envio, direccion)
            )
            # Insertar en la tabla Envios_Clientes
            cursor.execute(
                "INSERT INTO Envios_Clientes (cod_cliente, numero_envio) VALUES (:1, :2)",
                (cliente, codigo_envio)
            )
            connection.commit()
            flash('Envío registrado con éxito', 'success')
        except cx_Oracle.IntegrityError as e:
            flash('El código de cliente no fue encontrado', 'danger')
        except Exception as e:
            flash('Error al registrar el envio: {}'.format(str(e)), 'danger')
        finally:
            cursor.close()
            connection.close()
        return redirect(url_for('envios'))

    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("""
        SELECT e.numero_envio, ec.cod_cliente, e.Direccion
        FROM Envios e
        JOIN Envios_Clientes ec ON e.numero_envio = ec.numero_envio
    """)
    envios = cursor.fetchall()
    cursor.close()
    connection.close()

    return render_template("Envios.html", envios=envios)

@app.route("/envios/edit/<codigo_envio>", methods=['POST'])
def edit_envio(codigo_envio):
    cliente = request.form['cliente']
    direccion = request.form['direccion']

    connection = get_db_connection()
    cursor = connection.cursor()
    try:
        # Actualizar en la tabla Envios
        cursor.execute(
            "UPDATE Envios SET Direccion = :1 WHERE numero_envio = :2",
            (direccion, codigo_envio)
        )
        # Actualizar en la tabla Envios_Clientes
        cursor.execute(
            "UPDATE Envios_Clientes SET cod_cliente = :1 WHERE numero_envio = :2",
            (cliente, codigo_envio)
        )
        connection.commit()
        flash('Envío actualizado con éxito', 'success')
    except cx_Oracle.IntegrityError as e:
        flash('El código de cliente no fue encontrado', 'danger')
    except Exception as e:
        flash('Error al registrar el envio: {}'.format(str(e)), 'danger')
    finally:
        cursor.close()
        connection.close()

    return redirect(url_for('envios'))

@app.route("/envios/delete/<codigo_envio>", methods=['POST'])
def delete_envio(codigo_envio):
    connection = get_db_connection()
    cursor = connection.cursor()
    try:
        cursor.execute("DELETE FROM Envios_Clientes WHERE numero_envio = :1", (codigo_envio,))
        cursor.execute("DELETE FROM Envios WHERE numero_envio = :1", (codigo_envio,))
        connection.commit()
        flash('Envío eliminado con éxito', 'success')
    except cx_Oracle.Error as e:
        flash('Error al eliminar el envío', 'danger')
    finally:
        cursor.close()
        connection.close()

    return redirect(url_for('envios'))

#####################Facturacion#####################
@app.route("/facturacion", methods=['GET'])
@app.route("/Facturacion", methods=['GET'])
def facturacion():
    return render_template("Facturacion.html")

#####################Inventario#####################
@app.route("/inventario", methods=['GET'])
@app.route("/Inventario", methods=['GET'])
def inventario():
    return render_template("Inventario.html")

#####################Pagos#####################
@app.route("/pagos", methods=['GET'])
@app.route("/Pagos", methods=['GET'])
def pagos():
    return render_template("Pagos.html")

#Procesar pagos del carrito
@app.route('/pagos', methods=['POST'])
def procesar_pagos():
    data = request.get_json()
    productos = data.get('productos', [])

    connection = get_db_connection()
    cursor = connection.cursor()

    for producto in productos:
        cod_producto = producto['cod_producto']
        cantidad = producto['cantidad'] 
        resultado = cursor.callfunc('EliminarProducto', cx_Oracle.STRING, [cod_producto, cantidad])
        if resultado != 'Compra realizada con éxito y stock actualizado.':
            return jsonify({'success': False, 'error': resultado})

    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'success': True})



#Historial de compras
@app.route('/pagos/historial', methods=['GET'])
def historial_compras():
    connection = get_db_connection()
    cursor = connection.cursor()
    
    ref_cursor = cursor.callfunc('ObtenerHistorialCompras', cx_Oracle.CURSOR)
    rows = ref_cursor.fetchall()
    columns = [col[0] for col in ref_cursor.description]
    historial = [dict(zip(columns, row)) for row in rows]  
    print("Datos enviados al cliente:", historial)

    cursor.close()
    connection.close()
    return jsonify({'success': True, 'data': historial})


#####################Productos#####################
@app.route("/productos", methods=['GET'])
@app.route("/Productos", methods=['GET'])

#Listado de todos los productos
def productos():
    conn = get_db_connection()
    cursor = conn.cursor()
    ref_cursor = cursor.var(cx_Oracle.CURSOR)
    cursor.callproc('LeerTodosLosProductos', [ref_cursor])
    
    productos = ref_cursor.getvalue().fetchall()
    
    print("Consulta ejecutada")
    print("Productos recuperados:", productos)
    
    conn.commit()
    cursor.close()
    conn.close()

    return render_template('productos.html', productos=productos)


#Eliminar un producto del tab de productos
@app.route('/delete/<int:cod_producto>', methods=['POST'])
def delete_producto(cod_producto):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.callproc('EliminarProductoLista', [cod_producto])
    
    conn.commit()
    cursor.close()
    conn.close()
    
    return redirect(url_for('productos')) 


#Crear Producto
@app.route('/productos', methods=['GET', 'POST'])
def anadirproductos():
    if request.method == 'POST':
        cod_producto = request.form['cod_producto']
        nombre = request.form['nombre']
        precio = request.form['precio']
        imagen = request.form['imagen']
        stock = request.form['stock']

        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.callproc('CrearProducto', [cod_producto, nombre, imagen, precio, stock])
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return redirect(url_for('productos'))


#Ordenar productos de orden ascendente y descendente
@app.route("/productos/ordenar", methods=['GET'])
def ordenproductos():
    orden = request.args.get('orden', 'asc')
    print(f"Orden recibido: {orden}")
    
    conn = get_db_connection()
    cursor = conn.cursor()
    productos_cursor = cursor.callfunc('obtener_productos_ordenados', cx_Oracle.CURSOR, [orden])
    productos = productos_cursor.fetchall()
    print("Productos recuperados:", productos)
    
    productos_cursor.close()
    cursor.close()
    conn.close()

    return render_template('productos.html', productos=productos)


#Mostras total de productos y precio total de todo el stock
@app.route('/productos/total_productos', methods=['GET'])
def total_productos():
    connection = get_db_connection()
    cursor = connection.cursor()

    ref_cursor = cursor.callfunc('ObtenerTotales', cx_Oracle.CURSOR)
    rows = ref_cursor.fetchall()
    columns = [col[0] for col in ref_cursor.description]
    total_stock, total_precio = rows[0]
    
    cursor.close()
    connection.close()
    
    return jsonify({'success': True, 'total_stock': total_stock, 'total_precio': total_precio})


#Trigger de CRUD de productos
@app.route('/productos/auditoria', methods=['GET'])
def auditoria_productos():
    connection = get_db_connection()
    cursor = connection.cursor()

    ref_cursor = connection.cursor()
    cursor.callproc('auditoria_productos.obtener_auditoria', [ref_cursor])
    rows = ref_cursor.fetchall()
    columns = [col[0] for col in ref_cursor.description]
    auditoria = [dict(zip(columns, row)) for row in rows]
    print("Datos enviados al cliente:", auditoria)

    cursor.close()
    connection.close()

    return jsonify({'success': True, 'data': auditoria})


#Actualizar producto
@app.route('/productos/actualizar_producto', methods=['POST'])
def actualizar_producto():
    if request.method == 'POST':
        cod_producto = request.form['cod_producto']
        nombre = request.form['nombre']
        precio = request.form['precio']
        imagen = request.form['imagen']
        stock = request.form['stock']

        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.callproc('Producto_Package.ActualizarProducto', [cod_producto, nombre, imagen, precio, stock])
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return redirect(url_for('productos'))




#####################Proveedores#####################
@app.route("/proveedores", methods=['GET', 'POST'])
@app.route("/Proveedores", methods=['GET', 'POST'])
def proveedores():
    if request.method == 'POST':
        CodProveedor = request.form.get('CodProveedor')
        nombre_proveedor = request.form.get('nombre_proveedor')
        producto_ventas = request.form.get('producto_ventas') 

        connection = get_db_connection()
        cursor = connection.cursor()

        cursor.callproc('insertar_proveedor', [CodProveedor, nombre_proveedor, producto_ventas])

        connection.commit()
        cursor.close()
        connection.close()

        return redirect(url_for('proveedores'))

    connection = get_db_connection()
    cursor = connection.cursor()

    proveedores_cursor = connection.cursor()
    cursor.callproc('Listar_Proveedores', [proveedores_cursor])

    proveedores = proveedores_cursor.fetchall()
    proveedores_cursor.close()
    cursor.close()
    connection.close()
    return render_template('proveedores.html', proveedores=proveedores)


@app.route("/proveedores/delete/<int:CodProveedor>", methods=['POST'])
def delete_proveedores(CodProveedor):
    connection = get_db_connection()
    cursor = connection.cursor()

    cursor.callproc('Eliminar_Proveedor', [CodProveedor])
    connection.commit()

    cursor.close()
    connection.close()
    return redirect(url_for('proveedores'))


@app.route("/proveedores/edit/<int:CodProveedor>", methods=['POST'])
def edit_proveedor(CodProveedor):
    nombre_proveedor = request.form.get('nombre_proveedor')
    producto_ventas = request.form.get('producto_ventas')

    connection = get_db_connection()
    cursor = connection.cursor()

    cursor.callproc('Actualizar_Proveedor', [CodProveedor, nombre_proveedor, producto_ventas])
    connection.commit()

    cursor.close()
    connection.close()

    return redirect(url_for('proveedores'))




#####################Sucursales#####################
@app.route("/sucursales", methods=['GET'])
@app.route("/Sucursales", methods=['GET'])
def sucursales():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT cod_sucursal, Correo, Direccion, Telefono FROM Sucursal")
    sucursales = cursor.fetchall()
    cursor.close()
    connection.close()
    return render_template('sucursales.html', sucursales=sucursales)

@app.route('/updateSucursal/<codigo>', methods=['GET', 'POST'])
def update_sucursal(codigo):
    connection = get_db_connection()
    cursor = connection.cursor()

    # Obtener la sucursal por su código
    if request.method == 'GET':
        cursor.execute(
            "SELECT Correo, Direccion, Telefono FROM Sucursal WHERE cod_sucursal = :1",
            (codigo,))
        sucursal = cursor.fetchone()
        cursor.close()
        connection.close()
        return render_template('updateSucursal.html', sucursal=sucursal)

    # Actualizar la sucursal
    elif request.method == 'POST':
        correo = request.form['correo']
        direccion = request.form['direccion']
        telefono = request.form['telefono']
        cursor.callproc('actualizar_sucursal', [codigo, correo, direccion, telefono])
        connection.commit()
        cursor.close()
        connection.close()
        return redirect('/sucursales')

@app.route('/eliminarSucursal/<codigo>')
def eliminar_sucursal(codigo):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.callproc('eliminar_sucursal', [codigo])
    connection.commit()
    cursor.close()
    connection.close()

    return redirect('/sucursales')

@app.route('/addSucursal', methods=['GET', 'POST'])
def add_sucursal():
    if request.method == 'GET':
        return render_template('addSucursal.html')

    if request.method == 'POST':
        correo = request.form['correo']
        direccion = request.form['direccion']
        telefono = request.form['telefono']
        codigo = generate_unique_code()

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.callproc('insertar_sucursal', [codigo, correo, direccion, telefono])
        connection.commit()
        cursor.close()
        connection.close()

        return redirect('/sucursales')

def generate_unique_code():
    while True:
        codigo = random.randint(1000, 9999)
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("SELECT COUNT(*) FROM departamentos WHERE cod_departamento = :1", (codigo,))
        count = cursor.fetchone()[0]
        cursor.close()
        connection.close()
        if count == 0:
            return codigo
        
def get_sucursales_eliminadas():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT audit_id, cod_sucursal, Correo, Direccion, Telefono, audit_timestamp, audit_operation FROM Sucursal_Audit ORDER BY audit_timestamp DESC")
    sucursales = cursor.fetchall()
    cursor.close()
    connection.close()
    return sucursales

@app.route('/verSucursalesEliminadas')
def ver_sucursales_eliminadas():
    sucursales_eliminadas = get_sucursales_eliminadas()
    return render_template('ver_sucursales_eliminadas.html', sucursales=sucursales_eliminadas)


#####################Recursos (CSS, JS, Recursos)#####################
@app.route('/css/<path:path>')
def send_css(path):
    return send_from_directory('D:/Universidad/V Cuatrimestre/Lenguajes De Base De Datos/Proyecto/Lenguaje-de-BD/FerreteriaElEncuentro/CSS', path)

@app.route('/js/<path:path>')
def send_js(path):
    return send_from_directory('D:/Universidad/V Cuatrimestre/Lenguajes De Base De Datos/Proyecto/Lenguaje-de-BD/FerreteriaElEncuentro/JS', path)

@app.route('/recursos/img/<path:path>')
def send_img(path):
    return send_from_directory('D:/Universidad/V Cuatrimestre/Lenguajes De Base De Datos/Proyecto/Lenguaje-de-BD/FerreteriaElEncuentro/Recursos/img', path)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)
