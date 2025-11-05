include <openscad-library-manager/BOSL2/std.scad>
include <openscad-library-manager/BOSL2/screws.scad>

$fn=50;

stand_diam = 20;
adapter_thickness = 4;
adapter_grab_height = 25;

module adapter()
{
    on_top_extra = 12;
    chamfer_dist = 0;
    diff() {
        cyl(d=stand_diam+adapter_thickness*2, l=adapter_grab_height+adapter_thickness) {
            position(TOP) cyl(d=stand_diam+adapter_thickness*2, anchor=BOTTOM, l=on_top_extra, chamfer2=chamfer_dist);
            position(BOTTOM) tag("remove") cyl(d=stand_diam, l=adapter_grab_height, anchor=BOTTOM)
            position(TOP) tag("remove") screw_hole("1/4", l=20, anchor=BOTTOM)
            position(BOTTOM) nut_trap_inline(6, anchor=BOTTOM);
            tag("remove") position(TOP+FRONT) down(7.5+adapter_thickness) teardrop(d=4.25, l=adapter_thickness+1, anchor=FRONT, orient=DOWN);
        }
    }
}

adapter();
