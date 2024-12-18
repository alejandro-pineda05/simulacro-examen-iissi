DROP TABLE if EXISTS Valoraciones;

CREATE TABLE Valoraciones(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY ,
	jugadorId INT NOT NULL,
	videojuegoId INT NOT NULL,
	fecha DATE NOT NULL DEFAULT CURDATE(),
	puntuacion FLOAT(3,2) NOT NULL CHECK(puntuacion >= 0 AND puntuacion <= 5),
	opinion TEXT NOT NULL,
	likes INT DEFAULT 0,
	veredicto ENUM('Imprescindible', 'Recomendado', 'Comprar en rebajas', 'No merece la pena') NOT NULL,
	
	FOREIGN KEY (jugadorId) REFERENCES Jugadores(jugadorId) 
      ON DELETE CASCADE 
      ON UPDATE CASCADE,
	FOREIGN KEY (videojuegoId) REFERENCES Videojuegos(videojuegoId) 
      ON DELETE CASCADE 
      ON UPDATE CASCADE,
   UNIQUE(videojuegoId,jugadorId)
 /*
- **`ON DELETE CASCADE`**: Si se elimina una fila en la tabla referenciada, las filas en la tabla dependiente también se eliminan automáticamente.
  
- **`ON UPDATE CASCADE`**: Si se actualiza una clave primaria en la tabla referenciada, la actualización se propaga automáticamente a las claves foráneas correspondientes.

**`ON DELETE RESTRICT`**: Impide la eliminación de una fila en la tabla referenciada si existen filas dependientes en la tabla hija.

**`ON DELETE SET NULL`**: Si se elimina una fila en la tabla referenciada, las claves foráneas en la tabla hija se configuran a `NULL`.
	*/
);