include <BOSL2/std.scad>

$fn=50;


module washer() {
    diff() {
        cyl(d=23, l=3) {
            tag("remove") cyl(d=14, l=3);
        }
    }
}

module sleeve() {
    diff() 
    {
        cyl(d=20, l=4, anchor=BOTTOM) {
            position(BOTTOM) cyl(d=13, l=30, anchor=BOTTOM);
            #tag("remove") position(BOTTOM) cyl(d=10, l=30, anchor=BOTTOM);
        }
    }
}

sleeve();
