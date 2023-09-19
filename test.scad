use <threads-scad/threads.scad>

diameter = 6;
length = 20;
tolerance = 0.4;

MetricBolt(diameter, length);

translate([20, 0, 0])
ScrewThread(diameter, length, tolerance=tolerance,
    tip_height=ThreadPitch(diameter), tip_min_fract=0.75);