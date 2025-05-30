include <BOSL2/std.scad>
include <rosetta-stone/std.scad>

$fn=50;

first_layer_thickness = 0.2;
other_layer_thickness = 0.45;
overall_thickness = 5;
frisbee_diam = 12;
offense_diam = 20;
defense_size = [20, 7];
cyl_mag_d = 6;
cyl_mag_l = 2;
cyl_window_thickness = 2;

module cyl_mag(d, first_layer_thickness, other_layer_thickness, cyl_mag_l, height, window_thickness) {
    attachable(size=[d, d, overall_thickness])
    {
        // intersect("mag-intersect", "mag-keep") {
        //     cuboid([d, d, height]) {
        //         tag("mag-intersect") cuboid([window_thickness, d, overall_thickness]);
        //         position(BOTTOM) up(first_layer_thickness) tag("mag-keep") cyl(d=d, l=cyl_mag_l, anchor=BOTTOM);
        //     }
        // }
        cube_height = d+1;
        down(overall_thickness/2) cuboid([window_thickness, cube_height, first_layer_thickness], anchor=BOTTOM)
        position(TOP) cyl(d=d, l=cyl_mag_l, anchor=BOTTOM)
        position(TOP) cuboid([window_thickness, cube_height, overall_thickness-cyl_mag_l-first_layer_thickness], anchor=BOTTOM);
        children();
    }
}

module frisbee()
{
    diff(){
        cyl(d=frisbee_diam, l=overall_thickness)
        force_tag("remove") cyl_mag(cyl_mag_d, first_layer_thickness, other_layer_thickness, cyl_mag_l, overall_thickness, cyl_window_thickness);
    }
}

module offense()
{
    diff() {
        cyl(d=offense_diam, l=overall_thickness)
        force_tag("remove") cyl_mag(cyl_mag_d, first_layer_thickness, other_layer_thickness, cyl_mag_l, overall_thickness, cyl_window_thickness);
    }
}

module defense()
{
    diff() {
        cuboid(concat(defense_size, overall_thickness))
        force_tag("remove") cyl_mag(cyl_mag_d, first_layer_thickness, other_layer_thickness, cyl_mag_l, overall_thickness, cyl_window_thickness);
    }
}

// cyl_mag(cyl_mag_d, first_layer_thickness, other_layer_thickness, cyl_mag_l, overall_thickness, cyl_window_thickness);
// frisbee();
// right(20)
offense();
// right(45)
// defense();
