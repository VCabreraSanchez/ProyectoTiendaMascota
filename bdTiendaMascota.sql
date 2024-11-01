create database BDTiendaMascotas

use BDTiendaMascotas

create table clientes(
dni_cliente char(8) PRIMARY KEY,
nombre_cliente varchar(60),
correo_cliente varchar(60),
telefono_cliente char(9),
password_cliente varchar(60),
);

create table categorias(
id_categoria char(6) PRIMARY KEY,
nombre_categoria varchar(60),
);

create table subcategorias(
id_subcategoria char(6) PRIMARY KEY,
nombre_subcategoria varchar(60),
id_categoria char(6),
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

create table productos(
id_producto char(6) PRIMARY KEY,
nombre_producto varchar(60),
precio_producto DECIMAL(10, 2),
stock_producto int,
marca_producto varchar(60),
tipoanimal_producto varchar(60),
id_subcategoria char(6),
FOREIGN KEY (id_subcategoria) REFERENCES subcategorias(id_subcategoria)
);

create table factura_cabecera(
id_factura CHAR(6) PRIMARY KEY,
dni_cliente CHAR(8),
fecha_factura DATE,
total_factura DECIMAL(10,2),
FOREIGN KEY (dni_cliente) REFERENCES clientes(dni_cliente),
);

create table factura_detalle(
id_detalle CHAR(6) PRIMARY KEY,
id_factura CHAR(6),
id_producto CHAR(6), 
cantidad_producto INT,
precio_unitario_producto DECIMAL(10, 2),
subtotal_producto DECIMAL(10, 2),
FOREIGN KEY (id_factura) REFERENCES factura_cabecera(id_factura),
FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

SELECT * FROM clientes;
SELECT * FROM categorias;
SELECT * FROM subcategorias;
SELECT * FROM productos;
SELECT * FROM factura_cabecera;
SELECT * FROM factura_detalle;


INSERT INTO categorias (id_categoria, nombre_categoria)
VALUES 
    ('CAT001', 'Alimentos'),
    ('CAT002', 'Higiene'),
    ('CAT003', 'Accesorios'),
    ('CAT004', 'Salud'),
    ('CAT005', 'Cuidado del Hogar');

INSERT INTO subcategorias (id_subcategoria, nombre_subcategoria, id_categoria)
VALUES 
    ('SC001', 'Alimento Seco', 'CAT001'),
    ('SC002', 'Alimento Húmedo', 'CAT001'),
    ('SC003', 'Snacks y Golosinas', 'CAT001'),
    ('SC004', 'Suplementos Nutricionales', 'CAT001'),
    ('SC005', 'Shampoo y Acondicionador', 'CAT002'),
    ('SC006', 'Toallitas Húmedas', 'CAT002'),
    ('SC007', 'Cortauñas', 'CAT002'),
    ('SC008', 'Cepillos y Peines', 'CAT002'),
    ('SC009', 'Juguetes', 'CAT003'),
    ('SC010', 'Collares y Correas', 'CAT003'),
    ('SC011', 'Camas y Mantas', 'CAT003'),
    ('SC012', 'Transportadoras', 'CAT003'),
    ('SC013', 'Medicamentos', 'CAT004'),
    ('SC014', 'Antipulgas y Antiparasitarios', 'CAT004'),
    ('SC015', 'Suplementos de Salud', 'CAT004'),
    ('SC016', 'Productos de Cuidado Dental', 'CAT004'),
    ('SC017', 'Suministros de Limpieza', 'CAT005'),
    ('SC018', 'Productos Desinfectantes', 'CAT005'),
    ('SC019', 'Comederos y Bebederos', 'CAT005'),
    ('SC020', 'Camas y Sillas', 'CAT005');

INSERT INTO productos (id_producto, nombre_producto, precio_producto, stock_producto, marca_producto, tipoanimal_producto, id_subcategoria)
VALUES 
    ('P001', 'Alimento Seco para Perros', 75.50, 100, 'MarcaA', 'Perro', 'SC001'),
    ('P002', 'Alimento Húmedo para Gatos', 45.00, 50, 'MarcaB', 'Gato', 'SC002'),
    ('P003', 'Snacks de Pollo para Perros', 20.00, 200, 'MarcaC', 'Perro', 'SC003'),
    ('P004', 'Suplemento Nutricional para Gatos', 35.00, 75, 'MarcaD', 'Gato', 'SC004'),
    ('P005', 'Shampoo para Perros', 30.00, 150, 'MarcaE', 'Perro', 'SC005'),
    ('P006', 'Toallitas Húmedas para Mascotas', 15.00, 120, 'MarcaF', 'Perro', 'SC006'),
    ('P007', 'Cortauñas para Gatos', 10.00, 80, 'MarcaG', 'Gato', 'SC007'),
    ('P008', 'Juguete de Pelota para Perros', 25.00, 200, 'MarcaH', 'Perro', 'SC009'),
    ('P009', 'Collar Reflectante para Gatos', 12.50, 100, 'MarcaI', 'Gato', 'SC010'),
    ('P010', 'Cama Suave para Perros', 85.00, 60, 'MarcaJ', 'Perro', 'SC011'),
    ('P011', 'Medicamento Antipulgas para Gatos', 50.00, 40, 'MarcaK', 'Gato', 'SC013'),
    ('P012', 'Suministro de Limpieza para Mascotas', 22.00, 90, 'MarcaL', 'General', 'SC017');




--CREAR CLIENTES
CREATE PROCEDURE InsertarCliente
    @dni_cliente CHAR(8),
    @nombre_cliente VARCHAR(60),
    @correo_cliente VARCHAR(60),
    @telefono_cliente CHAR(9),
    @password_cliente VARCHAR(60)
AS
BEGIN
    -- Verificar si el DNI ya existe
    IF EXISTS (SELECT 1 FROM clientes WHERE dni_cliente = @dni_cliente)
    BEGIN
        RAISERROR('El DNI ya está registrado.', 16, 1);
        RETURN;
    END
    -- Insertar el nuevo cliente
    INSERT INTO clientes (dni_cliente, nombre_cliente, correo_cliente, telefono_cliente, password_cliente)
    VALUES (@dni_cliente, @nombre_cliente, @correo_cliente, @telefono_cliente, @password_cliente);
END;

--ACTUALIZAR CLIENTES
CREATE PROCEDURE ActualizarCliente
    @dni_cliente CHAR(8),
    @nombre_cliente VARCHAR(60),
    @correo_cliente VARCHAR(60),
    @telefono_cliente CHAR(9),
    @password_cliente VARCHAR(60)
AS
BEGIN
    -- Verificar si el DNI existe
    IF NOT EXISTS (SELECT 1 FROM clientes WHERE dni_cliente = @dni_cliente)
    BEGIN
        RAISERROR('El DNI no está registrado.', 16, 1);
        RETURN;
    END

    -- Actualizar los datos del cliente
    UPDATE clientes
    SET nombre_cliente = @nombre_cliente,
        correo_cliente = @correo_cliente,
        telefono_cliente = @telefono_cliente,
        password_cliente = @password_cliente
    WHERE dni_cliente = @dni_cliente;
END;

--BORRAR CLIENTES
CREATE PROCEDURE BorrarCliente
    @dni_cliente CHAR(8)
AS
BEGIN
    -- Verificar si el cliente existe
    IF NOT EXISTS (SELECT 1 FROM clientes WHERE dni_cliente = @dni_cliente)
    BEGIN
        RAISERROR('El DNI no está registrado.', 16, 1);
        RETURN;
    END

    -- Eliminar el cliente
    DELETE FROM clientes
    WHERE dni_cliente = @dni_cliente;
END;


--OBTENER CLIENTES
CREATE PROCEDURE ObtenerClientes
AS
BEGIN
    SELECT * FROM clientes;
END;


--OBTENER CLIENTES SEGUN DNI
CREATE PROCEDURE ObtenerClienteDNI
    @dni_cliente CHAR(8)
AS
BEGIN
    -- Verificar si el cliente existe
    IF NOT EXISTS (SELECT 1 FROM clientes WHERE dni_cliente = @dni_cliente)
    BEGIN
        RAISERROR('El DNI no está registrado.', 16, 1);
        RETURN;
    END

    -- Obtener el cliente según su DNI
    SELECT * FROM clientes WHERE dni_cliente = @dni_cliente;
END;

--OBTENER PRODUCTOS
CREATE PROCEDURE ObtenerProductos
    @orden VARCHAR(4) = NULL  -- NULL si no se especifica el orden
AS
BEGIN
    SET NOCOUNT ON;

    -- Consulta para obtener todos los productos
    DECLARE @sql NVARCHAR(MAX);
    
    SET @sql = 'SELECT * FROM productos';

    -- Agregar ordenación solo si se especifica
    IF @orden IS NOT NULL
    BEGIN
        SET @sql = @sql + ' ORDER BY precio_producto ' + @orden;
    END

    EXEC sp_executesql @sql;
END;


--OBTENER PRODUCTOS CATEGORIA
CREATE PROCEDURE ObtenerProductosCategoria
    @id_categoria CHAR(6),
    @orden NVARCHAR(4) = NULL -- Parámetro para el orden (ASC, DESC o NULL)
AS
BEGIN
    -- Verificar si la categoría existe
    IF NOT EXISTS (SELECT 1 FROM categorias WHERE id_categoria = @id_categoria)
    BEGIN
        RAISERROR('La categoría no está registrada.', 16, 1);
        RETURN;
    END

    -- Obtener productos según la categoría y el orden especificado
    IF @orden IS NULL
    BEGIN
        SELECT p.*
        FROM productos p
        INNER JOIN subcategorias s ON p.id_subcategoria = s.id_subcategoria
        WHERE s.id_categoria = @id_categoria;
    END
    ELSE IF @orden = 'ASC'
    BEGIN
        SELECT p.*
        FROM productos p
        INNER JOIN subcategorias s ON p.id_subcategoria = s.id_subcategoria
        WHERE s.id_categoria = @id_categoria
        ORDER BY p.precio_producto ASC;
    END
    ELSE IF @orden = 'DESC'
    BEGIN
        SELECT p.*
        FROM productos p
        INNER JOIN subcategorias s ON p.id_subcategoria = s.id_subcategoria
        WHERE s.id_categoria = @id_categoria
        ORDER BY p.precio_producto DESC;
    END
    ELSE
    BEGIN
        RAISERROR('Valor de orden no válido. Use "ASC", "DESC" o NULL.', 16, 1);
    END
END;



--OBTENER PRODUCTOS SUBCATEGORIA
CREATE PROCEDURE ObtenerProductosSubcategoria
    @id_subcategoria CHAR(6),
    @orden NVARCHAR(4) = NULL -- Parámetro para el orden (ASC, DESC o NULL)
AS
BEGIN
    -- Verificar si la subcategoría existe
    IF NOT EXISTS (SELECT 1 FROM subcategorias WHERE id_subcategoria = @id_subcategoria)
    BEGIN
        RAISERROR('La subcategoría no está registrada.', 16, 1);
        RETURN;
    END

    -- Obtener productos según la subcategoría y el orden especificado
    IF @orden IS NULL
    BEGIN
        SELECT *
        FROM productos
        WHERE id_subcategoria = @id_subcategoria;
    END
    ELSE IF @orden = 'ASC'
    BEGIN
        SELECT *
        FROM productos
        WHERE id_subcategoria = @id_subcategoria
        ORDER BY precio_producto ASC;
    END
    ELSE IF @orden = 'DESC'
    BEGIN
        SELECT *
        FROM productos
        WHERE id_subcategoria = @id_subcategoria
        ORDER BY precio_producto DESC;
    END
    ELSE
    BEGIN
        RAISERROR('Valor de orden no válido. Use "ASC", "DESC" o NULL.', 16, 1);
    END
END;


--OBTENER CATEGORIAS
CREATE PROCEDURE ObtenerCategorias
AS
BEGIN
    SELECT *
    FROM categorias;
END;

--OBTENER SUBCATEGORIAS
CREATE PROCEDURE ObtenerSubcategorias
AS
BEGIN
    SELECT *
    FROM subcategorias;
END;


--OBTENER FACTURA_CABECERA SEGUN CLIENTE DNI
CREATE PROCEDURE ObtenerFacCabeCliente
    @dni_cliente CHAR(8)
AS
BEGIN
    -- Verificar si el cliente existe
    IF NOT EXISTS (SELECT 1 FROM clientes WHERE dni_cliente = @dni_cliente)
    BEGIN
        RAISERROR('El cliente no está registrado.', 16, 1);
        RETURN;
    END

    -- Obtener la cabecera de las facturas según el cliente
    SELECT *
    FROM factura_cabecera
    WHERE dni_cliente = @dni_cliente;
END;

--OBTENER FACTURA_DETALLE SEGUN FACTURA_CABECERA
CREATE PROCEDURE ObtenerFacDetaPorFac
    @id_factura CHAR(6)
AS
BEGIN
    -- Verificar si la factura existe
    IF NOT EXISTS (SELECT 1 FROM factura_cabecera WHERE id_factura = @id_factura)
    BEGIN
        RAISERROR('La factura no está registrada.', 16, 1);
        RETURN;
    END

    -- Obtener los detalles de la factura según la cabecera
    SELECT *
    FROM factura_detalle
    WHERE id_factura = @id_factura;
END;

--CREAR FACTURA_CABECERA
CREATE PROCEDURE AgregarFacturaCabecera
    @id_factura CHAR(6),
    @dni_cliente CHAR(8),
    @fecha_factura DATE,
    @total_factura DECIMAL(10, 2)
AS
BEGIN
    -- Verificar si el cliente existe
    IF NOT EXISTS (SELECT 1 FROM clientes WHERE dni_cliente = @dni_cliente)
    BEGIN
        RAISERROR('El cliente no está registrado.', 16, 1);
        RETURN;
    END

    -- Verificar si la factura ya existe
    IF EXISTS (SELECT 1 FROM factura_cabecera WHERE id_factura = @id_factura)
    BEGIN
        RAISERROR('La factura ya está registrada.', 16, 1);
        RETURN;
    END

    -- Insertar la nueva factura cabecera
    INSERT INTO factura_cabecera (id_factura, dni_cliente, fecha_factura, total_factura)
    VALUES (@id_factura, @dni_cliente, @fecha_factura, @total_factura);
END;

--CREAR FACTURA_DETALLE
CREATE PROCEDURE AgregarFacturaDetalle
    @id_detalle CHAR(6),
    @id_factura CHAR(6),
    @id_producto CHAR(6),
    @cantidad_producto INT,
    @precio_unitario_producto DECIMAL(10, 2),
    @subtotal_producto DECIMAL(10, 2)
AS
BEGIN
    -- Verificar si la factura existe
    IF NOT EXISTS (SELECT 1 FROM factura_cabecera WHERE id_factura = @id_factura)
    BEGIN
        RAISERROR('La factura no está registrada.', 16, 1);
        RETURN;
    END

    -- Verificar si el producto existe
    IF NOT EXISTS (SELECT 1 FROM productos WHERE id_producto = @id_producto)
    BEGIN
        RAISERROR('El producto no está registrado.', 16, 1);
        RETURN;
    END

    -- Verificar si el detalle ya existe
    IF EXISTS (SELECT 1 FROM factura_detalle WHERE id_detalle = @id_detalle)
    BEGIN
        RAISERROR('El detalle de factura ya está registrado.', 16, 1);
        RETURN;
    END

    -- Verificar si hay suficiente stock
    DECLARE @stock_actual INT;
    SELECT @stock_actual = stock_producto FROM productos WHERE id_producto = @id_producto;

    IF @stock_actual < @cantidad_producto
    BEGIN
        RAISERROR('Stock insuficiente para el producto.', 16, 1);
        RETURN;
    END

    -- Insertar el nuevo detalle de la factura
    INSERT INTO factura_detalle (id_detalle, id_factura, id_producto, cantidad_producto, precio_unitario_producto, subtotal_producto)
    VALUES (@id_detalle, @id_factura, @id_producto, @cantidad_producto, @precio_unitario_producto, @subtotal_producto);

    -- Actualizar el stock del producto
    UPDATE productos
    SET stock_producto = stock_producto - @cantidad_producto
    WHERE id_producto = @id_producto;
END;




