include <BOSL2/std.scad>

$fn=50;

twobyfour_thickness = 37.5;
table_thickness = 55;
screw_grab_width = 30;
table_grab_width = 40;
arm_width = 20;
twobyfour_grab_thickness = 10;
screw_diam = 5;

module bracket()
{
    main_block_width = screw_grab_width * 2 + arm_width + table_grab_width;
    main_block_height = screw_grab_width + twobyfour_grab_thickness;
    main_block_thickness = twobyfour_thickness + twobyfour_grab_thickness;
    diff() {
        cuboid([main_block_width, main_block_height, main_block_thickness]) {
            right(screw_grab_width) position(FRONT+LEFT) cuboid([arm_width, table_thickness, main_block_thickness], anchor=BACK+LEFT) {
                for (loc=[[BACK+LEFT, 180],[FRONT+RIGHT, 0], [BACK+RIGHT, -90]]) {
                    position(loc[0]) fillet(r=10, l=main_block_thickness, spin=loc[1]);
                }
                position(FRONT+LEFT) cuboid([arm_width+table_grab_width, 20, main_block_thickness], anchor=BACK+LEFT, rounding=10, edges=[FRONT+LEFT, FRONT+RIGHT, BACK+RIGHT]);
            }
            tag("remove")
            for (loc=[
                 [BACK+LEFT+BOTTOM, screw_grab_width],
                 [BACK+RIGHT+BOTTOM, -screw_grab_width]
                 ]) {
                right(loc[1]) fwd(screw_grab_width/2) position(loc[0])
                cyl(d=screw_diam, l=100, anchor=TOP, orient=DOWN)
                position(TOP) cyl(h=5, d1=screw_diam, d2=8.5, anchor=TOP);
            }
            tag("remove")
            for (loc=[
                 [FRONT+LEFT+TOP, screw_grab_width/2],
                 [FRONT+RIGHT+TOP, -screw_grab_width/2],
                 ]) {
                position(loc[0]) right(loc[1]) down(twobyfour_thickness/2)
                teardrop(d=screw_diam, l=100, anchor=FRONT, orient=UP, ang=60)
                position(FRONT) teardrop(d1=8.5, d2=screw_diam, l=5, anchor=FRONT, ang=60);
            }
            tag("remove")
            position(FRONT+BOTTOM)
            back(twobyfour_grab_thickness)
            up(twobyfour_grab_thickness)
            cube([200, 100, 100], anchor=FRONT+BOTTOM);
        }
    }
}

bracket();
