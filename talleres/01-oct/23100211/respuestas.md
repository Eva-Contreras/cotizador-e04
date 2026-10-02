# Taller · quitar la mutación

Nombre: Valeria Segovia Espinoza
Número de control: 23100211
Equipo: 4

Copia este archivo a `talleres/01-oct/<tu número de control>/respuestas.md` en el repositorio de tu equipo,
junto con tu `sin_mutacion.ex`, y llena la tabla. Entrega: hoy antes de las 23:59.

| # | Función | ¿Qué muta la versión de TypeScript? | ¿Quién más se entera del cambio? |
|---|---|---|---|
| 1 | total_pesos | Muta el acumulador | El entorno local |
| 2 | marcar_urgentes | Muta los objetos prestados | Quien los tenga |
| 3 | aplicar_descuento | Muta un arreglo prestado | Quien lo mandó |
| 4 | contar_por_tipo | Muta el contador local (objeto) | Nadie |
| 5 | sin_duplicados | Muta un set y un arreglo | Nadie |

¿Cuál de las cinco era la más peligrosa en TypeScript, y por qué? (dos líneas)

La más peligrosa es 2, aunque la 3 se acerca al peligro sin embargo la 2 modifica directamente los objetos originales que recibió.
Cualquier otra parte del programa que tenga esos mismos objetos puede ver el cambio sin esperarlo, lo que podria afectar demasiado.
