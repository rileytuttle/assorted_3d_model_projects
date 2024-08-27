include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

$fn=50;

sweep_rot = 250;
flash_light_bulb_r = 29;
flash_light_straight_l = 36;
flash_light_shaft_d = 45;
holder_thickness = 5;

module flashlight_model(anchor=CENTER, orient=UP, spin=0)
{
    attachable(anchor=anchor, orient=orient, spin=spin) {
        cyl(r=flash_light_bulb_r, l=flash_light_straight_l, anchor=BOTTOM, rounding1=-2) {
            position(TOP)
            top_half()
            sphere(r=flash_light_bulb_r);
            position(BOTTOM)
            cyl(d=flash_light_shaft_d, l=200, anchor=BOTTOM);
        }
        children();
    }
}

// make the holder using constructive solid geometry principles
module csg_holder()
{
    diff() {
        cyl(r=flash_light_bulb_r+holder_thickness, l=flash_light_straight_l, anchor=BOTTOM) {
            position(TOP)
            top_half()
            sphere(r=flash_light_bulb_r+holder_thickness);
            tag("remove")
            position(BOTTOM)
            flashlight_model();
            position(BOTTOM)
            back(flash_light_bulb_r+holder_thickness + 4)
            cube([30, 8 , 35], anchor=BOTTOM+BACK) {
                position(BACK)
                fwd(5)
                yrot(-5)
                tag("remove")
                xcopies(n=2, l=18)
                zcopies(n=2, l=20)
                screw_hole("M4", l=10, head="socket", thread=false, anchor="head_bot", orient=FRONT, teardrop=true, spin=-5, counterbore=10);
            }
            position(BOTTOM)
            tag("remove") pie_slice(ang=360-sweep_rot, r=flash_light_bulb_r+holder_thickness+1, l=100, anchor=BOTTOM, spin=90 + sweep_rot/2);
        }
    }
}

csg_holder();
// flashlight_model();
