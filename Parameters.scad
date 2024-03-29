// Planetary gear bearing (customizable)
tinny=0.005;

D=100;  // outer diameter of ring
T=20;   // thickness

//Ball Bearing
bbT=7;      // thickness
bbED=22;    // external diameter
bbID=8;     // internal diameter
bbIR=12;    // internal ring
bbIDWH=1;   // internal disk washer high

//Thrust Ball Bearing
tbbT=7;      // thickness
tbbED=16;    // external diameter
tbbID=8;     // internal diameter

SlowPartHigh=44;
slowPartSmallDiameter=30;
lhhW=17.2;  // large hexagonal hole Width
lhhH=10;    // large hexagonal hole High
shhW=6.6;   // small hexagonal hole Width

//Drill Support
dsHighTop=180;
dsWidth=200;
dsTickness=50;
dsDepth= 70;
dsHole=43;

dsHighBottom=25;
HoleDiameterForThreadedRod=14;
HoleDiameterForBearingBallPlate=34;
BearingBallPlateHight=5;
FixingHolesDiameter=5.5;

adjustment=0.5;
washers=1;

// clearance
tol=0.15;

number_of_planets=4;
number_of_teeth_on_planets=15;
approximate_number_of_teeth_on_sun=10;

// pressure angle
P=45;//[30:60]

nTwist=1;   // number of teeth to twist across
w=13;       // width of little hexagonal hole
wH=6;       // Height of little hexagonal hole
DR=0.5*1;   // maximum depth ratio of teeth

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