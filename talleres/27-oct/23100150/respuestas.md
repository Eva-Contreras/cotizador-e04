# Taller 5 · Composición o herencia

Nombre:Eva Guadalupe Contreras Antúnez
Número de control:23100150
Equipo:4

Copia este archivo a `talleres/27-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `composicion.ts`. Entrega: martes 27 de octubre, 23:59.

## Paso 1 · La herencia

**a)** ¿En qué dos clases está escrito el cálculo del seguro? ¿Por qué no se pudo escribir una sola
vez?
Se encuentra en ConSeguro y RefrigeradaConSeguro. No se escribió una sola vez porque
RefrigeradaConSeguro ya hereda de Refrigerada, y TypeScript no permite heredar de dos clases;
por eso no puede heredar también de ConSeguro y debe repetir el cálculo del seguro.

**b)** Con un tercer extra (express), ¿cuántas clases hacen falta para todas las combinaciones?
¿Cuántas son nuevas? Muestra la cuenta.
Hacen falta 8 clases en total: 2 × 2 × 2 = 8, porque cada uno de los 3 extras puede estar o no
estar. Ya hay 4, así que son 4 nuevas: express, express con seguro, express con frío y express con
frío y seguro.

## Paso 2 · La composición

**c)** Para agregar express a `composicion.ts`, ¿qué agregaste? ¿Cambió `cotizar`?
No cambió, solamente se agregó una nueva constante referente a express, como es del mismo tipo
Ajuste, donde se especifica los detalles de cada uno.

## Paso 3 · El orden

| Llamada | Predigo | Salió |
|---|---|---|
| `cotizar(100, 1000, [express, seguro])` | 153000 | 153000 |
| `cotizar(100, 1000, [seguro, express])` | 152000 | 152000 |

**d)** ¿Por qué salen distintos? (dos líneas)
Porque seguro cobra el 2 % del monto que recibe, y ese monto depende de qué ajuste se aplicó antes.
Si express va primero, el seguro también aplica el 2 % a esos 50000 centavos.

## Paso 4 · Sostén la decisión

**e)** En su modelo del proyecto, ¿cómo están escritos los pasos del cálculo: con herencia o con
composición? Cita el archivo y la función.
Están escritos con composición: la función cotizar de nuestro modelo organiza el cálculo llamando
a funciones como validar, calcularFlete y calcularRecargo; no usa herencia.

**f)** Da **un** caso, en su proyecto o fuera de él, donde sí usarías herencia, y di por qué ahí no
hay explosión de combinaciones. (tres líneas)
Usaría EmbarqueRechazado extends Error, como en el ejemplo de la guía.
Un embarque rechazado es un error, así que hereda el mensaje y el rastro de la pila.
No hay combinaciones de extras: solo se especializa un tipo de error.
