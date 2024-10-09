include <BOSL2/std.scad>
include <BOSL2/threading.scad>
include <BOSL2/screws.scad>

$fn=50;

pvc_od = 21.5;
flange_d = 80;
spool_lip_d = 53;
spool_lip_l = 6;
bearing_od = 37.1;
bearing_l = 7;
bearing_id = 25;
spool_outside_to_outside = 65;
inner_threaded = true;
thread_d = 45;
thread_pitch = 1.1;
$slop = 0.1;
screw_profile = "M3";
// if it is possible to attach something like a drill to the adapter so we can not spin it manually
attachable = false;

attachable_r = (((flange_d+spool_lip_d)/2)-20)/2;
echo(str("attachable r=", attachable_r));

// inner_thread: if the threads on the end should be inner threads
// true if inner threads, false if outer threads
module spool_to_pvc(inner_thread = true, attachable=false) {
    diff() {
        cyl(d=flange_d, l=5, anchor=TOP) {
            position(TOP)
            cyl(d=spool_lip_d, l=spool_outside_to_outside/2, anchor=BOTTOM) {
                position(TOP)
                if (inner_thread)
                {
                    tag("remove")
                    threaded_rod(d=thread_d, l=3, pitch=thread_pitch, internal=true, anchor=TOP);
                } else {
                    threaded_rod(d=thread_d, l=3, pitch=thread_pitch, anchor=BOTTOM);
                }
            }
            chamfer_amount = 2;
            position(BOTTOM) tag("remove") cyl(d=bearing_od, l=chamfer_amount+bearing_l, anchor=BOTTOM, chamfer1=-chamfer_amount);
            position(BOTTOM) tag("remove")
            cyl(d=bearing_od-4, l=100, anchor=BOTTOM);
            
            if (attachable) {
                // nut trap for later to make a spool spinner
                zrot_copies(n=3, r=attachable_r) {
                    position(BOTTOM) screw_hole(screw_profile, thread=false, l=20, anchor=TOP, orient=DOWN);
                    up(0.001) position(TOP) nut_trap_side(20, screw_profile, anchor=TOP);
                }
            }
        }
    }
}

module bearing_to_pvc_spacer()
{
    spacer_l = bearing_l+5;
    diff() {
        cyl(d=bearing_id+0.5, l=spacer_l, chamfer2=0.5) {
            position(BOTTOM)
            cyl(d=28, l=2, anchor=BOTTOM);
            tag("remove") cyl(d=pvc_od, l=spacer_l);
        }
    }
}

// think about doing a magnetic driver adapter that can just snap on/off
module spool_driver_adapter()
{
    meat_h = 8;
    bit_d = 0.25 * INCH + 0.1;
    meat_width = 20;
    arm_thickness = 3;
    arm_width = meat_width -5;
    arm_standoff_h = 12;
    diff() {
        cyl(d=meat_width, l=meat_h, anchor=BOTTOM) {
            tag("remove") cube([bit_d, bit_d, meat_h+0.1], anchor=CENTER);
            position(BOTTOM) up(4) tag("remove") zrot_copies(n=4, r=bit_d/2)
            sphere(d=3);
            position(BOTTOM)
            zrot_copies(n=3) {
                cube([attachable_r, arm_width, arm_thickness], anchor=LEFT+BOTTOM) {
                    position(RIGHT)
                    cyl(d=arm_width, l=arm_thickness) {
                        position(BOTTOM) cyl(d=7, l=arm_standoff_h, anchor=BOTTOM);
                        position(BOTTOM)
                        screw_hole(screw_profile, l=arm_standoff_h + 1, anchor=BOTTOM);
                    }
                }
            }
        }
    }
}

// back_half()
spool_to_pvc(inner_threaded, attachable);
// up(spool_outside_to_outside)
// yrot(180)
// #spool_to_pvc(!inner_threaded);
// left(50)
// cube([10, 10, spool_outside_to_outside], anchor=BOTTOM);
// bearing_to_pvc_spacer();
// back_half()
// spool_driver_adapter();
