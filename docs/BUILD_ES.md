# Guía de fabricación y armado

Esta guía parte de la **V0.20 validada mecánicamente por el autor** y de un prototipo operativo instalado en un RELIFE RL-M3T durante más de un mes. Cada microscopio puede requerir modificar dimensiones.

## Herramientas y componentes

Se necesitan: calibre, impresora FDM apta para el filamento seleccionado, OpenSCAD, tornillos M3 y ~M4, 4 COB LED, 4 disipadores 22×22×13 mm nominales, interfaz térmica real, cable aislado flexible, cautín, multímetro y preferentemente fuente de laboratorio con limitación de corriente. Un termómetro de contacto ayuda a validar disipación.

La lente Barlow del caso real era de diámetro aproximadamente **50 mm**; el aro original de referencia de la luz tenía **63 mm de diámetro interior**. Los tres tornillos centradores completan la sujeción. La distancia entre Barlow y placa era aproximadamente **155 mm**.

## 1. Exportar piezas 3D

Abrí [cad/current/microscope_led_head_v020.scad](../cad/current/microscope_led_head_v020.scad) en OpenSCAD. Verificá dimensiones reales del objetivo y del disipador, y ajustá las variables antes de imprimir.

| Parte | Cantidad | Uso |
|---|---:|---|
| ring | 1 | Aro con tres orificios radiales para apretar al Barlow |
| arm | 4 | Brazos a 90° entre sí, sujetados al aro |
| pod | 4 | Bandeja para disipador COB con dos orejas de articulación |
| print_plate | inspección | Colocación de piezas para previsualización |

En el archivo, definir la variable **part** como **"ring"**, **"arm"**, **"pod"** o **"print_plate"** y usar F6 (render) → File → Export → STL. También se puede usar el script de exportación en [tools](../tools/).

### Orientación y tolerancias iniciales

- **Aro:** cara plana contra la cama, comprobar los tres taladros radiales.
- **Brazos:** cara plana contra la cama, evaluar puente y taladro de pivote.
- **Pods:** orientación que sostenga bien las orejas y deje limpios los rieles para el disipador.
- Como punto de partida **no validado para todas las impresoras**: 0,16–0,20 mm de altura de capa, 4 perímetros y 30–50% de relleno.
- Imprimí **un solo pod de prueba** antes de los cuatro; medí el paso de los agujeros M3 y la holgura del disipador. El clearance nominal parametrizado es **0,30 mm por lado**.

**Material:** PLA se usó exclusivamente en el primer prototipo; el autor reporta más de un mes de uso estable sin falla estructural, pero los disipadores llegaron a ~95 °C al máximo. Para la versión final se consideran **ABS, ASA o policarbonato**, siempre validando resistencia a temperatura real de la pieza y tensiones de las capas. El PC requiere condiciones exigentes de impresión; el cambio de filamento **no reduce la temperatura del LED**.

## 2. Montar aro, brazos y pods

1. Colocar el aro centrado en el tubo Barlow. Enroscá los **tres tornillos radiales ~M4×23 mm**, verificando que no dañen lentes, recubrimientos ni partes delicadas.
2. Encajar cada brazo en su ranura correspondiente, sin hacer fuerza que fracture las paredes impresas; bloquear con tornillo M3.
3. Unir brazo y pod: **el cilindro del brazo entra entre las dos orejas del pod**. Pasar M3 por los tres agujeros coaxiales; ajustar fricción y movimiento.
4. Deslizar el disipador por el pod. No agregar apoyos o adhesivos que tapen el recorrido o el frente del COB; la V0.18 eliminó unas salientes que lo bloqueaban.
5. Unir el COB al disipador mediante una interfaz térmica adecuada y una fijación compatible con la temperatura; no confiar en la cinta de aluminio como aislante.
6. Guiar cables dejando un bucle flexible junto a cada pivote y un **alivio de tensión** que proteja las soldaduras y evite partes móviles.
7. Asegurarse de que el montaje **no toque ni cargue directamente las superficies ópticas**.

## 3. Controlador analógico

Preparar el controlador separado del objetivo y cablearlo siguiendo [WIRING_ES](../hardware/WIRING_ES.md). El hardware original del autor era perfboard; la documentación es un **diseño de referencia que debe verificarse**. La alimentación es DC externa aislada, no cableado de red dentro del microscopio.

Confirmar que ningún tab metálico de los IRLZ44N (eléctricamente DRAIN) pueda cortocircuitarse con otra parte conductora. Dimensionar la refrigeración de los MOSFET y el disipador de 5 V si fuera necesario.

## 4. Ajuste óptico y comprobaciones finales

1. Colocar una motherboard real bajo el microscopio a la altura de trabajo.
2. Ajustar inclinaciones de los cuatro pods hasta iluminar la zona observada; el tilt nominal de diseño es 25°, pero el punto óptico depende de distancia y objetivo.
3. Probar los cuatro módulos, tres, dos opuestos y dos adyacentes; elegir según reflejos en soldadura, cobre o encapsulados.
4. Seguir [COMMISSIONING](COMMISSIONING.md): corriente individual, tensiones, temperatura de disipadores, temperatura del plástico y estabilidad de montaje.
5. No recomendar 100% continuo con los disipadores utilizados en el prototipo.

## Mantenimiento

Revisar periódicamente los tres tornillos del aro, los ocho tornillos M3, el contacto térmico, los bucles de cables, el aislamiento eléctrico y polvo acumulado en disipadores. Después de un cambio de corriente máxima o material impreso, repetir los ensayos térmicos.