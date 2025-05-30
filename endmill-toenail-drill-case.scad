include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=100;

// shank_d = 3.3;
// shank_d = 4;
shank_d = 3.7;
case_d = 15;

module case_bottom()
{
    full_length = 30;
    threaded_length = 5;
    unthreaded_length = full_length - threaded_length;
    diff() {
        cyl(d=case_d, l=unthreaded_length, anchor=TOP, chamfer1=1) {
            position(TOP) screw("M10", l=threaded_length, head="none", anchor=BOTTOM)
            position(TOP) tag("remove") cyl(d=shank_d, l=28, anchor=TOP, chamfer2=-1);
        }
    }
}

module case_cap()
{
    diff() {
        cyl(d=case_d , l=20, anchor=BOTTOM, chamfer2=1) {
            position(BOTTOM) screw_hole("M10", l=5, anchor=BOTTOM, thread=true, spin=180, $slop=0.1);
            position(BOTTOM) up(5) tag("remove") cyl(d=shank_d, l=13, anchor=BOTTOM, chamfer1=-1);
        }
    }
}

case_bottom();
// case_cap();
