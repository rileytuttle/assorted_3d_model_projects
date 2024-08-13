include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

$fn=50;

path = turtle([
    "setdir", 90,
    "ymove", 36,
    "arcleft", 37, 53.5163,
    "setdir", -90,
    "ymove", -10.8545,
    "setdir", -(90-40.6572),
    "arcright", 29, 40.6572,
    "ymove", -36,
    "setdir", 0,
    "xmove", 8,
    ]);

// rpath = round_corners(path, radius=2);

// stroke(right(37, rpath), width=1);
// rotate_extrude(angle=250)
// turtle([
//     "setdir", 90,
//     "ymove", 36,
//     "arcright", 37, 53.5163,
//     "setdir", -90,
//     "ymove", -10.8545,
//     "setdir", -(90 + 40.6572),
//     "arcleft", 29, 40.6572,
//     "ymove", -36,
//     "setdir", 180,
//     "xmove", -8,
//     ]);

// yrot(180)
diff() {
    rotate_sweep(right(37, path), 250, spin=-250/2 + 90);
    back(37 + 1)
        cube([30, 5 , 35], anchor=BOTTOM+BACK) {
            // position(FRONT)
            // back(1)
            // tag("remove") cyl(r=29, l=35, anchor=BACK);
            position(BACK)
            fwd(5)
            yrot(-5)
            tag("remove")
            xcopies(n=2, l=18)
            zcopies(n=2, l=20)
            screw_hole("M4", l=10, head="socket", thread=false, anchor="head_bot", orient=FRONT)
            position("head_bot")
            cyl(d=7.5, l=10, anchor=BOTTOM);
        }
}
