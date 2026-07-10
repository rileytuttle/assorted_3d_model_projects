include <../openscad-library-manager/BOSL2/std.scad>
include <../openscad-library-manager/rosetta-stone/std.scad>
include <../openscad-library-manager/BOSL2/screws.scad>
// include <socket-set-common-parts.scad>

$fn=50;

// quarter_inch_clip_path = turtle([
//     "xmove", 6.12702,
//     "setdir", 180,
//     "arcleft", 5.75403/2, 117.008,
//     "arcright", 4, 117.008 * 2,
//     "arcleft", 5.75403/2, 117.008,
//     "jump", [0, 0],
// ]);
// clip_dist = 33.5;
// quarter_inch_clip_info = [quarter_inch_clip_path, [16, 8, 12], clip_dist];

base_size = [70, 90, 20];
bit_holder = [10, 55, 15];
needle_diam_skinny = 2.1;
needle_diam_thick = 8;
needle_length=30;
ratchet_hole_diam = 12.4;
hex_bit_diam = 7.1;
extension_thick_diam = 10.2;
key_shaft_size = [2.9, 23, 7];
key_fob_size = [6.25, 20, 16];
schrader_diam = 7.7;
braze_on_dist = 2.5 * INCH;
shift_key_amount = 19;
bit_dist = 15;


module top() {
  edge_thickness = 2.5;
  diff() {
    cuboid([70+2*edge_thickness, 33+edge_thickness*2, 114+edge_thickness], rounding=3, except=[FRONT, BACK], orient=DOWN, teardrop=true) {
      tag("remove") position(BACK+TOP+LEFT) right(edge_thickness) fwd(edge_thickness) down(edge_thickness) cuboid([30, 33, 120], anchor=BACK+TOP+LEFT);
      tag("remove") position(BACK+TOP+RIGHT) left(edge_thickness) fwd(edge_thickness) down(edge_thickness) cuboid([70, 20, 120], anchor=BACK+TOP+RIGHT);
      tag("remove") position(BACK+TOP) down(25) cuboid([70-20, 10, 120], anchor=BACK+TOP);
    }
  }
}

module holder()
{
    diff() {
        cuboid(base_size, rounding=3, except=[TOP, BOTTOM]) {
            #tag("remove") left(2) position(RIGHT) teardrop(d=ratchet_hole_diam, l=base_size[1], anchor=RIGHT, ang=50, cap_h=(ratchet_hole_diam/2)+1)
                left(18) position(FRONT) teardrop(d=hex_bit_diam, anchor=FRONT, l=50) {
                    position(BACK) teardrop(d=extension_thick_diam, l=50, anchor=FRONT);
                }
            #tag("remove") left(shift_key_amount) back(3) position(FRONT+TOP) xcopies(n=2, l=bit_dist) cuboid(bit_holder, anchor=FRONT+TOP);
            #tag("remove") left(5) position(BACK)
            #teardrop(d=needle_diam_skinny, l=needle_length, anchor=BACK);
            #tag("remove") left(shift_key_amount) position(BACK) cuboid(key_fob_size, anchor=BACK)
            #position(FRONT) cuboid(key_shaft_size, anchor=BACK);
            #tag("remove") right(6) fwd(6) position(TOP+LEFT+BACK) cyl(d=schrader_diam, l=10, anchor=TOP);
            #tag("remove") position(BACK+TOP) fwd(20) left(shift_key_amount + bit_dist/2) cyl(d=hex_bit_diam, l=14, anchor=TOP, chamfer2=-1);
            #tag("remove") up(4) position(BOTTOM) ycopies(n=2, l=braze_on_dist) screw_hole("M5", l=10, counterbore=20, head="socket", anchor="shaft_top");
        }
    }
}

// left_half(200)
// back(14)
// up(7.5)
top();
// holder();
