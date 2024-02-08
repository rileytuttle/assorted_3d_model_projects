include <BOSL2/std.scad>
include <BOSL2/screws.scad>

diff() {
    flask_width = 84;
    flask_height = 27.5;
    dist_between_rails = 90+45;
    width_of_holder = 125;
    cube([width_of_holder, flask_height+2, 10], anchor=CENTER+BOTTOM) {
        tag("remove")
        position(FRONT)
        cube([flask_width, flask_height, 11], anchor=FRONT);
        for (loc = [[LEFT,RIGHT],[RIGHT,LEFT]]) {
            position(loc[0]+FRONT)
            cube([10, 10, 10], anchor=loc[1]+FRONT);
        }
        xcopies(l=dist_between_rails, n=2) {
            position(FRONT)
            tag("remove")
            screw_hole("1/4-20", length=11, orient=BACK, thread=true, anchor=BOTTOM);
        }
        // xcopies(l=(width_of_holder+flask_width)/2, n=2) {
        //     tag("remove")
        //     cube([12, 20, 11], anchor=CENTER);
        // }
    }
}
