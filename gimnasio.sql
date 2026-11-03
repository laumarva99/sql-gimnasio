

-- Ejercicio B1.

-- B1.1
CREATE TABLE planes (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    precio_mensual NUMERIC(8,2) NOT NULL
);


CREATE TABLE socios (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dni VARCHAR(15) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    fecha_alta DATE NOT NULL,
    plan_id INTEGER NOT NULL REFERENCES planes(id)
);


CREATE TABLE tarjetas (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo VARCHAR(30) NOT NULL UNIQUE,
    activa BOOLEAN NOT NULL DEFAULT TRUE,
    socio_id INTEGER NOT NULL UNIQUE REFERENCES socios(id)
);

-- B1.2
CREATE TABLE monitores (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dni VARCHAR(15) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE clases (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    actividad VARCHAR(100) NOT NULL,
    sala VARCHAR(30) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    plazas INTEGER NOT NULL,
    monitor_id INTEGER NOT NULL REFERENCES monitores(id)
);

-- B1.3
CREATE TABLE reservas (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    socio_id INTEGER NOT NULL REFERENCES socios(id),
    clase_id INTEGER NOT NULL REFERENCES clases(id),
    fecha_reserva TIMESTAMP NOT NULL,
    UNIQUE (socio_id, clase_id)
);

-- B1.4
CREATE TABLE especialidades (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE monitor_especialidades (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    monitor_id INTEGER NOT NULL REFERENCES monitores(id),
    especialidad_id INTEGER NOT NULL REFERENCES especialidades(id),
    UNIQUE (monitor_id, especialidad_id)
);



-- Ejercicio B2. 



INSERT INTO planes (nombre, precio_mensual) VALUES
('Básico', 25.00),
('Premium', 45.00),
('Familiar', 60.00);


INSERT INTO socios (dni, nombre, email, fecha_alta, plan_id) VALUES
('11111111A', 'Ana García', 'ana@example.com', '2026-01-10', 1),
('22222222B', 'Luis Pérez', 'luis@example.com', '2026-02-15', 2),
('33333333C', 'Marta López', 'marta@example.com', '2026-03-01', 1);


INSERT INTO tarjetas (codigo, activa, socio_id) VALUES
('FV-001', TRUE, 1),
('FV-002', TRUE, 2),
('FV-003', FALSE, 3);


INSERT INTO monitores (dni, nombre, email) VALUES
('44444444D', 'Carlos Ruiz', 'carlos@example.com'),
('55555555E', 'Elena Martín', 'elena@example.com');


INSERT INTO clases
    (actividad, sala, fecha_hora, plazas, monitor_id)
VALUES
('Ciclo indoor', 'Sala 1', '2026-11-05 18:00:00', 15, 1),
('Yoga', 'Sala 2', '2026-11-05 19:00:00', 12, 2),
('Fuerza', 'Sala 1', '2026-11-06 17:00:00', 10, 1);


INSERT INTO reservas (socio_id, clase_id, fecha_reserva) VALUES
(1, 1, CURRENT_TIMESTAMP),
(2, 1, CURRENT_TIMESTAMP),
(2, 2, CURRENT_TIMESTAMP),
(3, 3, CURRENT_TIMESTAMP);


INSERT INTO especialidades (nombre) VALUES
('Ciclo indoor'),
('Yoga'),
('Fuerza'),
('Pilates');


INSERT INTO monitor_especialidades (monitor_id, especialidad_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 4);


-- Ejercicio B4. 

-- B4.1
SELECT s.nombre, p.nombre AS plan, p.precio_mensual
FROM socios s
INNER JOIN planes p ON s.plan_id = p.id
ORDER BY s.nombre;


-- B4.2
SELECT c.actividad, c.fecha_hora, c.sala, m.nombre AS monitor
FROM clases c
INNER JOIN monitores m ON c.monitor_id = m.id
ORDER BY c.fecha_hora;


-- B4.3
SELECT s.nombre, t.codigo
FROM socios s
LEFT JOIN tarjetas t ON t.socio_id = s.id
ORDER BY s.nombre;


-- B4.4
SELECT s.nombre
FROM socios s
LEFT JOIN tarjetas t ON t.socio_id = s.id
WHERE t.id IS NULL;


-- B4.5
SELECT p.nombre, COUNT(s.id) AS num_socios
FROM planes p
LEFT JOIN socios s ON s.plan_id = p.id
GROUP BY p.id, p.nombre
ORDER BY p.nombre;


-- B4.6
SELECT s.nombre, c.actividad, c.fecha_hora
FROM reservas r
INNER JOIN socios s ON r.socio_id = s.id
INNER JOIN clases c ON r.clase_id = c.id
ORDER BY s.nombre, c.fecha_hora;

-- B4.7
SELECT s.nombre
FROM reservas r
INNER JOIN socios s ON r.socio_id = s.id
WHERE r.clase_id = 1;

-- B4.8
SELECT c.actividad, c.fecha_hora, c.plazas, COUNT(r.id) AS num_reservas
FROM clases c
LEFT JOIN reservas r ON r.clase_id = c.id
GROUP BY c.id, c.actividad, c.fecha_hora, c.plazas
ORDER BY c.fecha_hora;


-- B4.9
SELECT m.nombre
FROM monitores m
LEFT JOIN clases c ON c.monitor_id = m.id
WHERE c.id IS NULL;


-- B4.10
SELECT m.nombre AS monitor, e.nombre AS especialidad
FROM monitor_especialidades me
INNER JOIN monitores m ON me.monitor_id = m.id
INNER JOIN especialidades e ON me.especialidad_id = e.id
ORDER BY m.nombre, e.nombre;



-- Ejercicio B5. 

-- B5.1

SELECT * FROM socios WHERE email = 'luis@gym.com';

UPDATE socios
SET plan_id = 2
WHERE email = 'luis@gym.com';


-- B5.2
SELECT * FROM tarjetas WHERE codigo = 'TJ-0004';

UPDATE tarjetas
SET activa = TRUE
WHERE codigo = 'TJ-0004';

-- B5.3
INSERT INTO tarjetas (codigo, activa, socio_id)
VALUES ('TJ-0008', TRUE, 8);

-- B5.4
INSERT INTO reservas (socio_id, clase_id, fecha_reserva)
VALUES (8, 6, '2026-11-02');

-- B5.5
SELECT * FROM reservas WHERE socio_id = 2 AND clase_id = 2;

DELETE FROM reservas
WHERE socio_id = 2 AND clase_id = 2;

-- B5.6
-- DELETE FROM socios WHERE email = 'pablo@gym.com';
SELECT * FROM reservas WHERE socio_id = 6;
DELETE FROM reservas WHERE socio_id = 6;

SELECT * FROM tarjetas WHERE socio_id = 6;
DELETE FROM tarjetas WHERE socio_id = 6;

SELECT * FROM socios WHERE email = 'pablo@gym.com';
DELETE FROM socios WHERE email = 'pablo@gym.com';


