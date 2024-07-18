from flask import Flask, render_template, send_from_directory

app = Flask(
    __name__,
    template_folder= r'C:\Users\Morgan\Documents\Lenguaje-de-BD\FerreteriaElEncuentro\HTML',
    static_folder=None
)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/clientes", methods=['GET'])
@app.route("/Clientes", methods=['GET'])
def clientes():
    return render_template("Clientes.html")

@app.route("/departamentos", methods=['GET'])
@app.route("/Departamentos", methods=['GET'])
def departamentos():
    return render_template("Departamentos.html")

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
