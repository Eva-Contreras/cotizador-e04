# Taller 6 · Unificación paso a paso

Número de control: 23100150
Equipo: Equipo 04

## Paso 2 · Trazar a mano

| # | ¿Unifican? | Ligaduras, o la regla que lo impide |
|---|---|---|
| 1 | Sí | Id = 'EMB-1', P = 5000, T = general. |
| 2 | No | cotizacion/2 tiene 2 argumentos y cotizacion/3 tiene 3. |
| 3 | Sí | X = a, R = [b, c]. |
| 4 | No | La primera lista tiene exactamente 2 elementos y la segunda tiene 3. |
| 5 | Sí | Colombia = colombia. La variable toma el valor del átomo. |
| 6 | No | X tendría que unificar con a y con b; son átomos distintos. |
| 7 | Sí | Primero X = Y; luego Y = a. Por tanto, X = a y Y = a. |
| 8 | Sí | Id = 'EMB-2', T = 950150. _ no conserva el valor con el que unifica. |
| 9 | No | T tendría que unificar con 1 y con 2; son valores distintos. |
| 10 | No | [C | R] requiere una lista con al menos un elemento; [] está vacía. |

## Paso 4 · El trazo

?- aplica_descuento(8000, descuento(8000, 5, mas_de)).

Primera cláusula que intenta:
aplica_descuento(Peso, descuento(U, _, a_partir_de)) :- Peso >= U.

Qué pasa en su cabeza:
No unifica con descuento(8000, 5, mas_de), porque a_partir_de y mas_de son átomos distintos. Prolog intenta la siguiente cláusula.

Segunda cláusula:
aplica_descuento(Peso, descuento(U, _, mas_de)) :- Peso > U.

Qué pasa en su cabeza y en su cuerpo:
La cabeza unifica con Peso = 8000 y U = 8000. En el cuerpo, 8000 > 8000 es falso.

Respuesta final de Prolog:
false.
