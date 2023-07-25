
/* Case for USB-C to TTL Serial Adapter
 *
 * Design: @thomasflummer
 *
 * License: CC-BY-SA
 *
 */

module case(pcb_length, pcb_width, height, corner_radius)
{
    union()
    {
        difference()
        {
            union()
            {
                hull()
                {
                    for (x = [-1, 1])
                    {
                        for (y = [-1, 1])
                        {
                            translate([x*(pcb_length/2 - corner_radius), y*(pcb_width/2 - corner_radius), (height - corner_radius)/2])
                                cylinder(h = height - corner_radius, r = corner_radius, center = true, $fn = 50);

                            translate([x*(pcb_length/2 - corner_radius), y*(pcb_width/2 - corner_radius), (height - corner_radius)])
                                sphere(r = corner_radius, $fn = 50);
                        }
                    }
                }
            }
            union()
            {
                // main cutout
                hull()
                {
                    for (x = [-1, 1])
                    {
                        for (y = [-1, 1])
                        {
                            translate([x*(pcb_length/2 - corner_radius), y*(pcb_width/2 - corner_radius), (height - corner_radius)/2])
                                cylinder(h = height - corner_radius + 0.01, r = corner_radius - 1.2, center = true, $fn = 50);

                            translate([x*(pcb_length/2 - corner_radius), y*(pcb_width/2 - corner_radius), (height - corner_radius)])
                                sphere(r = corner_radius - 1.2, $fn = 50);
                        }
                    }
                }

                // USB connector cutout
                translate([-pcb_length/2, 0, 3.6/2])
                rotate(90, [0, 0, 1])
                rotate(90, [1, 0, 0])
                    hull()
                    {
                        for (x = [-1, 1])
                        {
                            for (y = [-1, 1])
                            {
                                translate([x*(9.4/2 - 1.5), y*(3.6/2 - 1.5), 0])
                                    cylinder(h = 10, r = 1.5, center = true, $fn = 50);
                            }
                        }
                    }

                translate([-pcb_length/2+10/2-0.2, 0, 0])
                    cube([10, 9.4, 3.6], center = true);

                // Activity LEDs
                
                translate([pcb_length/2-6, 2, 0])
                rotate(45, [0, 1, 0])
                    cube([5, 1.4, 20], center = true);

                translate([pcb_length/2-6, -2, 0])
                rotate(45, [0, 1, 0])
                    cube([5, 1.4, 20], center = true);

                // 12 pin female header
                translate([0, -pcb_width/2, 2.54/2])
                    cube([12*2.54+0.4, 5, 2.54+0.1], center = true);
                
                    
                // logo on the inside (for clear transparent)
                // translate([0, 0, height-3.3])
                // logo on the outside (for non-clear)
                translate([0, 0, height+2.5-0.3])
                linear_extrude(height = 5, center = true, scale=1)
                    import(file = "logo_simple.svg", center = true, dpi = 200);

                for (x = [-1, 1])
                {
                    for (y = [-1, 1])
                    {
                        translate([x*((pcb_length)/2 - corner_radius), y*((pcb_width)/2 - corner_radius), (height-1.2)/2])
                            cylinder(h = height-1.2, r = 1.5, center = true, $fn = 50);
                    }
                }
            }
        }
        difference()
        {
            intersection()
            {
                union()
                {
                    // main cutout
                    hull()
                    {
                        for (x = [-1, 1])
                        {
                            for (y = [-1, 1])
                            {
                                translate([x*(pcb_length/2 - corner_radius), y*(pcb_width/2 - corner_radius), (height - corner_radius)/2])
                                    cylinder(h = height - corner_radius + 0.01, r = corner_radius - 1, center = true, $fn = 50);

                                translate([x*(pcb_length/2 - corner_radius), y*(pcb_width/2 - corner_radius), (height - corner_radius)])
                                    sphere(r = corner_radius - 1, $fn = 50);
                            }
                        }
                    }
                }
                union()
                {
                    for (x = [-1, 1])
                    {
                        for (y = [-1, 1])
                        {
                            translate([x*((pcb_length)/2 - corner_radius), y*((pcb_width)/2 - corner_radius), (height)/2])
                                cylinder(h = height, r = corner_radius, center = true, $fn = 50);
                        }
                    }
                    
                    translate([pcb_length/2-6/2, 0, height/2])
                        cube([6, 1.2, height], center = true);
                }
            }
            union()
            {
                for (x = [-1, 1])
                {
                    for (y = [-1, 1])
                    {
                        translate([x*((pcb_length)/2 - corner_radius), y*((pcb_width)/2 - corner_radius), (height - 1.2)/2])
                            cylinder(h = height - 1.2 + 0.01, r = 1.5, center = true, $fn = 50);
                    }
                }
            }
        }
    }
}

module light_guide()
{
    difference()
    {
        union()
        {
            translate([-2.5, 0, -2.5])
            rotate(90, [1, 0, 0])
                cylinder(h = 2.5, r = 2.5, center = true, $fn = 50);
            
            translate([-2.5 - 2.5/2, 0, -2.5])
                cube([2.5, 2.5, 5], center = true);

            translate([-2.5, 0, -2.5 - 2.5/2])
                cube([5, 2.5, 2.5], center = true);
        }
        union()
        {
            translate([-2.5, 0, -2.5*2 - 3/2 + 0.8])
                cube([5.01, 2.51, 3], center = true);

            difference()
            {
                union()
                {
                    translate([-2.5, 0, -2.5])
                        cube([6, 6, 6], center = true);
                }
                union()
                {
                    translate([-2.5, 0, -2.5])
                    rotate(90, [1, 0, 0])
                        cylinder(h = 7, r = 2.5 - 1.2, center = true, $fn = 50);
                    
                    translate([-2.5 - 3/2, 0, -2.5-1.2])
                        cube([3, 2.5, 5], center = true);

                    translate([-2.5-1.2, 0, -2.5 - 3/2])
                        cube([5, 2.5, 3], center = true);                

                    translate([-6, 0, -5.5])
                    rotate(45, [0, 1, 0])
                        cube([5-0.2, 1.4-0.2, 20], center = true);
                
                }
            }
        }        
    }
}

case(40, 25, 5.5, 2.5);

//light_guide();

/*
translate([40/2, 2, 5.5])
    color("#eeeeee")
    light_guide();

translate([40/2, -2, 5.5])
    color("#eeeeee")
    light_guide();
*/

/*
difference()
{
    case(40, 25, 5.5, 2.5);
    translate([0, -25-(25/2)+2.5, 0])
        cube([50, 50, 50], center = true);
}
*/