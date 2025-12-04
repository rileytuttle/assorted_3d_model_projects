include <openscad-library-manager/BOSL2/std.scad>
include <openscad-library-manager/BOSL2/screws.scad>


$fn=50;

hole_diam = 6;
square_dist = 5;

module scissor_screw()
{
    top_half()
    up(square_dist/2)
    xrot(90)
    diff()
    {
        cyl(d=12, l=3, anchor=BOTTOM)
        {
            position(TOP) cyl(d=hole_diam, l=6, anchor=BOTTOM)
            position(TOP) screw("M6", l=4, anchor=BOTTOM, blunt_start1=false);
            position(TOP) tag("remove") up(3) back(square_dist/2) cuboid([10, 10, 20], anchor=BOTTOM+FRONT);
        }
    }
}

module screw_nut()
{
    diff() {
        cuboid([12, 12, 3], rounding=2, except=[TOP, BOTTOM])
        screw_hole("M6", l=3, $slop=0.03, thread=true);
    }
}

// scissor_screw();
screw_nut();
