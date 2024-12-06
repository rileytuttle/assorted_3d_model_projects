include <BOSL2/std.scad>
use <gridfinity-rebuilt-openscad/gridfinity-rebuilt-utility.scad>

$fn=50;
grid_length = 42;
gridx = 2;
gridy = 2;
hole_options = [false, false, false, false, false, false];

module tape_dispenser_bin()
{
    // cuboid([gridx * grid_length - 0.5, gridy * grid_length -0.5, 10], anchor=BOTTOM, rounding=4, edges=[FRONT+RIGHT, FRONT+LEFT, BACK+RIGHT, BACK+LEFT]);
    bottom_half(200)
    down(6.5)
    gridfinityBase([gridx, gridy], hole_options=hole_options, grid_dimensions=[grid_length, grid_length]);
    diff() {
        right(13) fwd(13) tube(od=24.5, id=23, l=20, anchor=BOTTOM) {
            position(TOP) cyl(d=24.5, l=5, anchor=TOP)
            tag("remove") cyl(d=20, l=5, chamfer1=-1);
            position(BOTTOM) cyl(d=24.5, l=10, anchor=BOTTOM);
            // #cyl(d=57, l=20);
            // torus() // capture ring
        }
        left(35) back(20) cuboid([5, 20, 20], anchor=BOTTOM, chamfer=1, edges=[BACK+RIGHT])
        position(BACK) tag("remove") cuboid([1, 5, 20], anchor=BACK);
    }
    
}

tape_dispenser_bin();
