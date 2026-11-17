# Historial de revisiones

La rama main conserva las revisiones CAD como **commits reconstruidos a partir de archivos originales** y también como archivos con nombre de versión en **cad/history**. Las fechas de esos commits corresponden a la publicación, **no a la fecha original de cada experimento**.

| Versión | Cambio documentado |
| --- | --- |
| V0.6 | Primer modelo modular de aro, brazo y bandeja deslizante del disipador; diámetro de aro inicialmente supuesto incorrectamente (103 mm). |
| V0.6.1 | Se eliminó un puente indeseado entre horquilla y bandeja. |
| V0.7–V0.8 | Iteraciones de brazos, pods y recuperación del espaciamiento 90°. |
| V0.9 | Base mecánica revisada que el autor consideró correcta salvo el pod. |
| V0.10–V0.11 | Recuperación de bandeja V0.6.1 sin alterar sus parámetros. |
| V0.12–V0.13 | Liberación del pivote del brazo: cuello más estrecho y cilindro expuesto. |
| V0.14 | Brazo extendido ~5 mm hacia el pivote. |
| V0.15–V0.16 | Corrección del diámetro interno real del aro a **63 mm**, OD paramétrico a 83 mm. |
| V0.17 | Horquilla de dos orejas separadas con hueco central para cilindro del brazo. |
| V0.18 | Eliminación de protuberancias que obstruían la entrada del disipador. |
| V0.19 | Primera reducción de agujeros radiales de fijación. |
| **V0.20** | Ajuste final del autor: agujeros radiales Ø3,7 mm; tornillos 20°/125°/275° y fase de módulos 65°. Impresa e instalada como prototipo funcional. |

Las versiones iniciales de 103 mm no son medidas correctas del montaje real. **Usar V0.20 para construir** y verificar dimensiones en tu microscopio; las anteriores son para comprender la evolución.

Revisiones eléctricas: la propuesta evolucionó desde explorar arrays de LED de alto CRI hacia **4 COB con corriente lineal independiente**; se ensayó la electrónica en placa perforada y se conservan los datos térmicos. La implementación de referencia documentada en [hardware/WIRING_ES.md](hardware/WIRING_ES.md) no pretende reproducir un netlist no relevado de esa placa.