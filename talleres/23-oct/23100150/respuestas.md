# Taller 4 · De condicionales a despacho

Nombre: Eva Guadalupe Contreras Antúnez
Número de control: 23100150
Equipo: 4

Copia este archivo a `talleres/23-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `despacho.ts`. Entrega: viernes 23 de octubre, 23:59.

## Paso 1 · La versión con switch

**a)** Antes de tocar nada: ¿cuántos lugares de `condicionales.ts` hay que cambiar para agregar
`perecedera`?
Para implementar el nuevo tipo hay que cambiar cuatro lugares: agregarlo al tipo `Tipo` y agregar un
caso a cada uno de los tres `switch` (`recargo`, `documentoRequerido` y `etiqueta`). Además, para
verlo en la demostración, también se agrega a la lista `tipos`.

**b)** Después de agregar `'perecedera'` solo al tipo: ¿qué dijo `tsc`, y qué imprimió la
demostración para perecedera?
`tsc` no mostró errores. La demostración imprimió `perecedera 0 null General`.

**c)** ¿Por qué el compilador no te avisó? (una línea)
Porque los tres `switch` tienen un `default`, así que el tipo nuevo cae en esos casos sin que TypeScript
exija agregar un `case` específico.

## Paso 3 · La versión con tabla

**d)** Después de agregar `'perecedera'` al tipo: ¿qué dijo `tsc`? Copia el mensaje.
`src/despacho.ts(16,14): error TS2741: Property 'perecedera' is missing in type '{ general: { pct: number; fija: number; documento: null; etiqueta: string; }; refrigerada: { pct: number; fija: number; documento: null; etiqueta: string; }; peligrosa: { pct: number; fija: number; documento: "numeroUn"; etiqueta: string; }; sobredimensionada: { ...; }; }' but required in type 'Record<Tipo, Politica>'.`

**e)** ¿Cuántos lugares cambiaste en `despacho.ts` para agregar perecedera?
En dos, en el tipo Tipo y a POLITICAS. Después de agregarlo al tipo, la entrada de la tabla es el único lugar que falta completar.

**f)** En su motor de Elixir, ¿qué pasa si llega un tipo de carga para el que no hay cláusula? ¿Y en
`despacho.ts`, si a la tabla le falta un tipo? ¿Cuál de los dos te avisa antes, y cuándo? (dos líneas)
Elixir produce un FunctionClauseError cuando se ejecuta una función sin una cláusula que coincida.
TypeScript avisa al compilar si falta una entrada requerida por Record<Tipo, Politica>, antes de ejecutar el programa.
