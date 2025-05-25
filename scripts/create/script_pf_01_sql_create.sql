CREATE TABLE instituciones
(
	id_institucion INT PRIMARY KEY,
	nombre_institucion VARCHAR(50) NOT NULL,
	tipo_institucion VARCHAR(30)NOT NULL,
	pais VARCHAR(30),
	ciudad VARCHAR (30),
	fecha_registro DATE NOT NULL
);

CREATE TABLE facultades
(
	id_facultad INT PRIMARY KEY NOT NULL,
	id_institucion INT NOT NULL,
	nombre_facultad VARCHAR (255) NOT NULL,
	director VARCHAR (30) NOT NULL,
	FOREIGN KEY (id_institucion) REFERENCES instituciones(id_institucion)
);

CREATE TABLE departamentos
(
	id_departamento INT PRIMARY KEY NOT NULL,
	id_facultad INT NOT NULL,
	nombre_departamento VARCHAR (255) NOT NULL,
	jefe_departamento VARCHAR (30),
	FOREIGN KEY (id_facultad) REFERENCES facultades(id_facultad)
);

CREATE TABLE programas
(
	id_programa INT PRIMARY KEY,
	cod_programa VARCHAR (30),
	id_departamento INT NOT NULL,
	nombre_programa VARCHAR (255) NOT NULL,
	nivel VARCHAR (50) NOT NULL,
	modalidad VARCHAR (50) NOT NULL,
	FOREIGN KEY (id_departamento) REFERENCES departamentos (id_departamento)
);

CREATE TABLE asignaturas
(
	id_asignatura INT PRIMARY KEY NOT NULL,
	id_programa INT NOT NULL,
	nombre_asignatura VARCHAR (50) NOT NULL,
	creditos INT,
	modalidad VARCHAR (30),
	FOREIGN KEY (id_programa) REFERENCES programas(id_programa)
);

CREATE TABLE permisos
(
	id_permiso INT PRIMARY KEY NOT NULL,
	descripcion_permiso TEXT NOT NULL
);

CREATE TABLE roles
(
	id_rol INT PRIMARY KEY,
	nombre_rol VARCHAR(50) NOT NULL
);

CREATE TABLE usuarios
(
	id_usuario INT PRIMARY KEY NOT NULL,
	username VARCHAR(50) NOT NULL,
	id_rol INT NOT NULL,
	fecha_registro_usuario DATE,
	estado VARCHAR(30),
	FOREIGN KEY(id_rol) REFERENCES roles(id_rol)
);

CREATE TABLE docentes
(
	id_docente INT PRIMARY KEY NOT NULL,
	id_departamento INT  NOT NULL,
	cedula_docente INT UNIQUE NOT NULL,
	nombre_docente VARCHAR(30) NOT NULL,
	apellido_docente VARCHAR (30) NOT NULL,
	id_rol INT,
	id_usuario INT NOT NULL,
	FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento),
	FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
	FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE estudiantes
(
	id_estudiante INT PRIMARY KEY NOT NULL,
	id_programa INT NOT NULL,
	id_asignatura INT NOT NULL,
	cedula_estudiante INT UNIQUE NOT NULL,
	nombre_estudiante VARCHAR(30) NOT NULL,
	apellido_estudiante VARCHAR (30) NOT NULL,
	estado VARCHAR(30) NOT NULL,
	fecha_ingreso DATE,
	id_rol INT NOT NULL,
	genero VARCHAR NOT NULL,
	id_usuario INT NOT NULL,
	FOREIGN KEY (id_programa) REFERENCES programas(id_programa),
	FOREIGN KEY (id_asignatura) REFERENCES asignaturas (id_asignatura),
	FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
	FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE tipo_proyecto
( 
	id_tipo_proyecto INT PRIMARY KEY,
	nombre_tipo VARCHAR(30)
);

CREATE TABLE proyectos
(
	id_proyecto INT PRIMARY KEY NOT NULL,
	id_tipo_proyecto INT NOT NULL,
	titulo_proyecto VARCHAR(255) NOT NULL,
	fecha_inicio DATE,
	id_programa INT NOT NULL,
	id_estudiante INT NOT NULL,
	id_docente INT NOT NULL,
	FOREIGN KEY (id_tipo_proyecto) REFERENCES tipo_proyecto(id_tipo_proyecto),
	FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante),
	FOREIGN KEY (id_programa) REFERENCES programas (id_programa),
	FOREIGN KEY (id_docente) REFERENCES Docentes(id_docente)
);

CREATE TABLE evaluadores
(
	id_evaluador INT PRIMARY KEY NOT NULL,
	id_institucion INT NOT NULL,
	nombre_evaluador VARCHAR(30),
	apellido_evaluador VARCHAR(30),
	tipo_evaluador VARCHAR(50) NOT NULL,
	es_interno BOOLEAN NOT NULL,
	id_usuario INT NOT NULL,
	FOREIGN KEY (id_institucion) REFERENCES instituciones(id_institucion),
	FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE evaluaciones
(
	id_evaluacion INT PRIMARY KEY,
	id_proyecto INT NOT NULL,
	id_evaluador INT NOT NULL,
	fecha_evaluacion DATE,
	calificacion DECIMAL(5,2),
	estado VARCHAR (30)  NOT NULL,
	FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto),
	FOREIGN KEY (id_evaluador) REFERENCES evaluadores(id_evaluador)
);

CREATE TABLE entregables
(
	id_entregable INT PRIMARY KEY NOT NULL,
	id_proyecto INT NOT NULL,
	titulo_entregable VARCHAR (255),
	fecha_entrega_entregable DATE,
	estado VARCHAR(30) NOT NULL,
	FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto)
);

CREATE TABLE era
(
	id_era INT PRIMARY KEY NOT NULL,
	id_proyecto INT NOT NULL,
	titulo_era VARCHAR(255),
	resultado TEXT,
	estado VARCHAR(30) NOT NULL,
	FOREIGN KEY(id_proyecto) REFERENCES proyectos(id_proyecto)
);

CREATE TABLE ira
(
	id_ira INT PRIMARY KEY NOT NULL,
	id_proyecto INT NOT NULL,
	titulo_ira VARCHAR(50),
	estado VARCHAR(30) NOT NULL,
	FOREIGN KEY(id_proyecto) REFERENCES proyectos(id_proyecto)
);

CREATE TABLE rol_Permiso
(
    id_rol INT NOT NULL,
    id_permiso INT NOT NULL,
    PRIMARY KEY (id_rol, id_permiso),
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
    FOREIGN KEY (id_permiso) REFERENCES permisos(id_permiso)
);

CREATE TABLE proyecto_asignatura
(
	id_proyecto INT NOT NULL,
	id_asignatura INT NOT NULL,
	grupo VARCHAR(30) NOT NULL,
	FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto),
	FOREIGN KEY (id_asignatura) REFERENCES asignaturas(id_asignatura)
);

CREATE TABLE docente_asignatura (
    id_docente INT NOT NULL,
    id_asignatura INT NOT NULL,
    PRIMARY KEY (id_docente, id_asignatura),
    FOREIGN KEY (id_docente) REFERENCES docentes(id_docente),
    FOREIGN KEY (id_asignatura) REFERENCES asignaturas(id_asignatura)
);

CREATE TABLE usuario_rol (
    id_usuario INT NOT NULL,
    id_rol INT NOT NULL,
    fecha_asignacion DATE,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

CREATE TABLE proyecto_evaluacion (
    id_proyecto INT NOT NULL,
    id_evaluacion INT NOT NULL,
    PRIMARY KEY (id_proyecto, id_evaluacion),
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto),
    FOREIGN KEY (id_evaluacion) REFERENCES evaluaciones(id_evaluacion)
);





