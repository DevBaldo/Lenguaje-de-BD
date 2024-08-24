from flask import Flask, render_template, send_from_directory
import cx_Oracle

app = Flask(
    __name__,
    template_folder='C:/Users/jmarin/LenguajeBaseDatosProyecto/Lenguaje-de-BD/FerreteriaElEncuentro/HTML',
    static_folder=None
)


class Config:
    ORACLE_USER = 'JESS'
    ORACLE_PASSWORD = 'Jm12345'
    ORACLE_DSN = 'localhost:1521/orcl'
    TNS_ADMIN = r'C:\Users\jmarin\Oracle\network\admin'

def get_db_connection():
    connection = cx_Oracle.connect(
        user=Config.ORACLE_USER,
        password=Config.ORACLE_PASSWORD,
        dsn=Config.ORACLE_DSN,

    )
    return connection

@app.route("/")
def index():
    return render_template("index.html")

#####################Clientes#####################
@app.route("/clientes", methods=['GET'])
@app.route("/Clientes", methods=['GET'])
def clientes():
    if request.method == 'POST':
        codigo = request.form['codigo']
        nombre = request.form['nombre']
        apellido = request.form['apellido']
        telefono = request.form['telefono']
        correo = request.form['correo']

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute(
            "INSERT INTO CLIENTES (CODIGO, NOMBRE, APELLIDO, TELEFONO, CORREO) VALUES (:1, :2, :3, :4, :5)",
            (codigo, nombre, apellido, telefono, correo)
        )
        connection.commit()
        cursor.close()
        connection.close()
        return redirect(url_for('clientes'))

    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM CLIENTES")
    clientes = cursor.fetchall()
    cursor.close()
    connection.close()

    return render_template("Clientes.html", clientes=clientes)

@app.route("/clientes/edit/<codigo>", methods=['POST'])
def edit_cliente(codigo):
    nombre = request.form['nombre']
    apellido = request.form['apellido']
    telefono = request.form['telefono']
    correo = request.form['correo']

    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute(
        "UPDATE CLIENTES SET NOMBRE = :1, APELLIDO = :2, TELEFONO = :3, CORREO = :4 WHERE CODIGO = :5",
        (nombre, apellido, telefono, correo, codigo)
    )
    connection.commit()
    cursor.close()
    connection.close()

    return redirect(url_for('clientes'))

@app.route("/clientes/delete/<codigo>", methods=['POST'])
def delete_cliente(codigo):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("DELETE FROM CLIENTES WHERE CODIGO = :1", (codigo,))
    connection.commit()
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
        cod_empleado = request.form['cod_empleado']
        nombre = request.form['nombre']
        primer_apellido = request.form['primer_apellido']
        segundo_apellido = request.form['segundo_apellido']
        correo = request.form['correo']
        numero = request.form['numero']
        departamento = request.form['departamento']

        print(f"Empleado registrado: {cod_empleado}, {nombre}, {primer_apellido}, {segundo_apellido}, {correo}, {numero}, {departamento}")

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.callproc('insertar_empleado', [nombre, primer_apellido, segundo_apellido, correo, numero, departamento])
        connection.commit()
        cursor.close()
        connection.close()
        return redirect(url_for('empleados'))

    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM Vista_Empleados")
    empleados = cursor.fetchall()
    cursor.close()
    connection.close()

    return render_template("Empleados.html", empleados=empleados)

@app.route("/empleados/edit/<int:cod_empleado>", methods=['GET', 'POST'])
def edit_empleado(cod_empleado):
    connection = get_db_connection()
    cursor = connection.cursor()

    if request.method == 'GET':
        cursor.callproc('obtener_empleado', [cod_empleado, cursor.var(cx_Oracle.STRING), cursor.var(cx_Oracle.STRING), cursor.var(cx_Oracle.STRING), cursor.var(cx_Oracle.STRING), cursor.var(cx_Oracle.STRING), cursor.var(cx_Oracle.NUMBER)])
        empleado = cursor.fetchone()
        cursor.close()
        connection.close()
        return render_template('edit_empleado.html', empleado=empleado)

    elif request.method == 'POST':
        nombre = request.form['nombre']
        primer_apellido = request.form['primer_apellido']
        segundo_apellido = request.form['segundo_apellido']
        correo = request.form['correo']
        numero = request.form['numero']
        departamento = request.form['departamento']

        print(f"Empleado actualizado: {cod_empleado}, {nombre}, {primer_apellido}, {segundo_apellido}, {correo}, {numero}, {departamento}")

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.callproc('actualizar_empleado', [cod_empleado, nombre, primer_apellido, segundo_apellido, correo, numero, departamento])
        connection.commit()
        cursor.close()
        connection.close()
        return redirect(url_for('empleados'))

@app.route("/empleados/delete/<int:cod_empleado>", methods=['POST'])
def delete_empleado(cod_empleado):
    print(f"Empleado eliminado: {cod_empleado}")

    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.callproc('eliminar_empleado', [cod_empleado])
    connection.commit()
    cursor.close()
    connection.close()

    return redirect(url_for('empleados'))

@app.route("/empleados/count")
def count_employees():
    connection = get_db_connection()
    cursor = connection.cursor()
    count = cursor.callfunc('contar_empleados_func', cx_Oracle.NUMBER)
    cursor.close()
    connection.close()
    return f"Total de empleados: {count}"

if __name__ == '__main__':
    app.run(debug=True)

#####################Envios#####################
@app.route("/envios", methods=['GET'])
@app.route("/Envios", methods=['GET'])
def envios():
    if request.method == 'POST':
        codigo_envio = request.form['codigoEnvio']
        cliente = request.form['cliente']
        direccion = request.form['direccion']
        fecha_envio_str = request.form['fechaEnvio']
        estado = request.form['estado']

        fecha_envio = datetime.strptime(fecha_envio_str, '%Y-%m-%d').date()
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute(
            "INSERT INTO ENVIOS (CODIGO_ENVIO, CLIENTE, DIRECCION, FECHA_ENVIO, ESTADO) VALUES (:1, :2, :3, :4, :5)",
            (codigo_envio, cliente, direccion, fecha_envio, estado)
        )
        connection.commit()
        cursor.close()
        connection.close()
        return redirect(url_for('envios'))

    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM ENVIOS")
    envios = cursor.fetchall()
    cursor.close()
    connection.close()

    return render_template("Envios.html", envios=envios)

@app.route("/envios/edit/<codigo_envio>", methods=['POST'])
def edit_envio(codigo_envio):
    cliente = request.form['cliente']
    direccion = request.form['direccion']
    fecha_envio_str = request.form['fechaEnvio']
    estado = request.form['estado']

    fecha_envio = datetime.strptime(fecha_envio_str, '%Y-%m-%d').date()
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute(
        "UPDATE ENVIOS SET CLIENTE = :1, DIRECCION = :2, FECHA_ENVIO = :3, ESTADO = :4 WHERE CODIGO_ENVIO = :5",
        (cliente, direccion, fecha_envio, estado, codigo_envio)
    )
    connection.commit()
    cursor.close()
    connection.close()

    return redirect(url_for('envios'))

@app.route("/envios/delete/<codigo_envio>", methods=['POST'])
def delete_envio(codigo_envio):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("DELETE FROM ENVIOS WHERE CODIGO_ENVIO = :1", (codigo_envio,))
    connection.commit()
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

#####################Productos#####################
@app.route("/productos", methods=['GET'])
@app.route("/Productos", methods=['GET'])
def productos():
    try:
        conn = get_db_connection()
        if conn is None:
            raise Exception("No se pudo establecer la conexión a la base de datos.") 
        cursor = conn.cursor()
        cursor.execute("SELECT cod_producto, nombre, imagen, precio FROM PRODUCTOS")
        print("Consulta ejecutada")
        
        productos = cursor.fetchall()
        print("Productos recuperados:", productos) 
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"Error al ejecutar la consulta: {e}")
        productos = []

    return render_template('productos.html', productos=productos)

@app.route('/delete/<int:producto_id>', methods=['POST'])
def delete_producto(producto_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('DELETE FROM Productos WHERE cod_producto = :id', [producto_id])
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('productos'))

@app.route('/productos', methods=['GET', 'POST'])
def anadirproductos():
    if request.method == 'POST':
        cod_producto = request.form['cod_producto']
        nombre = request.form['nombre']
        precio = request.form['precio']
        imagen = request.form['imagen']
        
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute(
            'INSERT INTO Productos (cod_producto, nombre, imagen, precio) VALUES (:cod_producto, :nombre, :imagen, :precio)',
            {'cod_producto': cod_producto,'nombre': nombre, 'imagen': imagen, 'precio': precio}
        )
        conn.commit()
        cursor.close()
        conn.close()
        
        return redirect(url_for('productos'))

#####################Proveedores#####################
@app.route("/proveedores", methods=['GET', 'POST'])
@app.route("/Proveedores", methods=['GET', 'POST'])
def proveedores():
    if request.method == 'POST':
        CodProveedor  = request.form['CodProveedor ']
        nombre_proveedor = request.form['nombre_proveedor']
        producto_ventas = request.form['producto_ventas']
        print(f"Proveedor registrado: {CodProveedor }, {nombre_proveedor}, {producto_ventas}")

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute(
            "INSERT INTO Proveedores (CodProveedor, nombre_proveedor, producto_ventas) VALUES (:1, :2, :3)",
            (CodProveedor , nombre_proveedor, producto_ventas)
        )
        connection.commit()
        cursor.close()
        connection.close()
        return redirect(url_for('proveedores'))

    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM Proveedores")
    proveedores = cursor.fetchall()
    cursor.close()
    connection.close()
    return render_template("Proveedores.html", proveedores=proveedores)

@app.route("/proveedores/edit/<CodProveedor >", methods=['POST'])
def edit_proveedor(CodProveedor ):
    nombre_proveedor = request.form['nombre_proveedor']
    producto_ventas = request.form['producto_ventas']
    print(f"Proveedor actualizado: {CodProveedor }, {nombre_proveedor}, {producto_ventas}")

    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute(
        "UPDATE Proveedores SET nombre_proveedor = :1, producto_ventas = :2 WHERE CodProveedor = :3",
        (nombre_proveedor, producto_ventas, CodProveedor )
    )
    connection.commit()
    cursor.close()
    connection.close()
    return redirect(url_for('proveedores'))

@app.route("/proveedores/delete/<CodProveedor >", methods=['POST'])
def delete_proveedor(CodProveedor ):
    print(f"Proveedor eliminado: {CodProveedor }")

    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("DELETE FROM Proveedores WHERE CodProveedor = :1", (CodProveedor ,))
    connection.commit()
    cursor.close()
    connection.close()
    return redirect(url_for('proveedores'))

@app.route('/verProveedoresEliminados')
def ver_proveedores_eliminados():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT id_auditoria, CodProveedor, nombre_proveedor, producto_ventas, operacion, fecha FROM auditoria_proveedores ORDER BY fecha DESC")
    proveedores_eliminados = cursor.fetchall()
    cursor.close()
    connection.close()
    return render_template('ver_proveedores_eliminados.html', proveedores=proveedores_eliminados)

@app.route('/obtenerProveedoresPorProducto/<producto>', methods=['GET'])
def obtener_proveedores_por_producto(producto):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT CodProveedor, nombre_proveedor FROM vista_proveedores_por_producto WHERE producto_ventas = :1", (producto,))
    proveedores = cursor.fetchall()
    cursor.close()
    connection.close()
    return render_template('proveedores_por_producto.html', proveedores=proveedores, producto=producto)

@app.route('/obtenerNombreProveedor/<CodProveedor >', methods=['GET'])
def obtener_nombre_proveedor(CodProveedor ):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.callproc('obtener_nombre_proveedor', [CodProveedor , cursor.var(cx_Oracle.STRING), cursor.var(cx_Oracle.STRING)])
    nombre_proveedor = cursor.var(cx_Oracle.STRING).getvalue()
    cursor.close()
    connection.close()
    return f'Nombre del proveedor: {nombre_proveedor}'

@app.route('/obtenerProductoVentas/<CodProveedor >', methods=['GET'])
def obtener_producto_ventas(CodProveedor ):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.callproc('obtener_producto_ventas', [CodProveedor , cursor.var(cx_Oracle.STRING)])
    producto_ventas = cursor.var(cx_Oracle.STRING).getvalue()
    cursor.close()
    connection.close()
    return f'Producto de ventas: {producto_ventas}'

@app.route('/contarProveedores', methods=['GET'])
def contar_proveedores():
    connection = get_db_connection()
    cursor = connection.cursor()
    count = cursor.callfunc('contar_proveedores_func', int)
    cursor.close()
    connection.close()
    return f'Número de proveedores: {count}'

if __name__ == '__main__':
    app.run(debug=True)

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
    return send_from_directory('C:/Users/jmarin/LenguajeBaseDatosProyecto/Lenguaje-de-BD/FerreteriaElEncuentro/CSS', path)

@app.route('/js/<path:path>')
def send_js(path):
    return send_from_directory('C:/Users/jmarin/LenguajeBaseDatosProyecto/Lenguaje-de-BD/FerreteriaElEncuentro/JS', path)

@app.route('/recursos/img/<path:path>')
def send_img(path):
    return send_from_directory('C:/Users/jmarin/LenguajeBaseDatosProyecto/Lenguaje-de-BD/FerreteriaElEncuentro/Recursos/img', path)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)
