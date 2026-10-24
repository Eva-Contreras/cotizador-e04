# Taller · coincidencia de patrones

Nombre:Valeria Segovia Espinoza
Número de control: 23100211
Equipo: 4

Copia este archivo a `talleres/06-oct/<tu número de control>/respuestas.md` en el repositorio de tu pareja,
junto con tu `patrones.ex`. Entrega: el mismo día del taller, antes de las 23:59.

## 1. ¿Por qué importa el orden de las cláusulas?

Importa mucho porque Elixir va leyendo las cláusulas de arriba para abajo. O sea, si en la función de los pesos ponemos primero la condición general de "menor a 10,000", las cláusulas de abajo que checan si es un peso ligero o inválido nunca van a entrar, porque la primera ya cumplió la condición y ahí se corta la ejecución.

## 2. ¿Qué pasa cuando ninguna cláusula coincide?

El programa truena y te avienta un error que se llama FunctionClauseError, y es por eso que es importante siempre dejar una cláusula al final que sirva para atrapar cualquier caso que no haya encajado con las de arriba, así evitamos que nos marque ese error.

## 3. Escribiste `documentos_completos?` sin un solo `if`. ¿Cuántas cláusulas usaste y en qué orden?
Use 4 en total, una por cada tipo y otra para cualquier otro caso extra,  las acomodé así: primero puse la de carga general, después la peligrosa (que da false si le falta el número), luego la sobredimensionada (que también da false si no trae su permiso), y ya hasta abajo dejé la cláusula para todos los demás casos.