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
        RAISERROR('El DNI ya est� registrado.', 16, 1);
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
        RAISERROR('El DNI no est� registrado.', 16, 1);
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
        RAISERROR('El DNI no est� registrado.', 16, 1);
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
        RAISERROR('El DNI no est� registrado.', 16, 1);
        RETURN;
    END

    -- Obtener el cliente seg�n su DNI
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

    -- Agregar ordenaci�n solo si se especifica
    IF @orden IS NOT NULL
    BEGIN
        SET @sql = @sql + ' ORDER BY precio_producto ' + @orden;
    END

    EXEC sp_executesql @sql;
END;


--OBTENER PRODUCTOS CATEGORIA
CREATE PROCEDURE ObtenerProductosCategoria
    @id_categoria CHAR(6),
    @orden NVARCHAR(4) = NULL -- Par�metro para el orden (ASC, DESC o NULL)
AS
BEGIN
    -- Verificar si la categor�a existe
    IF NOT EXISTS (SELECT 1 FROM categorias WHERE id_categoria = @id_categoria)
    BEGIN
        RAISERROR('La categor�a no est� registrada.', 16, 1);
        RETURN;
    END

    -- Obtener productos seg�n la categor�a y el orden especificado
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
        RAISERROR('Valor de orden no v�lido. Use "ASC", "DESC" o NULL.', 16, 1);
    END
END;



--OBTENER PRODUCTOS SUBCATEGORIA
CREATE PROCEDURE ObtenerProductosSubcategoria
    @id_subcategoria CHAR(6),
    @orden NVARCHAR(4) = NULL -- Par�metro para el orden (ASC, DESC o NULL)
AS
BEGIN
    -- Verificar si la subcategor�a existe
    IF NOT EXISTS (SELECT 1 FROM subcategorias WHERE id_subcategoria = @id_subcategoria)
    BEGIN
        RAISERROR('La subcategor�a no est� registrada.', 16, 1);
        RETURN;
    END

    -- Obtener productos seg�n la subcategor�a y el orden especificado
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
        RAISERROR('Valor de orden no v�lido. Use "ASC", "DESC" o NULL.', 16, 1);
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
        RAISERROR('El cliente no est� registrado.', 16, 1);
        RETURN;
    END

    -- Obtener la cabecera de las facturas seg�n el cliente
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
        RAISERROR('La factura no est� registrada.', 16, 1);
        RETURN;
    END

    -- Obtener los detalles de la factura seg�n la cabecera
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
        RAISERROR('El cliente no est� registrado.', 16, 1);
        RETURN;
    END

    -- Verificar si la factura ya existe
    IF EXISTS (SELECT 1 FROM factura_cabecera WHERE id_factura = @id_factura)
    BEGIN
        RAISERROR('La factura ya est� registrada.', 16, 1);
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
        RAISERROR('La factura no est� registrada.', 16, 1);
        RETURN;
    END

    -- Verificar si el producto existe
    IF NOT EXISTS (SELECT 1 FROM productos WHERE id_producto = @id_producto)
    BEGIN
        RAISERROR('El producto no est� registrado.', 16, 1);
        RETURN;
    END

    -- Verificar si el detalle ya existe
    IF EXISTS (SELECT 1 FROM factura_detalle WHERE id_detalle = @id_detalle)
    BEGIN
        RAISERROR('El detalle de factura ya est� registrado.', 16, 1);
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




