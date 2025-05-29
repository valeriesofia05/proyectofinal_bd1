--Listados de proyectos #1--
SELECT 
    tpr.nombre_tipo AS tipo_proyecto,
    pro.id_proyecto,
    pro.titulo_proyecto,
    fac.nombre_facultad,
    prg.nombre_programa
FROM 
    proyectos pro
JOIN tipo_proyecto tpr ON pro.id_tipo_proyecto = tpr.id_tipo_proyecto
JOIN programas prg ON pro.id_programa = prg.id_programa
JOIN departamentos dep ON prg.id_departamento = dep.id_departamento
JOIN facultades fac ON dep.id_facultad = fac.id_facultad
ORDER BY 
    fac.nombre_facultad,
    prg.nombre_programa,
    pro.id_proyecto;

--Listado de proyectos #2--
SELECT 
    tpr.nombre_tipo AS tipo_proyecto,
    pro.id_proyecto,
    pro.titulo_proyecto,
    fac.nombre_facultad,
    prg.nombre_programa,
    asi.nombre_asignatura,
    doc.nombre_docente || ' ' || doc.apellido_docente AS docente,
    est.nombre_estudiante || ' ' || est.apellido_estudiante AS estudiante
FROM 
    proyectos pro
JOIN tipo_proyecto tpr ON pro.id_tipo_proyecto = tpr.id_tipo_proyecto
JOIN programas prg ON pro.id_programa = prg.id_programa
JOIN departamentos dep ON prg.id_departamento = dep.id_departamento
JOIN facultades fac ON dep.id_facultad = fac.id_facultad
JOIN proyecto_asignatura pas ON pro.id_proyecto = pas.id_proyecto
JOIN asignaturas asi ON pas.id_asignatura = asi.id_asignatura
JOIN docente_asignatura das ON asi.id_asignatura = das.id_asignatura
JOIN docentes doc ON das.id_docente = doc.id_docente
JOIN estudiantes est ON pro.id_estudiante = est.id_estudiante
ORDER BY 
    pro.id_proyecto;

--Listado de proyectos #3--
SELECT 
    pro.id_proyecto,
    pro.titulo_proyecto,
    eva.id_evaluacion,
    eva.fecha_evaluacion,
    eva.calificacion,
    eva.estado,
    evr.nombre_evaluador || ' ' || evr.apellido_evaluador AS evaluador
FROM 
    evaluaciones eva
JOIN proyectos pro ON eva.id_proyecto = pro.id_proyecto
JOIN evaluadores evr ON eva.id_evaluador = evr.id_evaluador
ORDER BY 
    pro.id_proyecto, eva.fecha_evaluacion;

--Listado de proyectos #4--
SELECT 
    fac.id_facultad,
    fac.nombre_facultad,
    prg.id_programa,
    prg.nombre_programa,
    COUNT(pro.id_proyecto) AS cantidad_proyectos
FROM 
    proyectos pro
JOIN programas prg ON pro.id_programa = prg.id_programa
JOIN departamentos dep ON prg.id_departamento = dep.id_departamento
JOIN facultades fac ON dep.id_facultad = fac.id_facultad
GROUP BY 
    fac.id_facultad, fac.nombre_facultad, prg.id_programa, prg.nombre_programa
ORDER BY 
    fac.nombre_facultad, prg.nombre_programa;

--Listado de estudiantes/asignaturas #1--
SELECT 
    est.nombre_estudiante || ' ' || est.apellido_estudiante AS estudiante,
    asi.nombre_asignatura,
    prg.id_programa,
    pas.grupo
FROM 
    estudiantes est
JOIN asignaturas asi ON est.id_asignatura = asi.id_asignatura
JOIN proyecto_asignatura pas ON asi.id_asignatura = pas.id_asignatura
JOIN programas prg ON asi.id_programa = prg.id_programa
WHERE pas.grupo = '051';

--Listado de estudiantes/asignatura #2--
SELECT 
    tpr.nombre_tipo,
    fac.nombre_facultad,
    prg.nombre_programa,
    asi.nombre_asignatura,
    pas.grupo
FROM 
    proyecto_asignatura pas
JOIN asignaturas asi ON pas.id_asignatura = asi.id_asignatura
JOIN proyectos pro ON pas.id_proyecto = pro.id_proyecto
JOIN tipo_proyecto tpr ON pro.id_tipo_proyecto = tpr.id_tipo_proyecto
JOIN programas prg ON asi.id_programa = prg.id_programa
JOIN departamentos dep ON prg.id_departamento = dep.id_departamento
JOIN facultades fac ON dep.id_facultad = fac.id_facultad
ORDER BY 
    tpr.nombre_tipo, fac.nombre_facultad, prg.nombre_programa, asi.nombre_asignatura;

--Listado de estudiantes/asignatura #3--
SELECT 
    fac.id_facultad,
    fac.nombre_facultad,
    prg.id_programa,
    prg.nombre_programa,
    tpr.id_tipo_proyecto,
    tpr.nombre_tipo,
    COUNT(pro.id_proyecto) AS cantidad
FROM 
    proyectos pro
JOIN tipo_proyecto tpr ON pro.id_tipo_proyecto = tpr.id_tipo_proyecto
JOIN programas prg ON pro.id_programa = prg.id_programa
JOIN departamentos dep ON prg.id_departamento = dep.id_departamento
JOIN facultades fac ON dep.id_facultad = fac.id_facultad
GROUP BY 
    fac.id_facultad, fac.nombre_facultad, prg.id_programa, prg.nombre_programa, tpr.id_tipo_proyecto, tpr.nombre_tipo
ORDER BY 
    fac.nombre_facultad, prg.nombre_programa, tpr.nombre_tipo;

--Listado de evaluadores #1--
SELECT 
    evr.nombre_evaluador || ' ' || evr.apellido_evaluador AS evaluador,
    fac.nombre_facultad,
    prg.nombre_programa,
    tpr.nombre_tipo,
    pro.titulo_proyecto
FROM 
    evaluaciones eva
JOIN evaluadores evr ON eva.id_evaluador = evr.id_evaluador
JOIN proyectos pro ON eva.id_proyecto = pro.id_proyecto
JOIN tipo_proyecto tpr ON pro.id_tipo_proyecto = tpr.id_tipo_proyecto
JOIN programas prg ON pro.id_programa = prg.id_programa
JOIN departamentos dep ON prg.id_departamento = dep.id_departamento
JOIN facultades fac ON dep.id_facultad = fac.id_facultad
ORDER BY 
    evaluador, fac.nombre_facultad, prg.nombre_programa, tpr.nombre_tipo, pro.titulo_proyecto;

--Listado de evaluadores #2--
SELECT 
    evr.nombre_evaluador || ' ' || evr.apellido_evaluador AS evaluador,
    COUNT(eva.id_evaluacion) AS cantidad_evaluaciones,
    AVG(eva.calificacion) AS promedio_calificacion
FROM 
    evaluaciones eva
JOIN evaluadores evr ON eva.id_evaluador = evr.id_evaluador
GROUP BY 
    evr.nombre_evaluador, evr.apellido_evaluador
ORDER BY 
    promedio_calificacion DESC;

--Listado de evaluadores #3--
SELECT 
    evr.nombre_evaluador || ' ' || evr.apellido_evaluador AS evaluador,
    pro.titulo_proyecto,
    eva.fecha_evaluacion,
    eva.calificacion,
    eva.estado
FROM 
    evaluaciones eva
JOIN evaluadores evr ON eva.id_evaluador = evr.id_evaluador
JOIN proyectos pro ON eva.id_proyecto = pro.id_proyecto
ORDER BY 
    evaluador, eva.fecha_evaluacion;

--Listado de usuarios #1--
SELECT 
    usu.id_usuario,
    usu.username,
    rol.nombre_rol,
    usu.estado,
    usu.fecha_registro_usuario
FROM 
    usuarios usu
JOIN roles rol ON usu.id_rol = rol.id_rol
ORDER BY 
    rol.nombre_rol, usu.username;

--Consulta libre--
SELECT 
    usu.username,
    rol.nombre_rol,
    COUNT(pro.id_proyecto) AS cantidad_proyectos
FROM 
    usuarios usu
JOIN roles rol ON usu.id_rol = rol.id_rol
LEFT JOIN docentes doc ON usu.id_usuario = doc.id_usuario
LEFT JOIN estudiantes est ON usu.id_usuario = est.id_usuario
LEFT JOIN proyectos pro ON pro.id_docente = doc.id_docente OR pro.id_estudiante = est.id_estudiante
GROUP BY 
    usu.username, rol.nombre_rol
ORDER BY 
    cantidad_proyectos DESC, usu.username;