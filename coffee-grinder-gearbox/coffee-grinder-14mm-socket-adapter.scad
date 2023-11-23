include <BOSL2/std.scad>

drive_pent_size = 3.8;

module adapter() {
    // diff("remove") {
        // spur_gear(mod=mod, teeth=gear_data[0][1], profile_shift=gear_data[0][2], helical=helical, gear_spin=gear_data[0][3], thickness=gear_height)  //sun
        //     tag("remove")
        //     position(CENTER)
        //     translate([0, 0, -(gear_height+1)/2])
        //     offset_sweep(pentagon(or=drive_pent_size),l=gear_height+1, top=os_chamfer(width=-1), bottom=os_chamfer(width=-1));
    // }
    linear_extrude(14) {
    diff() {
        hexagon(id=13.7)
        tag("remove")
        pentagon(or=drive_pent_size);
    }
    }
}

adapter();
