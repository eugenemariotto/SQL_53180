drop schema if exists umami;
create database umami;
use umami;

-- drop table if exists clientes;
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT
);

-- drop table if exists area;
CREATE TABLE area (
  ID_AREA int NOT NULL,
  BANDA int not null,
  DESC_AREA varchar(50) DEFAULT NULL,
  PRIMARY KEY (ID_AREA)
) ;
-- drop table if exists contrato;
CREATE TABLE contrato (
  ID_CONTRATO int NOT NULL,
  DESC_CONTRATO varchar(50) DEFAULT NULL,
  PRIMARY KEY (ID_CONTRATO)
) ;
-- drop table if exists zona;
CREATE TABLE zona (
    ID_ZONA INT NOT NULL,
    DESC_ZONA VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (ID_ZONA)
) ;
-- drop table if exists nivel;
CREATE TABLE nivel (
  ID_NIVEL int NOT NULL,
  BANDA INT NOT NULL,
  DESC_PUESTO varchar(50) DEFAULT NULL,
  MINIMA DOUBLE NOT NULL,
  MAXIMA DOUBLE NOT NULL,
  PRIMARY KEY (ID_NIVEL)
) ;
-- drop table if exists empleados;
CREATE TABLE empleados (
  ID_EMPLEADO int NOT NULL AUTO_INCREMENT,
  PRIMER_NOMBRE varchar(50) NOT NULL,
  SEGUNDO_NOMBRE varchar(50) DEFAULT NULL,
  PRIMER_APELLIDO varchar(50) NOT NULL,
  SEGUNDO_APELLIDO varchar(50) DEFAULT NULL,
  DNI bigint NOT NULL,
  CUIL bigint NOT NULL,
  GENERO set('F','M','No binario') NOT NULL,
  CALLE varchar(50) NOT NULL,
  NUMERACION varchar(50) NOT NULL,
  PISO varchar(50) DEFAULT NULL,
  DEPARTAMENTO varchar(50) DEFAULT NULL,
  CODIGO_POSTAL int DEFAULT NULL,
  CIUDAD varchar(50) NOT NULL,
  EMAIL varchar(50) NOT NULL,
  TIPO_DE_EMPLEADOS set('C Level','Líder','Team Player') DEFAULT NULL,
  FECHA_DE_NACIMIENTO date DEFAULT NULL,
  FECHA_ALTA date DEFAULT NULL,
  ID_NIVEL int NOT NULL,
  ID_AREA int NOT NULL,
  ID_CONTRATO int NOT NULL,
  ID_ZONA int NOT NULL,
  ID_LIDER int DEFAULT NULL,
  SUELDO double,
  BANDA set("100","200","300") DEFAULT NULL,
  PRIMARY KEY (ID_EMPLEADO),
  UNIQUE KEY EMAIL (EMAIL),
  KEY IDX_EMAIL (EMAIL),
  KEY fk_empleados_nivel (ID_NIVEL),
  KEY fk_empleados_area (ID_AREA),
  KEY fk_empleados_contrato (ID_CONTRATO),
  KEY fk_empleados_zona (ID_ZONA),
  KEY fk_empleados_empleados (ID_LIDER),
  CONSTRAINT fk_empleados_area FOREIGN KEY (ID_AREA) REFERENCES area (ID_AREA),
  CONSTRAINT fk_empleados_contrato FOREIGN KEY (ID_CONTRATO) REFERENCES contrato (ID_CONTRATO),
  CONSTRAINT fk_empleados_empleados FOREIGN KEY (ID_LIDER) REFERENCES empleados (ID_EMPLEADO),
  CONSTRAINT fk_empleados_nivel FOREIGN KEY (ID_NIVEL) REFERENCES nivel (ID_NIVEL),
  CONSTRAINT fk_empleados_zona FOREIGN KEY (ID_ZONA) REFERENCES zona (ID_ZONA)
) ;
-- para insertar id_lider hay que deshabilitar la fk .. ya que no pueden ponerse datos que aun no existen
-- alter table empleados drop constraint fk_empleados_empleados;
-- alter table empleados add CONSTRAINT fk_empleados_empleados FOREIGN KEY (ID_LIDER) REFERENCES empleados (ID_EMPLEADO);

-- drop table if exists evaluacion;
CREATE TABLE evaluacion (
  ID_EVAL int NOT NULL,
  FECHA_EVAL date NOT NULL,
  RESULTADO_EVALUACION INT NOT NULL,
  ID_EMPLEADO int NOT NULL,
  EVALUADO_POR INT NOT NULL,
  PRIMARY KEY (ID_EVAL,ID_EMPLEADO,FECHA_EVAL),
  KEY fk_evaluacion_empleados (ID_EMPLEADO),
  CONSTRAINT fk_evaluacion_empleados FOREIGN KEY (ID_EMPLEADO) REFERENCES empleados (ID_EMPLEADO)
) ;
-- drop table if exists ficher;
CREATE TABLE fichero (
  ID_FICHERO int NOT NULL AUTO_INCREMENT,
  ID_EMPLEADO int DEFAULT NULL,
  fecha_hora_ingreso datetime DEFAULT NULL,
  fecha_hora_egreso datetime DEFAULT NULL,
  PRIMARY KEY (ID_FICHERO),
  KEY fk_fichero_empleados (ID_EMPLEADO),
  CONSTRAINT fk_fichero_empleados FOREIGN KEY (ID_EMPLEADO) REFERENCES empleados (ID_EMPLEADO)
) ;
-- drop table if exists rotacion;
CREATE TABLE rotacion (
  ID_BAJA int NOT NULL AUTO_INCREMENT,
  ID_EMPLEADO int DEFAULT NULL,
  FECHA_DE_BAJA date DEFAULT NULL,
  PRIMARY KEY (ID_BAJA),
  KEY fk_rotacion_empleados (ID_EMPLEADO),
  CONSTRAINT fk_rotacion_empleados FOREIGN KEY (ID_EMPLEADO) REFERENCES empleados (ID_EMPLEADO)
) ;

-- drop table if exists nivel;
CREATE TABLE ajustes (
  ID_SUELDO int NOT NULL,
  ID_EMPLEADO int DEFAULT NULL,
  FECHA_DE_AJUSTE date,
  OBSERVACIONES VARCHAR(50) DEFAULT NULL,
  MONTO_USD INT NOT NULL,
  MONTO_ARS INT DEFAULT NULL,
  PRIMARY KEY (ID_SUELDO),
  CONSTRAINT fk_ajustes_empleados FOREIGN KEY (ID_EMPLEADO) REFERENCES empleados (ID_EMPLEADO)
) ;

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

-- funciones ------------------------------------------------------------------------------------------------------------------------
delimiter //
CREATE FUNCTION premio_desempenio(p_id INT,p_premio FLOAT) 
  	RETURNS FLOAT
    READS SQL DATA

BEGIN
DECLARE premio_desempenio FLOAT;
		select monto_usd * p_premio INTO premio_desempenio
        from ajustes
        where id_empleado = p_id;
        RETURN premio_desempenio;
END//
DELIMITER ;

select premio_desempenio (13,1.30) as "Bono por buen desempeño"

delimiter //
CREATE FUNCTION monto_teletrabajo(m_id INT,m_teletrabajo FLOAT) 
  	RETURNS FLOAT
    READS SQL DATA

BEGIN
DECLARE monto_teletrabajo FLOAT;
		select monto_usd / m_teletrabajo INTO monto_teletrabajo
        from ajustes
        where id_empleado = m_id;
        RETURN monto_teletrabajo;
END//
DELIMITER ;

select monto_teletrabajo (1,9) as "Bono teletrabajo";

DROP PROCEDURE IF EXISTS sp_actualizacion_sueldos;
DELIMITER //
CREATE PROCEDURE sp_actualizacion_sueldos (IN inflacion_ars DOUBLE, IN bono_usd DOUBLE)
SQL SECURITY DEFINER
BEGIN
        -- Seleccione los resultados de ambas consultas
    SELECT e.primer_nombre, 
           e.primer_apellido, 
           s_ars.monto_ARS, 
           (s_ars.monto_ARS * inflacion_ars) AS "Ajuste de inflación Q1",
           s_usd.monto_usd, 
           (s_usd.monto_usd * bono_usd) AS "Bono precarización USD"
    FROM empleados AS e
    left JOIN -- encontrar lo que necesitás, no hace un select y lo plasma, solo lo busca.
    (SELECT id_empleado, monto_ARS
        FROM ajustes
        WHERE monto_usd < 2000 AND fecha_de_ajuste LIKE '2023-01-01') AS s_ars 
        ON e.id_empleado = s_ars.id_empleado
    left JOIN (SELECT id_empleado, monto_usd 
        FROM ajustes 
        WHERE monto_usd > 2000 AND fecha_de_ajuste LIKE '2023-01-01'
    ) AS s_usd ON e.id_empleado = s_usd.id_empleado;

END //
DELIMITER ;
call sp_actualizacion_sueldos(1.53, 0.23);

-- Creación de la tabla log_eventos para registrar eventos
CREATE TABLE log_eventos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    evento VARCHAR(255),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para INSERT
DELIMITER $$
CREATE TRIGGER tr_cliente_insert AFTER INSERT ON clientes
FOR EACH ROW
BEGIN
    -- Acciones a realizar después de un INSERT
    -- Por ejemplo, registrar un mensaje en una tabla de log
    INSERT INTO log_eventos (evento) VALUES (CONCAT('Nuevo cliente: ', NEW.nombre, ' ', NEW.apellido));
END$$
DELIMITER ;

-- Trigger para UPDATE
DELIMITER $$
CREATE TRIGGER tr_cliente_update AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    -- Acciones a realizar después de un UPDATE
    -- Por ejemplo, registrar un mensaje en una tabla de log
    INSERT INTO log_eventos (evento) VALUES (CONCAT('Actualización de cliente: ', OLD.nombre, ' ', OLD.apellido, ' -> ', NEW.nombre, ' ', NEW.apellido));
END$$
DELIMITER ;

-- Procedimiento almacenado para actualizar la edad de un cliente
DELIMITER $$
CREATE PROCEDURE actualizar_edad_cliente(
    IN cliente_id INT,
    IN nueva_edad INT
)
BEGIN
    UPDATE clientes
    SET edad = nueva_edad
    WHERE id = cliente_id;
END$$
DELIMITER ;


-- Trigger para DELETE
DELIMITER $$
CREATE TRIGGER tr_cliente_delete AFTER DELETE ON clientes
FOR EACH ROW
BEGIN
    -- Acciones a realizar después de un DELETE
    -- Por ejemplo, registrar un mensaje en una tabla de log
    INSERT INTO log_eventos (evento) VALUES (CONCAT('Cliente eliminado: ', OLD.nombre, ' ', OLD.apellido));
END$$
DELIMITER ;

-- Procedimiento almacenado para actualizar la edad de un cliente por su ID
DELIMITER $$
CREATE PROCEDURE sp_actualizar_edad_cliente(IN cliente_id INT, IN nueva_edad INT)
BEGIN
    -- Actualizar la edad del cliente especificado por su ID
    UPDATE clientes SET edad = nueva_edad WHERE id = cliente_id;
END $$
DELIMITER ;
