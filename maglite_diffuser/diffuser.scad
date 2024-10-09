include <BOSL2/std.scad>
include <BOSL2/threading.scad>
include <BOSL2/structs.scad>

$fn=50;

flashlight_r = 20.875;
thread_d = 53;
thread_pitch = 2;
thread_l = 5;
thread_starts = 4;

module retainer_bump()
{
    tag_scope()
    intersect() {
        cyl(r1=31.5, r2=31.75, l=42)
        tag("intersect") position(TOP) down(20) torus(r_maj=59, d_min=63, anchor=CENTER);
    }
}

module diffuser()
{
    diff(){
        sphere(r=31.5) {
            up(5) position(BOTTOM) cyl(r=flashlight_r+10, l=30, anchor=BOTTOM)
            {
                tag("remove") position(BOTTOM)
                threaded_rod(
                    d=thread_d,
                    l=thread_l,
                    pitch=thread_pitch,
                    starts=thread_starts,
                    anchor=BOTTOM, internal=true);
            }
            cyl(r1=31.5, r2=31.75, l=42, anchor=BOTTOM)
                tag("remove") cyl(r1=28.5, r2=28.75, l=42, chamfer2=-1);
            tag("remove") sphere(r=28.5);
            position(BOTTOM) tag("remove") cyl(r=flashlight_r, l=100, anchor=BOTTOM, chamfer1=-2);
        }
    }
}

module diffuser_lid()
{
    bottom_thickness=1.5; 
    diff() {
        cyl(r=flashlight_r+10, l=10, anchor=BOTTOM, chamfer1=2) {
            position(TOP) threaded_rod(d=thread_d, l=thread_l, pitch=thread_pitch, starts=thread_starts, anchor=BOTTOM);
            up(bottom_thickness) position(BOTTOM) tag("remove") cyl(r=flashlight_r, l=10+5-bottom_thickness, anchor=BOTTOM, chamfer2=-2, rounding1=2);
        }
    }
}

module diffuser_stand()
{
    diff() {
        cyl(r=flashlight_r+10, l=6, anchor=BOTTOM) {
            position(BOTTOM) tag("remove") threaded_rod(d=thread_d, l=thread_l, pitch=thread_pitch, starts=thread_starts, anchor=BOTTOM, internal=true, $slop=0.05);
            position(TOP) threaded_rod(d=thread_d, l=thread_l, pitch=thread_pitch, starts=thread_starts, anchor=BOTTOM);
            position(BOTTOM) tag("remove") cyl(r=flashlight_r, l=6+5, anchor=BOTTOM, chamfer2=-1);
        }
    }
}

// diffuser();
// diffuser_lid();
diffuser_stand();

// retainer_bump();
