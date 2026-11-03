

-- Ejercicio B1.


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


CREATE TABLE reservas (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    socio_id INTEGER NOT NULL REFERENCES socios(id),
    clase_id INTEGER NOT NULL REFERENCES clases(id),
    fecha_reserva TIMESTAMP NOT NULL,
    UNIQUE (socio_id, clase_id)
);


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



-- Ejercio B2. 



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


-- Ejercio B3. 

