include <BOSL2/std.scad>
include <BOSL2/threading.scad>
// see https://www.printables.com/model/461256-shopvac-50mm-camlock-connectors-with-magnetic-catc/files
$fn=50;

module camlock_male_end(anchor=BOTTOM, orient=UP, spin=0)
{
    outer_r = 24.5;
    inner_r = 20;
    main_h = 35;
    bottom_chamf = 1.6;
    attachable(size=[outer_r, outer_r, main_h+3], anchor=anchor, orient=orient, spin=spin) {
        up((main_h + 3)/2)
        zflip()
        diff() {
            cyl(r=outer_r, l=main_h, anchor=BOTTOM, chamfer1=bottom_chamf) {
                position(TOP) cyl(r=outer_r+2, l=3, chamfer1=2, anchor=BOTTOM);
                tag("remove") position(BOTTOM) cyl(r=inner_r, l=main_h+3, anchor=BOTTOM);
                down(20) position(TOP) tag("remove") torus(r_maj=27.25, r_min=5.1);
            }
        }
        children();
    }
}

module hose_threads()
{
}

// camlock_male_end();
// hose_threads();

// Parameters for the thread (based on approximations)
major_diameter = 50.8;  // Approx. 2 inches (major diameter of the thread)
pitch = INCH / 2.75;            // Approximate pitch (coarse thread)
length = 30;            // Length of the thread section

ball_arc=180;
small_ball_diam = pitch/2;
// big_ball_diam = small_ball_diam * 1.5;
big_ball_diam = pitch/2;
big = big_ball_diam/pitch;
small = small_ball_diam/pitch;
n=10;

function my_thread_profile() =
    [
        each arc(n=n, d=big, cp=[-(big + small)/2, -small/2], start=270, angle=ball_arc/2),
        each arc(n=n, d=small, cp=[0, -small/2], start=180, angle=-ball_arc),
        each arc(n=n, d=big, cp=[(big + small)/2, -small/2], start=180, angle=ball_arc/2),
    ];

// generic_threaded_rod(d=major_diameter, l=30, pitch=pitch, profile=my_thread_profile(), spin=0, anchor=TOP);

