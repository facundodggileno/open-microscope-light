
/*
  PC SERVICE - Luz LED profesional para microscopio
  Cabezal modular paramétrico V0.6
  OpenSCAD

  Arquitectura:
  - Aro central con ID 103 mm.
  - 3 tornillos radiales M4 a 120° para sujetar el Barlow/objetivo.
  - 4 brazos desmontables a 45°, 135°, 225° y 315°.
  - 4 pods articulados mediante tornillo M3.
  - Alojamiento para disipador 22 x 22 mm.
  - Inclinación nominal del pod: 25° hacia el centro.
  - Radio nominal del centro del COB: 68 mm.

  NOTA:
  Este archivo está pensado para iterar. Todas las medidas críticas están
  agrupadas al principio.
*/

// =========================
// SELECCIÓN DE SALIDA
// =========================
// "assembly", "ring", "arm", "pod", "print_plate"
part = "assembly";
exploded = 0;          // 0 = ensamblado, >0 separa piezas en la vista
$fn = 96;

// =========================
// PARÁMETROS PRINCIPALES
// =========================

// Microscopio / aro actual
ring_id              = 103.0;
ring_wall_radial     = 10.0;
ring_od              = ring_id + 2*ring_wall_radial;
ring_h               = 8.0;

// Tornillos de fijación al microscopio
scope_screw_count    = 3;
scope_screw_angles   = [0,120,240];
scope_screw_nominal  = 4.0;
scope_screw_hole     = 4.4;     // para tornillo M4 real; usar tuerca cautiva
scope_screw_length   = 23.0;
scope_boss_w         = 13.0;
scope_boss_l         = 14.0;
scope_boss_h         = 8.0;
m4_nut_af            = 7.2;     // ancho entre caras, holgura incluida
m4_nut_h             = 3.4;

// LEDs
led_angles           = [45,135,225,315];
cob_center_radius    = 68.0;
pod_tilt             = 25.0;    // grados hacia el centro
pod_drop             = 10.0;

// Disipador / COB
heatsink_w           = 22.0;
heatsink_l           = 22.0;
heatsink_h           = 13.0;    // EDITAR si tu disipador real difiere
heatsink_clearance   = 0.30;    // por lado
pocket_w             = heatsink_w + 2*heatsink_clearance;
pocket_l             = heatsink_l + 2*heatsink_clearance;

// Pod
pod_wall             = 2.4;
pod_back             = 2.8;
pod_side_h           = 5.0;
pod_outer_w          = pocket_w + 2*pod_wall;
pod_outer_l          = pocket_l + 2*pod_wall;
diffuser_enable      = true;
diffuser_slot        = 1.2;
diffuser_gap         = 5.0;

// Unión aro <-> brazo
tongue_w             = 8.0;
tongue_l             = 12.0;
tongue_t             = 3.8;
socket_clear         = 0.25;
socket_w             = tongue_w + 2*socket_clear;
socket_l             = tongue_l + 0.5;
socket_t             = tongue_t + 0.35;
socket_pad_w         = 14.0;
socket_pad_l         = 16.0;
socket_pad_h         = 6.0;
arm_lock_hole        = 3.3;     // M3 pasante

// Brazo
arm_w                = 10.0;
arm_t                = 5.0;
arm_pivot_r          = 64.0;    // radio del eje del tornillo de articulación
arm_pivot_hole       = 3.3;     // M3
arm_pivot_ear_w      = 8.0;
arm_pivot_ear_t      = 5.0;
arm_body_start_r     = ring_od/2 - tongue_l + 1.0;
arm_body_len         = arm_pivot_r - arm_body_start_r;

// Horquilla del pod
fork_gap             = arm_pivot_ear_t + 0.35;
fork_t               = 4.0;
fork_hole            = 3.3;
fork_outer_w         = fork_gap + 2*fork_t;

// Cableado
wire_channel_w       = 3.2;
wire_channel_d       = 2.0;
pod_wire_hole        = 4.0;

// =========================
// UTILIDADES
// =========================

module hex_prism(af, h){
    // hexágono definido por ancho entre caras
    r = af / sqrt(3);
    cylinder(h=h, r=r, $fn=6);
}

module radial_transform(angle, r=0, z=0){
    rotate([0,0,angle])
        translate([r,0,z])
            children();
}

// =========================
// ARO CENTRAL
// =========================

module ring_body(){
    difference(){
        union(){
            // Aro principal
            difference(){
                cylinder(h=ring_h, d=ring_od);
                translate([0,0,-0.5])
                    cylinder(h=ring_h+1, d=ring_id);
            }

            // Bosses de los 3 tornillos M4
            for(a = scope_screw_angles){
                radial_transform(a, ring_od/2 + scope_boss_l/2 - 2, 0)
                    cube([scope_boss_l, scope_boss_w, scope_boss_h], center=true);
            }

            // Pads para los cuatro brazos
            for(a = led_angles){
                radial_transform(a, ring_od/2 - socket_pad_l/2 + 4.0, ring_h - socket_pad_h/2)
                    cube([socket_pad_l, socket_pad_w, socket_pad_h], center=true);
            }
        }

        // Agujeros radiales para los M4 del microscopio
        for(a = scope_screw_angles){
            rotate([0,0,a])
                translate([ring_od/2 + scope_boss_l - 5,0,ring_h/2])
                    rotate([0,90,0])
                        cylinder(h=scope_boss_l + ring_wall_radial + 8,
                                 d=scope_screw_hole, center=true);

            // Trampa de tuerca M4 en la cara exterior
            rotate([0,0,a])
                translate([ring_od/2 + scope_boss_l - 7.0,0,ring_h/2])
                    rotate([0,90,0])
                        hex_prism(m4_nut_af, m4_nut_h+0.4);
        }

        // Ranuras superiores para espigas de brazo
        for(a = led_angles){
            rotate([0,0,a])
                translate([ring_od/2 - socket_l/2 + 2.2, 0,
                           ring_h - socket_t/2 + 0.05])
                    cube([socket_l, socket_w, socket_t], center=true);

            // Agujero vertical M3 de bloqueo
            rotate([0,0,a])
                translate([ring_od/2 - 2.5, 0, ring_h/2])
                    cylinder(h=ring_h+socket_pad_h+2, d=arm_lock_hole, center=true);
        }

        // Canaleta circular superior simple para cables
        // (interrumpida visualmente por los pads, pero funcional)
        translate([0,0,ring_h-wire_channel_d/2])
            difference(){
                cylinder(h=wire_channel_d+0.2, d=ring_od-5);
                cylinder(h=wire_channel_d+0.3, d=ring_od-5-2*wire_channel_w);
            }
    }
}

// =========================
// BRAZO MODULAR
// =========================

module arm_part(){
    // La pieza está orientada localmente en +X.
    // Su origen está aproximadamente donde comienza la espiga.
    difference(){
        union(){
            // Espiga que entra en el aro
            translate([tongue_l/2,0,tongue_t/2])
                cube([tongue_l, tongue_w, tongue_t], center=true);

            // Cuerpo del brazo
            translate([tongue_l + arm_body_len/2 - 2, 0, arm_t/2])
                cube([arm_body_len, arm_w, arm_t], center=true);

            // Oreja del pivote
            pivot_x = tongue_l + arm_body_len - 2;
            translate([pivot_x,0,arm_t/2])
                rotate([90,0,0])
                    cylinder(h=arm_pivot_ear_t,
                             d=arm_pivot_ear_w,
                             center=true);
        }

        // Agujero de bloqueo M3 de la espiga
        translate([tongue_l-2.5,0,0])
            cylinder(h=10, d=arm_lock_hole, center=true);

        // Agujero del pivote M3 (eje tangencial)
        pivot_x = tongue_l + arm_body_len - 2;
        translate([pivot_x,0,arm_t/2])
            rotate([90,0,0])
                cylinder(h=arm_pivot_ear_t+4,
                         d=arm_pivot_hole,
                         center=true);

        // Canaleta superior para cable
        translate([tongue_l + arm_body_len/2 - 2, 0, arm_t-wire_channel_d/2])
            cube([arm_body_len-2, wire_channel_w, wire_channel_d+0.2], center=true);
    }
}

// =========================
// POD LED ARTICULADO
// =========================

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

            // Puente de unión horquilla-bandeja
            translate([-pod_outer_l/2 + 8,0,1.5])
                cube([9, fork_outer_w, 5], center=true);
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

// =========================
// ENSAMBLE
// =========================

module assembled(){
    color([0.20,0.20,0.22]) ring_body();

    for(a = led_angles){
        // Posición local de inicio del brazo.
        // Se hace coincidir su espiga con la ranura del aro.
        base_r = ring_od/2 - socket_l + 3.0;

        // Brazo
        color([0.16,0.16,0.18])
            radial_transform(a, base_r + exploded, ring_h)
                arm_part();

        // Pod articulado
        // Radio del pivote definido paramétricamente.
        color([0.10,0.10,0.12])
            radial_transform(a,
                             arm_pivot_r + exploded*1.6,
                             ring_h + arm_t/2 - pod_drop)
                pod_part();

        // Disipador conceptual para visualizar volumen
        color([0.35,0.35,0.38,0.9])
            radial_transform(a,
                             cob_center_radius + exploded*1.8,
                             ring_h - pod_drop + 2.5)
                rotate([0,pod_tilt,0])
                    translate([0,0,heatsink_h/2 + pod_back/2])
                        cube([heatsink_l, heatsink_w, heatsink_h], center=true);

        // COB conceptual
        color([1.0,0.75,0.08])
            radial_transform(a,
                             cob_center_radius + exploded*1.8,
                             ring_h - pod_drop + 1.0)
                rotate([0,pod_tilt,0])
                    cube([13,13,1.2], center=true);
    }
}

// =========================
// PRINT PLATE
// =========================

module print_plate(){
    ring_body();

    // 4 brazos
    for(i=[0:3])
        translate([145, -45 + i*30, 0])
            arm_part();

    // 4 pods
    for(i=[0:3])
        translate([-145, -55 + i*38, 8])
            rotate([0,-pod_tilt,0])
                pod_part();
}

// =========================
// SALIDA
// =========================

if(part == "assembly")
    assembled();
else if(part == "ring")
    ring_body();
else if(part == "arm")
    arm_part();
else if(part == "pod")
    pod_part();
else if(part == "print_plate")
    print_plate();
else
    assembled();
