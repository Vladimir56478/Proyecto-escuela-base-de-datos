CREATE DATABASE IF NOT EXISTS Escuela;
USE Escuela;

CREATE TABLE Profesor (
    Num_Legajo_Profesor INT NOT NULL,
    Nombre VARCHAR(30),
    Apellido VARCHAR(210),
    Correo VARCHAR(50),
    PRIMARY KEY (Num_Legajo_Profesor)
);

CREATE TABLE Turno (
    ID_Turno INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(20),
    Horario_Inicio DATETIME,
    Horario_Fin DATETIME,
    PRIMARY KEY (ID_Turno)
);

CREATE TABLE Aula (
    Num_Legajo_Aula INT NOT NULL,
    Descripcion VARCHAR(100),
    Ubicacion VARCHAR(60),
    Capacidad INT,
    PRIMARY KEY (Num_Legajo_Aula)
);

CREATE TABLE Jefe_Preceptores (
    Num_Legajo_Jefe_Preceptor INT NOT NULL,
    Nombre VARCHAR(20),
    Apellido VARCHAR(20),
    CUIT BIGINT,
    PRIMARY KEY (Num_Legajo_Jefe_Preceptor)
);

CREATE TABLE Preceptor (
    Num_Legajo_Precep INT NOT NULL,
    Nombre VARCHAR(30),
    Apellido VARCHAR(30),
    PRIMARY KEY (Num_Legajo_Precep)
);

CREATE TABLE Ciclo (
    ID_Ciclo INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(30),
    PRIMARY KEY (ID_Ciclo)
);

CREATE TABLE Asignatura (
    ID_Asignatura INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(30),
    ID_Ciclo INT,
    PRIMARY KEY (ID_Asignatura),
    INDEX idx_asignatura_ciclo (ID_Ciclo),
    CONSTRAINT fk_asignatura_ciclo FOREIGN KEY (ID_Ciclo)
        REFERENCES Ciclo (ID_Ciclo)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Especialidad (
    ID_Especialidad INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(30),
    ID_Ciclo INT,
    PRIMARY KEY (ID_Especialidad),
    INDEX idx_especialidad_ciclo (ID_Ciclo),
    CONSTRAINT fk_especialidad_ciclo FOREIGN KEY (ID_Ciclo)
        REFERENCES Ciclo (ID_Ciclo)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Cursos (
    Num_Legajo INT NOT NULL,
    AnioDivision VARCHAR(20),
    Detalle VARCHAR(100),
    Num_Legajo_Aula INT,
    Num_Legajo_Preceptor INT,
    ID_Turno INT,
    PRIMARY KEY (Num_Legajo),
    INDEX idx_cursos_aula (Num_Legajo_Aula),
    INDEX idx_cursos_preceptor (Num_Legajo_Preceptor),
    INDEX idx_cursos_turno (ID_Turno),
    CONSTRAINT fk_cursos_aula FOREIGN KEY (Num_Legajo_Aula)
        REFERENCES Aula (Num_Legajo_Aula)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_cursos_preceptor FOREIGN KEY (Num_Legajo_Preceptor)
        REFERENCES Preceptor (Num_Legajo_Precep)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_cursos_turno FOREIGN KEY (ID_Turno)
        REFERENCES Turno (ID_Turno)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Regencia (
    Num_Legajo_Regen INT NOT NULL,
    Nombre VARCHAR(20),
    Apellido VARCHAR(20),
    ID_Turno INT,
    PRIMARY KEY (Num_Legajo_Regen),
    INDEX idx_regencia_turno (ID_Turno),
    CONSTRAINT fk_regencia_turno FOREIGN KEY (ID_Turno)
        REFERENCES Turno (ID_Turno)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Area (
    ID_Area INT NOT NULL AUTO_INCREMENT,
    Ubicacion VARCHAR(60),
    Descripcion VARCHAR(100),
    Horario_Fin DATETIME,
    Num_Legajo_Profesor INT,
    Horario_Inicio DATETIME,
    Capacidad INT,
    Nombre VARCHAR(20),
    PRIMARY KEY (ID_Area),
    INDEX idx_area_profesor (Num_Legajo_Profesor),
    CONSTRAINT fk_area_profesor FOREIGN KEY (Num_Legajo_Profesor)
        REFERENCES Profesor (Num_Legajo_Profesor)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Alumno (
    Num_Legajo_Alumno INT NOT NULL,
    Nombre VARCHAR(30),
    Apellido VARCHAR(30),
    Correo VARCHAR(100),
    DNI INT,
    Fecha_Nac DATETIME,
    PRIMARY KEY (Num_Legajo_Alumno),
    UNIQUE KEY uq_alumno_dni (DNI)
);

CREATE TABLE Calificaciones (
    ID_Calificacion INT NOT NULL AUTO_INCREMENT,
    Num_Legajo_Alumno INT,
    Nota_Valoracion VARCHAR(20),
    Bimestre INT,
    PRIMARY KEY (ID_Calificacion),
    INDEX idx_calificaciones_alumno (Num_Legajo_Alumno),
    CONSTRAINT fk_calificaciones_alumno FOREIGN KEY (Num_Legajo_Alumno)
        REFERENCES Alumno (Num_Legajo_Alumno)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Modulo (
    Num_Legajo_Profesor INT NOT NULL,
    Num_Legajo_Curso INT NOT NULL,
    Horario_Inicio DATETIME,
    Horario_Finalizacion DATETIME,
    ID_Asignatura INT NOT NULL,
    PRIMARY KEY (Num_Legajo_Profesor , Num_Legajo_Curso , ID_Asignatura),
    INDEX idx_modulo_profesor (Num_Legajo_Profesor),
    INDEX idx_modulo_curso (Num_Legajo_Curso),
    INDEX idx_modulo_asignatura (ID_Asignatura),
    CONSTRAINT fk_modulo_profesor FOREIGN KEY (Num_Legajo_Profesor)
        REFERENCES Profesor (Num_Legajo_Profesor)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_modulo_curso FOREIGN KEY (Num_Legajo_Curso)
        REFERENCES Cursos (Num_Legajo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_modulo_asignatura FOREIGN KEY (ID_Asignatura)
        REFERENCES Asignatura (ID_Asignatura)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ------------------------------
-- DML: Inserts (ordenados para respetar FKs)
-- ------------------------------
START TRANSACTION;

INSERT INTO Ciclo (ID_Ciclo, Nombre) VALUES
  (1, 'Primario'),
  (2, 'Secundario');

INSERT INTO Profesor (Num_Legajo_Profesor, Nombre, Apellido, Correo) VALUES
  (1001, 'María', 'González', 'mgonzalez@escuela.edu'),
  (1002, 'Javier', 'Pérez', 'jperez@escuela.edu');

INSERT INTO Turno (ID_Turno, Nombre, Horario_Inicio, Horario_Fin) VALUES
  (1, 'Mañana', '2025-01-01 08:00:00', '2025-01-01 12:00:00'),
  (2, 'Tarde',  '2025-01-01 13:00:00', '2025-01-01 18:00:00');

INSERT INTO Aula (Num_Legajo_Aula, Descripcion, Ubicacion, Capacidad) VALUES
  (201, 'Aula 1 - Piso 1', 'Edificio A - Piso 1', 30),
  (202, 'Aula 2 - Piso 1', 'Edificio A - Piso 1', 28);

INSERT INTO Jefe_Preceptores (Num_Legajo_Jefe_Preceptor, Nombre, Apellido, CUIT) VALUES
  (3001, 'Lucía', 'Martínez', 20333444555),
  (3002, 'Diego', 'Ruiz', 27355111222);

INSERT INTO Preceptor (Num_Legajo_Precep, Nombre, Apellido) VALUES
  (4001, 'Sofía', 'Fernández'),
  (4002, 'Carlos', 'Sosa');

INSERT INTO Asignatura (ID_Asignatura, Nombre, ID_Ciclo) VALUES
  (1, 'Matemáticas', 2),
  (2, 'Lengua', 2);

INSERT INTO Especialidad (ID_Especialidad, Nombre, ID_Ciclo) VALUES
  (1, 'Ciencias', 2),
  (2, 'Humanidades', 2);

INSERT INTO Cursos (Num_Legajo, AnioDivision, Detalle, Num_Legajo_Aula, Num_Legajo_Preceptor, ID_Turno) VALUES
  (5001, '1A', 'Primer año division A', 201, 4001, 1),
  (5002, '2B', 'Segundo año division B', 202, 4002, 2);

INSERT INTO Regencia (Num_Legajo_Regen, Nombre, Apellido, ID_Turno) VALUES
  (6001, 'Ana', 'Lopez', 1),
  (6002, 'Pablo', 'Salas', 2);

INSERT INTO Area (ID_Area, Ubicacion, Descripcion, Horario_Fin, Num_Legajo_Profesor, Horario_Inicio, Capacidad, Nombre) VALUES
  (7001, 'Biblioteca', 'Sala de lectura', '2025-01-01 17:00:00', 1001, '2025-01-01 08:00:00', 40, 'Biblioteca'),
  (7002, 'Laboratorio', 'Laboratorio de Ciencias', '2025-01-01 16:00:00', 1002, '2025-01-01 09:00:00', 25, 'LabCiencias');

INSERT INTO Alumno (Num_Legajo_Alumno, Nombre, Apellido, Correo, DNI, Fecha_Nac) VALUES
  (8001, 'Lucas', 'Gómez', 'lgomez@mail.com', 35111222, '2008-04-15 00:00:00'),
  (8002, 'Mariana', 'Vega', 'mvega@mail.com', 27222333, '2007-09-02 00:00:00');

INSERT INTO Calificaciones (Num_Legajo_Alumno, Nota_Valoracion, Bimestre) VALUES
  (8001, '8.5', 1),
  (8002, '9.0', 1);

INSERT INTO Modulo (Num_Legajo_Profesor, Num_Legajo_Curso, Horario_Inicio, Horario_Finalizacion, ID_Asignatura) VALUES
  (1001, 5001, '2025-03-01 08:30:00', '2025-03-01 10:00:00', 1),
  (1002, 5002, '2025-03-01 13:30:00', '2025-03-01 15:00:00', 2);

COMMIT;

-- ------------------------------
-- Consultas / Queries útiles (SELECT / UPDATE / DELETE)
-- ------------------------------

-- 1) Listar todos los cursos
SELECT * FROM Cursos;

-- 2) Cursos con su aula, turno y preceptor
SELECT
  c.Num_Legajo AS CursoID,
  c.AnioDivision,
  c.Detalle,
  a.Descripcion AS Aula,
  a.Ubicacion AS Ubicacion_Aula,
  t.Nombre AS Turno,
  p.Nombre AS Nombre_Preceptor,
  p.Apellido AS Apellido_Preceptor
FROM Cursos c
LEFT JOIN Aula a ON c.Num_Legajo_Aula = a.Num_Legajo_Aula
LEFT JOIN Turno t ON c.ID_Turno = t.ID_Turno
LEFT JOIN Preceptor p ON c.Num_Legajo_Preceptor = p.Num_Legajo_Precep;

-- 3) Módulos de un profesor (ej: legajo 1001) con detalle de asignatura y curso
SELECT
  m.Num_Legajo_Profesor,
  m.Num_Legajo_Curso,
  c.AnioDivision,
  asig.Nombre AS Asignatura,
  m.Horario_Inicio,
  m.Horario_Finalizacion
FROM Modulo m
JOIN Cursos c ON m.Num_Legajo_Curso = c.Num_Legajo
JOIN Asignatura asig ON m.ID_Asignatura = asig.ID_Asignatura
WHERE m.Num_Legajo_Profesor = 1001;

-- 4) Alumnos con sus calificaciones (todas)
SELECT
  al.Num_Legajo_Alumno,
  al.Nombre,
  al.Apellido,
  cal.Nota_Valoracion,
  cal.Bimestre
FROM Alumno al
LEFT JOIN Calificaciones cal ON al.Num_Legajo_Alumno = cal.Num_Legajo_Alumno
ORDER BY al.Num_Legajo_Alumno, cal.Bimestre;

-- 5) Asignaturas por ciclo
SELECT asig.ID_Asignatura, asig.Nombre, c.Nombre AS Ciclo
FROM Asignatura asig
LEFT JOIN Ciclo c ON asig.ID_Ciclo = c.ID_Ciclo;

-- 6) Áreas y profesor responsable
SELECT ar.ID_Area, ar.Nombre AS Nombre_Area, ar.Ubicacion, pr.Num_Legajo_Profesor, pr.Nombre, pr.Apellido
FROM Area ar
LEFT JOIN Profesor pr ON ar.Num_Legajo_Profesor = pr.Num_Legajo_Profesor;

-- 7) Ejemplo (hipotético) - Buscar alumnos de un curso si existiera tabla Matricula
-- SELECT a.Num_Legajo_Alumno, a.Nombre, a.Apellido
-- FROM Alumno a
-- JOIN Matricula m ON a.Num_Legajo_Alumno = m.Num_Legajo_Alumno
-- WHERE m.Num_Legajo_Curso = 5001;

-- 8) Actualizar correo de un profesor
UPDATE Profesor
SET Correo = 'm.gonzalez@nuevo.edu'
WHERE Num_Legajo_Profesor = 1001;

-- 9) Eliminar (ejemplo) una calificación por id
DELETE FROM Calificaciones
WHERE ID_Calificacion = 1;