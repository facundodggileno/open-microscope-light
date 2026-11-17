# OpenSCAD — guía del archivo final

**Archivo canónico sin rediseño de geometría:** [V0.20](../cad/current/microscope_led_head_v020.scad). El comentario de encabezado interno puede seguir nombrando V0.19 porque se preservó el archivo tal como fue entregado; el nombre y los valores finales identifican V0.20.

## Parámetros observables de V0.20

| Variable OpenSCAD | Valor |
|---|---|
| ring_id | 63.0 |
| ring_wall_radial | 10.0 |
| ring_od | ring_id + 2×ring_wall_radial = 83.0 |
| ring_h | 8.0 |
| scope_screw_angles | [20, 125, 275] |
| scope_screw_hole | 3.7 |
| scope_screw_length | 23.0 |
| led_phase | 65.0 |
| arm_angles | 65, 155, 245, 335 |
| cob_center_radius | ring_od/2 + 6.5 = 48.0 (valor paramétrico nominal) |
| pod_tilt | 25.0 |
| pod_drop | 10.0 |
| heatsink_w / heatsink_l / heatsink_h | 22 / 22 / 13 |
| heatsink_clearance | 0.30 mm por lado |
| arm_lock_hole / arm_pivot_hole / fork_hole | 3.3 / 3.3 / 3.3 |
| pod_fork_gap | arm_pivot_ear_t + 0.40 |

**Nota:** el radio nominal del centro COB en el archivo se complementa con offsets de ensamblado y articulación; no debe tratarse sin más como el radio óptico real en la posición de trabajo. El ángulo correcto de inclinación se determina apuntando cada LED a la PCB.

## Exportar

En OpenSCAD elegir el valor **part**:
- **assembly**: modelo ensamblado para inspección;
- **ring**: aro;
- **arm**: brazo;
- **pod**: bandeja articulada;
- **print_plate**: presentación de piezas en cama.

Ejemplo CLI tras instalar OpenSCAD:

~~~sh
openscad -o ring_v020.stl -D 'part="ring"' cad/current/microscope_led_head_v020.scad
openscad -o arm_v020.stl -D 'part="arm"' cad/current/microscope_led_head_v020.scad
openscad -o pod_v020.stl -D 'part="pod"' cad/current/microscope_led_head_v020.scad
~~~

Cada impresora y material necesita su propia calibración; los diámetros son dimensiones nominales de CAD y pueden requerir compensar contracción o tolerancias de impresión.

## Evolución y errores que motivaron cambios

Las versiones tempranas tenían diámetro inicial de aro 103 mm, incorrecto para el montaje real. Más adelante se corrigieron colisiones de tornillos con ranuras, geometría del pivote del brazo, hueco de horquilla y salientes que bloqueaban disipadores. Las revisiones previas a V0.20 se conservan en [cad/history](../cad/history/).

Si realizás una variante para otro microscopio, mantené copias de tus parámetros y registrá el fabricante, diámetro del Barlow, tamaño real de disipador y temperatura en servicio.