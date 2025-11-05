include <openscad-library-manager/BOSL2/std.scad>
include <openscad-library-manager/BOSL2/screws.scad>

$fn=50;



module camera_adapter_plate()
{
    diff() {
        cyl(d=70, l=10) {
            tag("remove") zrot_copies(n=3, r=30) screw_hole("M3", l=10) position(BOTTOM) nut_trap_inline(3, anchor=BOTTOM);
            position(TOP) tag("remove") screw_hole("1/4", l=10, head="hex", anchor=TOP);
        }
    }
    
}

module camera_adapter_plate2()
{
    diff(){
        cyl(d=70, l=6.5) {
            position(TOP) tag("remove") zrot_copies(n=3, r=29) screw_hole("M3", l=6.5, anchor=TOP) position(TOP) down(3) nut_trap_inline(10, anchor=TOP);
            position(TOP) screw_hole("1/4", l=6.5, thread=true, anchor=TOP);
        }
    }
    
}

camera_adapter_plate2();
