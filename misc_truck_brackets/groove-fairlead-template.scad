include <BOSL2/std.scad>
include <BOSL2/joiners.scad>
include <rosetta-stone/std.scad>
include <BOSL2/screws.scad>

$fn=50;

thickness = 3;
hole_dist = 10*INCH;
hole_diam = 13;
// round_r = 40;
round_r = 3.3 * INCH / 2;
extra_cutout_h = 10;
extra_cutout_w = 6 * INCH;


module full_bracket()
{
    attachable() {
        diff() {
            cuboid([hole_dist, round_r * 2, thickness]) {
                xcopies(n=2, l=hole_dist) {
                    cyl(r=round_r, l=thickness);
                    tag("remove") cyl(d=hole_diam, l=thickness+1);
                }
                // #position(BACK) cuboid([extra_cutout_w, extra_cutout_h, thickness], anchor=FRONT);
                position(BACK) cuboid([extra_cutout_w+extra_cutout_h, extra_cutout_h, thickness], anchor=FRONT, rounding=extra_cutout_h/2, edges=[BACK+LEFT, BACK+RIGHT]) {
                    position(FRONT+LEFT) fillet(r=extra_cutout_h/2, l=thickness, spin=90);
                    position(FRONT+RIGHT) fillet(r=extra_cutout_h/2, l=thickness, spin=0);
                }
            }
        }
        children();
    }
}

module left_bracket() {
    left_half(300) full_bracket();
    ycopies(n=2, l=round_r) dovetail("male", slide = thickness, width=15, height=8, radius=1, orient=RIGHT, spin=90);
}

module right_bracket() {
    difference() {
        right_half(300) full_bracket();
        ycopies(n=2, l=round_r) dovetail("female", slide = thickness, width=15, height=8, radius=1, orient=RIGHT, spin=90);
    }
    
}

module groove_expansion() {
    diff() {
        cyl(d=1 * INCH, l=thickness) {
            tag("remove") screw_hole("1/2", l=thickness);
            cuboid([round_r, round_r, thickness], anchor=RIGHT+FRONT, rounding=round_r-10, edges=BACK+LEFT);
        }
        
    }
}

// left_bracket();
// up(5)
// right_bracket();

groove_expansion();
