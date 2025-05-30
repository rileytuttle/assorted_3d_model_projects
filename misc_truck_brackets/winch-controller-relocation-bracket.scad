include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/std.scad>

$fn=50;

controller_mount_hole_spacing = [155, 97.5];
controller_mount_hole_diam = 6;
m6_thickness = 5;
m6_length = 35;
m5_grab = 5;
m5_length = 20;


module first_bracket() {
bracket_thickness = 15;
m5_thickness = bracket_thickness - m5_grab;
diff() {
    cuboid([180, 120, bracket_thickness], chamfer=8, edges=[FRONT+RIGHT, FRONT+LEFT, BACK+LEFT, BACK+RIGHT]) {
            for (pos=[
                 [[155/2, 97.5/2], 180],
                 [[155/2, -97.5/2], 90],
                 [[-155/2, 97.5/2], -90],
                 [[-155/2, -97.5/2], 0]])
            {
                // position(BOTTOM) translate(pos[0]) pie_slice(ang=90, l=4, r=6, anchor=TOP, spin=pos[1]) 
                {
                    // tag("remove") position(BOTTOM) cyl(d=6, l=4, anchor=BOTTOM);
                    // tag("remove") position(BOTTOM) up(4) screw_hole("M5", l=bracket_thickness, anchor=BOTTOM, thread=true)
                    tag("remove") position(BOTTOM) translate(pos[0]) screw_hole("M5", l=m5_length, anchor=BOTTOM, thread=true)
                    position(BOTTOM) up(m5_grab) nut_trap_inline(m5_thickness, anchor=BOTTOM);
                }
            }
            // tag("remove") grid_copies(n=2, size=controller_mount_hole_spacing) {
            //     position(BOTTOM) screw_hole("M5", l=bracket_thickness, anchor=BOTTOM, thread=true) 
            //     position(TOP) nut_trap_inline(m5_thickness, anchor=TOP);
            // }
        fwd(13) tag("remove") position(BACK+BOTTOM) xcopies(n=2, l=35) screw_hole("M8", l=m6_length, anchor=BOTTOM)
            position(BOTTOM) cyl(l=8, d=20, anchor=BOTTOM);
        cutout_w = 150;
        cutout_h = 90;
        position(LEFT+FRONT) tag("remove") cuboid([cutout_w, bracket_thickness, cutout_h/2], anchor=TOP+LEFT, orient=FRONT, chamfer=-8, edges=[TOP+RIGHT])
        position(BOTTOM) cuboid([cutout_w, bracket_thickness, cutout_h/2], anchor=TOP, chamfer=8, edges=[BOTTOM+RIGHT]);
        // position(FRONT) tag("remove") cuboid([cutout_w, bracket_thickness, cutout_h/2], anchor=TOP, orient=FRONT, chamfer=-8, edges=[TOP+LEFT, TOP+RIGHT])
        // position(BOTTOM) cuboid([cutout_w, bracket_thickness, cutout_h/2], anchor=TOP, chamfer=8, edges=[BOTTOM+LEFT, BOTTOM+RIGHT]);
    }
}

}

module second_try()
{
    bracket_thickness = 20;
    m5_thickness = bracket_thickness - m5_grab;
    diff() {
        cuboid([5 * INCH, 30, bracket_thickness], chamfer=8, edges=[FRONT+RIGHT, FRONT+LEFT, BACK+RIGHT, BACK+LEFT]) {
            height = 120;
            position(FRONT) cuboid([30, height, bracket_thickness], anchor=FRONT, chamfer=8, edges=[BACK+LEFT, BACK+RIGHT]) {
                back(30) position(FRONT+LEFT) fillet(l=bracket_thickness, r=8, spin=90, $fn=1);
                back(30) position(FRONT+RIGHT) fillet(l=bracket_thickness, r=8, spin=0, $fn=1);
                ycopies(n=2, l=controller_mount_hole_spacing[1]) screw_hole("M5", l=bracket_thickness, thread=true)
                    position(BOTTOM) nut_trap_inline(m5_thickness, anchor=BOTTOM);
            }
            tag("remove") xcopies(n=2, l=4*INCH) screw_hole("M8", l=bracket_thickness)
            up(5) position(BOTTOM) cyl(d=20, l=20, anchor=BOTTOM);
        }
    }
}

module full_spacer()
{
    bracket_thickness = 20 - 0.1*INCH;
    m5_thickness = bracket_thickness - m5_grab;
    height = controller_mount_hole_spacing[1] + 15 + 10;
    echo(str(height));
    diff() {
        cuboid([5 * INCH, 30, bracket_thickness], chamfer=8, edges=[FRONT+RIGHT, FRONT+LEFT, BACK+RIGHT, BACK+LEFT]) {
            position(FRONT) cuboid([30, height, bracket_thickness], anchor=FRONT, chamfer=8, edges=[BACK+LEFT, BACK+RIGHT]) {
                back(30) position(FRONT+LEFT) fillet(l=bracket_thickness, r=8, spin=90, $fn=1);
                back(30) position(FRONT+RIGHT) fillet(l=bracket_thickness, r=8, spin=0, $fn=1);
                position(FRONT) {
                    back(15) screw_hole("M5", l=bracket_thickness, thread=false)
                    {
                        position(BOTTOM) nut_trap_inline(m5_thickness, anchor=BOTTOM);
                        back(controller_mount_hole_spacing[1]) screw_hole("M5", l=bracket_thickness, thread=false)
                        position(BOTTOM) nut_trap_inline(m5_thickness, anchor=BOTTOM);
                    }
                }
                    // back(15) ycopies(n=2, l=controller_mount_hole_spacing[1]) screw_hole("M5", l=bracket_thickness, thread=true)
                    // position(BOTTOM) nut_trap_inline(m5_thickness, anchor=BOTTOM);
            }
            tag("remove") xcopies(n=2, l=4*INCH) screw_hole("M8", l=bracket_thickness)
            up(5) position(BOTTOM) cyl(d=20, l=20, anchor=BOTTOM);
        }
    }
}

module spacer()
{
    bracket_thickness = 20 - 0.1 * INCH;
    m5_thickness = bracket_thickness - m5_grab;
    diff() {
            height = 120;
            cuboid([30, height, bracket_thickness], anchor=FRONT, chamfer=8, edges=[BACK+LEFT, BACK+RIGHT, FRONT+LEFT, FRONT+RIGHT]) {
                ycopies(n=2, l=controller_mount_hole_spacing[1]) screw_hole("M5", l=bracket_thickness, thread=true)
                    position(BOTTOM) nut_trap_inline(m5_thickness, anchor=BOTTOM);
            }
    }
}

module washer()
{
    diff() {
        cuboid([5*INCH, 20, 2], rounding=5, edges=[FRONT+RIGHT, FRONT+LEFT, BACK+RIGHT, BACK+LEFT])
        xcopies(n=2, l=4*INCH) screw_hole("5/16", l=2, thread=true);
    }
}

// second_try();
// spacer();
// full_spacer();
washer();
