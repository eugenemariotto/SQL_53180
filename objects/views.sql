use umami;
-- VIEWS ---------------------------------------
CREATE OR REPLACE VIEW bajas_ano AS 
select e.id_empleado AS id_empleado,
(to_days(r.fecha_de_baja) - to_days(e.fecha_alta)) AS DIAS_DE_DIFERENCIA 
from empleados e 
join rotacion r 
ON e.id_empleado = r.id_empleado;

CREATE or replace VIEW empleados_de_caba AS 
select e.id_empleado AS id_empleado,
e.primer_nombre AS primer_nombre,
e.primer_apellido AS primer_apellido,
e.id_nivel AS id_nivel,
n.desc_puesto AS desc_puesto 
from empleados e 
join umami.zona Z 
on e.id_zona = z.id_zona 
join umami.nivel n 
on e.id_nivel = n.id_nivel
where z.desc_zona = 'CABA';


CREATE VIEW empleados_por_area_y_evaluacion AS 
select e.id_empleado AS id_empleado,
e.primer_nombre AS primer_nombre,
e.primer_apellido AS primer_apellido,
a.desc_area AS desc_area,
ev.evaluado_por AS EVALUADOR 
from umami.empleados e 
join umami.area a 
on e.id_area = a.id_area 
join evaluacion ev 
on e.id_empleado = ev.id_empleado;

CREATE VIEW inactivos AS 
select e.id_empleado AS id_empleado,
e.primer_nombre AS primer_nombre,
e.primer_apellido AS primer_apellido,
r.fecha_de_baja AS fecha_de_baja,
r.id_baja AS id_baja 
from empleados e 
join umami.rotacion r 
on e.id_empleado = r.id_empleado;
