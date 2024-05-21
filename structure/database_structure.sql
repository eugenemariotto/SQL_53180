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