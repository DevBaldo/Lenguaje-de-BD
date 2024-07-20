from flask import Flask, render_template, send_from_directory, request, redirect, url_for
import cx_Oracle
from datetime import datetime

app = Flask(
    __name__,
    template_folder=r'C:\Users\Morgan\Documents\Lenguaje-de-BD\FerreteriaElEncuentro\HTML',
    static_folder=None
)

# Configuración de la base de datos Oracle
class Config:
    ORACLE_USER = 'proyecto'
    ORACLE_PASSWORD = '123'
    ORACLE_DSN ='localhost:1521/ORCL'

def get_db_connection():
    connection = cx_Oracle.connect(
        user=Config.ORACLE_USER,
        password=Config.ORACLE_PASSWORD,
        dsn=Config.ORACLE_DSN
    )
    return connection

# CRUD para Clientes
@app.route("/")
def index():
    return render_template("index.html")

@app.route("/clientes", methods=['GET', 'POST'])
@app.route("/Clientes", methods=['GET', 'POST'])
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

# CRUD para Envios
@app.route("/envios", methods=['GET', 'POST'])
@app.route("/Envios", methods=['GET', 'POST'])
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

@app.route("/departamentos", methods=['GET'])
@app.route("/Departamentos", methods=['GET'])
def departamentos():
    return render_template("Departamentos.html")

@app.route("/empleados", methods=['GET'])
@app.route("/Empleados", methods=['GET'])
def empleados():
    return render_template("Empleados.html")

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

@app.route("/sucursales", methods=['GET'])
@app.route("/Sucursales", methods=['GET'])
def sucursales():
    return render_template("Sucursales.html")

@app.route('/css/<path:path>')
def send_css(path):
    return send_from_directory(r'C:\Users\Morgan\Documents\Lenguaje-de-BD\FerreteriaElEncuentro\CSS', path)

@app.route('/js/<path:path>')
def send_js(path):
    return send_from_directory(r'C:\Users\Morgan\Documents\Lenguaje-de-BD\FerreteriaElEncuentro\JS', path)

@app.route('/recursos/img/<path:path>')
def send_img(path):
    return send_from_directory(r'C:\Users\Morgan\Documents\Lenguaje-de-BD\FerreteriaElEncuentro\Recursos\img', path)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)