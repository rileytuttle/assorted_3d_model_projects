include <BOSL2/std.scad>
include <BOSL2/threading.scad>
include <BOSL2/screws.scad>

$fn=50;

maglite_inner_tube_diam = 34;
bat_27650_diam = 27;
washer_diam = 23;
washer_thickness = 2;
screw_type = "1/4-20";
adjust_screw_length = 10;
bat_18650_diam = 19;

module outer_adapter()
{
    diff() {
        cyl(d=maglite_inner_tube_diam, l=160, anchor=BOTTOM) {
            tag("remove") position(TOP) cyl(d=bat_27650_diam, l=145, anchor=TOP)
                position(BOTTOM) screw_hole(screw_type, l=15, thread=true, anchor=TOP);
            tag("remove") position(BOTTOM) cyl(d=washer_diam, l=washer_thickness, anchor=BOTTOM);
            tag("remove") position(TOP) threaded_rod(pitch = 2, d=bat_27650_diam+1.6, l=5, starts=3, internal=true, anchor=TOP);
        }
    }
}

module inner_adapter()
{
    diff() {
        up(15)
        cyl(d=bat_27650_diam-0.5, l=150, anchor=BOTTOM) {
            position(TOP) cyl(d=maglite_inner_tube_diam, l=5, anchor=TOP)
            position(BOTTOM) threaded_rod(pitch = 2, d=bat_27650_diam+1.25, l=5, starts=3, anchor=TOP);
            tag("remove") position(TOP) cyl(d=bat_18650_diam, l=150, anchor=TOP);
        }
    }
}

// outer_adapter();
inner_adapter();
