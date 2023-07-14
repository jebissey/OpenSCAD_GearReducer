// Planetary gear bearing (customizable)

// outer diameter of ring
D=80;

// thickness
T=20;

//Ball Bearing
bbT=7;      // thickness
bbED=22;    // external diameter
bbID=8;     // internal diameter
bbIR=12;    // internal ring
bbIDWH=1; // internal disk washer high

//Thrust Ball Bearing
tbbT=7;      // thickness
tbbED=16;    // external diameter
tbbID=8;     // internal diameter

SlowPartHigh=38;
slowPartSmallDiameter=30;
lhhW=17; // large hexagonal hole Width
lhhH=10; // large hexagonal hole High

//Drill Support
dsHighTop=200;
dsWidth=200;
dsTickness=50;
dsDepth= 70;
dsHole=43;

dsHighBottom=50;
HoleDiameterForThreadedRod=14;
HoleDiameterForBearingBallPlate=34;
BearingBallPlateHight=5;
FixingHolesDiameter=5.5;

// clearance
tol=0.15;

number_of_planets=4;
number_of_teeth_on_planets=15;
approximate_number_of_teeth_on_sun=10;

// pressure angle
P=45;//[30:60]

// number of teeth to twist across
nTwist=1;

// width of little hexagonal hole
w=6.7;

DR=0.5*1;// maximum depth ratio of teeth

m=round(number_of_planets);
np=round(number_of_teeth_on_planets);
ns1=approximate_number_of_teeth_on_sun;
k1=round(2/m*(ns1+np));
k= k1*m%2!=0 ? k1+1 : k1;
ns=k*m/2-np;
nr=ns+2*np;
pitchD=0.9*D/(1+min(PI/(2*nr*tan(P)),PI*DR/nr));
pitch=pitchD*PI/nr;
helix_angle=atan(2*nTwist*pitch/T);
phi=$t*360/m;

echo("ns=",ns);
echo("pitch =",pitch);
echo("helix_angle=",helix_angle);


module FixingDrillSupportParts(location)
{
    rotate([90,0,0]) 
        translate([0, location,  0]) 
    {
        translate([-((dsWidth - 2*dsTickness)+((dsWidth - 2*dsTickness)/2))/2,-dsTickness,0]) 
            cylinder(r=FixingHolesDiameter/2, h=dsDepth, center=true);
        translate([+((dsWidth - 2*dsTickness)+((dsWidth - 2*dsTickness)/2))/2,-dsTickness,0]) 
            cylinder(r=FixingHolesDiameter/2, h=dsDepth, center=true);
    }
}