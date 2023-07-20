include <./Parameters.scad>;

translate([0,0,100]) FastPart();

module FastPart()
translate([0,0,T/2])
{
    Crown();
    Sun();
	for(i=[1:m]) Planet(i);   
    
    //for(a=[0,90,180,270]) FasteningHoles(a);  
}




module Crown()
{
    translate([0,0,-T/2]) ExternalCrownAndLongBoxRounded();
    difference()
    {
		cylinder(r=D/2,h=T,center=true,$fn=100);
		herringbone(nr,pitch,P,DR,-adjustment,helix_angle,T+0.2);
        
		difference()
        {
			translate([0,-D/2,0]) rotate([90,0,0]) monogram(h=10);
			cylinder(r=D/2-0.25,h=T+2,center=true,$fn=100);
		}                 
	}

}

module ExternalCrownAndLongBoxRounded()
{
    //https://learn.cadhub.xyz/docs/definitive-beginners/adding-fillets
    difference()
    {
        linear_extrude(T){
            offset(4)offset(-8)offset(4){
                square([dsWidth,dsDepth/3],center=true);
                circle(r=D/2,$fn=100);   
            }
        }
        translate([0,0,T/2]) cylinder(r=D/2-tinny,h=T+tinny,center=true,$fn=100);
    }
}

module FasteningHoles(angle)
{
    rotate ([0,0,angle+45]) translate ([42,0,0]) difference () 
    {
         cylinder (h = T, r=5, center = true, $fn=100);
         cylinder (h = T+2, r=2, center = true, $fn=100);
    }
}



module Planet(i)
{
    rotate([0,0,i*360/m+phi])
        translate([pitchD/2*(ns+np)/nr,0,0])
            rotate([0,0,i*ns/m*360/np-phi*(ns+np)/np-phi]) 
                herringbone(np,pitch,P,DR,tol,helix_angle,T,true);
}


module Sun()
{
    difference()
    {
		mirror([0,1,0])	
            herringbone(ns,pitch,P,DR,tol,helix_angle,T,false,true);
		translate([0,0,-T+12+12+1]) 
            cylinder(r=w/sqrt(3),h=12,center=true,$fn=6);
	}
}






module monogram(h)
{
    linear_extrude(height=h,center=true)
    translate(-[3,2.5])union()
    {
        difference()
        {
            square([4,5]);
            translate([1,1])square([2,3]);
        }
        square([6,1]);
        translate([0,2])square([2,1]);
    }
}

module herringbone(number_of_teeth,circular_pitch,pressure_angle,depth_ratio,clearance,helix_angle,gear_thickness,satelliteHolder=false,planetaryDrive=false)
{
    union()
    {
        gear(number_of_teeth,circular_pitch,pressure_angle,depth_ratio,clearance,helix_angle,gear_thickness/2);
        mirror([0,0,1]) 
            gear(number_of_teeth,circular_pitch,pressure_angle,depth_ratio,clearance,helix_angle,gear_thickness/2);
    }
    
    if(satelliteHolder) 
        translate ([0,0,-gear_thickness/2-bbT/2-bbIDWH]) 
            cylinder (h=bbT, r=bbID/2 - adjustment, $fn=50, center=true); 
    if(satelliteHolder) 
        translate ([0,0,-gear_thickness/2-bbIDWH/2]) 
            cylinder (h=bbIDWH, r=bbIR/2 - adjustment, $fn=50, center=true);
        
    if(planetaryDrive) 
        translate ([0,0,-gear_thickness/2-bbIDWH/2]) 
            cylinder (h=bbIDWH, r=tbbED/2, $fn=50, center=true);
    if(planetaryDrive) 
        translate ([0,0,-gear_thickness/2-tbbT/2-bbIDWH]) 
            cylinder (h=tbbT, r=tbbID/2 - adjustment, $fn=50,center=true);
}

module gear (number_of_teeth,circular_pitch,pressure_angle,depth_ratio,clearance,helix_angle,gear_thickness,flat=false)
{
    pitch_radius = number_of_teeth*circular_pitch/(2*PI);
    twist=tan(helix_angle)*gear_thickness/pitch_radius*180/PI;
    
    flat_extrude(h=gear_thickness,twist=twist,flat=flat)
        gear2D(number_of_teeth, circular_pitch, pressure_angle, depth_ratio, clearance);
    
}

module flat_extrude(h,twist,flat)
{
	if(flat==false) linear_extrude(height=h,twist=twist,slices=twist/6)children(0);
	else children(0);
}

module gear2D (number_of_teeth,circular_pitch,pressure_angle,depth_ratio,clearance)
{
    pitch_radius = number_of_teeth*circular_pitch/(2*PI);
    base_radius = pitch_radius*cos(pressure_angle);
    depth=circular_pitch/(2*tan(pressure_angle));
    outer_radius = clearance<0 ? pitch_radius+depth/2-clearance : pitch_radius+depth/2;
    root_radius1 = pitch_radius-depth/2-clearance/2;
    root_radius = (clearance<0 && root_radius1<base_radius) ? base_radius : root_radius1;
    backlash_angle = clearance/(pitch_radius*cos(pressure_angle)) * 180 / PI;
    half_thick_angle = 90/number_of_teeth - backlash_angle/2;
    pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
    pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
    min_radius = max (base_radius,root_radius);
    
    intersection()
    {
        rotate(90/number_of_teeth) 
            circle($fn=number_of_teeth*3,r=pitch_radius+depth_ratio*circular_pitch/2-clearance/2);
        union()
        {
            rotate(90/number_of_teeth) 
                circle($fn=number_of_teeth*2,r=max(root_radius,pitch_radius-depth_ratio*circular_pitch/2-clearance/2));
            for (i = [1:number_of_teeth])rotate(i*360/number_of_teeth)
            {
                halftooth(pitch_angle,base_radius,min_radius,outer_radius, half_thick_angle);		
                mirror([0,1]) 
                    halftooth (pitch_angle,base_radius,min_radius,outer_radius,half_thick_angle);
            }
        }
    }
}

module halftooth (pitch_angle,base_radius,min_radius,outer_radius,half_thick_angle)
{
    index=[0,1,2,3,4,5];
    start_angle = max(involute_intersect_angle (base_radius, min_radius)-5,0);
    stop_angle = involute_intersect_angle (base_radius, outer_radius);
    angle=index*(stop_angle-start_angle)/index[len(index)-1];
    p=[[0,0],
        involute(base_radius,angle[0]+start_angle),
        involute(base_radius,angle[1]+start_angle),
        involute(base_radius,angle[2]+start_angle),
        involute(base_radius,angle[3]+start_angle),
        involute(base_radius,angle[4]+start_angle),
        involute(base_radius,angle[5]+start_angle)];
    
    difference()
    {
        rotate(-pitch_angle-half_thick_angle)polygon(points=p);
        square(2*outer_radius);
    }
}

// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from it's center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle (base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / PI;

// Calculate the involute position for a given base radius and involute angle.

function involute (base_radius, involute_angle) =
[
	base_radius*(cos (involute_angle) + involute_angle*PI/180*sin (involute_angle)),
	base_radius*(sin (involute_angle) - involute_angle*PI/180*cos (involute_angle))
];
