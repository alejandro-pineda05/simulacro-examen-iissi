/*
Cree una consulta que devuelva los juegos y la media de las valoraciones recibidas,
ordenados de mayor a menor. En el listado deben aparecer todos los juegos, tengan
o no valoración.
*/

SELECT videojuegos.nombre, AVG(valoraciones.puntuacion) AS media
FROM Videojuegos left JOIN Valoraciones ON valoraciones.videojuegoId = videojuegos.videojuegoId
GROUP BY videojuegos.videojuegoId
ORDER BY media DESC;
