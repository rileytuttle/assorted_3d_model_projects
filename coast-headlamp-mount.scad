include <openscad-library-manager/BOSL2/std.scad>
include <openscad-library-manager/rosetta-stone/std.scad>
include <openscad-library-manager/BOSL2/screws.scad>

$fn=50;

grabber_thickness = 5.3;
light_diam = 23.5;
clip_pocket_width = 11.25;
plate_size = [56, 33, 3.5];
dist_between_grabbers = 28.5;
clip_pocket_chamfer = 1;
ratchet_height = 1.75;

module mount()
{
    diff() {
        cuboid(plate_size, rounding=3, except=[TOP,BOTTOM]) {
            tag("remove") cuboid([clip_pocket_width, clip_pocket_width, plate_size[2]], chamfer=-clip_pocket_chamfer, edges=[TOP, BOTTOM]);
            tag("remove") xcopies(n=2, l=44) cuboid([4, 1*INCH, plate_size[2]+1], rounding=1, except=[TOP,BOTTOM]);
            position(TOP) right(clip_pocket_width/2 + clip_pocket_chamfer) cuboid([5, 2, ratchet_height], anchor=LEFT+BOTTOM, chamfer=0.8, edges=[FRONT+TOP,BACK+TOP]);
            position(TOP) left(clip_pocket_width/2 + clip_pocket_chamfer) cuboid([5, 2, ratchet_height], anchor=RIGHT+BOTTOM, chamfer=0.8, edges=[FRONT+TOP,BACK+TOP]);
            position(BOTTOM) xcopies(n=2, l=dist_between_grabbers) ycopies(n=2, l=25) screw_hole("M2", head="flat", l=12, anchor=TOP, orient=DOWN);
        }
    }
}

module grabber_arm()
{
    diff()
    {
        cuboid([grabber_thickness, plate_size[1], 22], anchor=BOTTOM, rounding=2, edges=[TOP+FRONT, TOP+BACK]) {
            tag("remove") position(BOTTOM) up(ratchet_height) cuboid([grabber_thickness+0.1, light_diam, light_diam], rounding=light_diam/2, except=[LEFT,RIGHT], anchor=BOTTOM);
            ycopies(n=2, l=25) position(BOTTOM) screw_hole("M2", l=10, anchor=TOP, orient=DOWN, teardrop=true, spin=90) position(TOP) down(4) nut_trap_side(10, spin=90);
        }
    }
}
// up(plate_size[2]/2) right(dist_between_grabbers/2)
// grabber_arm();
mount();
