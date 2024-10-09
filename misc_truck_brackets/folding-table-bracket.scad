include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/rounding.scad>
include <rosetta-stone/std.scad>

top_width=50;
hole_section_height=30;
table_width=57;
available_gap=80;
holder_height = available_gap - table_width;
holder_width = 50;
bracket_thickness = 15;
slot_rounding = 7;
nut_trap_l = 7;
screw_type = "5/16"; //["5/16", "1/4"]
$fn=10;

module make_base(bracket_thickness=15, slot_rounding=7, screw_type=screw_type) {
    diff(remove = "mount-threads hook-hole")
    cuboid([top_width, hole_section_height, bracket_thickness], anchor=BACK+LEFT, rounding=5, teardrop=true, edges=[LEFT+BACK, BACK+RIGHT]) {
        union() {
            position(FRONT) cuboid([top_width, available_gap, bracket_thickness], anchor=BACK, rounding=5, teardrop=true, edges=[FRONT+LEFT]) {
                tag("hook-hole") {
                    position(FRONT+LEFT)
                    translate([10, 10, 0])
                    slot(d=20, spread=50-20, h=bracket_thickness, spin=90, round_radius=slot_rounding, anchor=BACK+LEFT);
                }
                position(FRONT+RIGHT) cuboid([holder_width, holder_height, bracket_thickness], anchor=FRONT+LEFT, rounding=5, teardrop=true, edges=[FRONT+RIGHT, BACK+RIGHT]);
                position(FRONT+RIGHT)
                translate([0,holder_height,0])
                fillet(l=bracket_thickness, r=5);
            }
        }
        tag("mount-threads") {
            xcopies(n=2, l=2 * top_width/4)  {
                screw_hole(screw_type, l=bracket_thickness)
                position(TOP) nut_trap_inline(nut_trap_l, screw_type, anchor=TOP);
            }
        }
    }
}

make_base(bracket_thickness, slot_rounding, screw_type);
