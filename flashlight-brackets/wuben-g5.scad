include <../openscad-library-manager/BOSL2/std.scad>
include <../openscad-library-manager/BOSL2/screws.scad>
include <../openscad-library-manager/rosetta-stone/std.scad>

$fn=50;
light_size = [35, 13, 35];
rail_size = [24, 1.5, 1];
rail_offset = 3;
wall_thickness = 4;
bracket_base_size = [light_size[0] + wall_thickness, light_size[1] + wall_thickness*2+1, light_size[2] + wall_thickness];

module bracket()
{
    diff()
    {
        cuboid(bracket_base_size) {
        position(BOTTOM+RIGHT) up(wall_thickness) tag("remove") cuboid(light_size, anchor=BOTTOM+RIGHT) {
            position(BACK) screw_hole("1/4", head="flat", anchor=TOP, orient=FRONT, l=10, teardrop=true, spin=-90)
            position(TOP) cuboid([6, 20, 10], anchor=TOP+FRONT);
            tag("keep") position(BOTTOM+LEFT+FRONT) up(rail_offset) cuboid(rail_size, anchor=LEFT+FRONT, chamfer=0.5, edges=[RIGHT+TOP, RIGHT+BOTTOM]);
            tag("keep") position(BOTTOM+LEFT+BACK) up(rail_offset) cuboid(rail_size, anchor=LEFT+BACK, chamfer=0.5, edges=[RIGHT+TOP, RIGHT+BOTTOM]);
            tag("remove") position(BOTTOM+LEFT) right(15) cuboid([20, 5, 1.5], anchor=TOP);
            tag("remove") position(BOTTOM+LEFT) up(28) cuboid([2, 10, 10], anchor=RIGHT);
        }
        }
    }
}
bracket();
