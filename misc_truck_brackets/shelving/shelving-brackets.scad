include <BOSL2/std.scad>
include <rosetta-stone/std.scad>
include <BOSL2/screws.scad>

plywood_thickness = 3/8 *INCH;
$fn=50;
inner_diam = 1.5 * INCH;
outer_diam = (1.5+1) * INCH;

module platform_hinge()
{
    diff() {
        cuboid([1*INCH, 1.5 * INCH, plywood_thickness/2], anchor=CENTER) {
            left_half() position(LEFT) cyl(d=1.5 * INCH, l=plywood_thickness /2)
            left_half() position(TOP) cyl(d=(1.5 + 1) * INCH, l=plywood_thickness/2, anchor=BOTTOM)
            position(TOP) arc_copies(d=2 * INCH, n=3, sa=90, ea=270) screw_hole("#8", head="flat", anchor=TOP, l=plywood_thickness);
            position(TOP) cuboid([1*INCH, (1.5+1) * INCH, plywood_thickness/2], anchor=BOTTOM);
            tag("remove") position(TOP+RIGHT) cuboid([1*INCH, 0.5*INCH, plywood_thickness], anchor=RIGHT) {
                position(LEFT) left_half() cyl(d=0.5*INCH, l=plywood_thickness);
                #tag("remove") position(FRONT) fwd(5) screw_hole("M4", l=2*INCH, anchor="head_bot", orient=FRONT, head="socket", counterbore=30);
            }
            #position(BACK+TOP) fwd(3) nut_trap_inline(30, "M4", anchor=BOTTOM, orient=BACK);
        }
    }
    
}

module hinge_route_inner_template()
{
    bit_diam = 1/2 * INCH;
    shaft_diam = 3/8 * INCH;
    bit_shift_amount = (bit_diam - shaft_diam) / 2;
    width = inner_diam - 2*bit_shift_amount;
    diff() {
        cuboid([60, 200, 10]) {
        tag("remove") position(RIGHT) cuboid([1*INCH, width, 11], anchor=RIGHT)
        position(LEFT) left_half() cyl(d=width, l=11);
        position(RIGHT+BACK+TOP) cuboid([10, 50, 30], anchor=TOP+BACK+LEFT);
        position(RIGHT+FRONT+TOP) cuboid([10, 50, 30], anchor=TOP+FRONT+LEFT);
        }
    }
}


// this is not exactly right. we will need plywood/2 riser so the bit has room to actually get underneath. this will depend on the actual bit height though so I'll wait to do this
module hinge_route_outer_template()
{
    bit_diam = 1/2 * INCH;
    shaft_diam = 3/8 * INCH;
    bit_shift_amount = (bit_diam - shaft_diam) / 2;
    width = outer_diam - 2*bit_shift_amount;
    diff() {
        cuboid([60, 200, 10]) {
        tag("remove") position(RIGHT) cuboid([1*INCH, width, 11], anchor=RIGHT)
        position(LEFT) left_half() cyl(d=width, l=11);
        position(RIGHT+BACK+TOP) cuboid([10, 50, 30], anchor=TOP+BACK+LEFT);
        position(RIGHT+FRONT+TOP) cuboid([10, 50, 30], anchor=TOP+FRONT+LEFT);
        }
    }
}

// platform_hinge();
// hinge_route_inner_template();
hinge_route_outer_template();
