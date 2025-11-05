include <openscad-library-manager/BOSL2/std.scad>

$fn=50;

module adjuster()
{
    diff() {
        cuboid([35, 25, 5], rounding=2, except=[TOP, BOTTOM]) {
            ycopies(n=2, l=10) tag("remove") {
                cuboid([28, 4.5, 5.1], rounding=4.5/2, except=[TOP,BOTTOM]);
                #cuboid([28-4.5, 4.5, 5], chamfer=-1, edges=[TOP+FRONT, TOP+BACK, BOTTOM+FRONT, BOTTOM+BACK]);
            }
            position(BACK) tag("remove") cuboid([28-4.5, 4.5, 5], chamfer=-1, edges=[TOP+FRONT, TOP+BACK, BOTTOM+FRONT, BOTTOM+BACK], anchor=FRONT);
            position(FRONT) tag("remove") cuboid([28-4.5, 4.5, 5], chamfer=-1, edges=[TOP+FRONT, TOP+BACK, BOTTOM+FRONT, BOTTOM+BACK], anchor=BACK);
        }
    }
}

adjuster();
