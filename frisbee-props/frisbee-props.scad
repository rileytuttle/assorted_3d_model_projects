include <BOSL2/std.scad>
include <rosetta-stone/std.scad>

$fn=50;

first_layer_thickness = 0.2;
other_layer_thickness = 0.45;
overall_thickness = 5;
frisbee_diam = 11;
offense_diam = 12;
defense_size = [20, 7];
cyl_mag_d = 6.1;
cyl_mag_l = 2;
cyl_window_thickness = 2;
rect_mag_size = [10, 5, 2];

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
    mag_pocket_layers = ceil(cyl_mag_l/other_layer_thickness);
    mag_pocket_thickness = mag_pocket_layers * other_layer_thickness;
    echo(str("mag pocket layer count is ", mag_pocket_layers, " for a total ", mag_pocket_thickness, " thickness"));
    diff() {
        cyl(d=offense_diam, l=overall_thickness)
        force_tag("remove") cyl_mag(cyl_mag_d, first_layer_thickness, other_layer_thickness, mag_pocket_thickness, overall_thickness, cyl_window_thickness);
    }
}

module defense()
{
    mag_pocket_layers = ceil(rect_mag_size[2]/other_layer_thickness);
    mag_pocket_thickness = mag_pocket_layers * other_layer_thickness;
    echo(str("mag pocket layer count is ", mag_pocket_layers, " for a total ", mag_pocket_thickness, " thickness"));
    diff() {
        cuboid(concat(defense_size, overall_thickness)) {
        up(first_layer_thickness)
        position(BOTTOM)
        force_tag("remove") cuboid([rect_mag_size[0], rect_mag_size[1], mag_pocket_thickness], anchor=BOTTOM)
            position(TOP) up(other_layer_thickness) cyl(d=2, l=5, anchor=BOTTOM);
        tag("remove") position(BOTTOM) cyl(d=2, l=first_layer_thickness, anchor=BOTTOM);
        }
    }
}

// cyl_mag(cyl_mag_d, first_layer_thickness, other_layer_thickness, cyl_mag_l, overall_thickness, cyl_window_thickness);
// frisbee();
// right(20)
// offense();
// right(45)
defense();
