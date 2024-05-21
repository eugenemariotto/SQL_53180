use umami;
-- VIEWS ---------------------------------------
CREATE OR REPLACE VIEW bajas_ano AS 
select e.ID_EMPLEADO AS ID_EMPLEADO,
(to_days(r.FECHA_DE_BAJA) - to_days(e.FECHA_ALTA)) AS DIAS_DE_DIFERENCIA 
from empleados e 
join rotacion r 
ON e.ID_EMPLEADO = r.ID_EMPLEADO;

CREATE or replace VIEW empleados_de_caba AS 
select e.ID_EMPLEADO AS ID_EMPLEADO,
e.PRIMER_NOMBRE AS PRIMER_NOMBRE,
e.PRIMER_APELLIDO AS PRIMER_APELLIDO,
e.ID_NIVEL AS ID_NIVEL,
n.DESC_PUESTO AS DESC_PUESTO 
from empleados e 
join umami.ZONA Z 
on e.ID_ZONA = z.ID_ZONA 
join umami.nivel n 
on e.ID_NIVEL = n.ID_NIVEL
where z.DESC_ZONA = 'CABA';


CREATE VIEW empleados_por_area_y_evaluacion AS 
select e.ID_EMPLEADO AS ID_EMPLEADO,
e.PRIMER_NOMBRE AS PRIMER_NOMBRE,
e.PRIMER_APELLIDO AS PRIMER_APELLIDO,
a.DESC_AREA AS DESC_AREA,
ev.EVALUADO_POR AS EVALUADOR 
from umami.empleados e 
join umami.area a 
on e.ID_AREA = a.ID_AREA 
join evaluacion ev 
on e.ID_EMPLEADO = ev.ID_EMPLEADO;

CREATE VIEW inactivos AS 
select e.ID_EMPLEADO AS ID_EMPLEADO,
e.PRIMER_NOMBRE AS PRIMER_NOMBRE,
e.PRIMER_APELLIDO AS PRIMER_APELLIDO,
r.FECHA_DE_BAJA AS FECHA_DE_BAJA,
r.ID_BAJA AS ID_BAJA 
from empleados e 
join umami.rotacion r 
on e.ID_EMPLEADO = r.ID_EMPLEADO;
