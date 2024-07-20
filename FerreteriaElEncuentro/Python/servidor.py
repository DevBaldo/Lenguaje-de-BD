from flask import Flask, render_template, send_from_directory, request, redirect, url_for
import cx_Oracle

app = Flask(
    __name__,
    template_folder='D:/Universidad/V Cuatrimestre/Lenguajes De Base De Datos/Proyecto/Lenguaje-de-BD/FerreteriaElEncuentro/HTML',
    static_folder=None
)

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
@app.route("/clientes", methods=['GET'])
@app.route("/Clientes", methods=['GET'])
def clientes():
    return render_template("Clientes.html")


#####################Departamentos#####################
@app.route("/departamentos", methods=['GET'])
@app.route("/Departamentos", methods=['GET'])
def departamentos():
    return render_template("Departamentos.html")


#####################Empleados#####################
@app.route("/empleados", methods=['GET'])
@app.route("/Empleados", methods=['GET'])
def empleados():
    return render_template("Empleados.html")


#####################Envios#####################
@app.route("/envios", methods=['GET'])
@app.route("/Envios", methods=['GET'])
def envios():
    return render_template("Envios.html")


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
@app.route("/proveedores", methods=['GET'])
@app.route("/Proveedores", methods=['GET'])
def proveedores():
    return render_template("Proveedores.html")


#####################Sucursales#####################
@app.route("/sucursales", methods=['GET'])
@app.route("/Sucursales", methods=['GET'])
def sucursales():
    return render_template("Sucursales.html")


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
