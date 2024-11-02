USE BDTiendaMascotas

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


