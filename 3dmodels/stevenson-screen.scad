use <threads.scad>

$fn=25;

//Inputs
height=70;
layer_count=7;
internal_radius=30;
rim_taper=5;
wall_thickness=2;
connector_height=2;
facets=18;
interior_angle = 360 / facets;

/*
//Base
translate([(3*internal_radius),0,0])
difference(){
AugerThread((2*internal_radius)-(2*wall_thickness), (2*internal_radius)-(4*wall_thickness), height / layer_count, 7, tooth_angle=30, tolerance=0.4, tip_height=0, tip_min_fract=0);
    translate([0,0,-1])
        cube([2*wall_thickness,8*wall_thickness,4*wall_thickness], center = true);

}*/
//Body

//Negative thread
AugerHole((2*internal_radius)-(2*wall_thickness), (2*internal_radius)-(4*wall_thickness), height / layer_count, 7, position=[0,0,0], rotation=[0,0,0], tooth_angle=30, tolerance=0.4)
cylinder(h=height / layer_count,r1=internal_radius,r2=internal_radius,$fn=facets);


//body
translate([0,0,height / layer_count])
for (i = [0:layer_count-2])
    {
        translate([0,0,(height / layer_count) * (i+1)])
        difference(){
            connector();
            cutouts();
        }
    }

//body
translate([0,0,height / layer_count])
for (i = [0:layer_count-1])
    {
        //stuff
        translate([0,0,(height / layer_count) * (i)])
        ring_cut();
    }
    
//roof
translate([0,0,(height/layer_count)+height])
    difference(){
    cylinder(h=wall_thickness,r1=internal_radius - rim_taper,r2=internal_radius - rim_taper,$fn=facets);

    //roof text
        translate([0,0,-0.5])
    linear_extrude(wall_thickness+1)
    text("Bedroom",8,halign = "center", valign = "center");
    }
//modules

module ring_cut(){
difference(){
 ring_outer();
 ring_inner();
}
}

module ring_outer()
{
    //Outer top straight ring
    translate([0,0,height / layer_count/3*2])
    cylinder(h=height / layer_count / 3,r1=internal_radius - rim_taper,r2=internal_radius - rim_taper,$fn=facets);
    //Outer middle angled ring
    translate([0,0,(height / layer_count / 3)])
    cylinder(h=height / layer_count / 3,r1=internal_radius,r2=internal_radius - rim_taper,$fn=facets);
    //Outer bottom straight ring
    cylinder(h=height / layer_count / 3,r1=internal_radius,r2=internal_radius,$fn=facets);
     

}


module ring_inner(){
    translate([0,0,0])
{
    //inner top straight ring
    translate([0,0,(height / layer_count/3*2)-1])
    cylinder(h=(height / layer_count / 3)+2,r1=internal_radius - wall_thickness - rim_taper,r2=internal_radius - wall_thickness - rim_taper,$fn=facets);
    
    //inner middle angled ring
    translate([0,0,(height / layer_count / 3)])
    cylinder(h=height / layer_count / 3,r1=internal_radius - wall_thickness,r2=internal_radius - wall_thickness - rim_taper,$fn=facets);
    
    //inner bottom straight ring
    translate([0,0,-1])
    cylinder(h=(height / layer_count / 3)+1.001,r1=internal_radius - wall_thickness,r2=internal_radius - wall_thickness,$fn=facets);
}}


module connector(){
difference(){
//Outer cylinder
cylinder(h=height / layer_count,r1=internal_radius - rim_taper,r2=internal_radius - rim_taper,$fn=facets);
//Inner cylinder
    translate([0,0,-2])
cylinder(height / layer_count + 4,internal_radius - rim_taper - wall_thickness,internal_radius - rim_taper- wall_thickness,$fn=facets);
}}

module cutouts(){
    translate([0,0,-1])
for (f = [0:2:facets])
    //stuffs
linear_extrude((height / layer_count)+2)
    polygon([
    [0,0],
    [((internal_radius - rim_taper+1) * cos (interior_angle * f)),((internal_radius - rim_taper+1) * sin (interior_angle * f) )],
    [((internal_radius - rim_taper+1) * cos (interior_angle * (f+1))),((internal_radius - rim_taper+1) * sin (interior_angle * (f+1)) )]
]);
    ;
}
