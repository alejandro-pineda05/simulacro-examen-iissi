/*
Cree un procedimiento pAddUsuarioValoracion que, dentro de una transacción,
inserte un usuario y una valoración de dicho usuario a un videojuego dado.
Incluya los parámetros que considere oportunos.

Realice dos llamadas: una que inserte ambos (el usuario y la valoración)
correctamente, y una en la que el segundo rompa alguna restricción y aborte
la transacción. Incluya capturas de pantallas.
*/

DROP PROCEDURE if EXISTS pAddUsuarioValoracion;
DELIMITER //

CREATE PROCEDURE pAddUsuarioValoracion(
    IN nicknameUsuario VARCHAR(60),
    IN videojuegoId INT,
    IN fechaValoracion DATE,
    IN puntuacion FLOAT(3,2),
    IN opinion TEXT,
    IN veredicto ENUM('Imprescindible', 'Recomendado', 'Comprar en rebajas', 'No merece la pena')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Revertir la transacción en caso de error
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transacción fallida, cambios revertidos.';
    END;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Insertar el nuevo jugador
    INSERT INTO Jugadores (nickname)
    VALUES (nicknameUsuario);

    -- Obtener el ID del último jugador insertado
    SET @nuevoJugadorId = LAST_INSERT_ID();

    -- Validar la fecha de valoración
    IF fechaValoracion < (SELECT fechaLanzamiento FROM Videojuegos WHERE videojuegoId = videojuegoId)
       OR fechaValoracion > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de valoración es inválida.';
    END IF;

    -- Insertar la valoración
    INSERT INTO Valoraciones (jugadorId, videojuegoId, fecha, puntuacion, opinion, veredicto)
    VALUES (@nuevoJugadorId, videojuegoId, fechaValoracion, puntuacion, opinion, veredicto);

    -- Confirmar la transacción
    COMMIT;
END //

DELIMITER ;


CALL pAddUsuarioValoracion(
    'JugadorNuevo',
    1, -- ID del videojuego
    '2024-12-18',
    4.5,
    'Un excelente videojuego con una jugabilidad única.',
    'Imprescindible'
);

CALL pAddUsuarioValoracion(
    'JugadorFallido',
    1, -- ID del videojuego
    '2016-12-31', -- Fecha anterior a la fecha de lanzamiento
    3.5,
    'Juego interesante, pero no perfecto.',
    'Recomendado'
);
