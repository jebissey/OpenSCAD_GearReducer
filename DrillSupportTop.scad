include <./Parameters.scad>;


translate([0,0,dsHighTop/2])    DrillSupportTop();

module DrillSupportTop()
difference()
{
    cube([dsWidth,dsDepth,dsHighTop],center=true);
    translate([0,0,-dsTickness/2]) cube([dsWidth, dsDepth/3 + 0.5,        dsHighTop-dsTickness],center=true);
    translate([0,0,-dsTickness/2]) cube([dsWidth - 2*dsTickness, dsDepth, dsHighTop-dsTickness],center=true);
    cylinder(r=dsHole/2 + tol*4, h=dsHighTop, center=true);
    FixingDrillSupportParts(-dsTickness/2);
}
