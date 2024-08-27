include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <base-holder.scad>

$fn = 50;
screw_profile = "M4";
screw_head = "flat"; // [flat, socket]
screw_dist = 30;

diff() {
    holder(add_pokeout=true) {
        tag("remove")
        position("screw-center")
        zcopies(n=2, l=screw_dist)
        screw_hole(screw_profile, head=screw_head, l=20, orient=BACK, anchor=TOP, teardrop=true, spin=180);
    }
}
