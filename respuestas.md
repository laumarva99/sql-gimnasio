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

1. País – ciudad (1:N) 