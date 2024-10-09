include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;

lcd_screw_hole_dist = 135;
enclosure_hole_dist = 120;
drop_down = 27;

module drop_down_bracket()
{
    diff() {
        cuboid([145, 10, 4], rounding=2, edges=[BACK+LEFT, BACK+RIGHT]) {
            for (loc=[LEFT, RIGHT])
            {
                position(FRONT+loc) cuboid([20, drop_down, 4], anchor=BACK+loc, rounding=2, edges=[FRONT+LEFT, FRONT+RIGHT]);
            }
            xcopies(n=2, l=lcd_screw_hole_dist) {
                fwd(5) position(BACK) screw_hole("M3", l=4, thread=true);
            }
            fwd(drop_down) xcopies(n=2, l=enclosure_hole_dist) {
                screw_hole("M3", l=4, thread=true);
            }
            fwd(9) xcopies(n=2, l=enclosure_hole_dist) {
                screw_hole("M3", l=4, thread=true);
            }
            fwd(-1) xcopies(n=2, l=enclosure_hole_dist) {
                screw_hole("M3", l=4, thread=true);
            }
            
            //     position(FRONT) cuboid([20, 20, 4], anchor=BACK, rounding=2, edges=[FRONT+LEFT, FRONT+RIGHT]) {
            //         back(5) position(FRONT) screw_hole("M3", l=4, thread=true);
            //     }
            // }
            // xcopies(n=2, l=lcd_screw_hole_dist) screw_hole("M3", l=4, thread=true);
        }
    }
}

drop_down_bracket();
