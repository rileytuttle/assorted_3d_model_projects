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

module make_base() {
    diff(remove = "mount-threads hook-hole")
    cuboid([top_width, hole_section_height, bracket_thickness], anchor=BACK+LEFT, rounding=5, teardrop=true, edges=[LEFT+BACK, BACK+RIGHT]) {
        union() {
            position(FRONT) cuboid([top_width, available_gap, bracket_thickness], anchor=BACK, rounding=5, teardrop=true, edges=[FRONT+LEFT]) {
                position(FRONT+RIGHT) cuboid([holder_width, holder_height, bracket_thickness], anchor=FRONT+LEFT, rounding=5, teardrop=true, edges=[FRONT+RIGHT, BACK+RIGHT]);
                position(FRONT+RIGHT)
                translate([0,holder_height,0])
                fillet(l=bracket_thickness, r=5);
            }
        }
        tag("mount-threads") {
            for (i = [-1, 1]) {
                position(CENTER) translate([i*top_width/4, 0, 0]) threaded_rod(d=5/16 * INCH, height=bracket_thickness, pitch=1 * INCH /18);
            }
        }
        tag("hook-hole") {
            position(CENTER)
            translate([0, -30, 0])
            slot(d=20, spread=20, height=bracket_thickness, spin=90, round_radius=7);
        }
    }
}

make_base();

// try to add squares to path then use path_collinear_merge to eliminate unnecessary points. the path can then be rounded and offset swept to create something with fillets where I want them

// path = [
//     [0,0],
//     [top_width, 0],
//     [top_width, -hole_section_height],
//     [top_width, -available_gap - hole_section_height],
//     [top_width+holder_width, -available_gap -hole_section_height],
//     [top_width+holder_width, -available_gap -hole_section_height - holder_height],
//     [0, -available_gap -hole_section_height - holder_height],
// ];
// merged_path = path_merge_collinear(path);
// // stroke(merged_path, closed=true);

// rpath = round_corners(merged_path, joint=[10,10,5,10,10,10], closed = true);
// // polygon(rpath);
// linear_extrude(rpath, 
                  
// the above kind of works but I found the fillet command and will probably use that
