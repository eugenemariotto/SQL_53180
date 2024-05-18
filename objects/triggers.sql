
use umami;

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
