DROP TRIGGER if EXISTS impedirFechaAnterior;
DELIMITER //

CREATE TRIGGER impedirFechaAnterior
BEFORE INSERT ON valoraciones
FOR EACH ROW
BEGIN 
	DECLARE fechaLanzamiento DATE;

   -- Obtener la fecha de lanzamiento del videojuego
   SELECT v.fechaLanzamiento INTO fechaLanzamiento
   FROM Videojuegos v
   WHERE v.videojuegoId = videojuegoId LIMIT 1;
   
   IF NEW.fecha < fechaLanzamiento OR NEW.fecha > CURDATE() THEN
   	SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'La fecha de una valoración es anterior a la fecha de lanzamiento del juego, o posterior a la fecha actual.';
   END IF;
END //

DELIMITER ;

-- debe de dar error y mostrar el mensaje en la pantalla
CALL insertar_valoracion(1,6,'2025-12-18',4.85,'Opinion personal', 'Imprescindible');