--Listado de docentes #1
SELECT
d.id_docente,
d.nombre_docente AS nombre,
d.apellido_docente AS apellido,
d.cedula_docente AS cedula,
d.id_departamento,
d.id_usuario
FROM docentes d
ORDER BY apellido_docente, nombre_docente;

--Listado de docentes #2
SELECT
d.id_docente,
d.id_departamento AS cod_departamento,
d.nombre_docente AS nombre,
d.apellido_docente AS apellido,
d.cedula_docente AS cedula,
d.id_usuario
FROM docentes d
ORDER BY id_departamento, apellido_docente, nombre_docente;

--Listado de docentes #3
SELECT 
    d.id_docente AS codigo_docente,
    d.cedula_docente,
    d.nombre_docente AS nombre_docente,
    d.apellido_docente AS apellido_docente
FROM docentes d
WHERE d.id_departamento = (
    SELECT dept.id_departamento 
    FROM departamentos dept 
    WHERE dept.nombre_departamento = 'Sistemas Digitales'
)
ORDER BY d.cedula_docente;

--Listado de docentes #4
SELECT 
    d.id_departamento AS codigo_departamento,
    COUNT(*) AS total_docentes
FROM docentes d
GROUP BY d.id_departamento
ORDER BY d.id_departamento;


--Listado de estudiantes #1
SELECT 
    e.id_estudiante AS codigo_estudiante,
    e.id_usuario AS codigo_usuario,
    e.genero AS sexo,
    e.nombre_estudiante,
    e.apellido_estudiante,
    e.id_programa
FROM estudiantes e
ORDER BY e.genero, e.apellido_estudiante, e.nombre_estudiante;

--Listado de estudiantes #2
SELECT 
    e.id_estudiante AS codigo_estudiante,
    e.id_usuario AS usuario,
    e.nombre_estudiante AS nombre,
    e.apellido_estudiante AS apellido,
	e.genero AS sexo,
    e.id_programa AS programa,
	e.cedula_estudiante AS cedula
FROM estudiantes e
ORDER BY e.genero, e.apellido_estudiante, e.nombre_estudiante;

--Listado de estudiantes #3
SELECT 
    e.id_estudiante AS codigo_estudiante,
    e.cedula_estudiante AS cedula,
	(SELECT pro.nombre_programa 
     FROM programas pro 
     WHERE pro.id_programa = e.id_programa) AS nombre_programa,
    e.nombre_estudiante AS nombre,
    e.apellido_estudiante AS apellido
FROM estudiantes e
WHERE e.id_programa IN(
    SELECT pro.id_programa
    FROM programas pro
    WHERE pro.nombre_programa IN ('Ingeniería de Software', 'Tecnología en Desarrollo de Software')
)
ORDER BY e.id_programa , e.cedula_estudiante;

--Listado de estudiantes #4
SELECT 
    e.id_programa AS codigo_programa,
    COUNT(*) AS total_estudiantes
FROM estudiantes e
GROUP BY e.id_programa
ORDER BY e.id_programa;

--Listado de asignaturas #1
SELECT*FROM asignaturas
SELECT
a.id_asignatura AS codigo_asignatura,
a.id_programa,
a.nombre_asignatura,
a.creditos,
a.modalidad
FROM asignaturas a
ORDER BY nombre_asignatura;

--Listado de asignaturas #2 y #3
SELECT
a.id_asignatura AS codigo_asignatura,
a.id_programa AS cod_programa,
a.nombre_asignatura,
(
SELECT p.nombre_programa
FROM programas p
WHERE p.id_programa = a.id_programa
),
a.modalidad AS modalidad_asignatura,
a.creditos AS creditos_asignatura
FROM asignaturas a
WHERE a.id_programa IN(
SELECT p.id_programa FROM programas p
WHERE p.nombre_programa IN ('Ingeniería de Software', 'Tecnología en Desarrollo de Software')
)
ORDER BY a.id_programa, a.id_asignatura;


--Listado de asignaturas #4
SELECT 
a.id_programa AS codigo_programa,
COUNT(*) AS total_asignaturas
FROM asignaturas a
GROUP BY id_programa
ORDER BY id_programa;

--Listado libre #1
--Listado de proyectos aprobados ordenado de mayor a menor nota
SELECT
e.id_evaluacion,
e.id_proyecto,
e.calificacion,
e.estado
FROM evaluaciones e
WHERE estado = 'Aprobado'
ORDER BY calificacion DESC;

--Listado libre #2
--Listado de proyectos reprobados ordenado de mayor a menor nota
SELECT
e.id_evaluacion,
e.id_proyecto,
e.calificacion,
e.estado
FROM evaluaciones e
WHERE estado = 'Reprobado'
ORDER BY calificacion DESC;

--Listado libre #3
--Listado de proyectos PIA
SELECT
p.id_proyecto,
p.titulo_proyecto,
(
SELECT tp.nombre_tipo FROM tipo_proyecto tp
WHERE tp.id_tipo_proyecto = p.id_tipo_proyecto
) AS tipo
FROM proyectos p
WHERE p.id_tipo_proyecto IN
(
SELECT tp.id_tipo_proyecto
FROM tipo_proyecto tp
WHERE tp.nombre_tipo = 'PIA'
)
ORDER BY titulo_proyecto;






