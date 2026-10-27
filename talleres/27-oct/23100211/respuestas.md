# Taller 5 · Composición o herencia

Nombre: Valeria Segovia Espinoza
Número de control: 23100211
Equipo: 4

Copia este archivo a `talleres/27-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `composicion.ts`. Entrega: martes 27 de octubre, 23:59.

## Paso 1 · La herencia

**a)** ¿En qué dos clases está escrito el cálculo del seguro? ¿Por qué no se pudo escribir una sola
vez?

El cálculo del seguro está escrito en ConSeguro y RefrigeradaConSeguro. Se repite porque TypeScript solo permite heredar de una clase y RefrigeradaConSeguro ya hereda de Refrigerada para obtener el frio, pero no puede heredar tambien de ConSeguro y por eso debe repetir el cálculo del seguro.

**b)** Con un tercer extra (express), ¿cuántas clases hacen falta para todas las combinaciones?
¿Cuántas son nuevas? Muestra la cuenta.

Hacen falta **8 clases** para las combinaciones de tres extras: 2 × 2 × 2 = 8. Ya hay 4 clases, por lo que son **4 nuevas**: express solo, frío + express, seguro + express y los tres extras.

## Paso 2 · La composición

**c)** Para agregar express a `composicion.ts`, ¿qué agregaste? ¿Cambió `cotizar`?

Agregué la función `express`, que suma 50 000 centavos ($500.00). No cambió cotizar, solamente se agregó una nueva constante referente a express, como es del mismo tipo
Ajuste, donde se especifica los detalles de cada uno.

## Paso 3 · El orden

| Llamada | Predigo | Salió |
|---|---|---|
| `cotizar(100, 1000, [express, seguro])` | 153000 | 153000 |
| `cotizar(100, 1000, [seguro, express])` | 152000 | 152000 |

**d)** ¿Por qué salen distintos? (dos líneas)

Porque seguro cobra el 2 % del monto que recibe, y ese monto depende de qué ajuste se aplicó antes.
Si el seguro va primero, `express` suma esos $500 después y no se calcula seguro sobre ellos.

## Paso 4 · Sostén la decisión

**e)** En su modelo del proyecto, ¿cómo están escritos los pasos del cálculo: con herencia o con
composición? Cita el archivo y la función.

Están escritos con composición: la función cotizar de nuestro modelo organiza el cálculo llamando
a funciones como validar, calcularFlete y calcularRecargo; no usa herencia.

**f)** Da **un** caso, en su proyecto o fuera de él, donde sí usarías herencia, y di por qué ahí no
hay explosión de combinaciones. (tres líneas)

Usaría herencia para un error de dominio como `EmbarqueRechazado extends Error`. Un `EmbarqueRechazado` es un `Error` y hereda el mensaje y el rastro de la pila; es una sola relación estable, no varias dimensiones de extras que deban combinarse en clases.
