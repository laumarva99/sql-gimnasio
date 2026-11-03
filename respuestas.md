A1.

1-El id, dni y email
2-El id
3-El dni y email
4-La clave ajena es plan_id. Se utiliza porque es más sencillo y no depende de ningún dato personal que pudiese cambiar

A2.

Pareja	                            Un A, ¿cuántos B?	      Un B, ¿cuántos A?           	Relación
planes – socios			                     1                      muchos                    1:N
socios – tarjetas			                 1                        1                       1:1
monitores – clases			                 1                     muchos                     1:N
socios – clases			                   muchos                  muchos                     N:M
monitores – especialidades                 muchos                  muchos                     N:M

A3.

1-Un monitor puede dar muchas clases, pero cada clase la imparte un solo monitor (1:N)
2-Va en clases.monitor_id. Guardaría el identificador del monitor en clases
3-Si lo pusiéramos al contrario, en monitores, habría un error grave porque en cada celda va un solo valor
4-Debe ser NOT NULL porque cada clase la da un monitor asignado
5-Primero crearía la tabla de monitores ya que utilizaría su id para introducirla en clases

A4.

1-El socio podría utilizar diferentes tarjetas con su id
2-Que un socio tenga varias tarjetas y que de un tarjeta puedan entrar varios socios
3-Por ejemplo podría ser una persona que tenga un único pasaporte. Pondríamos persona_id en la tabla pasaportes, con una clave ajena a personas(id) y una restricción UNIQUE.

A5.

1-Un monitor puede tener varias especialidades y una misma especialidad puede estar asignada a varios monitores (N:M)
2-Tres tablas: monitores, especialidades y monitor_especialidades (tabla intermedia que relaciona las otras dos)
3-La tabla monitor_especialidades tiene las siguientes columnas: id: clave primaria; monitor_id: clave ajena que referencia a monitores(id); especialidad_id: clave ajena que referencia a especialidades(id)
4-Evita que un mismo monitor tenga registrada dos veces la misma especialidad. Es parecido al ejemplo de reservas, que impide que un socio reserve dos veces la misma clase.

A6.

1. País – ciudad (1:N) La clave ajena va en ciudad (ciudad.id_pais) porque un país puede tener muchas ciudades
2. Persona – pasaporte (1:1) La clave ajena va en pasaporte (pasaporte.id_persona) porque una persona existe sin pasaporte, pero un pasaporte no existe sin persona
3. Alumno – asignatura (N:N) Se crea la tabla intermedia matricula (id_alumno, id_asignatura) porque un alumno puede hacer varias asignaturas y una asignatura la hacen varios alumnos.
4. Cliente – pedido (1:N) La clave ajena va en pedido (pedido.id_cliente) porque un cliente puede hacer muchos pedidos
5. Película – actor (N:N) Se crea la tabla intermedia reparto, donde se relacionan las dos tablas (id_pelicula, id_actor, personaje) porque una película tiene varios actores y un actor sale en varias películas
6. Autor – libro (1:N o N:N según el dato) El dato que falta es si un libro puede tener uno o varios autores. Si tiene un solo autor, la clave ajena va en libro (libro.id_autor). Si puede tener varios, se crea la tabla intermedia autoria (id_autor, id_libro).
7. Furniro: User – Order (1:N) La clave ajena va en order (order.user_id) porque un usuario puede hacer muchos pedidos.
8. Furniro: Order – Product (N:N) Se crea la tabla intermedia order_item (order_id, product_id, quantity, unit_price) porque un pedido tiene varios productos y un producto aparece en varios pedidos. Guardaría cantidad y precio

