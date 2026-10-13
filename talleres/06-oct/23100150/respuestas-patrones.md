# Taller · coincidencia de patrones

Nombre:Eva Contreras
Número de control: 23100150
Equipo: 4

Copia este archivo a `talleres/06-oct/<tu número de control>/respuestas.md` en el repositorio de tu pareja,
junto con tu `patrones.ex`. Entrega: el mismo día del taller, antes de las 23:59.

## 1. ¿Por qué importa el orden de las cláusulas?

El orden es importante porque Elixir revisa las cláusulas de arriba hacia abajo. Por ejemplo, en la función 
de clasificar peso, si pusieramos hasta arriba la de menor a 10 000, entonces Elixir nunca podría calsificar 
en ligero o inválido cualquier peso menor a 10 000.

## 2. ¿Qué pasa cuando ninguna cláusula coincide?

Manda un error de cláusula llamado FunctionClauseError cuando ninguna coincide, por eso es importante agregar
una en caso de que ninguna coincida, para evitar dicho error.

## 3. Escribiste `documentos_completos?` sin un solo `if`. ¿Cuántas cláusulas usaste y en qué orden?
Fueron 4 en total, 1 por cada tipo y 1 para cualquier otro cas, y el orden fue de primero general, luego 
peligrosa, donde si no cuenta con el número entonces es false, luego sobredimensionada donde si no cuenta con 
el permiso es false, y por último la que es para los otros casos. 
