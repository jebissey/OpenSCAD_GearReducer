include <./Parameters.scad>;


translate([0,0,-dsHighBottom/2])
    DrillSupportBottom();

module DrillSupportBottom()
union()
{
    difference()
    {
        translate([0,0,dsHighBottom*5/2]) cube([dsWidth,dsDepth,dsHighBottom*4],center=true);
        translate([0,0,dsHighBottom*5/2]) cube([dsWidth - 2*dsTickness,dsDepth,dsHighBottom*4],center=true);
        translate([0,dsDepth/3,dsHighBottom*5/2]) cube([dsWidth,dsDepth/3,dsHighBottom*4],center=true);
        translate([0,-dsDepth/3,dsHighBottom*5/2]) cube([dsWidth,dsDepth/3,dsHighBottom*4],center=true);
        FixingDrillSupportParts(2*dsTickness-10);
        FixingDrillSupportParts(3*dsTickness-10);
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
