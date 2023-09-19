include <BOSL2/std.scad>
include <BOSL2/threading.scad>
include <BOSL2/rounding.scad>
include <rosetta-stone/std.scad>

top_width=50;
hole_section_height=30;
table_width=57;
available_gap=80;
holder_height = available_gap - table_width;
holder_width = 50;
bracket_thickness = 15;
$fn=10;

diff(remove = "mount-threads hook-hole")
#cuboid([top_width, hole_section_height, bracket_thickness], anchor=BACK+LEFT, rounding=5, teardrop=true, edges=[LEFT+BACK, BACK+RIGHT]) {
    position(FRONT) cuboid([top_width, available_gap, bracket_thickness], anchor=BACK, rounding=5, teardrop=true, edges=[FRONT+LEFT]) {
        position(FRONT+RIGHT) cuboid([holder_width, holder_height, bracket_thickness], anchor=FRONT+LEFT, rounding=5, teardrop=true, edges=[FRONT+RIGHT, BACK+RIGHT]);
    }
    tag("mount-threads") {
        for (i = [-1, 1]) {
            position(CENTER) translate([i*top_width/4, 0, 0]) threaded_rod(d=5/16 * INCH, height=bracket_thickness, pitch=1 * INCH /18);
        }
    }
    tag("hook-hole")
        position(CENTER)
        translate([0, -30, 0])
        slot(d=20, spread=20, height=bracket_thickness, spin=90, round_radius=5);
}

// try to add squares to path then use path_collinear_merge to eliminate unnecessary points. the path can then be rounded and offset swept to create something with fillets where I want them

