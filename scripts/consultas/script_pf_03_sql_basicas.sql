--Listado de docentes #1 
SELECT
doc.id_docente,
doc.nombre_docente AS nombre,
doc.apellido_docente AS apellido,
doc.cedula_docente AS cedula,
doc.id_departamento,
doc.id_usuario
FROM docentes doc
ORDER BY doc.apellido_docente, doc.nombre_docente;

--Listado de docentes #2
SELECT
doc.id_docente,
doc.id_departamento AS cod_departamento,
doc.nombre_docente AS nombre,
doc.apellido_docente AS apellido,
doc.cedula_docente AS cedula,
doc.id_usuario
FROM docentes doc
ORDER BY doc.id_departamento, doc.apellido_docente, doc.nombre_docente;

--Listado de docentes #3
SELECT 
    doc.id_docente AS codigo_docente,
    doc.cedula_docente,
    doc.nombre_docente AS nombre_docente,
    doc.apellido_docente AS apellido_docente
FROM docentes doc
WHERE doc.id_departamento = (
    SELECT dep.id_departamento 
    FROM departamentos dep 
    WHERE dep.nombre_departamento = 'Sistemas Digitales'
)
ORDER BY doc.cedula_docente;

--Listado de docentes #4
SELECT 
    doc.id_departamento AS codigo_departamento,
    COUNT(*) AS total_docentes
FROM docentes doc
GROUP BY doc.id_departamento
ORDER BY doc.id_departamento;
--Listado de estudiantes #1
SELECT 
    est.id_estudiante AS codigo_estudiante,
    est.id_usuario AS codigo_usuario,
    est.genero AS sexo,
    est.nombre_estudiante,
    est.apellido_estudiante,
    est.id_programa
FROM estudiantes est
ORDER BY est.genero, est.apellido_estudiante, est.nombre_estudiante;

--Listado de estudiantes #2
SELECT 
    est.id_estudiante AS codigo_estudiante,
    est.id_usuario AS usuario,
    est.nombre_estudiante AS nombre,
    est.apellido_estudiante AS apellido,
    est.genero AS sexo,
    est.id_programa AS programa,
    est.cedula_estudiante AS cedula
FROM estudiantes est
ORDER BY est.genero, est.apellido_estudiante, est.nombre_estudiante;

--Listado de estudiantes #3
SELECT 
    est.id_estudiante AS codigo_estudiante,
    est.cedula_estudiante AS cedula,
    (
        SELECT pro.nombre_programa 
        FROM programas pro 
        WHERE pro.id_programa = est.id_programa
    ) AS nombre_programa,
    est.nombre_estudiante AS nombre,
    est.apellido_estudiante AS apellido
FROM estudiantes est
WHERE est.id_programa IN (
    SELECT pro.id_programa
    FROM programas pro
    WHERE pro.nombre_programa IN ('Ingeniería de Software', 'Tecnología en Desarrollo de Software')
)
ORDER BY est.id_programa, est.cedula_estudiante;

--Listado de estudiantes #4
SELECT 
    est.id_programa AS codigo_programa,
    COUNT(*) AS total_estudiantes
FROM estudiantes est
GROUP BY est.id_programa
ORDER BY est.id_programa;
--Listado de asignaturas #1
SELECT * FROM asignaturas;

SELECT
asi.id_asignatura AS codigo_asignatura,
asi.id_programa,
asi.nombre_asignatura,
asi.creditos,
asi.modalidad
FROM asignaturas asi
ORDER BY asi.nombre_asignatura;

--Listado de asignaturas #2 y #3
SELECT
asi.id_asignatura AS codigo_asignatura,
asi.id_programa AS cod_programa,
asi.nombre_asignatura,
(
    SELECT pro.nombre_programa
    FROM programas pro
    WHERE pro.id_programa = asi.id_programa
),
asi.modalidad AS modalidad_asignatura,
asi.creditos AS creditos_asignatura
FROM asignaturas asi
WHERE asi.id_programa IN (
    SELECT pro.id_programa FROM programas pro
    WHERE pro.nombre_programa IN ('Ingeniería de Software', 'Tecnología en Desarrollo de Software')
)
ORDER BY asi.id_programa, asi.id_asignatura;

--Listado de asignaturas #4
SELECT 
asi.id_programa AS codigo_programa,
COUNT(*) AS total_asignaturas
FROM asignaturas asi
GROUP BY asi.id_programa
ORDER BY asi.id_programa;
--Listado libre #1
SELECT
eva.id_evaluacion,
eva.id_proyecto,
eva.calificacion,
eva.estado
FROM evaluaciones eva
WHERE eva.estado = 'Aprobado'
ORDER BY eva.calificacion DESC;

--Listado libre #2
SELECT
eva.id_evaluacion,
eva.id_proyecto,
eva.calificacion,
eva.estado
FROM evaluaciones eva
WHERE eva.estado = 'Reprobado'
ORDER BY eva.calificacion DESC;

--Listado libre #3
SELECT
proy.id_proyecto,
proy.titulo_proyecto,
(
    SELECT tip.nombre_tipo FROM tipo_proyecto tip
    WHERE tip.id_tipo_proyecto = proy.id_tipo_proyecto
) AS tipo
FROM proyectos proy
WHERE proy.id_tipo_proyecto IN (
    SELECT tip.id_tipo_proyecto
    FROM tipo_proyecto tip
    WHERE tip.nombre_tipo = 'PIA'
)
ORDER BY proy.titulo_proyecto;