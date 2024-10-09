include <BOSL2/std.scad>
include <rosetta-stone/std.scad>

$fn=50;

case_thickness=21;
case_height=186.5;
case_width=71;

driver_main_length = 152.5;
driver_main_d = 18;
driver_sub_d = 11;
driver_sub_l = 7.5;

mag_type = "circle"; // ["circle", "rect"]

module bit_remove_with_circle_mags(anchor=CENTER, spin=0, orient=UP, l=50)
{

    size = [37, 9, l];
    top_half_size = [37, 9, l/2];
    front_pocket_size = [37, 3.5, l];
    default_tag("remove");
    attachable(size=size, anchor=anchor, orient=orient, spin=spin) {
        cube(top_half_size, anchor=BOTTOM) {
            position(FRONT+TOP) cube(front_pocket_size, anchor=FRONT+TOP)
            position(BACK+BOTTOM)
            xcopies(n=6, l=30) {
                hexagon3d(minor_width=4, height=l/2, anchor=BOTTOM)
                up(8) position(BOTTOM) back(4/2) #magnet_cutout_cyl(5.1, 2, case_thickness, n_layers_to_surface=1, orient=FRONT, anchor=TOP); 
            }
        }
        children();
    }
}

module bit_remove_with_rect_mags(anchor=CENTER, spin=0, orient=UP, l=50)
{
    size = [37, 9, l];
    top_half_size = [37, 9, l/2];
    front_pocket_size = [37, 3.5, l];
    default_tag("remove");
    attachable(size=size, anchor=anchor, orient=orient, spin=spin) {
        cube(top_half_size, anchor=BOTTOM) {
            position(FRONT+TOP) cube(front_pocket_size, anchor=FRONT+TOP) {
                position(BACK+BOTTOM)
                xcopies(n=6, l=30) {
                    hexagon3d(minor_width=4, height=l/2, anchor=BOTTOM);
                    // up(8) position(BOTTOM) back(4/2) #magnet_cutout_cyl(5.1, 2, case_thickness, n_layers_to_surface=1, orient=FRONT, anchor=TOP); 
                }
                position(BACK+BOTTOM)
                up(8)
                back(4/2)
                cuboid([30.1, 2, 0.2], anchor=TOP, orient=FRONT)
                position(BOTTOM) cuboid([30.1, 5.1, 2.1], anchor=TOP, rounding=1, edges=[LEFT+FRONT, LEFT+BACK, RIGHT+FRONT, RIGHT+BACK])
                for (loc=[[LEFT, RIGHT], [RIGHT, LEFT]])
                    position(loc[0]) cuboid([100, 5.1, 2.1], rounding=1, edges=[loc[1]+FRONT, loc[1]+BACK], anchor=loc[1]);
            }
        }
        children();
    }
}

module latch(anchor=BOTTOM, orient=DOWN) {
    attachable() {
        cuboid([3, 4, 10-3], anchor=anchor, chamfer=0.5, edges=[TOP+LEFT, TOP+RIGHT], orient=orient)
            position(TOP) cuboid([5, 4, 3], anchor=BOTTOM, chamfer=1.5, edges=[TOP+LEFT, TOP+RIGHT]);
        children();
    }
}

module driver_remove(anchor=BACK, orient=FRONT)
{
    default_tag("remove")
    attachable() {
        teardrop(d=driver_main_d, l=driver_main_length, anchor=anchor, orient=orient, cap_h=driver_main_d/2) {
            cube([20, driver_main_d-1, driver_main_length], anchor=RIGHT, orient=FRONT)
                right(1.5) cube([10, 30, driver_main_length], anchor=CENTER);
            position(BACK+RIGHT) cyl(d=7, l=10, anchor=BOTTOM+RIGHT, orient=BACK);
            position(BACK+LEFT) cyl(d=7, l=10, anchor=BOTTOM+LEFT, orient=BACK);
            position(BACK) cube([driver_main_d-7, 7, 10], anchor=BOTTOM, orient=BACK);
            position(FRONT) teardrop(d=driver_sub_d, l=driver_sub_l, anchor=BACK, cap_h=driver_sub_d/2)
            cube([20, driver_sub_l, driver_sub_d-1], anchor=RIGHT);
        }
        children();
    }
}

module case_insert(anchor=CENTER)
{
    diff() {
        cuboid([case_width, case_thickness, case_height], rounding=case_thickness/2, edges=[FRONT+LEFT, FRONT+RIGHT, BACK+LEFT, BACK+RIGHT], anchor=anchor) {
            down(3) right(case_thickness/2)
            position(LEFT+TOP)
            driver_remove();
            // the bit holders
            spacing=6;
            if (mag_type == "circle") {
                force_tag("remove")
                down(spacing) left(case_thickness/2-3) position(TOP+RIGHT+FRONT) bit_remove_with_circle_mags(l=50, anchor=TOP+RIGHT+FRONT)
                down(spacing) position(BOTTOM) bit_remove_with_circle_mags(l=33, anchor=TOP)
                down(spacing) position(BOTTOM) bit_remove_with_circle_mags(l=33, anchor=TOP)
                down(spacing) position(BOTTOM) bit_remove_with_circle_mags(l=33, anchor=TOP)
                for (spec = [[-25/2, (case_thickness-10.5)/2], [-25/6, (case_thickness-10.5)/2], [25/6, case_thickness], [25/2, case_thickness]])
                {
                    #translate([spec[0], 0, -6]) position(BOTTOM+FRONT) force_tag("remove") magnet_cutout_cyl(6.1, 2, spec[1], anchor=TOP, orient=FRONT);
                }
            }
            else if (mag_type == "rect")
            {
                force_tag("remove")
                down(spacing) left(case_thickness/2-3) position(TOP+RIGHT+FRONT) bit_remove_with_rect_mags(l=50, anchor=TOP+RIGHT+FRONT)
                down(spacing) position(BOTTOM) bit_remove_with_rect_mags(l=33, anchor=TOP)
                down(spacing) position(BOTTOM) bit_remove_with_rect_mags(l=33, anchor=TOP)
                down(spacing) position(BOTTOM) bit_remove_with_rect_mags(l=33, anchor=TOP)
                for (spec = [[-25/2, (case_thickness-10.5)/2], [-25/6, (case_thickness-10.5)/2], [25/6, case_thickness], [25/2, case_thickness]])
                {
                    translate([spec[0], 0, -6]) position(BOTTOM+FRONT) force_tag("remove") magnet_cutout_cyl(6.1, 2, spec[1], anchor=TOP, orient=FRONT);
                }
            }
            // latch thing
            position(BOTTOM) tag("remove") slot(d=10.5, h=10, spread=24.5-10.5, anchor=BOTTOM);
            up(10) position(BOTTOM) tag("keep") latch();
        }
    }
}
// todo
// 2 magnets per long bit

// bottom_half(200)
// down(50)
case_insert(anchor=CENTER);

// case_insert_with_teardrop();

// hexagon3d(minor_width=4, height=25, spin=30);
// bit_remove_with_rect_mags();

// magnet_cutout_cyl(5.1, 2, 10, n_layers_to_surface=1, orient=FRONT, anchor=TOP); 
