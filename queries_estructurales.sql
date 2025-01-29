--tabla organizadores:

--INSERT
INSERT INTO `organizadores` 
(`IDOrganizador`, `NombreOrganizador`, `Email`, `Status`)  
VALUES 
(41, 'Mariana Perez', 'mari.pp@icloud.com', 'inactivo'),
(42, 'James Riggs', 'james.riggs@example.com', 'inactivo'),
(43, 'Jacqueline Henry', 'jacky.henry@yahoo.com', 'inactivo'),
(44, 'Daniela Gomez', 'daniela.gomez@gmail.com', 'inactivo'),
(45, 'Carlos Ramirez', 'carlos.ramirez@hotmail.com', 'inactivo'),
(46, 'Laura Martínez', 'laura.martinez@outlook.com', 'inactivo'),
(47, 'Andrés López', 'andres.lopez@yahoo.com', 'inactivo'),
(48, 'Claudia Torres', 'claudia.torres@icloud.com', 'inactivo'),
(49, 'Santiago Pérez', 'santiago.perez@example.com', 'inactivo'),
(50, 'Valentina Gómez', 'valentina.gomez@aol.com', 'inactivo');

--UPDATE:

UPDATE `organizadores`
SET `Status` = 'activo'
WHERE `IDOrganizador` IN ( 6, 7, 8, 13, 20, 32, 35, 41, 42, 43, 44, 45);

--DELETE:
DELETE
FROM `organizadores`
WHERE	
	`Status`= 'inactivo';

--tabla lugar:

--INSERT:
INSERT INTO `lugar` 
(`IDLugar`, `Direccion`, `Capacidad`)  
VALUES 
(30, 'Periférico Sur 4500, Pedregal', 100),
(31, 'C. Nte. 16 Pensador Mexicano, Venustiano Carranza', 200),  
(32, 'Av. Hidalgo 107, Centro Histórico de la Cdad.', 300),  
(33, 'Av Constituyentes 800, Bosque de Chapultepec', 200),  
(34, 'Vizcaínas 21, Centro Histórico', 200),  
(35, 'Regina 7, Centro Histórico', 350),  
(36, 'Avenida Reforma 115, Colonia Juárez', 400),  
(37, 'Calle Juárez 60, Centro Histórico', 150),  
(38, 'Avenida Insurgentes 25, Del Valle', 250),  
(39, 'Plaza de la Constitución 10, Centro Histórico', 450),  
(40, 'Paseo de la Reforma 150, Polanco', 500),  
(41, 'Av. P.º de la Reforma 325, Cuauhtémoc', 300),  
(42, 'Bosque de Chapultepec II Secc, Miguel Hidalgo', 150),  
(43, 'Juan Vazquez de Mella 525, Polanco', 300),  
(44, 'Perif. Blvd. Manuel Ávila Camacho Manzana 020', 100);

--UPDATE:
UPDATE `lugar`
SET `Direccion` = 'Nueva Avenida Hidalgo 107, Centro Histórico',
    `Capacidad` = 400
WHERE `IDLugar` = 32;

--DELETE:
DELETE
FROM `lugar`
WHERE	
	`Capacidad`< 100;


--TABLA EVENTO:
--INSERT:
INSERT
INSERT INTO `evento` 
(`IDEvento`, `NombreEvento`, `FechaEvento`, `IDOrganizador`, `IDLugar`)  
VALUES 
(50, 'Feria de ESDAI', '2024-11-15', 5, 1),
(49, 'Concierto navideño', '2024-12-06', 27, 21),
(48, 'Evento TEFAL', '2024-03-25', 18, 22),
(47, 'Expo Bodas', '2025-01-17', 19, 23),
(46, 'Festival de Cine', '2024-02-13', 24, 6),
(45, 'Conferencia de Tecnología', '2024-11-25', 22, 5),
(44, 'Feria Internacional de Arte', '2024-09-10', 23, 12),
(43, 'Convención de Marketing', '2024-12-02', 25, 10),
(42, 'Show de Talentos', '2024-11-30', 26, 4),
(41, 'Encuentro de Tecnología', '2025-01-20', 28, 14);

--UPDATE:
UPDATE `evento`
SET `NombreEvento`= CONCAT (`NombreEvento`, '*')
WHERE 
	SUBSTR(`NombreEvento`, 1, 10) = 'Graduacion';

--DELETE:
DELETE e
FROM `evento` e
JOIN `organizadores` o ON e.IDOrganizador = o.IDOrganizador
WHERE o.Status = 'inactivo';

--TABLA ASISTENTES:
--INSERT
INSERT INTO `asistentes` 
(`IDAsistente`, `NombreAsistente`, `telefono`)  
VALUES 
(3407, 'Jude Duarte', 5580233240),
(3408, 'Richard Sandoval', 5540422500),
(3409, 'Nicolas Brown', 5513322041),
(3410, 'Marco Parish', 5543815032),
(3411, 'Henry Wright', 5512345678),
(3412, 'Emily Carter', 5587412365),  
(3413, 'Olivia Martinez', 5578901246),  
(3414, 'Sophia Bennett', 5543216789),  
(3415, 'James Anderson', 5512348976),  
(3416, 'Liam Thompson', 5598765432),  
(3417, 'Emma Johnson', 5587654321),  
(3418, 'William Smith', 5545678901),  
(3419, 'Ava Davis', 5534567890),  
(3999, 'Mason Clark', 5594321765);

--UPDATE:
UPDATE `asistentes`
SET `Telefono` = '5534127890'
WHERE `IDAsistente` = 209;

--DELETE:
DELETE FROM `asistentes`
WHERE `IDAsistente` = 209;


--TABLA TICKETS:

--INSERT
INSERT INTO `tickets` 
(`IDTicket`, `IDAsistente`, `IDEvento`, `Precio`)  
VALUES 
(6099, 4182, 2, 1000.56),
(6100, 4183, 2, 1000.56),
(6101, 4184, 2, 1000.56),
(6102, 4185, 2, 1000.56),
(6103, 4186, 2, 1000.56);
--UPDATE
UPDATE `tickets`
SET `Precio` = 1550.08
WHERE `IDEvento`= 84;
--DELETE
DELETE FROM `tickets`
WHERE IDTicket = 315;

--TABLA FACTURAS:

--INSERT
INSERT INTO `facturas` 
(`IDFactura`, `IDTicket`, `Gasto`, `FechaGasto`)  
VALUES 
(3560, 5624, 1400, '2025-02-05'),
(3561, 5625, 1400, '2025-02-07'),
(3562, 5626, 1400, '2025-02-09'),
(3563, 5627, 1400, '2025-02-11'),
(3564, 5628, 1400, '2025-02-13'),
(3565, 5629, 1400, '2025-02-15'),
(3566, 5630, 1400, '2025-02-17');

--UPDATE
UPDATE `facturas`
SET `Gasto` = `Gasto` * 1.21
WHERE `Gasto` > 1800;

--DELETE
DELETE FROM `facturas`
WHERE IDTicket = 315;