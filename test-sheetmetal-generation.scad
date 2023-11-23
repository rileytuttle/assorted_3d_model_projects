include <BOSL2/std.scad>
include <rosetta-stone/sheet-metal.scad>


translate([0, 0, 0]) rotate([0, 0, 0]) translate([0, 0, 0]) rotate([0, 0, 0]) cube([100, 100, 5], anchor=CENTER) {
position([1, 0, 0]) translate([0, 0, 0]) rotate([0, 0, 0]) sheetmetal_bend(
metal_thickness=5,
ir=10,
ang=90,
edge_len=100,
bend=false,
spin=0,
orient=[0, 0, 1],
anchor="attach1");
}
