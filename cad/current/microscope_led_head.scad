
/*
  PC SERVICE - Luz LED profesional para microscopio
  Cabezal modular paramétrico V0.7
  OpenSCAD

  Cambios V0.7:
  1) Encastres aro<->brazo abiertos, sin paredes que bloqueen el deslizamiento.
  2) Eliminados bosses/guías salientes alrededor de los 3 tornillos M4 del microscopio.
     Los agujeros M4 atraviesan directamente la pared del aro.
  3) Pod simplificado: bandeja lisa para pegar el disipador, SIN clips / snap-fit.
  4) Brazos recolocados para aumentar la separación respecto de las líneas de los tornillos.
     Default: 30°, 90°, 210°, 270°. Todo queda parametrizado.
*/

part = "assembly";       // "assembly", "ring", "arm", "pod", "print_plate"
exploded = 0;
$fn = 96;

// ============================================================
// PARÁMETROS PRINCIPALES
// ============================================================

// Aro / microscopio
ring_id              = 103.0;
ring_wall_radial     = 10.0;
ring_od              = ring_id + 2*ring_wall_radial;
ring_h               = 8.0;

// Tornillos de fijación al microscopio
scope_screw_angles   = [0,120,240];
scope_screw_hole     = 4.4;      // M4 con holgura
scope_screw_length   = 23.0;

// Posición de los brazos.
// Se evita 45/135/225/315 porque 135 y 225 quedan a sólo 15° de M4 a 120/240.
// Esta distribución deja ~30° de separación angular mínima.
arm_angles           = [30,90,210,270];

// Óptica / LEDs
cob_center_radius    = 68.0;
pod_tilt             = 25.0;
pod_drop             = 10.0;

// Disipador
heatsink_w           = 22.0;
heatsink_l           = 22.0;
heatsink_h           = 13.0;     // editar según medición final
heatsink_clearance   = 0.40;     // no es press-fit; sólo holgura visual/mecánica

// Unión aro -> brazo: canal abierto superior
arm_tongue_w         = 8.0;
arm_tongue_l         = 13.0;
arm_tongue_t         = 4.0;

slot_clearance_xy    = 0.30;
arm_slot_w           = arm_tongue_w + 2*slot_clearance_xy;
arm_slot_l           = arm_tongue_l + 0.5;
arm_slot_depth       = arm_tongue_t + 0.35;

// Bloqueo brazo -> aro
arm_lock_hole        = 3.3;      // M3 pasante
arm_lock_offset      = 4.0;      // desde extremo interior de la lengüeta

// Brazo
arm_w                = 10.0;
arm_t                = 5.0;
arm_pivot_r          = 63.5;     // eje M3 de articulación
arm_pivot_hole       = 3.3;
arm_pivot_ear_d      = 9.0;
arm_pivot_ear_t      = 5.0;

// Pod
pod_plate_w          = 25.0;
pod_plate_l          = 25.0;
pod_plate_t          = 3.0;
pod_fork_t           = 4.0;
pod_fork_gap         = arm_pivot_ear_t + 0.40;
pod_pivot_hole       = 3.3;
pod_pivot_ear_d      = 9.0;
pod_wire_hole        = 4.0;

// Canaletas
wire_channel_w       = 3.2;
wire_channel_d       = 1.8;

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
            // Aro simple, sin bosses salientes para los tornillos M4
            difference(){
                cylinder(h=ring_h, d=ring_od);
                translate([0,0,-0.5])
                    cylinder(h=ring_h+1, d=ring_id);
            }

            // Pequeñas plataformas interiores/superiores para los anclajes de brazo.
            // No crean paredes laterales: sólo aportan espesor local.
            for(a = arm_angles){
                rotate([0,0,a])
                    translate([ring_od/2 - arm_slot_l/2 - 1.5, 0, ring_h])
                        cube([arm_slot_l+5, arm_slot_w+5, 2.5], center=true);
            }
        }

        // M4 RADIALES DIRECTOS: sin guía/boss exterior.
        for(a = scope_screw_angles){
            rotate([0,0,a])
                translate([ring_od/2,0,ring_h/2])
                    rotate([0,90,0])
                        cylinder(h=ring_wall_radial*2 + 5,
                                 d=scope_screw_hole,
                                 center=true);
        }

        // Canales ABIERTOS SUPERIORES para los brazos.
        // La ranura llega hasta el borde exterior: el brazo puede deslizar desde afuera.
        for(a = arm_angles){
            rotate([0,0,a])
                translate([ring_od/2 - arm_slot_l/2 + 0.4, 0,
                           ring_h - arm_slot_depth/2 + 1.0])
                    cube([arm_slot_l+3.0,
                          arm_slot_w,
                          arm_slot_depth+2.2],
                         center=true);

            // M3 vertical para bloquear el brazo
            rotate([0,0,a])
                translate([ring_od/2 - arm_lock_offset,0,ring_h/2])
                    cylinder(h=ring_h+6,
                             d=arm_lock_hole,
                             center=true);
        }

        // Canaleta superior circular para cableado
        translate([0,0,ring_h-wire_channel_d/2+0.05])
            difference(){
                cylinder(h=wire_channel_d+0.2, d=ring_od-5);
                cylinder(h=wire_channel_d+0.4,
                         d=ring_od-5-2*wire_channel_w);
            }
    }
}

// ============================================================
// BRAZO
// ============================================================

module arm_part(){
    total_len = (arm_pivot_r - (ring_od/2 - arm_tongue_l + 1.0));
    body_len = max(8, total_len - arm_tongue_l);

    difference(){
        union(){
            // Lengüeta limpia de entrada al aro
            translate([arm_tongue_l/2,0,arm_tongue_t/2])
                cube([arm_tongue_l,
                      arm_tongue_w,
                      arm_tongue_t],
                     center=true);

            // Cuerpo
            translate([arm_tongue_l + body_len/2 - 1,0,arm_t/2])
                cube([body_len+2,arm_w,arm_t],center=true);

            // Oreja simple para el pivote del pod
            pivot_x = arm_tongue_l + body_len;
            translate([pivot_x,0,arm_t/2])
                rotate([90,0,0])
                    cylinder(h=arm_pivot_ear_t,
                             d=arm_pivot_ear_d,
                             center=true);
        }

        // Agujero M3 de bloqueo aro-brazo
        translate([arm_tongue_l-arm_lock_offset,0,0])
            cylinder(h=12,d=arm_lock_hole,center=true);

        // Agujero M3 de articulación
        pivot_x = arm_tongue_l + body_len;
        translate([pivot_x,0,arm_t/2])
            rotate([90,0,0])
                cylinder(h=arm_pivot_ear_t+4,
                         d=arm_pivot_hole,
                         center=true);

        // Canaleta abierta para cable
        translate([arm_tongue_l + body_len/2 - 1,
                   0,
                   arm_t-wire_channel_d/2+0.05])
            cube([max(3,body_len),
                  wire_channel_w,
                  wire_channel_d+0.2],
                 center=true);
    }
}

// ============================================================
// POD LISO PARA PEGAR DISIPADOR
// ============================================================

module pod_raw(){
    // Bandeja totalmente lisa: sin clips, sin paredes de press-fit, sin retenes.
    // El disipador se pega sobre la cara plana externa.
    union(){
        // Placa soporte del disipador
        cube([pod_plate_l,pod_plate_w,pod_plate_t],center=true);

        // Horquilla del pivote: dos orejas planas SOLAMENTE.
        // Ninguna protuberancia adicional frente/atrás.
        fork_x = -pod_plate_l/2 - pod_pivot_ear_d/2 + 1.0;

        for(s=[-1,1]){
            translate([fork_x,
                       s*(pod_fork_gap/2 + pod_fork_t/2),
                       0])
                rotate([90,0,0])
                    difference(){
                        cylinder(h=pod_fork_t,
                                 d=pod_pivot_ear_d,
                                 center=true);
                        cylinder(h=pod_fork_t+2,
                                 d=pod_pivot_hole,
                                 center=true);
                    }
        }

        // Cuello rectangular mínimo que une horquilla y placa.
        // Se mantiene dentro del ancho de la horquilla y no sobresale hacia el disipador.
        translate([-pod_plate_l/2+1.5,0,0])
            cube([5.0,
                  pod_fork_gap + 2*pod_fork_t,
                  pod_plate_t],
                 center=true);
    }
}

module pod_part(){
    // Inclinación inicial; la articulación M3 permite modificarla.
    rotate([0,pod_tilt,0])
        difference(){
            pod_raw();

            // Paso de cable simple, sin boss.
            translate([pod_plate_l/4,0,0])
                rotate([0,90,0])
                    cylinder(h=pod_plate_l,
                             d=pod_wire_hole,
                             center=true);
        }
}

// ============================================================
// ENSAMBLE
// ============================================================

module assembled(){
    color([0.22,0.22,0.24]) ring_body();

    for(a = arm_angles){
        // El brazo entra desde el borde exterior en su canal abierto
        base_r = ring_od/2 - arm_tongue_l + 1.0;

        color([0.16,0.16,0.18])
            radial(a, base_r + exploded, ring_h)
                arm_part();

        color([0.10,0.10,0.12])
            radial(a,
                   arm_pivot_r + exploded*1.5,
                   ring_h + arm_t/2 - pod_drop)
                pod_part();

        // Disipador conceptual simplemente APOYADO/PEGADO al pod
        color([0.38,0.38,0.40,0.85])
            radial(a,
                   cob_center_radius + exploded*1.8,
                   ring_h - pod_drop + heatsink_h/2 + 2.0)
                rotate([0,pod_tilt,0])
                    cube([heatsink_l,
                          heatsink_w,
                          heatsink_h],
                         center=true);

        // COB conceptual
        color([1.0,0.75,0.08])
            radial(a,
                   cob_center_radius + exploded*1.8,
                   ring_h - pod_drop + 1.3)
                rotate([0,pod_tilt,0])
                    cube([13,13,1.0],center=true);
    }
}

// ============================================================
// PLACA DE IMPRESIÓN
// ============================================================

module print_plate(){
    translate([0,0,0]) ring_body();

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