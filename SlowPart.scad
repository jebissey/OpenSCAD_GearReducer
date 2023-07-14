include <./Parameters.scad>;

translate([0,0,60]) SlowPart();

module SlowPart()
difference()
{
    SlowPartBody();
    ThinChuckHole();
    LargeChuckHole();
    for(i=[1:m]) BallBearingHole(i);  
    ThrustBallBearingHole();
}
module SlowPartBody()
{
    union()
    {
        translate([0,0,SlowPartHigh/2]) 
            cylinder(r=D/2, h=bbT, center=true, $fn=50);
        cylinder($fa=12, $fs=2, h=SlowPartHigh-bbT, r1=slowPartSmallDiameter/2, r2=D/2, center=true, $fn=50);
    }
}
module BallBearingHole(i)
{
    translate([0,0,+SlowPartHigh/2])
        rotate([0,0,i*360/m+phi]) 
            translate([pitchD/2*(ns+np)/nr,0,0])
                cylinder(r=bbED/2 + tol, h=bbT, center=true, $fn=50);
}
module ThinChuckHole() 
    translate([0,0,+bbT/2]) 
        cylinder(r=w/sqrt(3), h=SlowPartHigh, center=true, $fn=6);

module LargeChuckHole() 
    translate([0,0,-SlowPartHigh/2 + bbT/2]) 
        cylinder(r=lhhW/sqrt(3), h=lhhH, $fn=6);

module ThrustBallBearingHole() 
    translate([0,0,SlowPartHigh/2 - tbbT/2]) 
        cylinder(r=tbbED/2 + tol, h=tbbT, $fn=50);  

