DROP TRIGGER if EXISTS impedirValorarJuegoBeta;
DELIMITER //

CREATE TRIGGER impedirValorarJuegoBeta
BEFORE INSERT ON valoraciones
FOR EACH ROW
BEGIN
	DECLARE estado ENUM('Lanzado', 'Beta', 'Acceso anticipado');
	
	SELECT videojuegos.estado INTO estado
	FROM videojuegos
	WHERE videojuegos.videojuegoId = NEW.videojuegoId;
	
	if estado = 'Beta' then
		SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El videojuego se encuentra en fase beta.';
   END IF;
END //

DELIMITER ;

CALL insertar_valoracion(1,9,CURDATE(),4.9, 'Cosa curiosa', 'Imprescindible');