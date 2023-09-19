include <BOSL2/std.scad>
include <BOSL2/threading.scad>

top_width=50;
hole_section_height=30;
table_width=57;
available_gap=80;
holder_height = available_gap - table_width;
holder_width = 50;
bracket_thickness = 15;

diff(remove = "mount-threads hook-hole")
cube([top_width, hole_section_height, bracket_thickness], anchor=BACK+LEFT) {
    position(FRONT) cube([top_width, available_gap, bracket_thickness], anchor=BACK) {
        position(FRONT+RIGHT) cube([holder_width, holder_height, bracket_thickness], anchor=FRONT+LEFT);
    }
    tag("mount-threads") {
        for (i = [-1, 1]) {
            position(CENTER) translate([i*top_width/4, 0, 0]) threaded_rod(d=5/16 * INCH, height=bracket_thickness, pitch=1 * INCH /18);
        }
    }
    tag("hook-hole") position(LEFT) translate([5,-30,0]) cyl(l=bracket_thickness, d=20, rounding =-5, teardrop=true, anchor=LEFT);
}
