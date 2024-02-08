include <BOSL2/std.scad>
include <rosetta-stone/std.scad>

$fn=50;

pencil_thickness = 2.2;
teardrop_ang = 55;
lead_thickness = 0.9;
lead_cutout_thickness = lead_thickness+0.2;
magnet_d=4.1;
magnet_thickness = 2;
small_mag_d = 3.1;
small_mag_thickness = 1;
pusher_d = 0.55;

module magnet_cutout() {
    attachable() {
        union() {
            cyl(d=small_mag_d, l=small_mag_thickness, anchor=TOP);
            intersection() {
                cyl(d=small_mag_d, l=10);
                cube([small_mag_d, 1, 10], anchor=CENTER);
            }
        }
        children();
    }
}

module get_cutout() {
    difference() {
        fwd(50)
        square([0.5 * INCH, 35], anchor=CENTER+FRONT);
        intersection() {
            projection(cut=false) {
                import("mechpencilv4.stl", convexity=3);
            }
            fwd(50)
            square([0.5 * INCH, 35], anchor=CENTER+FRONT);
        }
    }
}

module modified_cutout() {
    // first half
    difference() {
        get_cutout();
        fwd(44)
        square([15, 5], anchor=BACK);
    }
    // second half
    fwd(3)
    intersection() {
        get_cutout();
        fwd(44)
        square([15, 5], anchor=BACK);
    }
    fwd(43)
    left(0.3)
    square([0.22465, 5], anchor=BACK+LEFT);
}

module pencil_body() {
    difference() {
        union() {
            difference() {
                intersection() {
                    diff() {
                        cuboid([0.5 * INCH, 100, pencil_thickness], anchor=CENTER, chamfer=0.5) {
                        tag("remove")
                        left(3) {
                            fwd(20)
                            ycopies(n=5, l=20) {
                                position(TOP)
                                down(0.2)
                                magnet_cutout();
                                // cyl(d=small_mag_d, l=small_mag_thickness, anchor=TOP);
                                // intersection() {
                                //     cyl(d=small_mag_d, l=10);
                                //     cube([small_mag_d, 1, 10], anchor=CENTER);
                                // }
                            }
                        }
                        tag("remove")
                        back(45)
                        xcopies(n=2, l=6)
                        {
                            position(TOP)
                            down(0.2)
                            magnet_cutout();
                        }
                        }
                    }
                    fwd(50)
                    cyl(d1=0.5*INCH, d2=0, h=10, orient=FRONT, anchor=TOP)
                        position(BOTTOM)
                        cube([0.5*INCH, pencil_thickness, 200], anchor=TOP);
                }
                back(15)
                down(5)
                linear_extrude(10)
                modified_cutout();
                fwd(50)
                // first part of led cutout
                teardrop(d=lead_cutout_thickness, l=16, anchor=FRONT, ang=teardrop_ang) {
                    // middle part of led cutout
                    position(BACK)
                    back(7)
                    teardrop(d=lead_cutout_thickness, l=200, anchor=FRONT, ang=teardrop_ang)
                        tag("remove")
                        position(CENTER)
                        cube([pusher_d,200,5], anchor=BOTTOM);
                    position(BACK)
                    diff() {
                        teardrop(d=lead_cutout_thickness, l=7, anchor=FRONT, ang=teardrop_ang)
                            tag("remove")
                            left(0.2)
                            cube([lead_cutout_thickness, 7, 5], anchor=LEFT);
                    }
                }
                
            }
            // fwd(50)
            // back(19)
            // back(0.563)
            // left(0.2)
            // right(0.1)
            // #cube([3, 3.005, pencil_thickness], anchor=FRONT+LEFT);
        }
        fwd(27)
        // up(10)
        zrot(-2)
        cyl(d=0.9, l=7, anchor=BOTTOM, orient=FRONT);

        if (false) {
            fwd(30.5) {
                left(3) 
                cyl(d=magnet_d, l=magnet_thickness)
                    intersection() {
                        cube([magnet_d, 1.5, 10], anchor=CENTER);
                        cyl(d=magnet_d, l=10);
                    }
                right(2.5)
                cyl(d=magnet_d, l=magnet_thickness)
                    intersection() {
                        cube([magnet_d, 1.5, 10], anchor=CENTER);
                        cyl(d=magnet_d, l=10);
                    }
            }
        }
    }
}
module slide() {
    attachable(){
        zflip()
        up((pencil_thickness-1.5)/2)
        diff() {
            cuboid([0.5*INCH + 2*2, 10, pencil_thickness + 1.5]) {
                position(TOP)
                tag("remove")
                cuboid([0.5*INCH+0.25, 11, pencil_thickness], anchor=TOP);
                xcopies(n=2, l=6)
                down((pencil_thickness-1.5)/2)
                down(0.2)
                tag("remove")
                magnet_cutout();
                tag("remove")
                position(BACK+BOTTOM)
                up(0.4)
                xrot(90-5)
                up(0.5)
                cube([pusher_d, pusher_d, 16.5], anchor=BOTTOM, spin=45);
            }
        }
        children();
    }
}

// modified_cutout();

// pencil_body();
// up(pencil_thickness/2)
color_this("tomato") slide();


// import("mechpencilv4.stl", convexity=3);
// up(0.25/2 * INCH)
// #teardrop(d=1.1, l=200);

