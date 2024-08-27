include <BOSL2/std.scad>
include <BOSL2/screws.scad>

module holder(add_pokeout=false, orient=UP, anchor=CENTER, spin=0)
{
    attachable(anchor=anchor, orient=orient, spin=spin, anchors=[named_anchor("screw-center", [0, 9.8, 15+30/2])])
    {
        difference() {
            union() {
                left(125)
                fwd(95)
                back(0.15)
                import("dewalt-battery-holder-base.stl", convexity=3);
                up(20 + 30/2)
                cube([10, 9.8, 40], anchor=FRONT);
                left(19)
                up(5)
                cube([15, 5, 20], anchor=BOTTOM+FRONT);
                back(4)
                up(78)
                wedge([23.7, 5, 12], anchor=FRONT+TOP);
            }
            back(4.8)
            up(57.25)
            cube([23.65, 8, 7], anchor=BOTTOM+FRONT) {
                if (add_pokeout) {
                    xcopies(n=2, l=10)
                    teardrop(d=3, l=30);
                }
            }
        }
        children();
    }
}
