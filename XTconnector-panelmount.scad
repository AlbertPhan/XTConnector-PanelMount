/*  XT60/90 panel mount
    by Albert P
    Last updated: Jan 23, 2018
    
    This allows an xt connector (60 or 90 series) to be glued or/and pressfit into this panel mount and then be panel mounted into a panel.

*/

include <MCAD/boxes.scad>   // rounded box
// Change number of faces
$fn = 100;


//******************************************* 
//Choose part here
//*******************************************
part = "xt60";          // "xt60" "xt90"
tol = -0.2;             // Set the tolerance for a tighter or looser fit. Set negative values (~-0.2)for a press fit
flush = false;          // Sets connector to be flush with panel but that leaves little space for gripping the mating connector. Set false for connector to protrude but give more space for gripping the mating connector.

//******************************************* 
// END Choose part
//*******************************************

// XT Dimensions

xt60_height = 15.6;
xt60_width = 7.9;
xt60_length = 16.4;

xt90_height= 20.9;
xt90_width = 9.95;
xt90_length = 21.3;

xt60_protrude_length = 6;
xt90_protrude_length = 10;

// !roundedBox([20,20,50],2,true);    //quick test

if (part == "xt60")
{
    xt60_panel_mount(tol,flush);
}
else if (part == "xt90")
{   
    xt90_panel_mount(tol,flush);
}


module xt60_panel_mount(tolerance, flush = true)
{
    protrude_length = flush == true ? 0:xt90_protrude_length;
    xt_panel_mount(xt60_height + tolerance, xt60_width + tolerance, xt60_length + tolerance - protrude_length);
}

module xt90_panel_mount(tolerance, flush = true)
{
    protrude_length = flush == true ? 0:xt90_protrude_length;
    xt_panel_mount(xt90_height + tolerance, xt90_width + tolerance, xt90_length + tolerance - protrude_length);
}

module xt_panel_mount(xt_height, xt_width, xt_length, panel_thickness = 2, body_thickness = 2, panel_width = 4)
{
    
    lip_length = 8;
    lip_thickness = 1.5;
    xt90_side_nib_length = 7.5;
    fillet_radius = 2;
    difference()
    {
        union()
        {
            // Panel Lip
            
            //cylinder(d = xt_height + body_thickness + panel_width, h = panel_thickness);
            translate([0,0,-panel_thickness/2])
            roundedBox([xt_height + body_thickness * 2 + panel_width * 2, xt_width + body_thickness * 2 + panel_width * 2, panel_thickness],fillet_radius, true);
            
            // Main body
            //cylinder(d = xt_height + body_thickness, h = xt_length + lip_thickness);
            translate([0,0,xt_length/2 + lip_thickness/2])
            cube([xt_height + body_thickness * 2, xt_width + body_thickness * 2, xt_length + lip_thickness],center = true);
            
       }
       // XT cutouts
       translate([0,0,xt_length/2 - 0.1])
       
       
       cube([xt_height,xt_width, xt_length], center = true);
       // Cutting out extra space for loose fit
       translate([0,0,xt_length/2 - 7.5])
       cube([xt_height + 1,xt_width + 1, xt_length], center = true);
       // All cutout
       cube([xt_height, xt_width, xt_length *5],center = true);
       // Cutout for xt90 slots on side
       translate([0,0,xt_length/2])
       cube([xt90_side_nib_length,xt_width + 1, xt_length- 0.01], center = true);

 
    }
    // Lip for XT cutout
    difference()
    {
        // Build Lip
        translate([0,0,xt_length + lip_thickness/2])
        {
        cube([lip_length, xt_width, lip_thickness], center = true);
        

        }
        // Cut lip
        translate([0,0,xt_length + lip_thickness/2])
        cube([xt_height, xt_width-lip_thickness, lip_thickness +0.1], center = true);
        

        
       
    }
    
    // Below was used for cylindrical panel mount
}