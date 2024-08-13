include <BOSL2/std.scad>
include <rosetta-stone/ball-mount-bits.scad>

$fn = 50;


module assem()
{
    down(2)
    double_socket(25.5, 75, "1/4,20", nut_trap=true, offset_spring=true)
    up(4)
    zflip()
    double_socket(25.5, 75, "1/4,20", nut_trap=false, offset_spring=true)
    position(BOTTOM)
    wing_nut(anchor=BOTTOM, orient=DOWN);
}

double_socket(25.5, 75, "1/4,20", nut_trap=false, offset_spring=true);
// wing_nut();
