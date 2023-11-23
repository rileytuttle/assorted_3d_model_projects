include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/std.scad>

$fn=30;

difference() {
import("Airtag_V2.stl");

// translate([33.325, 1, 2.625])
// // translate([1.3 * INCH, 0, 1/8 * INCH])
// rotate([90, 0, 0])
// screw_hole("M3x0.5", thread=true, length=6);

// translate([33.325, -7, 2.625])
// rotate([90, 0, 0])
// #screw_hole("M3x0.5", thread=false, length=6);

translate([33.325, 3.5, 2.625])
rotate([90, 0, 0])
nut_trap_inline(spec="M3x0.5", l=2);
}
