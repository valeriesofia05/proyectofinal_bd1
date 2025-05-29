-- vista_proyectos --
CREATE VIEW vista_proyectos AS
SELECT 
    pro.id_proyecto,
    tip.nombre_tipo AS tipo_proyecto,
    pro.titulo_proyecto,
    fac.id_facultad,
    fac.nombre_facultad,
    prg.id_programa,
    prg.nombre_programa,
    asi.id_asignatura,
    asi.nombre_asignatura,
    pas.grupo,
    doc.id_docente,
    doc.nombre_docente || ' ' || doc.apellido_docente AS nombre_docente,
    est.id_estudiante,
    est.nombre_estudiante || ' ' || est.apellido_estudiante AS nombre_estudiante
FROM 
    proyectos pro
JOIN tipo_proyecto tip ON pro.id_tipo_proyecto = tip.id_tipo_proyecto
JOIN programas prg ON pro.id_programa = prg.id_programa
JOIN departamentos dep ON prg.id_departamento = dep.id_departamento
JOIN facultades fac ON dep.id_facultad = fac.id_facultad
LEFT JOIN proyecto_asignatura pas ON pro.id_proyecto = pas.id_proyecto
LEFT JOIN asignaturas asi ON pas.id_asignatura = asi.id_asignatura
LEFT JOIN docentes doc ON pro.id_docente = doc.id_docente
LEFT JOIN estudiantes est ON pro.id_estudiante = est.id_estudiante;

-- vista_evaluaciones --
CREATE VIEW vista_evaluaciones AS
SELECT 
    eva.id_evaluacion,
    eva.fecha_evaluacion,
    eva.calificacion,
    eva.estado AS estado_evaluacion,
    
    pro.id_proyecto,
    pro.titulo_proyecto,
    tip.nombre_tipo AS tipo_proyecto,

    fac.id_facultad,
    fac.nombre_facultad,
    prg.id_programa,
    prg.nombre_programa,
    asi.id_asignatura,
    asi.nombre_asignatura,
    pas.grupo,

    doc.id_docente,
    doc.nombre_docente || ' ' || doc.apellido_docente AS nombre_docente,
    est.id_estudiante,
    est.nombre_estudiante || ' ' || est.apellido_estudiante AS nombre_estudiante,

    evl.id_evaluador,
    evl.nombre_evaluador || ' ' || evl.apellido_evaluador AS nombre_evaluador

FROM 
    evaluaciones eva
JOIN proyectos pro ON eva.id_proyecto = pro.id_proyecto
JOIN tipo_proyecto tip ON pro.id_tipo_proyecto = tip.id_tipo_proyecto
JOIN programas prg ON pro.id_programa = prg.id_programa
JOIN departamentos dep ON prg.id_departamento = dep.id_departamento
JOIN facultades fac ON dep.id_facultad = fac.id_facultad
LEFT JOIN proyecto_asignatura pas ON pro.id_proyecto = pas.id_proyecto
LEFT JOIN asignaturas asi ON pas.id_asignatura = asi.id_asignatura
LEFT JOIN docentes doc ON pro.id_docente = doc.id_docente
LEFT JOIN estudiantes est ON pro.id_estudiante = est.id_estudiante
LEFT JOIN evaluadores evl ON eva.id_evaluador = evl.id_evaluador;

-- vista_estadistica --
CREATE VIEW vista_estadistica AS
SELECT 
    fac.id_facultad,
    fac.nombre_facultad,
    prg.id_programa,
    prg.nombre_programa,
    asi.id_asignatura,
    asi.nombre_asignatura,
    tip.id_tipo_proyecto,
    tip.nombre_tipo AS tipo_proyecto,
    COUNT(DISTINCT pro.id_proyecto) AS total_proyectos
FROM 
    proyectos pro
JOIN tipo_proyecto tip ON pro.id_tipo_proyecto = tip.id_tipo_proyecto
JOIN programas prg ON pro.id_programa = prg.id_programa
JOIN departamentos dep ON prg.id_departamento = dep.id_departamento
JOIN facultades fac ON dep.id_facultad = fac.id_facultad
LEFT JOIN proyecto_asignatura pas ON pro.id_proyecto = pas.id_proyecto
LEFT JOIN asignaturas asi ON pas.id_asignatura = asi.id_asignatura
GROUP BY 
    fac.id_facultad, fac.nombre_facultad,
    prg.id_programa, prg.nombre_programa,
    asi.id_asignatura, asi.nombre_asignatura,
    tip.id_tipo_proyecto, tip.nombre_tipo;

-- vista_docentes --
CREATE OR REPLACE VIEW vista_docentes AS
SELECT 
    doc.id_docente,
    CONCAT(doc.nombre_docente, ' ', doc.apellido_docente) AS nombre_completo_docente,
    asi.nombre_asignatura,
    asi.modalidad AS modalidad_asignatura,
    asi.creditos,
    prg.nombre_programa,
    dep.nombre_departamento,
    fac.nombre_facultad,
    ins.nombre_institucion
FROM 
    docente_asignatura das
JOIN docentes doc ON das.id_docente = doc.id_docente
JOIN asignaturas asi ON das.id_asignatura = asi.id_asignatura
JOIN programas prg ON asi.id_programa = prg.id_programa
JOIN departamentos dep ON prg.id_departamento = dep.id_departamento
JOIN facultades fac ON dep.id_facultad = fac.id_facultad
JOIN instituciones ins ON fac.id_institucion = ins.id_institucion;
-- vista-consulta #1 --
SELECT * 
FROM vista_proyectos
WHERE nombre_facultad = 'Ingeniería';

-- vista-consulta #2 --
SELECT * 
FROM vista_evaluaciones
WHERE estado_evaluacion = 'Reprobado'
ORDER BY nombre_estudiante;

-- vista-consulta #3 --
SELECT id_tipo_proyecto, COUNT(*) 
FROM vista_estadistica
GROUP BY id_tipo_proyecto;

-- vista-consulta #4 --
SELECT 
    nombre_completo_docente,
    nombre_asignatura,
    modalidad_asignatura,
    creditos,
    nombre_departamento,
    nombre_facultad,
    nombre_institucion
FROM vista_docentes
WHERE modalidad_asignatura = 'Presencial'
ORDER BY nombre_completo_docente;