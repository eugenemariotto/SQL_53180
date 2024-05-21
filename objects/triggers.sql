use umami;

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
