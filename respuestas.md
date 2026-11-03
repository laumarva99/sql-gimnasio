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




B3.1.Un socio con un plan que no existe: La clave primaria ya existe en planes, por eso da error de duplicado.

ERROR: la operación de inserción o actualización en la tabla «socios» incumple la restricción de clave externa «socios_plan_id_fkey»
La clave (plan_id)=(99) no existe en la tabla «planes».

Estado SQL: 23503
Detalle: La clave (plan_id)=(99) no existe en la tabla «planes».



B3.2 Un socio con el email de Ana: El email ya existe y al tener la restricción UNIQUE no deja que dos usuarios tengan el mismo email.

ERROR: un valor de clave duplicado incumple la restricción de unicidad «socios_email_key»
La clave (email)=(ana@gym.com) ya existe.

Estado SQL: 23505
Detalle: La clave (email)=(ana@gym.com) ya existe.



B3.3 Una segunda tarjeta para Ana: El plan_id debe hacer referencia a un registro existente en planes(id), al no existir el plan con id = 9999 da error por clave ajena inexistente.

ERROR: un valor de clave duplicado incumple la restricción de unicidad «tarjetas_socio_id_key»
La clave (socio_id)=(1) ya existe.

Estado SQL: 23505
Detalle: La clave (socio_id)=(1) ya existe.



B3.4 Ana reserva otra vez el Spinning del lunes: La columna nombre es obligatoria y no admite valores nulos.

ERROR: un valor de clave duplicado incumple la restricción de unicidad «reservas_socio_id_clase_id_key»
La clave (socio_id, clase_id)=(1, 1) ya existe.

Estado SQL: 23505
Detalle: La clave (socio_id, clase_id)=(1, 1) ya existe.



B3.5 Una reserva para una clase que no existe: Ya existe una reserva del socio 1 para la clase 1, por eso da error por duplicado.

ERROR:  La operación de inserción o actualización en la tabla «reservas» incumple la restricción de clave externa «reservas_clase_id_fkey»
La clave (clase_id)=(50) no existe en la tabla «clases».

Estado SQL: 23503
Detalle: La clave (clase_id)=(50) no existe en la tabla «clases».



B3.6 Borrar el plan Básico: Hay socios con plan_id, y no deja borrar una fila que otra tabla sigue referenciando.

ERROR: la operación de actualización o eliminación en la tabla «planes» incumple la restricción de clave externa «socios_plan_id_fkey» de la tabla «socios».
La clave (id)=(1) sigue siendo referenciada desde la tabla «socios».

Estado SQL: 23503
Detalle: La clave (id)=(1) sigue siendo referenciada desde la tabla «socios».



B3.7 Borrar el plan Mañanas: No da error porque ningún socio tiene ese plan, así que no hay filas que lo referencien.

DELETE 1

La consulta se ha ejecutado correctamente en 59 milisegundos.



B3.8   B3.6 falla y B3.7 funciona. Los dos son planes. ¿Por qué?

B3.6 falla y B3.7 funciona porque la clave ajena socios.plan_id impide borrar un plan que todavía está referenciado por algún socio. El plan Básico tiene socios asociados. El plan Mañanas no tiene ningún socio, así que no hay referencias que romper y el borrado se permite.


B4.11 
No es ningún error, porque Ana ha reservado tres clases. En la tabla reservas aparece una fila por cada reserva y, como la consulta parte de esa tabla, Ana sale tres veces, una por cada clase que ha reservado.


B.5.6 

Pablo, que es el socio número 6, tiene la tarjeta TJ-0006 y una reserva para la clase 4. Las dos están relacionadas con él mediante socio_id. Si se pudiera borrar a Pablo, la tarjeta y la reserva seguirían en la base de datos sin tener un socio al que pertenecer. 
Primero eliminé las reservas y la tarjeta de Pablo, y después borré su registro de socio. Esto se hace así porque no se puede eliminar un socio mientras haya otras tablas que sigan haciendo referencia. Por último, el socio.



B6.1. Las dos sirven para evitar que haya valores repetidos. La clave primaria solo puede haber una por tabla y no puede contener valores NULL. Con UNIQUE en una misma tabla puede tenr varios valores como el DNI y el email de los socios.

B6.2. Porque varios registros pueden estar relacionados con el mismo registro de otra tabla. Por ejemplo, varios socios pueden tener contratado el mismo plan, por lo que el valor de plan_id puede aparecer repetido.

B6.3. La clave ajena se coloca en el lado de muchos. Si se pusiera en el lado de uno, habría que guardar varios id en una misma celda, pero no deja porque una celda tiene un único valor.

B6.4. Añadir una restricción UNIQUE a la clave ajena. El mismo registro no puede aparecer relacionado con varios registros de la otra tabla.

B6.5. Porque las dos tablas pueden tener varios registros relacionados entre sí. Se utiliza una tabla intermedia, que guarda cada relación en una fila. 

B6.6. Porque la fecha es a una reserva concreta, no al socio ni a la clase. Un socio puede hacer varias reservas en fechas diferentes y una clase puede recibir reservas de distintos socios. Por eso, la fecha debe guardarse en la tabla reservas.