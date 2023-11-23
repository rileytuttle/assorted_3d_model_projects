include <BOSL2/std.scad>
include <BOSL2/gears.scad>
include <BOSL2/screws.scad>
include <BOSL2/rounding.scad>
$fn=30;
mod=1;
helical=25;
gear_height = 5;
gear_data = planetary_gears(mod=mod, n=3, max_teeth=50, ring_sun=1/3, helical=helical,gear_spin=360/33*$t);
echo(gear_data);
drive_pent_size = 3.8;
driven_pent_size = 3.75;
backing=18;
base_diam = 60;

module handle() {
    diam=17;
    thickness =3.5;
    path=[
        each arc(n=100, r=diam/2, angle=[90, 270]),
        // each rect([100, diam], anchor=LEFT)];
        [100, -diam/2],
        [100, diam/2],
    ];
    translate([0, 0, -thickness])
    offset_sweep(path, l=thickness, top=os_chamfer(width=1));
    // cyl(l=thickness, d=diam, anchor=TOP)
    //     position(CENTER)
    //     cube([100, diam, thickness], anchor=LEFT);
    // stroke(path);
}

module base_plate() {
    diff("remove") {
        cyl(d=base_diam, l=5, anchor=TOP) {
            tag("remove")
            cyl(d=15, l=5+1, anchor=CENTER); 
            tag("remove")
            position(CENTER)
            move_copies(gear_data[2][4]) screw_hole("M4x0.7", l=5+1, thread=true, anchor=CENTER);
            position(BOTTOM)
            tube(id=51, od=base_diam, h=20, anchor=TOP);
            
        }
    }
}

module planet_gear(spin=0) {
    diff("remove") {
    color("red") spur_gear(mod=mod, teeth=gear_data[2][1], profile_shift=gear_data[2][2], helical=-helical, gear_spin=spin, thickness=gear_height) {
        position(TOP)
        cyl(d=22, l=2, anchor=BOTTOM) {
            tag("remove")
            position(TOP)
            screw_hole("M4x0.7", thread=false, l=gear_height+1+2, anchor=TOP, head="socket");
        }
    }
    }
}

module all_planets() {
    move_copies(gear_data[2][4])
        planet_gear(gear_data[2][3][$idx]);
}

module sun_gear() {
    diff("remove") {
        spur_gear(mod=mod, teeth=gear_data[0][1], profile_shift=gear_data[0][2], helical=helical, gear_spin=gear_data[0][3], thickness=gear_height)  //sun
            tag("remove")
            position(CENTER)
            translate([0, 0, -(gear_height+1)/2])
            offset_sweep(pentagon(or=drive_pent_size),l=gear_height+1, top=os_chamfer(width=-1), bottom=os_chamfer(width=-1));
    }
}

module outer_ring_gear() {
    diff("remove") {
    ring_gear(mod=mod, teeth=gear_data[1][1], profile_shift=gear_data[1][2], helical=helical, gear_spin=gear_data[1][3],backing=backing-3,thickness=gear_height) {
        tube(od=98, wall=7, l=gear_height, $fn=10);
        tag("remove") {
            for (i=[-1, 1]) {
                position(TOP)
                translate([i*44,-15,0])
                cube([10, 15, 3.5], anchor=TOP);
                position(TOP) translate([i*37.5, 0, 0]) rotate([0, 0, -90 - i*5]) handle();
            }
        }
    }
}}

// color("blue"){
//     move_copies(gear_data[2][4]) cyl(h=12,d=4);
//     down(10)linear_extrude(height=3)scale(1.2)polygon(gear_data[2][4]);
// }

// base_plate();
// translate([0, 0, gear_height/2]) {
// all_planets();
// sun_gear();
outer_ring_gear();
// }
// planet_gear();
// handle();
