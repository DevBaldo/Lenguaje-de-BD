--Table: proveedores
CREATE TABLE Proveedores (
    CodProveedor INT PRIMARY KEY,
    nombre_proveedor VARCHAR2(100),
    producto_ventas VARCHAR2(100)
);

-- Table: Sucursal
CREATE TABLE Sucursal (
    cod_sucursal INT PRIMARY KEY,
    Correo VARCHAR2(100),
    Direccion VARCHAR2(200),
    Telefono VARCHAR2(20)
);

-- Table: Proveedores_Sucursal
CREATE TABLE Proveedores_Sucursal (
    cod_proveedor INT,
    cod_sucursal INT,
    FOREIGN KEY (cod_proveedor) REFERENCES Proveedores(CodProveedor),
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal)
);

-- Table: Departamentos
CREATE TABLE Departamentos (
    cod_departamento INT PRIMARY KEY,
    nombre_departamento VARCHAR2(100),
    descrip_departamento VARCHAR2(200)
);

-- INSERT INTO Departamentos(cod_departamento,nombre_departamento,descrip_departamento) VALUES(1,'Departamento de Finanzas', 'Responsable de gestionar los recursos financieros');
-- INSERT INTO Departamentos(cod_departamento,nombre_departamento,descrip_departamento) VALUES(2,'Departamento de Cobros', 'Responsable de gestionar los cobros.');
-- INSERT INTO Departamentos(cod_departamento,nombre_departamento,descrip_departamento) VALUES(3,'Departamento de Recursos Huamnos', 'Responsable de gestionar los recursos humanos de la empresa');


-- Table: Empleados
CREATE TABLE Empleados (
    cod_empleado INT PRIMARY KEY,
    nombre VARCHAR2(100),
    primer_apellido VARCHAR2(100),
    segundo_apellido VARCHAR2(100),
    correo VARCHAR2(100),
    numero VARCHAR2(20),
    departamento INT,
    FOREIGN KEY (departamento) REFERENCES Departamentos(cod_departamento)
);

-- Table: Sucursal_Departamentos
CREATE TABLE Sucursal_Departamentos (
    cod_sucursal INT,
    cod_departamento INT,
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal),
    FOREIGN KEY (cod_departamento) REFERENCES Departamentos(cod_departamento)
);

-- Table: Inventarios
CREATE TABLE Inventarios (
    cod_inventario INT PRIMARY KEY,
    cod_sucursal INT,
    Cantidad INT,
    FechaIngreso DATE,
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal)
);

-- Table: Productos
CREATE TABLE Productos (
    cod_producto INT PRIMARY KEY,
    nombre VARCHAR2(100),
    imagen VARCHAR2(200),
    precio NUMBER (10,2),
    cod_inventario INT,
    stock INT,
    FOREIGN KEY (cod_inventario) REFERENCES Inventarios(cod_inventario)
);


INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(1, 'Taladro', 'https://http2.mlstatic.com/D_NQ_NP_633420-MLA45467093493_042021-F.jpg', 50000, 10);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(2, 'Martillo de garra', 'https://brooksdollar.com/wp-content/uploads/2019/11/Stalwart-Steel-Claw-Hammer.jpg', 10000, 20);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(3, 'Destornillador plano', 'https://ferreteriavidri.com/images/items/large/92301.jpg', 5000, 30);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(4, 'Brocas para taladro', 'https://images-na.ssl-images-amazon.com/images/I/61XPTBYUNZL._SL1200_.jpg', 2000, 15);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(5, 'Llave inglesa ajustable', 'https://images-na.ssl-images-amazon.com/images/I/51gL3zbx6OL._SL1005_.jpg', 3000, 25);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(6, 'Llave de tubo', 'https://www.ferrisariato.com/wp-content/uploads/2020/07/40304302_01.jpg', 4500, 10);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(7, 'Sierra de calar', 'https://catalogosmart.online/wp-content/uploads/2022/04/Sierra-de-calar-Bosch.jpg', 45000, 5);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(8, 'Cinta métrica', 'https://ferreteriavidri.com/images/items/large/40886.jpg', 6000, 40);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(9, 'Nivel de burbuja', 'https://como-funciona.co/wp-content/uploads/2019/08/Como-funciona-un-nivel-de-burbuja-torpedo.jpg', 9000, 12);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(10, 'Alicate universal', 'https://m.media-amazon.com/images/I/41Cy2dvF8tL.jpg', 5500, 18);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(11, 'Tenazas', 'https://vega.cr/wp-content/uploads/imagenes/N_84-281.jpg', 10000, 8);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(12, 'Cinta aislante', 'https://images.implementos.cl/img/1000/HERCAR0040-3.jpg', 2000, 50);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(13, 'Cinta de teflón', 'https://www.pronor.com.ar/images/000000JD-218102022426JD-2181020.JPG', 600, 60);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(14, 'Tornillos de madera', 'https://images-na.ssl-images-amazon.com/images/I/61La7mXoaHL._AC_SL1180_.jpg', 100, 200);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(15, 'Tornillo de metal', 'https://ferreteriavidri.com/images/items/large/36565.jpg', 50, 300);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(16, 'Clavos de acero', 'https://ferreteriavidri.com/images/items/large/3992.jpg', 2000, 150);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(17, 'Tacos de pared', 'https://lopezparra.es/1017596-thickbox_default/taco-sx-16x80-10-unidades-fischer.jpg', 200, 75);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(18, 'Tubo de PVC', 'https://aquatronics.com.co/wp-content/uploads/2016/11/tubopvc.jpg', 1000, 20);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(19, 'Abrazaderas para tubos', 'https://ferrelaeconomica.com.mx/wp-content/uploads/2020/07/AU-1.jpg', 1500, 30);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(21, 'Bisagras para puertas', 'https://assaabloy.cl/wp-content/uploads/2014/01/p17fhbot9idgqlmb1pc2a29u8s4.jpg', 3000, 22);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(22, 'Candado de seguridad', 'https://resources.claroshop.com/medios-plazavip/s2/10976/1334960/5e5999dded9a0-ph03-453-1600x1600.jpg', 4000, 18);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(23, 'Escalera plegable', 'https://images-na.ssl-images-amazon.com/images/I/41SJ5qdsh8L._SL1001_.jpg', 40000, 6);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(25, 'Cemento de contacto', 'https://www.ferreteriamonterroso.com/wp-content/uploads/2021/06/R0100033.jpg', 2250, 45);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(26, 'Pistola de silicona', 'https://s.libertaddigital.com/2021/02/08/pistola-de-silicona-electrica-tilswall-tsw-ggeu.jpg', 7000, 12);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(28, 'Rodillos para pintura', 'https://industriasmastder.com/wp-content/uploads/2021/03/949-Rodillo-Lana-Natural-para-pintura-Epoxica-9.jpg', 4000, 30);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(29, 'Taladro percutor', 'https://aritrans.cl/wp-content/uploads/2022/03/Taladro-Percutor-13-mm-1.100W-Dewalt-1-600x600.jpg', 25000, 8);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(30, 'Llave de impacto', 'https://minotauro.com.mx/wp-content/uploads/2021/05/LLAVE-DE-IMPACTO-DTW301RTJ.jpg', 40000, 10);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(31, 'Cortafríos', 'https://www.dateriumsystem.com/appfiles/clientes/308/catalogo/171151_2.jpg', 5000, 15);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(32, 'Esmeril angular', 'https://ferreteriavidri.com/images/items/large/143870.jpg', 35000, 9);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(33, 'Acha', 'https://cdn.chausson.fr/catalog-image/1822eeda-91c0-44e6-ac70-578a59361f0e/600-600/hach.png', 26000, 7);

INSERT INTO Productos (cod_producto, nombre, imagen, precio, stock) VALUES
(34, 'Pistola de calor', 'https://www.atrial.com.co/wp-content/uploads/2021/05/pistola-de-calor-profesional-2000-w-841.jpg', 50000, 4);

commit;


-- Table: Facturacion
CREATE TABLE Facturacion (
    numero_factura INT PRIMARY KEY,
    cod_producto INT,
    FOREIGN KEY (cod_producto) REFERENCES Productos(cod_producto)
);

-- Table: Pagos
CREATE TABLE Pagos (
    num_transaccion INT PRIMARY KEY,
    forma_pago VARCHAR2(50)
);
-- Table: Clientes
CREATE TABLE Clientes (
    cod_cliente INT PRIMARY KEY,
    Nombre VARCHAR2(100),
    primerApellido VARCHAR2(100),
    segundoApellido VARCHAR2(100),
    Numero VARCHAR2(20),
    Correo VARCHAR2(100),
    numero_factura INT,
    num_transaccion INT,
    FOREIGN KEY (numero_factura) REFERENCES Facturacion(numero_factura),
    FOREIGN KEY (num_transaccion) REFERENCES Pagos(num_transaccion)
);


-- Table: Productos_Clientes
CREATE TABLE Productos_Clientes (
    cod_producto INT,
    cod_cliente INT,
    FOREIGN KEY (cod_producto) REFERENCES Productos(cod_producto),
    FOREIGN KEY (cod_cliente) REFERENCES Clientes(cod_cliente)
);

-- Table: Envios
CREATE TABLE Envios (
    numero_envio INT PRIMARY KEY,
    Direccion VARCHAR2(200)
);

-- Table: Envios_Clientes
CREATE TABLE Envios_Clientes (
    cod_cliente INT,
    numero_envio INT,
    FOREIGN KEY (cod_cliente) REFERENCES Clientes(cod_cliente),
    FOREIGN KEY (numero_envio) REFERENCES Envios(numero_envio)
);

-- Table: Forma_Pago
CREATE TABLE Forma_Pago (
    num_transaccion INT PRIMARY KEY,
    forma_pago VARCHAR2(50)
);


--Historial de compras
CREATE TABLE HistorialCompras (
    id_historial INT PRIMARY KEY,
    cod_producto INT,
    nombre VARCHAR2(100),
    imagen VARCHAR2(200),
    precio NUMBER (10,2),
    fecha_compra DATE,
    cantidad INT
);

CREATE SEQUENCE HistorialCompras_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
CREATE TABLE Eventos_Productos (
    id_evento NUMBER PRIMARY KEY,
    cod_producto INT,
    nombre VARCHAR (50),
    tipo_evento VARCHAR2(20),
    stock INT,
    fecha_evento TIMESTAMP
);

CREATE SEQUENCE Eventos_Productos_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE; 
    
--Login
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY,
    email VARCHAR2(50) UNIQUE NOT NULL,
    contrasena VARCHAR2(255) NOT NULL
);


CREATE SEQUENCE usuarios_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

SELECT usuarios_seq.NEXTVAL FROM dual;

INSERT INTO Usuarios (id_usuario, email, contrasena)
VALUES (usuarios_seq.NEXTVAL, 'admin@dominio.com', '$2b$12$gKZcMn9QVvyXoP60rtr1neh5UpXLSOXLoazMSC.3EqCDdqmvGKxpy');
SELECT * FROM Usuarios;
commit;


    
--------------------------------------------------------------------Division entre tablas y prod almacenados, funciones, paquetes, triggers, views-----------------------------------------------------

-------------------------------------------------------------------Sucursal----------------------------------------------------------------------------------------------------------------------------
--Procedimiento para insertar una nueva sucursal
CREATE OR REPLACE PROCEDURE insertar_sucursal(
    p_cod_sucursal IN Sucursal.cod_sucursal%TYPE,
    p_correo IN Sucursal.Correo%TYPE,
    p_direccion IN Sucursal.Direccion%TYPE,
    p_telefono IN Sucursal.Telefono%TYPE
) IS
BEGIN
    INSERT INTO Sucursal (cod_sucursal, Correo, Direccion, Telefono)
    VALUES (p_cod_sucursal, p_correo, p_direccion, p_telefono);
END insertar_sucursal;
/


--Procedimiento para actualizar una sucursal
CREATE OR REPLACE PROCEDURE actualizar_sucursal(
    p_cod_sucursal IN Sucursal.cod_sucursal%TYPE,
    p_correo IN Sucursal.Correo%TYPE,
    p_direccion IN Sucursal.Direccion%TYPE,
    p_telefono IN Sucursal.Telefono%TYPE
) IS
BEGIN
    UPDATE Sucursal
    SET Correo = p_correo,
        Direccion = p_direccion,
        Telefono = p_telefono
    WHERE cod_sucursal = p_cod_sucursal;
END actualizar_sucursal;
/

--Procedimiento para eliminar una sucursal
CREATE OR REPLACE PROCEDURE eliminar_sucursal(
    p_cod_sucursal IN Sucursal.cod_sucursal%TYPE
) IS
BEGIN
    DELETE FROM Sucursal WHERE cod_sucursal = p_cod_sucursal;
END eliminar_sucursal;


-----Eliminacion de politica de llaves foraneas para poder eliminar las sucursales en cascada
SELECT constraint_name, table_name, column_name
FROM all_cons_columns
WHERE constraint_name = 'SYS_C007506';

SELECT constraint_name
FROM user_constraints
WHERE table_name = 'PROVEEDORES_SUCURSAL' AND constraint_type = 'R';

SELECT constraint_name, table_name, column_name
FROM user_cons_columns
WHERE constraint_name = 'SYS_C007510';


-- Eliminar la restricción SYS_C007505
ALTER TABLE PROVEEDORES_SUCURSAL
DROP CONSTRAINT SYS_C007505;

-- Eliminar la restricción SYS_C007506
ALTER TABLE PROVEEDORES_SUCURSAL
DROP CONSTRAINT SYS_C007506;


-- Agregar restricción con ON DELETE CASCADE
ALTER TABLE PROVEEDORES_SUCURSAL
ADD CONSTRAINT fk_cod_sucursal
FOREIGN KEY (COD_SUCURSAL)
REFERENCES SUCURSAL (COD_SUCURSAL)
ON DELETE CASCADE;

ALTER TABLE SUCURSAL_DEPARTAMENTOS
DROP CONSTRAINT SYS_C007510;

ALTER TABLE SUCURSAL_DEPARTAMENTOS
ADD CONSTRAINT fk_cod_sucursal_departamentos
FOREIGN KEY (COD_SUCURSAL)
REFERENCES SUCURSAL (COD_SUCURSAL)
ON DELETE CASCADE;

SELECT *
FROM USER_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'SYS_C007513';

ALTER TABLE INVENTARIOS
DROP CONSTRAINT SYS_C007513;

ALTER TABLE INVENTARIOS
ADD CONSTRAINT fk_sucursal
FOREIGN KEY (COD_SUCURSAL)
REFERENCES SUCURSAL (COD_SUCURSAL)
ON DELETE CASCADE;


-------------------------------------------------------------------DEPARTAMENTO----------------------------------------------------------------------------------------------------------------------------
--Procedimiento para insertar un nuevo departamento
CREATE OR REPLACE PROCEDURE insertar_departamento(
    p_cod_departamento IN Departamentos.cod_departamento%TYPE,
    p_nombre_departamento IN Departamentos.nombre_departamento%TYPE,
    p_descrip_departamento IN Departamentos.descrip_departamento%TYPE
) IS
BEGIN
    INSERT INTO Departamentos (cod_departamento, nombre_departamento, descrip_departamento)
    VALUES (p_cod_departamento, p_nombre_departamento, p_descrip_departamento);
END insertar_departamento;
/

--Procedimiento para actualizar un departamento
CREATE OR REPLACE PROCEDURE actualizar_departamento(
    p_cod_departamento IN Departamentos.cod_departamento%TYPE,
    p_nombre_departamento IN Departamentos.nombre_departamento%TYPE,
    p_descrip_departamento IN Departamentos.descrip_departamento%TYPE
) IS
BEGIN
    UPDATE Departamentos
    SET nombre_departamento = p_nombre_departamento,
        descrip_departamento = p_descrip_departamento
    WHERE cod_departamento = p_cod_departamento;
END actualizar_departamento;
/

CREATE OR REPLACE PROCEDURE eliminar_departamento(
    p_cod_departamento IN Departamentos.cod_departamento%TYPE
) IS
BEGIN
    DELETE FROM Departamentos WHERE cod_departamento = p_cod_departamento;
END eliminar_departamento;

--Tabla de Auditoria Departamentos
CREATE TABLE Departamentos_Audit (
    audit_id INT PRIMARY KEY,
    cod_departamento INT,
    nombre_departamento VARCHAR2(100),
    descrip_departamento VARCHAR2(200),
    audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    audit_operation VARCHAR2(10)
);

--Tabla de Auditoria sucursal
CREATE TABLE Sucursal_Audit (
    audit_id INT PRIMARY KEY,
    cod_sucursal INT,
    Correo VARCHAR2(100),
    Direccion VARCHAR2(200),
    Telefono VARCHAR2(20),
    audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    audit_operation VARCHAR2(10)
);

CREATE SEQUENCE dept_audit_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE suc_audit_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_departamentos_audit
AFTER DELETE ON Departamentos
FOR EACH ROW
BEGIN
    INSERT INTO Departamentos_Audit (
        audit_id, cod_departamento, nombre_departamento, descrip_departamento, audit_operation
    ) VALUES (
        dept_audit_seq.NEXTVAL,
        :OLD.cod_departamento,
        :OLD.nombre_departamento,
        :OLD.descrip_departamento,
        'DELETE'
    );
END;

CREATE OR REPLACE TRIGGER trg_sucursal_audit
AFTER DELETE ON Sucursal
FOR EACH ROW
BEGIN
    INSERT INTO Sucursal_Audit (
        audit_id, cod_sucursal, Correo, Direccion, Telefono, audit_operation
    ) VALUES (
        suc_audit_seq.NEXTVAL,
        :OLD.cod_sucursal,
        :OLD.Correo,
        :OLD.Direccion,
        :OLD.Telefono,
        'DELETE'
    );
END;

--vista Sucursal_Departamentos
CREATE OR REPLACE VIEW VISTA_SUCURSAL_DEPARTAMENTOS AS
SELECT 
    sd.cod_sucursal,
    s.Correo,
    s.Direccion,
    s.Telefono,
    sd.cod_departamento,
    d.nombre_departamento,
    d.descrip_departamento
FROM 
    Sucursal_Departamentos sd
JOIN 
    Sucursal s ON sd.cod_sucursal = s.cod_sucursal
JOIN 
    Departamentos d ON sd.cod_departamento = d.cod_departamento;
    
    
--funcion que devuelve un cursor 
CREATE OR REPLACE FUNCTION FN_VISTA_SUCURSAL_DEPARTAMENTOS
RETURN SYS_REFCURSOR
AS
    p_cursor SYS_REFCURSOR;
BEGIN
    OPEN p_cursor FOR
        SELECT * FROM VISTA_SUCURSAL_DEPARTAMENTOS;
    
    RETURN p_cursor;
END FN_VISTA_SUCURSAL_DEPARTAMENTOS;

----Vista sucursal
CREATE OR REPLACE FUNCTION FN_DESCRIPCION_SUCURSAL(
    p_cod_sucursal IN Sucursal.cod_sucursal%TYPE
) RETURN VARCHAR2 AS
    v_descripcion VARCHAR2(255);
BEGIN
    -- Creamos una descripci n personalizada basada en el c digo de la sucursal
    SELECT 'La sucursal ' || Correo || ' ubicada en ' || Direccion
    INTO v_descripcion
    FROM Sucursal
    WHERE cod_sucursal = p_cod_sucursal;
    
    -- Devolvemos la descripci n
    RETURN v_descripcion;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Descripci n no disponible';
    WHEN OTHERS THEN
        RETURN 'Error al generar la descripci n';
END FN_DESCRIPCION_SUCURSAL;

CREATE OR REPLACE VIEW VISTA_SUCURSAL_DESCRIPCION AS
SELECT 
    cod_sucursal AS Codigo_Sucursal,
    Correo AS Correo_Sucursal,
    Direccion AS Direccion_Sucursal,
    Telefono AS Telefono_Sucursal,
    FN_DESCRIPCION_SUCURSAL(cod_sucursal) AS Descripcion_Sucursal
FROM 
    Sucursal;

commit;

SELECT *
FROM USER_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'SYS_C007509';

ALTER TABLE EMPLEADOS
DROP CONSTRAINT SYS_C007509;

ALTER TABLE Empleados
ADD CONSTRAINT fk_departamento
FOREIGN KEY (departamento)
REFERENCES Departamentos (cod_departamento)
ON DELETE CASCADE;

select * from productos;

-------------------------------------------------------------------Productos----------------------------------------------------------------------------------------------------------------------------
--Paquete que engloba los procedimientos almacenados de añadir un nuevo producto, eliminar un producto, actualizar un producto
CREATE OR REPLACE PACKAGE Producto_Package AS
    -- Procedimiento para insertar un nuevo producto
    PROCEDURE CrearProducto (
        cod_producto IN productos.cod_producto%TYPE,
        nombre IN productos.nombre%TYPE,
        imagen IN productos.imagen%TYPE,
        precio IN productos.precio%TYPE,
        stock IN productos.stock%TYPE
    );

    -- Procedimiento para seleccionar todos los productos
    PROCEDURE LeerTodosLosProductos (
        cur OUT SYS_REFCURSOR
    );

    -- Procedimiento para actualizar un producto
    PROCEDURE ActualizarProducto (
        p_cod_producto IN Productos.cod_producto%TYPE,
        p_nombre IN Productos.nombre%TYPE,
        p_imagen IN Productos.imagen%TYPE,
        p_precio IN Productos.precio%TYPE,
        p_stock IN Productos.stock%TYPE
    );

    -- Procedimiento para eliminar un producto
    PROCEDURE EliminarProductoLista (
        p_cod_producto IN Productos.cod_producto%TYPE
    );
END Producto_Package;


CREATE OR REPLACE PACKAGE BODY Producto_Package AS

    PROCEDURE CrearProducto (
        cod_producto IN productos.cod_producto%TYPE,
        nombre IN productos.nombre%TYPE,
        imagen IN productos.imagen%TYPE,
        precio IN productos.precio%TYPE,
        stock IN productos.stock%TYPE
    ) AS
    BEGIN
        INSERT INTO productos (cod_producto, nombre, imagen, precio, stock)
        VALUES (cod_producto, nombre, imagen, precio, stock);
    END CrearProducto;

    PROCEDURE LeerTodosLosProductos (
        cur OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN cur FOR
        SELECT cod_producto, nombre, imagen, precio, cod_inventario
        FROM productos;
    END LeerTodosLosProductos;

    PROCEDURE ActualizarProducto (
    p_cod_producto IN Productos.cod_producto%TYPE,
    p_nombre IN Productos.nombre%TYPE,
    p_imagen IN Productos.imagen%TYPE,
    p_precio IN Productos.precio%TYPE,
    p_stock IN productos.stock%TYPE
    ) AS
    BEGIN
    UPDATE productos
    SET nombre = p_nombre,
        imagen = p_imagen,
        precio = p_precio,
        stock = p_stock
    WHERE cod_producto = p_cod_producto;
    commit;
    END ActualizarProducto; 


    PROCEDURE EliminarProductoLista (
        p_cod_producto IN Productos.cod_producto%TYPE
    ) AS
    BEGIN
        DELETE FROM productos
        WHERE cod_producto = p_cod_producto;
    END EliminarProductoLista;

END Producto_Package;

select * from productos;

-- Eliminar la restricción en FACTURACION
ALTER TABLE FACTURACION
DROP CONSTRAINT SYS_C007517;

-- Eliminar las restricciones en PRODUCTOS_CLIENTES
ALTER TABLE PRODUCTOS_CLIENTES
DROP CONSTRAINT SYS_C007522;

ALTER TABLE PRODUCTOS_CLIENTES
DROP CONSTRAINT SYS_C007523;


-- Agregar la restricción con eliminación en cascada para FACTURACION
ALTER TABLE FACTURACION
ADD CONSTRAINT fk_producto_facturacion
FOREIGN KEY (COD_PRODUCTO)
REFERENCES PRODUCTOS(cod_producto)
ON DELETE CASCADE;

-- Agregar la restricción con eliminación en cascada para PRODUCTOS_CLIENTES
ALTER TABLE PRODUCTOS_CLIENTES
ADD CONSTRAINT fk_producto_clientes
FOREIGN KEY (COD_PRODUCTO)
REFERENCES PRODUCTOS(cod_producto)
ON DELETE CASCADE;

ALTER TABLE CLIENTES
DROP CONSTRAINT SYS_C007520;

ALTER TABLE CLIENTES
ADD CONSTRAINT fk_cliente_factura
FOREIGN KEY (NUMERO_FACTURA)
REFERENCES FACTURACION(NUMERO_FACTURA)
ON DELETE CASCADE;

commit;


--Funcion productos ordenados
CREATE OR REPLACE FUNCTION obtener_productos_ordenados (
    orden IN VARCHAR2
) RETURN SYS_REFCURSOR IS
    productos_cursor SYS_REFCURSOR;
BEGIN
    IF orden = 'asc' THEN
        OPEN productos_cursor FOR
            SELECT cod_producto, nombre, imagen, precio, cod_inventario
            FROM Productos
            ORDER BY precio ASC;
    ELSE
        OPEN productos_cursor FOR
            SELECT cod_producto, nombre, imagen, precio, cod_inventario
            FROM Productos
            ORDER BY precio DESC;
    END IF;
    RETURN productos_cursor;
END obtener_productos_ordenados;

--Funcion proceso de compra
CREATE OR REPLACE FUNCTION EliminarProducto (
    p_cod_producto IN Productos.cod_producto%TYPE,
    p_cantidad IN NUMBER
) RETURN VARCHAR2
IS
    v_resultado VARCHAR2(100);
    v_stock_actual Productos.stock%TYPE;
BEGIN
    SELECT stock INTO v_stock_actual
    FROM Productos
    WHERE cod_producto = p_cod_producto;
    
    IF v_stock_actual < p_cantidad THEN
        v_resultado := 'No hay suficiente stock para completar la compra.';
        RETURN v_resultado;
    END IF;

    INSERT INTO HistorialCompras (id_historial, cod_producto, nombre, imagen, precio, cantidad, fecha_compra)
    SELECT HistorialCompras_seq.NEXTVAL, cod_producto, nombre, imagen, precio, p_cantidad, SYSDATE
    FROM Productos
    WHERE cod_producto = p_cod_producto;

    UPDATE Productos
    SET stock = stock - p_cantidad
    WHERE cod_producto = p_cod_producto;

    IF SQL%ROWCOUNT = 0 THEN
        v_resultado := 'No se encontro un producto con el codigo proporcionado o no se actualizo el stock.';
        ROLLBACK;
    ELSE
        v_resultado := 'Compra realizada con éxito y stock actualizado.';
        COMMIT;
    END IF;
    
    RETURN v_resultado;
END;

select * from productos;

--Vista Historial Compras
CREATE OR REPLACE VIEW VistaHistorialCompras AS
SELECT
    id_historial,
    cod_producto,
    nombre,
    precio,
    fecha_compra
FROM
    HistorialCompras;

--Funcion y cursor para llamar la vista del Historial de compras
    CREATE OR REPLACE FUNCTION ObtenerHistorialCompras
RETURN SYS_REFCURSOR
IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR SELECT * FROM VistaHistorialCompras;
    RETURN v_cursor;
END;

--Vista total del precio de productos en stock y cantidad de elementos en stock
CREATE OR REPLACE VIEW VistaTotalProductos AS
SELECT
    SUM(stock) AS total_stock,
    SUM(precio * stock) AS total_precio
FROM
    Productos;

--Funcion y cursor que llama a la vista VistaTotalProductos para ejecutarla en Python
CREATE OR REPLACE FUNCTION ObtenerTotales
RETURN SYS_REFCURSOR
IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR SELECT total_stock, total_precio FROM VistaTotalProductos;
    RETURN v_cursor;
END;

--Paquete Auditoria productos
CREATE OR REPLACE PACKAGE auditoria_productos AS
    PROCEDURE auditar_producto(tipo_evento VARCHAR2, cod_producto INT, nombre VARCHAR2, stock INT);
    PROCEDURE obtener_auditoria(p_cursor OUT SYS_REFCURSOR);
END auditoria_productos;

CREATE OR REPLACE PACKAGE BODY auditoria_productos AS
    PROCEDURE auditar_producto(tipo_evento VARCHAR2, cod_producto INT, nombre VARCHAR2, stock INT) IS
    BEGIN
        INSERT INTO Eventos_Productos (id_evento, tipo_evento, cod_producto, nombre, stock, fecha_evento)
        VALUES (Eventos_Productos_seq.NEXTVAL, tipo_evento, cod_producto, nombre, stock, SYSTIMESTAMP);
    END auditar_producto;

    PROCEDURE obtener_auditoria(p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR
            SELECT id_evento, tipo_evento, cod_producto, nombre, stock, fecha_evento 
            FROM Eventos_Productos;
    END obtener_auditoria;
END auditoria_productos;


--Trigger para Productos
CREATE OR REPLACE TRIGGER auditoria_productos
    AFTER INSERT OR DELETE OR UPDATE ON Productos
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        auditoria_productos.auditar_producto('INSERT', :NEW.cod_producto, :NEW.nombre, :NEW.stock);
    ELSIF UPDATING THEN
        auditoria_productos.auditar_producto('UPDATE', :NEW.cod_producto, :NEW.nombre, :NEW.stock);
    ELSIF DELETING THEN
        auditoria_productos.auditar_producto('DELETE', :OLD.cod_producto, :OLD.nombre, :OLD.stock);
    END IF;
END;

select * from productos;

-------------------------------------------------------------------Proveedores----------------------------------------------------------------------------------------------------------------------------

--Inserta
CREATE OR REPLACE PROCEDURE insertar_proveedor (
    p_cod_proveedor IN INT,
    p_nombre_proveedor IN VARCHAR2,
    p_producto_ventas IN VARCHAR2
) AS
BEGIN
    INSERT INTO Proveedores (CodProveedor, nombre_proveedor, producto_ventas)
    VALUES (p_cod_proveedor, p_nombre_proveedor, p_producto_ventas);
END insertar_proveedor;


--actualiza
CREATE OR REPLACE PROCEDURE Actualizar_Proveedor (
    p_CodProveedor IN INT,
    p_nombre_proveedor IN VARCHAR2,
    p_producto_ventas IN VARCHAR2
) AS
BEGIN
    UPDATE Proveedores
    SET nombre_proveedor = p_nombre_proveedor,
        producto_ventas = p_producto_ventas
    WHERE CodProveedor = p_CodProveedor;
END;


--elimina
CREATE OR REPLACE PROCEDURE Eliminar_Proveedor (
    p_CodProveedor IN INT
) AS
BEGIN
    DELETE FROM Proveedores
    WHERE CodProveedor = p_CodProveedor;
END;

--ver proveedores
CREATE OR REPLACE PROCEDURE Listar_Proveedores (
    p_resultado OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_resultado FOR
    SELECT CodProveedor, nombre_proveedor, producto_ventas
    FROM Proveedores;
END Listar_Proveedores;


--contarlos
CREATE OR REPLACE PROCEDURE obtener_proveedor (
    p_CodProveedor IN INT,
    p_nombre_proveedor OUT VARCHAR2,
    p_producto_ventas OUT VARCHAR2
) AS
BEGIN
    SELECT nombre_proveedor, producto_ventas
    INTO p_nombre_proveedor, p_producto_ventas
    FROM proveedores
    WHERE CodProveedor = p_CodProveedor;
END obtener_proveedor;

------------------------------------------------------------------------------------------
-- VISTAS PROVEEDORES

--vista detalle
CREATE OR REPLACE VIEW Vista_Proveedores AS
SELECT CodProveedor, nombre_proveedor, producto_ventas
FROM Proveedores;

--proveedro x producto
CREATE OR REPLACE VIEW vista_proveedores_por_producto AS
SELECT producto_ventas, COUNT(*) AS num_proveedores
FROM proveedores
GROUP BY producto_ventas;

-- FUNCIONES PROVEEDORES
--nombre proveedor
CREATE OR REPLACE FUNCTION obtener_nombre_proveedor (
    p_CodProveedor IN INT
) RETURN VARCHAR2 AS
    v_nombre_proveedor VARCHAR2(100);
BEGIN
    SELECT nombre_proveedor INTO v_nombre_proveedor
    FROM proveedores
    WHERE CodProveedor = p_CodProveedor;
    RETURN v_nombre_proveedor;
END obtener_nombre_proveedor;

--obtiene productos
CREATE OR REPLACE FUNCTION obtener_producto_ventas (
    p_CodProveedor IN INT
) RETURN VARCHAR2 AS
    v_producto_ventas VARCHAR2(100);
BEGIN
    SELECT producto_ventas INTO v_producto_ventas
    FROM proveedores
    WHERE CodProveedor = p_CodProveedor;
    RETURN v_producto_ventas;
END obtener_producto_ventas;

--cuenta proveedrores
CREATE OR REPLACE FUNCTION contar_proveedores_func RETURN INT AS
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count FROM proveedores;
    RETURN v_count;
END contar_proveedores_func;

-- PAQUETES PROVEEDORES
--1
CREATE OR REPLACE PACKAGE pkg_proveedores AS
    PROCEDURE insertar_proveedor (
        p_nombre_proveedor IN VARCHAR2,
        p_producto_ventas IN VARCHAR2
    );
    PROCEDURE actualizar_proveedor (
        p_CodProveedor IN INT,
        p_nombre_proveedor IN VARCHAR2,
        p_producto_ventas IN VARCHAR2
    );
    PROCEDURE eliminar_proveedor (
        p_CodProveedor IN INT
    );
    FUNCTION contar_proveedores_func RETURN INT;
END pkg_proveedores;

CREATE OR REPLACE PACKAGE BODY pkg_proveedores AS
    PROCEDURE insertar_proveedor (
        p_nombre_proveedor IN VARCHAR2,
        p_producto_ventas IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO proveedores (nombre_proveedor, producto_ventas)
        VALUES (p_nombre_proveedor, p_producto_ventas);
    END insertar_proveedor;

    PROCEDURE actualizar_proveedor (
        p_CodProveedor IN INT,
        p_nombre_proveedor IN VARCHAR2,
        p_producto_ventas IN VARCHAR2
    ) AS
    BEGIN
        UPDATE proveedores
        SET nombre_proveedor = p_nombre_proveedor,
            producto_ventas = p_producto_ventas
        WHERE CodProveedor = p_CodProveedor;
    END actualizar_proveedor;

    PROCEDURE eliminar_proveedor (
        p_CodProveedor IN INT
    ) AS
    BEGIN
        DELETE FROM proveedores
        WHERE CodProveedor = p_CodProveedor;
    END eliminar_proveedor;

    FUNCTION contar_proveedores_func RETURN INT AS
        v_count INT;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM proveedores;
        RETURN v_count;
    END contar_proveedores_func;
END pkg_proveedores;

-- TRIGGER PROVEEDORES  ****pendiente****
CREATE TABLE auditoria_proveedores (
    id_auditoria INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    CodProveedor INT,
    nombre_proveedor VARCHAR2(100),
    producto_ventas VARCHAR2(100),
    operacion VARCHAR2(10), -- 'INSERT' o 'UPDATE'
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE TRIGGER trg_audit_proveedores_insert
AFTER INSERT ON proveedores
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_proveedores (CodProveedor, nombre_proveedor, producto_ventas, operacion, fecha)
    VALUES (:NEW.CodProveedor, :NEW.nombre_proveedor, :NEW.producto_ventas, 'INSERT', SYSDATE);
END;

-- CURSORES PROVEEDORES
--obtiene proveedores
DECLARE
    CURSOR c_proveedores IS
        SELECT CodProveedor, nombre_proveedor, producto_ventas
        FROM proveedores;
        
    v_proveedor proveedores%ROWTYPE;
BEGIN
    OPEN c_proveedores;
    LOOP
        FETCH c_proveedores INTO v_proveedor;
        EXIT WHEN c_proveedores%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_proveedor.CodProveedor || ' - ' || v_proveedor.nombre_proveedor);
    END LOOP;
    CLOSE c_proveedores;
END;

DECLARE
    CURSOR c_proveedores_por_producto (p_producto IN VARCHAR2) IS
        SELECT CodProveedor, nombre_proveedor
        FROM proveedores
        WHERE producto_ventas = p_producto;
        
    v_CodProveedor proveedores.CodProveedor%TYPE;
    v_nombre_proveedor proveedores.nombre_proveedor%TYPE;
BEGIN
   OPEN c_proveedores_por_producto('Herramientas');
    LOOP
        FETCH c_proveedores_por_producto INTO v_CodProveedor, v_nombre_proveedor;
        EXIT WHEN c_proveedores_por_producto%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_CodProveedor || ' - ' || v_nombre_proveedor);
    END LOOP;
    CLOSE c_proveedores_por_producto;
END;

--los obtiene por nombre
DECLARE
    CURSOR c_proveedores_por_nombre (p_nombre IN VARCHAR2) IS
        SELECT CodProveedor, nombre_proveedor
        FROM proveedores
        WHERE nombre_proveedor LIKE '%' || p_nombre || '%';
        
    v_CodProveedor proveedores.CodProveedor%TYPE;
    v_nombre_proveedor proveedores.nombre_proveedor%TYPE;
BEGIN
    OPEN c_proveedores_por_nombre('ABC');
    LOOP
        FETCH c_proveedores_por_nombre INTO v_CodProveedor, v_nombre_proveedor;
        EXIT WHEN c_proveedores_por_nombre%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_CodProveedor || ' - ' || v_nombre_proveedor);
    END LOOP;
    CLOSE c_proveedores_por_nombre;
END;

select * from proveedores;

-------------------------------------------------------------------Empleados----------------------------------------------------------------------------------------------------------------------------
--insertar
CREATE OR REPLACE PROCEDURE Insertar_Empleado (
    p_cod_empleado IN INT,
    p_nombre IN VARCHAR2,
    p_primer_apellido IN VARCHAR2,
    p_segundo_apellido IN VARCHAR2,
    p_correo IN VARCHAR2,
    p_numero IN VARCHAR2,
    p_departamento IN INT
) AS
BEGIN
    INSERT INTO Empleados (cod_empleado, nombre, primer_apellido, segundo_apellido, correo, numero, departamento)
    VALUES (p_cod_empleado, p_nombre, p_primer_apellido, p_segundo_apellido, p_correo, p_numero, p_departamento);
END;

--Listar Empleados
CREATE OR REPLACE PROCEDURE obtener_todos_empleados (
    p_empleados OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_empleados FOR
    SELECT cod_empleado, nombre, primer_apellido, segundo_apellido, correo, numero, departamento
    FROM empleados;
END obtener_todos_empleados;


--actualizar
CREATE OR REPLACE PROCEDURE Actualizar_Empleado (
    p_cod_empleado IN INT,
    p_nombre IN VARCHAR2,
    p_primer_apellido IN VARCHAR2,
    p_segundo_apellido IN VARCHAR2,
    p_correo IN VARCHAR2,
    p_numero IN VARCHAR2,
    p_departamento IN INT
) AS
BEGIN
    UPDATE Empleados
    SET nombre = p_nombre,
        primer_apellido = p_primer_apellido,
        segundo_apellido = p_segundo_apellido,
        correo = p_correo,
        numero = p_numero,
        departamento = p_departamento
    WHERE cod_empleado = p_cod_empleado;
END;

--elimina 
CREATE OR REPLACE PROCEDURE eliminar_empleado (
    p_cod_empleado IN INT
) AS
BEGIN
    DELETE FROM empleados
    WHERE cod_empleado = p_cod_empleado;
END eliminar_empleado;

--cuenta empleados
CREATE OR REPLACE PROCEDURE contar_empleados (
    p_count OUT INT
) AS
BEGIN
    SELECT COUNT(*) INTO p_count FROM empleados;
END contar_empleados;

--Vistas proveedores

CREATE OR REPLACE VIEW Vista_Proveedores AS
SELECT CodProveedor, nombre_proveedor, producto_ventas
FROM Proveedores;


-- VISTAS EMPLEADOS
--vista detalles
CREATE OR REPLACE VIEW Vista_Empleados AS
SELECT cod_empleado, nombre, primer_apellido, segundo_apellido, correo, numero, departamento
FROM Empleados;

--empleados x departamento
CREATE OR REPLACE VIEW vista_empleados_por_departamento AS
SELECT departamento, COUNT(*) AS num_empleados
FROM empleados
GROUP BY departamento;

-- FUNCIONES EMPLEADOS
--nombre empleado
CREATE OR REPLACE FUNCTION obtener_nombre_empleado (
    p_cod_empleado IN INT
) RETURN VARCHAR2 AS
    v_nombre_empleado VARCHAR2(100);
BEGIN
    SELECT nombre INTO v_nombre_empleado
    FROM empleados
    WHERE cod_empleado = p_cod_empleado;
    RETURN v_nombre_empleado;
END obtener_nombre_empleado;

--correos de empleados
CREATE OR REPLACE FUNCTION obtener_correo_empleado (
    p_cod_empleado IN INT
) RETURN VARCHAR2 AS
    v_correo_empleado VARCHAR2(100);
BEGIN
    SELECT correo INTO v_correo_empleado
    FROM empleados
    WHERE cod_empleado = p_cod_empleado;
    RETURN v_correo_empleado;
END obtener_correo_empleado;

--conteo empleados
CREATE OR REPLACE FUNCTION contar_empleados_func RETURN INT AS
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count FROM empleados;
    RETURN v_count;
END contar_empleados_func;

-- PAQUETES EMPLEADOS
--1 
CREATE OR REPLACE PACKAGE pkg_empleados AS
    PROCEDURE insertar_empleado (
        p_nombre IN VARCHAR2,
        p_primer_apellido IN VARCHAR2,
        p_segundo_apellido IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_numero IN VARCHAR2,
        p_departamento IN INT
    );
    PROCEDURE actualizar_empleado (
        p_cod_empleado IN INT,
        p_nombre IN VARCHAR2,
        p_primer_apellido IN VARCHAR2,
        p_segundo_apellido IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_numero IN VARCHAR2,
        p_departamento IN INT
    );
    PROCEDURE eliminar_empleado (
        p_cod_empleado IN INT
    );
    FUNCTION contar_empleados_func RETURN INT;
END pkg_empleados;

CREATE OR REPLACE PACKAGE BODY pkg_empleados AS
    PROCEDURE insertar_empleado (
        p_nombre IN VARCHAR2,
        p_primer_apellido IN VARCHAR2,
        p_segundo_apellido IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_numero IN VARCHAR2,
        p_departamento IN INT
    ) AS
    BEGIN
        INSERT INTO empleados (nombre, primer_apellido, segundo_apellido, correo, numero, departamento)
        VALUES (p_nombre, p_primer_apellido, p_segundo_apellido, p_correo, p_numero, p_departamento);
    END insertar_empleado;

    PROCEDURE actualizar_empleado (
        p_cod_empleado IN INT,
        p_nombre IN VARCHAR2,
        p_primer_apellido IN VARCHAR2,
        p_segundo_apellido IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_numero IN VARCHAR2,
        p_departamento IN INT
    ) AS
    BEGIN
        UPDATE empleados
        SET nombre = p_nombre,
            primer_apellido = p_primer_apellido,
            segundo_apellido = p_segundo_apellido,
            correo = p_correo,
            numero = p_numero,
            departamento = p_departamento
        WHERE cod_empleado = p_cod_empleado;
    END actualizar_empleado;

    PROCEDURE eliminar_empleado (
        p_cod_empleado IN INT
    ) AS
    BEGIN
        DELETE FROM empleados
        WHERE cod_empleado = p_cod_empleado;
    END eliminar_empleado;

    FUNCTION contar_empleados_func RETURN INT AS
        v_count INT;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM empleados;
        RETURN v_count;
    END contar_empleados_func;
END pkg_empleados;

--2
CREATE OR REPLACE PACKAGE pkg_empleados_consultas AS
    FUNCTION obtener_nombre_empleado (
        p_cod_empleado IN INT
    ) RETURN VARCHAR2;
    FUNCTION obtener_correo_empleado (
        p_cod_empleado IN INT
    ) RETURN VARCHAR2;
END pkg_empleados_consultas;

CREATE OR REPLACE PACKAGE BODY pkg_empleados_consultas AS
    FUNCTION obtener_nombre_empleado (
        p_cod_empleado IN INT
    ) RETURN VARCHAR2 AS
        v_nombre_empleado VARCHAR2(100);
    BEGIN
        SELECT nombre INTO v_nombre_empleado
        FROM empleados
        WHERE cod_empleado = p_cod_empleado;
        RETURN v_nombre_empleado;
    END obtener_nombre_empleado;

    FUNCTION obtener_correo_empleado (
        p_cod_empleado IN INT
    ) RETURN VARCHAR2 AS
        v_correo_empleado VARCHAR2(100);
    BEGIN
        SELECT correo INTO v_correo_empleado
        FROM empleados
        WHERE cod_empleado = p_cod_empleado;
        RETURN v_correo_empleado;
    END obtener_correo_empleado;
END pkg_empleados_consultas;

--------------------------------------------------------------------------------

-- TRIGGER EMPLEADOS
CREATE TABLE auditoria_empleados (
    id_auditoria INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cod_empleado INT,
    operacion VARCHAR2(10), -- 'INSERT', 'UPDATE', 'DELETE'
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_nombre VARCHAR2(100),
    new_nombre VARCHAR2(100)
);

CREATE OR REPLACE TRIGGER trg_audit_empleados_update
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_empleados (cod_empleado, operacion, fecha, old_nombre, new_nombre)
    VALUES (:NEW.cod_empleado, 'UPDATE', SYSDATE, :OLD.nombre, :NEW.nombre);
END;

-- CURSORES EMPLEADOS
--obtinene los empleados
DECLARE
    CURSOR c_empleados IS
        SELECT cod_empleado, nombre, primer_apellido, segundo_apellido
        FROM empleados;
        
    v_empleado c_empleados%ROWTYPE;
BEGIN
    OPEN c_empleados;
    LOOP
        FETCH c_empleados INTO v_empleado;
        EXIT WHEN c_empleados%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_empleado.cod_empleado || ' - ' || v_empleado.nombre || ' - ' || v_empleado.primer_apellido || ' - ' || v_empleado.segundo_apellido);
    END LOOP;
    CLOSE c_empleados;
END;

--empleados por correo
DECLARE
    CURSOR c_empleados_por_correo (p_correo IN VARCHAR2) IS
        SELECT cod_empleado, nombre
        FROM empleados
        WHERE correo = p_correo;
        
    TYPE t_empleado_rec IS RECORD (
        cod_empleado empleados.cod_empleado%TYPE,
        nombre empleados.nombre%TYPE
    );

    v_empleado t_empleado_rec;
BEGIN
    OPEN c_empleados_por_correo('test@example.com');
    LOOP
        FETCH c_empleados_por_correo INTO v_empleado;
        EXIT WHEN c_empleados_por_correo%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_empleado.cod_empleado || ' - ' || v_empleado.nombre);
    END LOOP;
    CLOSE c_empleados_por_correo;
END;

--empleados por departamento
DECLARE
    CURSOR c_empleados_por_departamento (p_departamento IN INT) IS
        SELECT cod_empleado, nombre
        FROM empleados
        WHERE departamento = p_departamento;
    TYPE t_empleado_rec IS RECORD (
        cod_empleado empleados.cod_empleado%TYPE,
        nombre empleados.nombre%TYPE
    );
    v_empleado t_empleado_rec;
BEGIN
    OPEN c_empleados_por_departamento(10);
    LOOP
        FETCH c_empleados_por_departamento INTO v_empleado;
        EXIT WHEN c_empleados_por_departamento%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_empleado.cod_empleado || ' - ' || v_empleado.nombre);
    END LOOP;
    CLOSE c_empleados_por_departamento;
END;

-------------------------------------------------------------------Clientes----------------------------------------------------------------------------------------------------------------------------
--Agregar cliente
CREATE OR REPLACE PROCEDURE sp_insertar_cliente(
    p_cod_cliente IN INT,
    p_nombre IN VARCHAR2,
    p_primerApellido IN VARCHAR2,
    p_segundoApellido IN VARCHAR2,
    p_numero IN VARCHAR2,
    p_correo IN VARCHAR2,
    p_numero_factura IN INT,
    p_num_transaccion IN INT
) AS
BEGIN
    INSERT INTO Clientes (cod_cliente, Nombre, primerApellido, segundoApellido, Numero, Correo, numero_factura, num_transaccion)
    VALUES (p_cod_cliente, p_nombre, p_primerApellido, p_segundoApellido, p_numero, p_correo, p_numero_factura, p_num_transaccion);
END;



--Actualizar cliente
CREATE OR REPLACE PROCEDURE sp_actualizar_cliente(
    p_cod_cliente IN INT,
    p_nombre IN VARCHAR2,
    p_primerApellido IN VARCHAR2,
    p_segundoApellido IN VARCHAR2,
    p_numero IN VARCHAR2,
    p_correo IN VARCHAR2,
    p_numero_factura IN INT,
    p_num_transaccion IN INT
) AS
BEGIN
    UPDATE Clientes
    SET Nombre = p_nombre,
        primerApellido = p_primerApellido,
        segundoApellido = p_segundoApellido,
        Numero = p_numero,
        Correo = p_correo,
        numero_factura = p_numero_factura,
        num_transaccion = p_num_transaccion
    WHERE cod_cliente = p_cod_cliente;
END;


--eliminar cliente
CREATE OR REPLACE PROCEDURE sp_eliminar_cliente(
    p_cod_cliente IN Clientes.cod_cliente%TYPE
) AS
BEGIN
    DELETE FROM Clientes WHERE cod_cliente = p_cod_cliente;
    
    COMMIT;
END;


-------------------------------------------------------------------Envios----------------------------------------------------------------------------------------------------------------------------

--Agregar envio
CREATE OR REPLACE PROCEDURE sp_registrar_envio(
    p_numero_envio IN INT,
    p_direccion IN VARCHAR2,
    p_cod_cliente IN INT
) AS
BEGIN
    INSERT INTO Envios (numero_envio, Direccion) VALUES (p_numero_envio, p_direccion);
    INSERT INTO Envios_Clientes (cod_cliente, numero_envio) VALUES (p_cod_cliente, p_numero_envio);
END;


--Editar envio
CREATE OR REPLACE PROCEDURE actualizar_envio(
    p_numero_envio IN Envios.numero_envio%TYPE,
    p_direccion IN Envios.Direccion%TYPE
) IS
BEGIN
    UPDATE Envios
    SET Direccion = p_direccion
    WHERE numero_envio = p_numero_envio;
END actualizar_envio;


--Eliminar envio
CREATE OR REPLACE PROCEDURE eliminar_envio(
    p_numero_envio IN Envios.numero_envio%TYPE
) IS
BEGIN
    DELETE FROM Envios WHERE numero_envio = p_numero_envio;
END eliminar_envio;

-------------------------------------------------------------------Clientes----------------------------------------------------------------------------------------------------------------------------

--Envio_Clientes
CREATE OR REPLACE PROCEDURE sp_asignar_envio_cliente(
    p_cod_cliente IN INT,
    p_numero_envio IN INT
) AS
BEGIN
    INSERT INTO Envios_Clientes (cod_cliente, numero_envio)
    VALUES (p_cod_cliente, p_numero_envio);
END;

---Actualizar Envio_Clientes
CREATE OR REPLACE PROCEDURE actualizar_envio_cliente(
    p_cod_cliente IN Envios_Clientes.cod_cliente%TYPE,
    p_numero_envio IN Envios_Clientes.numero_envio%TYPE,
    p_new_cod_cliente IN Envios_Clientes.cod_cliente%TYPE,
    p_new_numero_envio IN Envios_Clientes.numero_envio%TYPE
) IS
BEGIN
    UPDATE Envios_Clientes
    SET cod_cliente = p_new_cod_cliente,
        numero_envio = p_new_numero_envio
    WHERE cod_cliente = p_cod_cliente AND numero_envio = p_numero_envio;
END actualizar_envio_cliente;

---Eliminar Envio_Cliente
CREATE OR REPLACE PROCEDURE eliminar_envio_cliente(
    p_cod_cliente IN Envios_Clientes.cod_cliente%TYPE,
    p_numero_envio IN Envios_Clientes.numero_envio%TYPE
) IS
BEGIN
    DELETE FROM Envios_Clientes
    WHERE cod_cliente = p_cod_cliente AND numero_envio = p_numero_envio;
END eliminar_envio_cliente;

--vista de datos de clientes
CREATE OR REPLACE VIEW VISTA_CLIENTES AS
SELECT 
    cod_cliente AS CODIGO,
    Nombre AS NOMBRE,
    primerApellido || ' ' || segundoApellido AS APELLIDO,
    Numero AS TELEFONO,
    Correo AS CORREO
FROM 
    Clientes;


--Vista de detalles de los env os con info del cliente
CREATE OR REPLACE VIEW VISTA_ENVIOS_DETALLE AS
SELECT 
    E.numero_envio AS CODIGO_ENVIO,
    E.Direccion AS DIRECCION,
    C.Nombre AS NOMBRE_CLIENTE,
    C.primerApellido || ' ' || C.segundoApellido AS APELLIDO_CLIENTE,
    C.Numero AS TELEFONO_CLIENTE,
    C.Correo AS CORREO_CLIENTE
FROM 
    Envios E
JOIN 
    Envios_Clientes EC ON E.numero_envio = EC.numero_envio
JOIN 
    Clientes C ON EC.cod_cliente = C.cod_cliente;
    



--------------------------------------------------------------Clientes y envios---------------------------------------------------------------

-- Funciones Clientes y Envios

--Contar Envios
CREATE OR REPLACE FUNCTION fn_contar_envios_cliente(
    p_cod_cliente IN INT
) RETURN INT AS
    v_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Envios_Clientes
    WHERE cod_cliente = p_cod_cliente;
    
    RETURN v_count;
END;

-- Validar correo
CREATE OR REPLACE FUNCTION fn_validar_correo_cliente(
    p_correo IN VARCHAR2
) RETURN BOOLEAN AS
    v_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Clientes
    WHERE Correo = p_correo;
    
    RETURN v_count > 0;
END;

-- Obtener nombre del cliente
CREATE OR REPLACE FUNCTION fn_obtener_nombre_cliente(
    p_cod_cliente IN INT
) RETURN VARCHAR2 AS
    v_nombre VARCHAR2(300);
BEGIN
    SELECT Nombre || ' ' || primerApellido || ' ' || segundoApellido
    INTO v_nombre
    FROM Clientes
    WHERE cod_cliente = p_cod_cliente;
    
    RETURN v_nombre;
END;

-- Paquetes Clientes y Envios

-- Gestionar Clientes
CREATE OR REPLACE PACKAGE pkg_gestion_clientes AS
    PROCEDURE insertar_cliente(
        p_cod_cliente IN INT,
        p_nombre IN VARCHAR2,
        p_primerApellido IN VARCHAR2,
        p_segundoApellido IN VARCHAR2,
        p_numero IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_numero_factura IN INT,
        p_num_transaccion IN INT);
    
    PROCEDURE actualizar_cliente(
        p_cod_cliente IN INT,
        p_nombre IN VARCHAR2,
        p_primerApellido IN VARCHAR2,
        p_segundoApellido IN VARCHAR2,
        p_numero IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_numero_factura IN INT,
        p_num_transaccion IN INT);
    
    PROCEDURE eliminar_cliente(p_cod_cliente IN INT);
END pkg_gestion_clientes;

CREATE OR REPLACE PACKAGE BODY pkg_gestion_clientes AS
    PROCEDURE insertar_cliente(
        p_cod_cliente IN INT,
        p_nombre IN VARCHAR2,
        p_primerApellido IN VARCHAR2,
        p_segundoApellido IN VARCHAR2,
        p_numero IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_numero_factura IN INT,
        p_num_transaccion IN INT) AS
    BEGIN
        sp_insertar_cliente(p_cod_cliente, p_nombre, p_primerApellido, p_segundoApellido, p_numero, p_correo, p_numero_factura, p_num_transaccion);
    END;
    
    PROCEDURE actualizar_cliente(
        p_cod_cliente IN INT,
        p_nombre IN VARCHAR2,
        p_primerApellido IN VARCHAR2,
        p_segundoApellido IN VARCHAR2,
        p_numero IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_numero_factura IN INT,
        p_num_transaccion IN INT) AS
    BEGIN
        sp_actualizar_cliente(p_cod_cliente, p_nombre, p_primerApellido, p_segundoApellido, p_numero, p_correo, p_numero_factura, p_num_transaccion);
    END;
    
    PROCEDURE eliminar_cliente(p_cod_cliente IN INT) AS
    BEGIN
        sp_eliminar_cliente(p_cod_cliente);
    END;
END pkg_gestion_clientes;


-- Gestionar Envios
CREATE OR REPLACE PACKAGE pkg_gestion_envios AS
    PROCEDURE registrar_envio(
        p_numero_envio IN INT,
        p_direccion IN VARCHAR2,
        p_cod_cliente IN INT);
    
    PROCEDURE asignar_envio_cliente(
        p_cod_cliente IN INT,
        p_numero_envio IN INT);
END pkg_gestion_envios;

CREATE OR REPLACE PACKAGE BODY pkg_gestion_envios AS
    PROCEDURE registrar_envio(
        p_numero_envio IN INT,
        p_direccion IN VARCHAR2,
        p_cod_cliente IN INT) AS
    BEGIN
        sp_registrar_envio(p_numero_envio, p_direccion, p_cod_cliente);
    END;
    
    PROCEDURE asignar_envio_cliente(
        p_cod_cliente IN INT,
        p_numero_envio IN INT) AS
    BEGIN
        sp_asignar_envio_cliente(p_cod_cliente, p_numero_envio);
    END;
END pkg_gestion_envios;


-- Triggers Clientes y Envios

-- Validar numero cliente
CREATE OR REPLACE TRIGGER trg_validar_numero_cliente
BEFORE INSERT OR UPDATE ON Clientes
FOR EACH ROW
BEGIN
    IF :NEW.Numero IS NOT NULL AND NOT REGEXP_LIKE(:NEW.Numero, '^\d{4}-\d{4}$') THEN
        RAISE_APPLICATION_ERROR(-20001, 'El número de teléfono debe estar en el formato XXXX-XXXX');
    END IF;
END;

select * from facturacion;

-- Cursores Clientes y Envios

CREATE OR REPLACE PACKAGE pkg_cursores AS
    CURSOR cur_clientes_con_envios IS
        SELECT c.cod_cliente, c.Nombre, c.primerApellido, c.segundoApellido
        FROM Clientes c
        WHERE EXISTS (
            SELECT 1
            FROM Envios_Clientes ec
            WHERE ec.cod_cliente = c.cod_cliente
        );
END pkg_cursores;

CREATE OR REPLACE PACKAGE pkg_cursores AS
    CURSOR cur_envios_sin_cliente IS
        SELECT e.numero_envio, e.Direccion
        FROM Envios e
        WHERE NOT EXISTS (
            SELECT 1
            FROM Envios_Clientes ec
            WHERE ec.numero_envio = e.numero_envio
        );
END pkg_cursores;

CREATE OR REPLACE PACKAGE pkg_cursores AS
    CURSOR cur_clientes_sin_envios IS
        SELECT c.cod_cliente, c.Nombre, c.primerApellido, c.segundoApellido
        FROM Clientes c
        WHERE NOT EXISTS (
            SELECT 1
            FROM Envios_Clientes ec
            WHERE ec.cod_cliente = c.cod_cliente
        );
END pkg_cursores;


--------------------------------------------------------------------------------Inventarios-------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertar_inventario(
    p_cod_inventario IN INT,
    p_cod_sucursal IN INT,
    p_cantidad IN INT,
    p_fechaingreso IN VARCHAR2
) AS
BEGIN
    INSERT INTO Inventarios (cod_inventario, cod_sucursal, Cantidad, FechaIngreso)
    VALUES (p_cod_inventario, p_cod_sucursal, p_cantidad, TO_DATE(p_fechaingreso, 'YYYY-MM-DD'));
END;



CREATE OR REPLACE PROCEDURE actualizar_inventario(
    p_cod_inventario IN INT,
    p_cod_sucursal IN INT,
    p_cantidad IN INT,
    p_fechaingreso IN DATE
) AS
BEGIN
    UPDATE Inventarios
    SET cod_sucursal = p_cod_sucursal,
        Cantidad = p_cantidad,
        FechaIngreso = p_fechaingreso
    WHERE cod_inventario = p_cod_inventario;
END;

CREATE OR REPLACE PROCEDURE eliminar_inventario(
    p_cod_inventario IN INT
) AS
BEGIN
    -- Insertar el registro en la tabla de auditoría antes de eliminarlo
    INSERT INTO Inventarios_Audit (cod_inventario, cod_sucursal, cantidad, fechaingreso, audit_operation)
    SELECT cod_inventario, cod_sucursal, cantidad, fechaingreso, 'DELETE'
    FROM Inventarios
    WHERE cod_inventario = p_cod_inventario;

    -- Luego, eliminar el inventario
    DELETE FROM Inventarios
    WHERE cod_inventario = p_cod_inventario;
END;

CREATE TABLE Inventarios_Audit (
    audit_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    cod_inventario INT,
    cod_sucursal INT,
    cantidad INT,
    fechaingreso DATE,
    audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    audit_operation VARCHAR2(10)
);


CREATE OR REPLACE VIEW Vista_Inventarios_Eliminados AS
SELECT cod_inventario, cod_sucursal, cantidad, fechaingreso, audit_timestamp
FROM Inventarios_Audit
WHERE audit_operation = 'DELETE';


--------------------------------------------------------------------------------Facturacion---------------------------------------------------------------------------------------------
--Actualizar la info de un prod
CREATE OR REPLACE PROCEDURE Actualizar_Informacion_Producto (
    p_cod_producto IN INT,
    p_nombre IN VARCHAR2,
    p_precio IN NUMBER
) AS
BEGIN
    UPDATE Productos
    SET nombre = p_nombre,
        precio = p_precio
    WHERE cod_producto = p_cod_producto;
    
    COMMIT;
END;

--Funcion para el total de fact del cliente

CREATE OR REPLACE FUNCTION fn_total_facturado_cliente(
    p_cod_cliente IN INT
) RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT SUM(f.total_factura) INTO v_total
    FROM Facturas f
    JOIN Clientes c ON f.cod_cliente = c.cod_cliente
    WHERE c.cod_cliente = p_cod_cliente;

    -- Manejar el caso en el que el cliente no tenga facturas
    IF v_total IS NULL THEN
        v_total := 0;
    END IF;

    RETURN v_total;
END;


--Funcion para el inventario total 
CREATE OR REPLACE FUNCTION fn_total_inventario() 
RETURN NUMBER IS
    v_total_stock NUMBER;
BEGIN
    SELECT SUM(stock) INTO v_total_stock
    FROM Productos;

    -- en caso que no haya productos
    IF v_total_stock IS NULL THEN
        v_total_stock := 0;
    END IF;

    RETURN v_total_stock;
END;

--Cursor para seleccionar las facturas de un cliente 
CREATE OR REPLACE PACKAGE pkg_cursores_facturacion AS
    CURSOR cur_facturas_cliente(p_cod_cliente IN INT) IS
        SELECT f.numero_factura, f.fecha_factura, f.total_factura
        FROM Facturas f
        WHERE f.cod_cliente = p_cod_cliente;
END pkg_cursores_facturacion;


--Cursor para seleccionar productos de inventario

CREATE OR REPLACE PACKAGE pkg_cursores_inventario AS
    CURSOR cur_productos_bajo_stock(p_umbral IN NUMBER) IS
        SELECT cod_producto, nombre, stock
        FROM Productos
        WHERE stock < p_umbral;
END pkg_cursores_inventario;


--Trigger cambios en fact
CREATE OR REPLACE TRIGGER trg_auditoria_facturas
AFTER INSERT OR UPDATE OR DELETE ON Factura
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO Auditoria_Facturas (id_evento, tipo_evento, numero_factura, fecha_factura, total_factura, estado_factura, fecha_evento)
        VALUES (Auditoria_Facturas_seq.NEXTVAL, 'INSERT', :NEW.numero_factura, :NEW.fecha_factura, :NEW.total_factura, :NEW.estado_factura, SYSTIMESTAMP);
    ELSIF UPDATING THEN
        INSERT INTO Auditoria_Facturas (id_evento, tipo_evento, numero_factura, fecha_factura, total_factura, estado_factura, fecha_evento)
        VALUES (Auditoria_Facturas_seq.NEXTVAL, 'UPDATE', :NEW.numero_factura, :NEW.fecha_factura, :NEW.total_factura, :NEW.estado_factura, SYSTIMESTAMP);
    ELSIF DELETING THEN
        INSERT INTO Auditoria_Facturas (id_evento, tipo_evento, numero_factura, fecha_factura, total_factura, estado_factura, fecha_evento)
        VALUES (Auditoria_Facturas_seq.NEXTVAL, 'DELETE', :OLD.numero_factura, :OLD.fecha_factura, :OLD.total_factura, :OLD.estado_factura, SYSTIMESTAMP);
    END IF;
END;



CREATE OR REPLACE TRIGGER trg_actualizar_stock
AFTER INSERT ON Items_Factura
FOR EACH ROW
BEGIN
    UPDATE Productos
    SET stock = stock - :NEW.cantidad
    WHERE cod_producto = :NEW.cod_producto;

END;




























