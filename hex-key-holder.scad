include <openscad-library-manager/BOSL2/std.scad>

module holder()
{
    cuboid([50, 20, 10], rounding=5, edges=[LEFT+FRONT, LEFT+BACK, RIGHT+FRONT, RIGHT+BACK]);
}
