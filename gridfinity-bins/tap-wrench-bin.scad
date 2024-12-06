include <BOSL2/std.scad>
include <gridfinity-rebuilt-openscad/gridfinity-rebuilt-utility.scad>

gridx = 6;
gridy = 1;
gridz = 4;
l_gridx = 42;
l_gridy = 42;
hole_options = bundle_hole_options(false, false, false, false, false, false);

module tap_wrench_pocket()
{
    left_side_tube_length = 87;
    right_side_tube_length = 83;
    side_tube_d = 12;
    middle_tube_length = 63;
    middle_tube_diam = 15;
    cuboid([middle_tube_length, 26, middle_tube_diam]) {
        for(loc = [[LEFT, left_side_tube_length], [RIGHT, right_side_tube_length]]) {
            position(loc[0]) cyl(d=side_tube_d, l=loc[1], anchor=BOTTOM, orient=loc[0])
            position(TOP) sphere(d=20);
            position(loc[0]) prismoid([middle_tube_diam, 26], [side_tube_d, side_tube_d], h=10, anchor=BOTTOM, orient=loc[0]);
        }
    }
}

module tap_wrench_bin()
{
    // difference() {
    // union() {
        gridfinityInit(gridx, gridy, height(gridz, 0, 0, false), 0, sl=0, l=[l_gridx, l_gridy])
        {
            up(gridz*7)
            right(2)
            tap_wrench_pocket();
        }
        gridfinityBase([gridx, gridy], hole_options=hole_options, thumbscrew=false, grid_dimensions=[l_gridx, l_gridy]);
    // }
    // up(gridz*7)
    // right(2)
    // tap_wrench_pocket();
    // }
}

tap_wrench_bin();
// tap_wrench_pocket();
