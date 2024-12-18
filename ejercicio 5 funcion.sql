DROP FUNCTION if EXISTS numValoracionesJugador;

DELIMITER //

CREATE FUNCTION numValoracionesJugador (p_jugadorId INT)
RETURNS INT
BEGIN
	DECLARE cuenta INT;
	SELECT COUNT(*) INTO cuenta FROM Valoraciones WHERE p_jugadorId = jugadorId;
	RETURN cuenta;
END//
DELIMITER ;

SELECT numValoracionesJugador(1);
	