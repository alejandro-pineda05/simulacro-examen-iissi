-- Cree una consulta que devuelva todos los usuarios, sus juegos y las valoraciones respectivas, ordenados por videojuegosId.
SELECT jugadores.nickname AS usuario, videojuegos.nombre AS videojuego, valoraciones.videojuegoId,
valoraciones.fecha, valoraciones.puntuacion ,valoraciones.opinion,
valoraciones.likes, valoraciones.veredicto

FROM valoraciones
JOIN jugadores ON jugadores.jugadorId = valoraciones.jugadorId
JOIN videojuegos ON videojuegos.videojuegoId = valoraciones.videojuegoId
ORDER BY valoraciones.videojuegoId ASC