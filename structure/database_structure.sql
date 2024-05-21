drop schema if exists umami;
create database umami;
use umami;

-- drop table if exists clientes;
CREATE TABLE clientes (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT,
    PRIMARY KEY(id)
);

-- drop table if exists area;
CREATE TABLE area (
  id_area INT NOT NULL,
  banda INT NOT NULL,
  desc_area VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (id_area)
) ;
-- drop table if exists contrato;
CREATE TABLE contrato (
  id_contrato INT NOT NULL,
  desc_contrato VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (id_contrato)
) ;
-- drop table if exists zona;
CREATE TABLE zona (
    id_zona INT NOT NULL,
    desc_zona VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (id_zona)
) ;
-- drop table if exists nivel;
CREATE TABLE nivel (
  id_nivel INT NOT NULL,
  banda INT NOT NULL,
  desc_puesto VARCHAR(50) DEFAULT NULL,
  minima FLOAT NOT NULL,
  maxima FLOAT NOT NULL,
  PRIMARY KEY (id_nivel)
) ;
-- drop table if exists empleados;
CREATE TABLE empleados (
  id_empleado INT NOT NULL AUTO_INCREMENT,
  primer_nombre VARCHAR(50) NOT NULL,
  segundo_nombre VARCHAR(50) DEFAULT NULL,
  primer_apellido VARCHAR(50) NOT NULL,
  segundo_apellido VARCHAR(50) DEFAULT NULL,
  dni bigINT NOT NULL,
  cuil bigINT NOT NULL,
  genero set('F','M','No binario') NOT NULL,
  calle VARCHAR(50) NOT NULL,
  numeracion VARCHAR(50) NOT NULL,
  piso VARCHAR(50) DEFAULT NULL,
  departamento VARCHAR(50) DEFAULT NULL,
  codigo_postal INT DEFAULT NULL,
  ciudad VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  tipo_de_empleados set('C Level','Líder','Team Player') DEFAULT NULL,
  fecha_de_nacimiento date DEFAULT NULL,
  fecha_alta date DEFAULT NULL,
  id_nivel INT NOT NULL,
  id_area INT NOT NULL,
  id_contrato INT NOT NULL,
  id_zona INT NOT NULL,
  id_lider INT DEFAULT NULL,
  sueldo FLOAT,
  banda set("100","200","300") DEFAULT NULL,
  PRIMARY KEY (id_empleado),
  UNIQUE KEY email (email),
  KEY IDX_email (email),
  tipo_de_empleados tipo_de_empleadosmpleados_nivel (tipo_de_empleados),
  KEY fecha_de_nacimientoea (id_areafecha_de_nacimiento  KEY fk_empleados_contrato (id_contrato),
  KEY fecha_alta(id_zona),
  KEY fk_empleados_empleados (id_lider),
  CONSTRAINT fk_empleados_area FOREIGN KEY (id_area) REFERENCES area (id_area),
  CONSTRAINT fk_empleados_contrato FOREIGN KEY (id_contrato) REFERENCES contrato (id_contrato),
  CONSTRAINT fk_empleados_empleados FOREIGN KEY (id_lider) REFERENCES empleados (id_empleado),
  CONSTRAINT fk_empleados_nivel FOREIGN KEY (id_nivel) REFERENCES nivel (id_nivel),
  CONSTRAINT fk_empleados_zona FOREIGN KEY (id_zona) REFERENCES zona (id_zona)
) ;
-- para insertar id_lider hay que deshabilitar la fk .. ya que no pueden ponerse datos que aun no existen
-- alter table empleados drop constraINT fk_empleados_empleados;
-- alter table empleados add CONSTRAINT fk_empleados_empleados FOREIGN KEY (id_lider) REFERENCES empleados (id_empleado);

-- drop table if exists evaluacion;
CREATE TABLE evaluacion (
  id_eval INT NOT NULL,
  fecha_eval date NOT NULL,
  resultado_evaluacion INT NOT NULL,
  id_empleado INT NOT NULL,
  evaluado_por INT NOT NULL,
  PRIMARY KEY (id_eval,id_empleado,fecha_eval),
  KEY fk_evaluacion_empleados (id_empleado),
  CONSTRAINT fk_evaluacion_empleados FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
) ;
-- drop table if exists ficher;
CREATE TABLE fichero (
  id_fichero INT NOT NULL AUTO_INCREMENT,
  id_empleado INT DEFAULT NULL,
  fecha_hora_ingreso datetime DEFAULT NULL,
  fecha_hora_egreso datetime DEFAULT NULL,
  PRIMARY KEY (id_fichero),
  KEY fk_fichero_empleados (id_empleado),
  CONSTRAINT fk_fichero_empleados FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
) ;
-- drop table if exists rotacion;
CREATE TABLE rotacion (
  id_baja INT NOT NULL AUTO_INCREMENT,
  id_empleado INT DEFAULT NULL,
  fecha_de_baja date DEFAULT NULL,
  PRIMARY KEY (id_baja),
  KEY fk_rotacion_empleados (id_empleado),
  CONSTRAINT fk_rotacion_empleados FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
) ;

-- drop table if exists nivel;
CREATE TABLE ajustes (
  id_sueldo INT NOT NULL,
  id_empleado INT DEFAULT NULL,
  fecha_de_ajuste date,
  observaciones VARCHAR(50) DEFAULT NULL,
  monto_usd INT NOT NULL,
  monto_ars INT DEFAULT NULL,
  PRIMARY KEY (id_sueldo),
  CONSTRAINT fk_ajustes_empleados FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
) ;