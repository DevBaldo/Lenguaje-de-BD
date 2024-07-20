from flask import Flask, render_template, send_from_directory, redirect, request

import configparser
import random

import cx_Oracle
import uuid

app = Flask(
    __name__,
    template_folder='C:/Users/USUARIO/Documents/Lenguaje de Datos/prueba3.0/Lenguaje-de-BD/FerreteriaElEncuentro/HTML',
    static_folder= 'C:/Users/USUARIO/Documents/Lenguaje de Datos/prueba3.0/Lenguaje-de-BD/FerreteriaElEncuentro/static'
)


@app.route("/")
def index():
    return render_template("index.html")

@app.route("/clientes", methods=['GET'])
@app.route("/Clientes", methods=['GET'])
def clientes():
    return render_template("Clientes.html")


@app.route("/empleados", methods=['GET'])
@app.route("/Empleados", methods=['GET'])
def empleados():
    return render_template("Empleados.html")

@app.route("/envios", methods=['GET'])
@app.route("/Envios", methods=['GET'])
def envios():
    return render_template("Envios.html")

@app.route("/facturacion", methods=['GET'])
@app.route("/Facturacion", methods=['GET'])
def facturacion():
    return render_template("Facturacion.html")

@app.route("/inventario", methods=['GET'])
@app.route("/Inventario", methods=['GET'])
def inventario():
    return render_template("Inventario.html")

@app.route("/pagos", methods=['GET'])
@app.route("/Pagos", methods=['GET'])
def pagos():
    return render_template("Pagos.html")

@app.route("/productos", methods=['GET'])
@app.route("/Productos", methods=['GET'])
def productos():
    return render_template("productos.html")

@app.route("/proveedores", methods=['GET'])
@app.route("/Proveedores", methods=['GET'])
def proveedores():
    return render_template("Proveedores.html")


def get_db_connection():
    config = configparser.ConfigParser()
    config.read('config.ini')
    user = config['database']['user']
    password = config['database']['password']
    host = config['database']['host']
    port = config['database']['port']
    service_name = config['database']['service_name']
    # Create the dsn
    dsn = cx_Oracle.makedsn(host, port, service_name=service_name)
    # Connection to DB
    connection = cx_Oracle.connect(
        user=user,
        password=password,
        dsn=dsn
    )
    return connection


@app.route('/departamentos')
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


@app.route('/sucursales')
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





@app.route('/css/<path:path>')
def send_css(path):
    return send_from_directory('C:/Users/USUARIO/Documents/Lenguaje de Datos/prueba3.0/Lenguaje-de-BD/FerreteriaElEncuentro/CSS', path)
@app.route('/js/<path:path>')
def send_js(path):
    return send_from_directory('C:/Users/USUARIO/Documents/Lenguaje de Datos/prueba3.0/Lenguaje-de-BD/FerreteriaElEncuentro/JS', path)

@app.route('/recursos/img/<path:path>')
def send_img(path):
    return send_from_directory('C:/Users/USUARIO/Documents/Lenguaje de Datos/prueba3.0/Lenguaje-de-BD/FerreteriaElEncuentro/Recursos/img', path)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)

connection = get_db_connection()