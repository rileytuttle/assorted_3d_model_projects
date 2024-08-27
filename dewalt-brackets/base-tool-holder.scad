include <BOSL2/std.scad>
include <rosetta-stone/std.scad>

$fn=50;

module tool_holder(anchor=CENTER, orient=UP, spin=0)
{
    size = [1.975 * INCH, 0.46 * INCH, 2.64 * INCH];
    echo(str("size is ", size));
    attachable(anchor=anchor, orient=orient, spin=spin, size=size)
    {
        union() {
            down(size[2]/2)
            left(size[0]/2)
            back(size[1]/2)
            xrot(90)
            scale(INCH)
            back(1.14)
            left(0.635)
            up(0.29)
            import("dewalt-tool-holder-base.stl");
            move_copies([
                [27.5/2, 0, -23.5],
                [-27.5/2, 0, -23.5],
                [0, 0, 11.5]
            ])
            orient(BACK)
            cyl(d=10, l=size[1]);
        }
        children();
    }
    // #cube(size, anchor=BACK+LEFT+BOTTOM);
}

tool_holder();
