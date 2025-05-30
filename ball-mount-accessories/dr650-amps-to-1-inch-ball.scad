include <BOSL2/std.scad>
include <rosetta-stone/std.scad>
include <ball-mount/ball-mount-bits.scad>
include <BOSL2/screws.scad>

$fn=50;

diagonal_dist = sqrt(amps_spacing[0]^2 + amps_spacing[1]^2);
overall_len = 62;
right_height = 40;
left_height = 20;
thickness = 7;

x_offset = 10;
y_offset = 13;

module amps_plate()
{

    rounded_trap = trapezoid(w1=right_height, w2=left_height, h=overall_len, shift=-left_height/2, spin=90, rounding=5, anchor=LEFT);
    diff() {
        offset_sweep(rounded_trap, height=thickness) {
        position(BOTTOM+FRONT) back(7) xcopies(n=2, l=diagonal_dist) screw_hole("M5", l=thickness, anchor=BOTTOM);
        position(BOTTOM+FRONT) up(thickness - 5) back(7+y_offset) right(x_offset) ball_with_circular_base(1 * INCH, [10, 5], [12,12], anchor=BOTTOM, flare_neck_bottom=-5);
        position(BOTTOM+FRONT) back(7+y_offset) right(x_offset) screw_hole("M6", l=32, head="flat", thread=true, anchor=TOP, orient=DOWN);
        }
    }
}

amps_plate();
