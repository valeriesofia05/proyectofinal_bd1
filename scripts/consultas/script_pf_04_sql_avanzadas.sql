--Listados de proyectos #1--
SELECT 
    tp.nombre_tipo AS tipo_proyecto,
    p.id_proyecto,
    p.titulo_proyecto,
    f.nombre_facultad,
    pr.nombre_programa
FROM 
    proyectos p
JOIN tipo_proyecto tp ON p.id_tipo_proyecto = tp.id_tipo_proyecto
JOIN programas pr ON p.id_programa = pr.id_programa
JOIN departamentos d ON pr.id_departamento = d.id_departamento
JOIN facultades f ON d.id_facultad = f.id_facultad
ORDER BY 
    f.nombre_facultad,
    pr.nombre_programa,
    p.id_proyecto;
	
--Listado de proyectos #2--
SELECT 
    tp.nombre_tipo AS tipo_proyecto,
    p.id_proyecto,
    p.titulo_proyecto,
    f.nombre_facultad,
    pr.nombre_programa,
    a.nombre_asignatura,
    d.nombre_docente || ' ' || d.apellido_docente AS docente,
    e.nombre_estudiante || ' ' || e.apellido_estudiante AS estudiante
FROM 
    proyectos p
JOIN tipo_proyecto tp ON p.id_tipo_proyecto = tp.id_tipo_proyecto
JOIN programas pr ON p.id_programa = pr.id_programa
JOIN departamentos dept ON pr.id_departamento = dept.id_departamento
JOIN facultades f ON dept.id_facultad = f.id_facultad
JOIN proyecto_asignatura pa ON p.id_proyecto = pa.id_proyecto
JOIN asignaturas a ON pa.id_asignatura = a.id_asignatura
JOIN docente_asignatura da ON a.id_asignatura = da.id_asignatura
JOIN docentes d ON da.id_docente = d.id_docente
JOIN estudiantes e ON p.id_estudiante = e.id_estudiante
ORDER BY 
    p.id_proyecto;

--Listado de proyectos #3--
SELECT 
    p.id_proyecto,
    p.titulo_proyecto,
    ev.id_evaluacion,
    ev.fecha_evaluacion,
    ev.calificacion,
    ev.estado,
    e.nombre_evaluador || ' ' || e.apellido_evaluador AS evaluador
FROM 
    evaluaciones ev
JOIN proyectos p ON ev.id_proyecto = p.id_proyecto
JOIN evaluadores e ON ev.id_evaluador = e.id_evaluador
ORDER BY 
    p.id_proyecto, ev.fecha_evaluacion;

--Listado de proyectos #4--
SELECT 
    f.id_facultad,
    f.nombre_facultad,
    pr.id_programa,
    pr.nombre_programa,
    COUNT(p.id_proyecto) AS cantidad_proyectos
FROM 
    proyectos p
JOIN programas pr ON p.id_programa = pr.id_programa
JOIN departamentos d ON pr.id_departamento = d.id_departamento
JOIN facultades f ON d.id_facultad = f.id_facultad
GROUP BY 
    f.id_facultad, f.nombre_facultad, pr.id_programa, pr.nombre_programa
ORDER BY 
    f.nombre_facultad, pr.nombre_programa;
	
--Listado de estudiantes/asignaturas #1--
SELECT 
    e.nombre_estudiante || ' ' || e.apellido_estudiante AS estudiante,
    a.nombre_asignatura,
    p.id_programa,
    pa.grupo
FROM 
    estudiantes e
JOIN asignaturas a ON e.id_asignatura = a.id_asignatura
JOIN proyecto_asignatura pa ON a.id_asignatura = pa.id_asignatura
JOIN programas p ON a.id_programa = p.id_programa
WHERE pa.grupo = '051';

--Listado de estudiantes/asignatura #2--
SELECT 
    tp.nombre_tipo,
    f.nombre_facultad,
    pr.nombre_programa,
    a.nombre_asignatura,
    pa.grupo
FROM 
    proyecto_asignatura pa
JOIN asignaturas a ON pa.id_asignatura = a.id_asignatura
JOIN proyectos p ON pa.id_proyecto = p.id_proyecto
JOIN tipo_proyecto tp ON p.id_tipo_proyecto = tp.id_tipo_proyecto
JOIN programas pr ON a.id_programa = pr.id_programa
JOIN departamentos d ON pr.id_departamento = d.id_departamento
JOIN facultades f ON d.id_facultad = f.id_facultad
ORDER BY 
    tp.nombre_tipo, f.nombre_facultad, pr.nombre_programa, a.nombre_asignatura;

--Listado de estudiantes/asignatura #3-
SELECT 
    f.id_facultad,
    f.nombre_facultad,
    pr.id_programa,
    pr.nombre_programa,
    tp.id_tipo_proyecto,
    tp.nombre_tipo,
    COUNT(p.id_proyecto) AS cantidad
FROM 
    proyectos p
JOIN tipo_proyecto tp ON p.id_tipo_proyecto = tp.id_tipo_proyecto
JOIN programas pr ON p.id_programa = pr.id_programa
JOIN departamentos d ON pr.id_departamento = d.id_departamento
JOIN facultades f ON d.id_facultad = f.id_facultad
GROUP BY 
    f.id_facultad, f.nombre_facultad, pr.id_programa, pr.nombre_programa, tp.id_tipo_proyecto, tp.nombre_tipo
ORDER BY 
    f.nombre_facultad, pr.nombre_programa, tp.nombre_tipo;

--Listado de evaluadores 1#--
SELECT 
    e.nombre_evaluador || ' ' || e.apellido_evaluador AS evaluador,
    f.nombre_facultad,
    pr.nombre_programa,
    tp.nombre_tipo,
    p.titulo_proyecto
FROM 
    evaluaciones ev
JOIN evaluadores e ON ev.id_evaluador = e.id_evaluador
JOIN proyectos p ON ev.id_proyecto = p.id_proyecto
JOIN tipo_proyecto tp ON p.id_tipo_proyecto = tp.id_tipo_proyecto
JOIN programas pr ON p.id_programa = pr.id_programa
JOIN departamentos d ON pr.id_departamento = d.id_departamento
JOIN facultades f ON d.id_facultad = f.id_facultad
ORDER BY 
    evaluador, f.nombre_facultad, pr.nombre_programa, tp.nombre_tipo, p.titulo_proyecto;

--Listado de evaluadores #2--
SELECT 
    e.nombre_evaluador || ' ' || e.apellido_evaluador AS evaluador,
    COUNT(ev.id_evaluacion) AS cantidad_evaluaciones,
    AVG(ev.calificacion) AS promedio_calificacion
FROM 
    evaluaciones ev
JOIN evaluadores e ON ev.id_evaluador = e.id_evaluador
GROUP BY 
    e.nombre_evaluador, e.apellido_evaluador
ORDER BY 
    promedio_calificacion DESC;

--Listado de evaluadores #3--
SELECT 
    e.nombre_evaluador || ' ' || e.apellido_evaluador AS evaluador,
    p.titulo_proyecto,
    ev.fecha_evaluacion,
    ev.calificacion,
    ev.estado
FROM 
    evaluaciones ev
JOIN evaluadores e ON ev.id_evaluador = e.id_evaluador
JOIN proyectos p ON ev.id_proyecto = p.id_proyecto
ORDER BY 
    evaluador, ev.fecha_evaluacion;

--Listado de usuarios #1--
SELECT 
    u.id_usuario,
    u.username,
    r.nombre_rol,
    u.estado,
    u.fecha_registro_usuario
FROM 
    usuarios u
JOIN roles r ON u.id_rol = r.id_rol
ORDER BY 
    r.nombre_rol, u.username;

--Consulta libre--
--Lista de usuarios con su rol y la cantidad de proyectos realizados--
--ordenado por la cantidad de proyectos(de mayor a menor) y su nombre de usuario--
SELECT 
    u.username,
    r.nombre_rol,
    COUNT(p.id_proyecto) AS cantidad_proyectos
FROM 
    usuarios u
JOIN roles r ON u.id_rol = r.id_rol
LEFT JOIN docentes d ON u.id_usuario = d.id_usuario
LEFT JOIN estudiantes e ON u.id_usuario = e.id_usuario
LEFT JOIN proyectos p ON p.id_docente = d.id_docente OR p.id_estudiante = e.id_estudiante
GROUP BY 
    u.username, r.nombre_rol
ORDER BY 
    cantidad_proyectos DESC, u.username;

	