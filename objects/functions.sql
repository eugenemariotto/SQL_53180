use umami;
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