// XT60/90 panel mount
// by Albert P
// Last updated: Jan 16, 2018

// Change number of faces
$fn = 100;

/// XT60 Dimensions
tol= 0.2;
xt60_height = 15.6 + tol;
xt60_width = 7.8 + tol;
xt60_length = 16.4 + tol;

xt90_height= 21.4 + tol;
xt90_width = 10.7 + tol;
xt90_length = 21.3 + tol;


// Choose part here
part = "xt90"; // "xt60" "xt90"

if (part == "xt60")
{
    
    xt_panel_mount(xt60_height, xt60_width, xt60_length);
    
}
else if (part == "xt90")
{
    xt_panel_mount(xt90_height,xt90_width,xt90_length);
}

module xt_panel_mount(xt_height, xt_width, xt_length, panel_thickness = 2, body_thickness = 4, panel_diameter = 12)
{
    // body_diameter is diameter larger than the main body for the panel front
    m3_diameter = 3.5;
    bolt_diameter = m3_diameter;    // Size of panel mounting screw
    lip_length = 8;
    lip_thickness = 1.5;
    difference()
    {
        union()
        {
            // Panel Circle
            cylinder(d = xt_height + body_thickness + panel_diameter, h = panel_thickness);
            // Main body
            cylinder(d = xt_height + body_thickness, h = xt_length + lip_thickness);
            
            
       }
       // XT cutouts
       translate([0,0,xt_length/2 - 0.1])
       
       // TEMP change to thing after
       %cube([xt_height,xt_width, xt_length], center = true);
       // Cutting out extra space for loose fit
       translate([0,0,xt_length/2 - 7.5])
       cube([xt_height + 1,xt_width + 1, xt_length], center = true);
       // cut out
       cube([xt_height, xt_width, xt_length *5],center = true);

      
       // Panel Screw cutouts
       for(x = [-1:1])  // mirrors cutout
       {
       translate([0,x *(xt_height + body_thickness + panel_diameter/2)/2,-0.1])
       cylinder(d = m3_diameter, h = body_thickness);
       }
    }
    // Lip for XT cutout
    difference()
    {
        translate([0,0,xt_length + lip_thickness/2])
        {
        cube([lip_length, xt_width, lip_thickness], center = true);
        

        }
        translate([0,0,xt_length + lip_thickness/2])
        cube([xt_height, xt_width-lip_thickness, lip_thickness +0.1], center = true);
       
    }
    
    echo("Body Drill Size = ",xt_height + body_thickness, "mm ", (xt_height + body_thickness )/25.4, "in");
}