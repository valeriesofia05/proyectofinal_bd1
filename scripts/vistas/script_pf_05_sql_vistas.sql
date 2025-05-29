--vista_proyecto--
CREATE VIEW vista_proyectos AS
SELECT 
    p.id_proyecto,
    tp.nombre_tipo AS tipo_proyecto,
    p.titulo_proyecto,
    f.id_facultad,
    f.nombre_facultad,
    pr.id_programa,
    pr.nombre_programa,
    a.id_asignatura,
    a.nombre_asignatura,
    pa.grupo,
    d.id_docente,
    d.nombre_docente || ' ' || d.apellido_docente AS nombre_docente,
    e.id_estudiante,
    e.nombre_estudiante || ' ' || e.apellido_estudiante AS nombre_estudiante
FROM 
    proyectos p
JOIN tipo_proyecto tp ON p.id_tipo_proyecto = tp.id_tipo_proyecto
JOIN programas pr ON p.id_programa = pr.id_programa
JOIN departamentos dep ON pr.id_departamento = dep.id_departamento
JOIN facultades f ON dep.id_facultad = f.id_facultad
LEFT JOIN proyecto_asignatura pa ON p.id_proyecto = pa.id_proyecto
LEFT JOIN asignaturas a ON pa.id_asignatura = a.id_asignatura
LEFT JOIN docentes d ON p.id_docente = d.id_docente
LEFT JOIN estudiantes e ON p.id_estudiante = e.id_estudiante;

--vista_evaluacion--
CREATE VIEW vista_evaluaciones AS
SELECT 
    ev.id_evaluacion,
    ev.fecha_evaluacion,
    ev.calificacion,
    ev.estado AS estado_evaluacion,
    
    p.id_proyecto,
    p.titulo_proyecto,
    tp.nombre_tipo AS tipo_proyecto,

    f.id_facultad,
    f.nombre_facultad,
    pr.id_programa,
    pr.nombre_programa,
    a.id_asignatura,
    a.nombre_asignatura,
    pa.grupo,

    d.id_docente,
    d.nombre_docente || ' ' || d.apellido_docente AS nombre_docente,
    e.id_estudiante,
    e.nombre_estudiante || ' ' || e.apellido_estudiante AS nombre_estudiante,

    evl.id_evaluador,
    evl.nombre_evaluador || ' ' || evl.apellido_evaluador AS nombre_evaluador

FROM 
    evaluaciones ev
JOIN proyectos p ON ev.id_proyecto = p.id_proyecto
JOIN tipo_proyecto tp ON p.id_tipo_proyecto = tp.id_tipo_proyecto
JOIN programas pr ON p.id_programa = pr.id_programa
JOIN departamentos dep ON pr.id_departamento = dep.id_departamento
JOIN facultades f ON dep.id_facultad = f.id_facultad
LEFT JOIN proyecto_asignatura pa ON p.id_proyecto = pa.id_proyecto
LEFT JOIN asignaturas a ON pa.id_asignatura = a.id_asignatura
LEFT JOIN docentes d ON p.id_docente = d.id_docente
LEFT JOIN estudiantes e ON p.id_estudiante = e.id_estudiante
LEFT JOIN evaluadores evl ON ev.id_evaluador = evl.id_evaluador;


--vista_estadistica-
CREATE VIEW vista_estadistica AS
SELECT 
    f.id_facultad,
    f.nombre_facultad,
    pr.id_programa,
    pr.nombre_programa,
    a.id_asignatura,
    a.nombre_asignatura,
    tp.id_tipo_proyecto,
    tp.nombre_tipo AS tipo_proyecto,
    COUNT(DISTINCT p.id_proyecto) AS total_proyectos
FROM 
    proyectos p
JOIN tipo_proyecto tp ON p.id_tipo_proyecto = tp.id_tipo_proyecto
JOIN programas pr ON p.id_programa = pr.id_programa
JOIN departamentos dep ON pr.id_departamento = dep.id_departamento
JOIN facultades f ON dep.id_facultad = f.id_facultad
LEFT JOIN proyecto_asignatura pa ON p.id_proyecto = pa.id_proyecto
LEFT JOIN asignaturas a ON pa.id_asignatura = a.id_asignatura
GROUP BY 
    f.id_facultad, f.nombre_facultad,
    pr.id_programa, pr.nombre_programa,
    a.id_asignatura, a.nombre_asignatura,
    tp.id_tipo_proyecto, tp.nombre_tipo;

--Vista_docentes--
CREATE OR REPLACE VIEW vista_docentes AS
SELECT 
    d.id_docente,
    CONCAT(d.nombre_docente, ' ', d.apellido_docente) AS nombre_completo_docente,
    a.nombre_asignatura,
    a.modalidad AS modalidad_asignatura,
    a.creditos,
    p.nombre_programa,
    dpto.nombre_departamento,
    f.nombre_facultad,
    i.nombre_institucion
FROM 
    docente_asignatura da
    JOIN docentes d ON da.id_docente = d.id_docente
    JOIN asignaturas a ON da.id_asignatura = a.id_asignatura
    JOIN programas p ON a.id_programa = p.id_programa
    JOIN departamentos dpto ON p.id_departamento = dpto.id_departamento
    JOIN facultades f ON dpto.id_facultad = f.id_facultad
    JOIN instituciones i ON f.id_institucion = i.id_institucion;

--vista-consulta #1--
SELECT *FROM vista_proyectos
WHERE nombre_facultad = 'Ingeniería';

--vista-consulta #2--
SELECT *FROM vista_evaluaciones
WHERE estado_evaluacion = 'Reprobado'
ORDER BY nombre_estudiante;

--vista-consulta #3--
SELECT id_tipo_proyecto, COUNT(*) 
FROM vista_estadistica
GROUP BY id_tipo_proyecto;

--vista-consulta #4--
SELECT 
  nombre_completo_docente,
  nombre_asignatura,
  modalidad_asignatura,
  creditos,
  nombre_departamento,
  nombre_facultad,
  nombre_institucion
FROM 
    vista_docentes
WHERE
modalidad_asignatura = 'Presencial'
ORDER BY nombre_completo_docente;
