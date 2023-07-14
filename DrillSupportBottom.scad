include <./Parameters.scad>;


translate([0,0,-dsHighBottom/2])
    DrillSupportBottom();

module DrillSupportBottom()
union()
{
    difference()
    {
        translate([0,0,dsHighBottom]) cube([dsWidth,dsDepth,dsHighBottom],center=true);
        translate([0,0,dsHighBottom]) cube([dsWidth - 2*dsTickness,dsDepth,dsHighBottom],center=true);
        translate([0,dsDepth/3,dsHighBottom]) cube([dsWidth,dsDepth/3,dsHighBottom],center=true);
        translate([0,-dsDepth/3,dsHighBottom]) cube([dsWidth,dsDepth/3,dsHighBottom],center=true);
        FixingDrillSupportParts(2*dsTickness);
    }
    difference()
    {
        cube([dsWidth,dsDepth,dsHighBottom],center=true);
        cylinder(r=HoleDiameterForThreadedRod/2, h=dsHighBottom, center=true);
        translate([0,0,-dsHighBottom/2]) cylinder(r=HoleDiameterForBearingBallPlate/2, h=BearingBallPlateHight, center=true);
        FixingHoles();        
    }
}

module FixingHoles()
{
    translate([-40,-20,0]) cylinder(r=FixingHolesDiameter/2, h=dsHighBottom, center=true);
    translate([-40,20,0]) cylinder(r=FixingHolesDiameter/2, h=dsHighBottom, center=true);
    translate([40,-20,0]) cylinder(r=FixingHolesDiameter/2, h=dsHighBottom, center=true);
    translate([40,20,0]) cylinder(r=FixingHolesDiameter/2, h=dsHighBottom, center=true);
}
