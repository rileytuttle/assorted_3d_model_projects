include <BOSL2/std.scad>
include <skadis/skadis.scad>

$fn=50;
h = 20;
wall_thickness = 2;
cutoutd=15;
cutout_depth=30;
cutout_h_gap = 0;
diff() {
    cuboid([100+wall_thickness*2, 55+wall_thickness+5, h+wall_thickness+0.1], anchor=CENTER, rounding=2, except=[BOTTOM]) {
        up(0.1) fwd(5) position(BACK+TOP) tag("remove") cuboid([100, 55, h], anchor=BACK+TOP);
        down(13) position(BACK+TOP) xcopies(n=2, spacing=40) tslot_seat(orient=FRONT);
        position(TOP) tag("remove") cuboid([120, cutout_depth, cutoutd], anchor=TOP, rounding=-cutoutd, edges=[TOP+FRONT, TOP+BACK]) {
            if (cutout_h_gap > 0)
            {
                position(BOTTOM) tag("remove") cuboid([120, cutout_depth, cutout_h_gap], anchor=TOP);
            }
            down(cutout_h_gap) position(BOTTOM) tag("remove") cuboid([120, cutout_depth, cutoutd], anchor=TOP, rounding=cutoutd, edges=[BOTTOM+FRONT, BOTTOM+BACK]);
        }
    }
}
