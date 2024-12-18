 DELIMITER //

CREATE PROCEDURE insertar_valoracion(
	IN p_jugadorId INT,
	IN p_videojuegoId INT,
	IN p_fechaValoracion DATE,
	IN p_puntuacion FLOAT(3,2),
	IN p_opinion VARCHAR(255),
	IN p_veredicto VARCHAR(255)
)
BEGIN 
	INSERT INTO Valoraciones(jugadorId, videojuegoId, fecha, puntuacion, opinion, veredicto)
	VALUES (p_jugadorId, p_videojuegoId, p_fechaValoracion, p_puntuacion, p_opinion, p_veredicto);
END//

DELIMITER ;

-- 'Imprescindible', 'Recomendado', 'Comprar en rebajas', 'No merece la pena'

/*
⦁	Insertar el progreso del usuario 1 en el juego 2, puntuación = 5, un comentario de texto cualquiera, y veredicto ‘Imprescindible’, fecha de hoy.
⦁	Insertar el progreso del usuario 2 en el juego 4, puntuación = 3, un comentario de texto cualquiera, y estado ‘Comprar en rebajas’, fecha de hoy.
⦁	Insertar el progreso del usuario 3 en el juego 3, puntuación = 4, un comentario de texto cualquiera, y estado ‘Recomendado’, fecha de hoy.
⦁	Insertar el progreso del usuario 4 en el juego 5, puntuación = 1, un comentario de texto cualquiera, y estado ‘No merece la pena’, fecha de hoy.
⦁	Insertar el progreso del usuario 2 en el juego 3, puntuación = 4.5, un comentario de texto cualquiera, y estado ‘Imprescindible’, fecha de hoy.

⦁	Insertar el progreso del usuario 1 en el juego 6, puntuación = 10, un comentario de texto cualquiera, y estado ‘Imprescindible’. (RN-1-01)
⦁	Insertar el progreso del usuario 3 en el juego 1, puntuación = 3, un comentario de texto cualquiera, y estado ‘Ni fu ni fa’. (RN-1-02)
⦁	Insertar el progreso del usuario 3 en el juego 3, puntuación = 2, comentario ‘No era para tanto’, y estado ‘No merece la pena’. (RN-1-03)
⦁	Insertar el progreso del usuario 6 en el juego 8, puntuación = 3, un comentario de texto cualquiera, y estado ‘Comprar en rebajas’. (referencia no existente)

*/
CALL insertar_valoracion(1,2,CURDATE(),5,'Opinion personal', 'Imprescindible');
CALL insertar_valoracion(2,4,CURDATE(),3,'Opinion personal', 'Comprar en rebajas');
CALL insertar_valoracion(3,3,CURDATE(),4,'Opinion personal', 'No merece la pena');
CALL insertar_valoracion(4,5,CURDATE(),1,'Opinion personal', 'Imprescindible');
CALL insertar_valoracion(2,3,CURDATE(),4.5,'Opinion personal', 'Imprescindible');

-- Las que deben de dar fallo
CALL insertar_valoracion(1,6,CURDATE(),10,'Opinion personal', 'Imprescindible');
CALL insertar_valoracion(3,1,CURDATE(),3,'Opinion personal', 'Ni fu ni fa');
CALL insertar_valoracion(3,3,CURDATE(),2,'Opinion personal', 'No merece la pena');
CALL insertar_valoracion(6,8,CURDATE(),3,'Opinion personal', 'Comprar en rebajas');
