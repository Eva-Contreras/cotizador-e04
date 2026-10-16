# Taller 3 · La mutación escondida

Nombre: Eva Guadalupe Contreras Antúnez
Número de control: 23100150
Equipo: 4

Copia este archivo a `talleres/16-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `escondida.ex`. Entrega: viernes 16 de octubre, 23:59.

## 1 · Antes y después de ejecutar

Llena "Predigo" **antes** de correr `npx tsx escondida.ts`. No borres las predicciones que fallaron.

| Línea | Predigo | Salió |
|---|---|---|
| 1 · | 1. B, A TRUE | B,A TRUE |
| 2 · | 2. 10 TRUE | 10 TRUE |
| 3 · | 3. 2 TRUE | 2 TRUE |
| 4 · | 4. SCT-77 TRUE | SCT-77 FALSE |
| 5 · | 5. 2026-09-15 2026-09-15 | 15 15 |

## 2 · Qué se muta y quién se entera

| # | Función | ¿Qué línea muta, y qué cambia? | ¿Quién más se entera del cambio? |
|---|---|---|---|
| 1 | ordenarPorPeso | La línea de sort es la que muta | Cualquiera que tenga una referencia al mismo arreglo ve los embarques reordenados. |
| 2 | conDescuento | La asignación directa es la que muta | Cualquiera que tenga una referencia al mismo objeto ve el porcentaje cambiado. |
| 3 | registrar | La línea de push es la que muta | Todas las llamadas comparten la variable global; quienes lean o tengan una referencia a ese arreglo ven los nuevos ids. |
| 4 | conPermiso | La asignación del persmiso es la que muta | Quien tenga una referencia al mismo objeto anidado ve el permiso cambiado. |
| 5 | fechaDeEntrega | La línea de setDate es la que muta | Cualquiera que tenga una referencia al mismo objeto de fecha ve la fecha cambiada. |

## 3 · Tres preguntas cortas

**a)** En la línea 4 salió `false` en `original === conP`, y aun así el original cambió. ¿Cómo es
posible? (dos líneas)
La copia crea un objeto nuevo, por eso la comparación da false. Pero la copia superficial conserva la referencia al mismo objeto documentos, así que cambiar el permiso también afecta al original.

**b)** ¿Por qué `registrar` no es una función pura? (una línea)
Porque utiliza una variable que se encuentra fuera de la función.

**c)** En tus pruebas de Elixir, la última aserción de cada una revisa que el original sigue igual.
¿Por qué en Elixir esa aserción no puede fallar? (dos líneas)
Los valores son inmutables, por lo que las funciones producen valores nuevos en lugar de modificarlos.
El valor original se concerva y la última aserción sigue pasando.