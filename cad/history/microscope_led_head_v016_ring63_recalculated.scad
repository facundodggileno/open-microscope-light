
/*
  PC SERVICE - Luz LED profesional para microscopio
  Cabezal modular paramétrico V0.16 - aro 63 mm recalculado
  OpenSCAD

  V0.16:
  - ring_id corregido a 63 mm.
  - ring_od recalculado paramétricamente a 83 mm (pared radial 10 mm).
  - agujeros M4 y encastres siguen al nuevo radio del aro.
  - radios de pivote y COB recalculados para conservar proporciones.
  - se mantiene brazo V0.14 (+5 mm) y pod V0.6.1.

  Cambios V0.11:
  - BASE GENERAL: V0.9.
  - POD: copia literal de V0.6.1, incluyendo TODOS sus parámetros asociados.
  - El pod NO fue rediseñado ni reinterpretado.
  - 4 módulos LED nuevamente separados EXACTAMENTE 90°.
  - Fase angular configurable; default 45° -> 45/135/225/315°.
  - Pod restaurado al concepto original de bandeja deslizante.
  - La horquilla M3 ahora se une por DEBAJO y DETRÁS de la bandeja.
  - Se elimina por completo la protuberancia que invadía el pocket del disipador.
  - Los agujeros M4 de fijación siguen directamente en la pared del aro,
    sin bosses/guías salientes.
  - Encastres aro-brazo siguen abiertos hacia el exterior para permitir
    deslizamiento limpio.
*/

part = "assembly";       // "assembly", "ring", "arm", "pod", "print_plate"
exploded = 0;
$fn = 96;

// ============================================================
// PARÁMETROS PRINCIPALES
// ============================================================

// Aro
ring_id              = 63.0;
ring_wall_radial     = 10.0;
ring_od              = ring_id + 2*ring_wall_radial;
ring_h               = 8.0;

// Tornillos radiales de fijación al microscopio
scope_screw_angles   = [0,120,240];
scope_screw_hole     = 4.4;     // M4 con holgura
scope_screw_length   = 23.0;

// LEDs / brazos: SIEMPRE separados 90°
led_phase            = 45.0;    // rotación global del conjunto de 4 LEDs
arm_angles           = [led_phase,
                        led_phase+90,
                        led_phase+180,
                        led_phase+270];

// Óptica
cob_center_radius    = ring_od/2 + 6.5;   // 48.0 mm with ID63 / OD83
pod_tilt             = 25.0;
pod_drop             = 10.0;

// Disipador
heatsink_w           = 22.0;
heatsink_l           = 22.0;
heatsink_h           = 13.0;    // EDITAR si tu disipador real difiere
heatsink_clearance   = 0.30;    // por lado
pocket_w             = heatsink_w + 2*heatsink_clearance;
pocket_l             = heatsink_l + 2*heatsink_clearance;

// Unión aro -> brazo
arm_tongue_w         = 8.0;
arm_tongue_l         = 13.0;
arm_tongue_t         = 4.0;
slot_clearance_xy    = 0.30;
arm_slot_w           = arm_tongue_w + 2*slot_clearance_xy;
arm_slot_l           = arm_tongue_l + 0.6;
arm_slot_depth       = arm_tongue_t + 0.40;

// Bloqueo brazo -> aro
arm_lock_hole        = 3.3;     // M3
arm_lock_offset      = 4.0;

// Brazo
arm_w                = 10.0;
arm_t                = 5.0;
arm_pivot_r          = ring_od/2 + 2.0;   // preserves prior pivot offset from ring edge
arm_pivot_hole       = 3.3;
arm_pivot_ear_d      = 9.0;
arm_pivot_ear_t      = 5.0;

// Pod / bandeja deslizante
pod_wall             = 2.4;
pod_back             = 2.8;
pod_rail_h           = 5.0;
pod_outer_w          = pocket_w + 2*pod_wall;
pod_outer_l          = pocket_l + 2*pod_wall;

// Apertura frontal del pod para insertar/deslizar el disipador.
// El disipador entra desde el lado exterior (+X local).
pod_front_open       = true;

// Horquilla de articulación
pod_fork_t           = 4.0;
pod_fork_gap         = arm_pivot_ear_t + 0.40;
pod_pivot_hole       = 3.3;
pod_pivot_ear_d      = 9.0;

// Cuello compacto: NO sobresale hacia la zona del disipador.
pod_neck_l           = 4.0;
pod_neck_h           = 3.0;

// Cable
wire_channel_w       = 3.2;
wire_channel_d       = 1.8;
pod_wire_hole        = 4.0;

pod_side_h           = 5.0;
diffuser_enable      = true;
diffuser_slot        = 1.2;
diffuser_gap         = 5.0;
fork_gap             = arm_pivot_ear_t + 0.35;
fork_t               = 4.0;
fork_hole            = 3.3;
fork_outer_w         = fork_gap + 2*fork_t;
// ============================================================
// UTILIDADES
// ============================================================

module radial(angle, r=0, z=0){
    rotate([0,0,angle])
        translate([r,0,z])
            children();
}

// ============================================================
// ARO CENTRAL
// ============================================================

module ring_body(){
    difference(){
        union(){
            // Aro simple
            difference(){
                cylinder(h=ring_h, d=ring_od);
                translate([0,0,-0.5])
                    cylinder(h=ring_h+1, d=ring_id);
            }

            // Refuerzo bajo cada ranura de brazo.
            // No forma paredes laterales que bloqueen la entrada.
            for(a = arm_angles){
                rotate([0,0,a])
                    translate([ring_od/2 - arm_slot_l/2 - 1.0,
                               0,
                               ring_h + 1.0])
                        cube([arm_slot_l+4,
                              arm_slot_w+4,
                              2.0],
                             center=true);
            }
        }

        // Agujeros M4 radiales directos
        for(a = scope_screw_angles){
            rotate([0,0,a])
                translate([ring_od/2,0,ring_h/2])
                    rotate([0,90,0])
                        cylinder(h=ring_wall_radial*2 + 6,
                                 d=scope_screw_hole,
                                 center=true);
        }

        // Ranuras abiertas al borde exterior
        for(a = arm_angles){
            rotate([0,0,a])
                translate([ring_od/2 - arm_slot_l/2 + 1.0,
                           0,
                           ring_h - arm_slot_depth/2 + 1.1])
                    cube([arm_slot_l+4.0,
                          arm_slot_w,
                          arm_slot_depth+2.5],
                         center=true);

            // Agujero M3 vertical de bloqueo.
            // Está radialmente desplazado respecto al M4, por lo que aun
            // en posiciones angulares próximas no cruza el agujero radial.
            rotate([0,0,a])
                translate([ring_od/2 - arm_lock_offset,
                           0,
                           ring_h/2])
                    cylinder(h=ring_h+6,
                             d=arm_lock_hole,
                             center=true);
        }

        // Canaleta superior circular para cableado
        translate([0,0,ring_h-wire_channel_d/2+0.05])
            difference(){
                cylinder(h=wire_channel_d+0.2,
                         d=ring_od-5);
                cylinder(h=wire_channel_d+0.4,
                         d=ring_od-5-2*wire_channel_w);
            }
    }
}

// ============================================================
// BRAZO
// ============================================================

module arm_part(){
    /*
      V0.14 - brazo extendido 5 mm hacia el pivote.

      Cambio:
      - Se mantiene la posición del agujero M3 que fija el brazo al aro.
      - Se desplazan 5 mm hacia afuera el cuello central y el cilindro del pivote.
      - Resultado: mayor separación entre el tornillo aro-brazo y la articulación pod-brazo.
    */

    base_r_local = ring_od/2 - arm_tongue_l + 1.0;

    // Posición anterior del pivote + 5 mm hacia afuera
    pivot_x = (arm_pivot_r - base_r_local) + 5.0;

    // Cuello central
    neck_len = 5.0;
    neck_w   = 5.0;

    wide_end_x = pivot_x - neck_len;
    wide_len   = max(3.0, wide_end_x);

    difference(){
        union(){
            // Barra principal extendida
            translate([wide_len/2, 0, arm_tongue_t/2])
                cube([wide_len,
                      arm_tongue_w,
                      arm_tongue_t],
                     center=true);

            // Cuello central
            translate([wide_end_x + neck_len/2,
                       0,
                       arm_t/2])
                cube([neck_len,
                      neck_w,
                      arm_t],
                     center=true);

            // Cilindro del pivote
            translate([pivot_x,0,arm_t/2])
                rotate([90,0,0])
                    cylinder(h=arm_pivot_ear_t,
                             d=arm_pivot_ear_d,
                             center=true);
        }

        // Agujero M3 aro-brazo:
        // CONSERVA la posición original, no se desplaza.
        lock_x = arm_tongue_l - arm_lock_offset;
        translate([lock_x,0,0])
            cylinder(h=12,
                     d=arm_lock_hole,
                     center=true);

        // Agujero M3 del pivote
        translate([pivot_x,0,arm_t/2])
            rotate([90,0,0])
                cylinder(h=arm_pivot_ear_t+4,
                         d=arm_pivot_hole,
                         center=true);

        // Canaleta sobre la barra principal
        if(wide_len > 4)
            translate([wide_len/2,
                       0,
                       arm_tongue_t-wire_channel_d/2+0.05])
                cube([max(3,wide_len-1.5),
                      wire_channel_w,
                      wire_channel_d+0.2],
                     center=true);
    }
}

module pod_tray(){
    /*
      Sistema local:
      - X = radial hacia afuera
      - Y = tangencial
      - Z = vertical
      - cara del LED apunta aproximadamente hacia -Z,
        inclinada pod_tilt hacia -X (centro del microscopio).
    */

    difference(){
        union(){
            // Bandeja / respaldo
            translate([6,0,0])
                cube([pod_outer_l, pod_outer_w, pod_back], center=true);

            // Labios laterales de retención del disipador
            for(s=[-1,1]){
                translate([6, s*(pocket_w/2 + pod_wall/2), pod_side_h/2])
                    cube([pod_outer_l, pod_wall, pod_side_h], center=true);
            }

            // Labio posterior
            translate([6 + pod_outer_l/2 - pod_wall/2,0,pod_side_h/2])
                cube([pod_wall, pod_outer_w, pod_side_h], center=true);

            // Horquilla doble del pivote en el lado interior
            for(s=[-1,1]){
                translate([-pod_outer_l/2 + 4.5,
                           s*(fork_gap/2 + fork_t/2),
                           1.5])
                    rotate([90,0,0])
                        cylinder(h=fork_t,
                                 d=9.0,
                                 center=true);
            }

            // V0.6 corregida:
            // Se eliminó el puente de unión horquilla-bandeja que sobresalía
            // dentro de la zona útil del pod e interfería con el montaje.
            // La horquilla queda unida por sus propias orejas al cuerpo del pod.
        }

        // Hueco central para reducir plástico detrás del disipador
        translate([6,0,-0.2])
            cube([pocket_l-4, pocket_w-4, pod_back+1], center=true);

        // Agujeros M3 de la horquilla
        for(s=[-1,1]){
            translate([-pod_outer_l/2 + 4.5,
                       s*(fork_gap/2 + fork_t/2),
                       1.5])
                rotate([90,0,0])
                    cylinder(h=fork_t+3, d=fork_hole, center=true);
        }

        // Paso de cable
        translate([6 + pod_outer_l/2 - 3,0,2.5])
            rotate([0,90,0])
                cylinder(h=8, d=pod_wire_hole, center=true);

        // Ranura opcional para difusor en el frente
        if(diffuser_enable){
            translate([6 - pod_outer_l/2 + diffuser_gap,0,-0.1])
                cube([diffuser_slot, pocket_w+1.0, pod_back+2], center=true);
        }
    }
}

module pod_part(){
    rotate([0,pod_tilt,0])
        pod_tray();
}

// ============================================================
// ENSAMBLE
// ============================================================

module assembled(){
    color([0.22,0.22,0.24])
        ring_body();

    for(a = arm_angles){
        base_r = ring_od/2 - arm_tongue_l + 1.0;

        color([0.16,0.16,0.18])
            radial(a,
                   base_r + exploded,
                   ring_h)
                arm_part();

        color([0.10,0.10,0.12])
            radial(a,
                   arm_pivot_r + 5.0 + exploded*1.5,
                   ring_h + arm_t/2 - pod_drop)
                pod_part();

        // Disipador conceptual dentro del canal
        color([0.38,0.38,0.40,0.85])
            radial(a,
                   cob_center_radius + 5.0 + exploded*1.8,
                   ring_h - pod_drop + heatsink_h/2 + pod_back/2)
                rotate([0,pod_tilt,0])
                    cube([heatsink_l,
                          heatsink_w,
                          heatsink_h],
                         center=true);

        // COB conceptual
        color([1.0,0.75,0.08])
            radial(a,
                   cob_center_radius + 5.0 + exploded*1.8,
                   ring_h - pod_drop + pod_back/2 + 0.8)
                rotate([0,pod_tilt,0])
                    cube([13,13,1.0],
                         center=true);
    }
}

// ============================================================
// PLACA DE IMPRESIÓN
// ============================================================

module print_plate(){
    ring_body();

    for(i=[0:3])
        translate([145,-45+i*30,0])
            arm_part();

    for(i=[0:3])
        translate([-145,-55+i*38,8])
            rotate([0,-pod_tilt,0])
                pod_part();
}

// ============================================================
// SALIDA
// ============================================================

if(part=="assembly")
    assembled();
else if(part=="ring")
    ring_body();
else if(part=="arm")
    arm_part();
else if(part=="pod")
    pod_part();
else if(part=="print_plate")
    print_plate();
else
    assembled();
