include <rosetta-stone/hinges.scad>

union() {

hinge_fin(
angle_per_fin=10,
cut_depth=30,
height_of_cut=3,
top_length_of_fin=2,
minimum_gap=0.4,
fudge_factor=0.001,
spin=0,
orient=[0, 0, 1],
anchor=[0, 0, 0]);

translate([0, 5, 0]) hinge_fin(
angle_per_fin=10,
cut_depth=30,
height_of_cut=3,
top_length_of_fin=2,
minimum_gap=0.4,
fudge_factor=0.001,
spin=20,
orient=[0, 0, 1],
anchor=[0, 0, 0]);

}