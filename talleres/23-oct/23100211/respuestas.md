# Taller 4 · De condicionales a despacho

Nombre: Valeria Segovia Espinoza
Número de control: 23100211
Equipo: 4

Copia este archivo a `talleres/23-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `despacho.ts`. Entrega: viernes 23 de octubre, 23:59.

## Paso 1 · La versión con switch

**a)** Antes de tocar nada: ¿cuántos lugares de `condicionales.ts` hay que cambiar para agregar
`perecedera`? 

En 4 lugares, al inicio cuando se agrega al type Tipo, y cuando se agrega el caso a los 3 switch, el cual solo lo agregue en 2, tambien se puede agregar en la demostracion. 

**b)** Después de agregar `'perecedera'` solo al tipo: ¿qué dijo `tsc`, y qué imprimió la
demostración para perecedera? 

Al agregarla solo al type y en la demostracion, al ejecutar condicionales el tsc no mostro ningun error y aparecio lo siguiente en la demostracion.
**perecedera 0 null General**

**c)** ¿Por qué el compilador no te avisó? (una línea) 

Porque los switch estan configurados con un default que toma los tipos que no tienen un caso en especifico.

## Paso 3 · La versión con tabla

**d)** Después de agregar `'perecedera'` al tipo: ¿qué dijo `tsc`? Copia el mensaje.

El compilador marcó un error porque faltaba agregar perecedera a la tabla POLITICAS.

Property 'perecedera' is missing in type
but required in type 'Record<Tipo, Politica>'

**e)** ¿Cuántos lugares cambiaste en `despacho.ts` para agregar perecedera?

Solo tuve que agregar perecedera al tipo Tipo y después agregar su información en la tabla POLITICAS. No tuve que modificar ninguna de las tres funciones.

## Los dos lenguajes

**f)** En su motor de Elixir, ¿qué pasa si llega un tipo de carga para el que no hay cláusula? ¿Y en
`despacho.ts`, si a la tabla le falta un tipo? ¿Cuál de los dos te avisa antes, y cuándo? (dos líneas)

En Elixir, si no hay una cláusula para un tipo, aparece un FunctionClauseError al ejecutarlo. En TypeScript, si falta un tipo en la tabla, marca un error de compilación.
TypeScript avisa antes de ejecutar el programa, mientras que Elixir avisa cuando se intenta usar ese tipo.