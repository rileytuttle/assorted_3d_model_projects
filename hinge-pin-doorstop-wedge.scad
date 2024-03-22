include <BOSL2/std.scad>

$fn=50;

slice_ang = 20;
length_after = 40;
height_mid = 13;
length_before = height_mid / (2 * tan(slice_ang/2));
pie_slice_r = length_before + length_after;

difference() {
    union() {
        // left(length_before)
        intersection() {
            // pie_slice(ang=slice_ang, l=15, r=pie_slice_r, spin=-slice_ang/2);
            cube([40, 20, 15], anchor=BOTTOM+LEFT);

            // right(length_before)
            // cube([length_after, 100, 15], anchor=LEFT+BOTTOM);
        }
        cyl(d=height_mid, l=15, anchor=BOTTOM);
    }
    cyl(d=6.75, l=6.5, anchor=BOTTOM)
        position(TOP)
        cyl(d=11, l=20, anchor=BOTTOM) {
            angle = 200;
            position(BOTTOM+RIGHT)
            pie_slice(ang=angle, r=20, l=20, anchor=BOTTOM, spin=(-(angle-180)/2)+90);
            // position(BOTTOM+RIGHT)
            // cube([20, 20, 20], anchor=BOTTOM+RIGHT);
        }
        // #cube([10, 10, 10], anchor=RIGHT);
}
