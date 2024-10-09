include <BOSL2/std.scad>
include <skadis/skadis.scad>

module nitecore_mount()
{
    intersection() {
        import("nitecore-base-mount.stl");
        back(7) #cube([100, 50, 200], anchor=BOTTOM);
    }
}

nitecore_mount();
