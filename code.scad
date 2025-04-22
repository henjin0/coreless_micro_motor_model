// 1200r/min DC Motor Model (ZWPD006006-26)
// Based on specifications from diagram

// Main dimensions
motor_body_diameter = 6;  // 6mm body diameter
total_length = 16.35;  // Total length as specified (L=16.35mm)
shaft_diameter = 2;  // 2mm shaft diameter
shaft_length = 3.6;  // 3.6mm shaft length
motor_body_length = total_length - shaft_length;  // Body length = Total length - shaft length
terminal_width = 0.5;  // Width of the terminals (estimated)
terminal_length = 6;  // Length of the terminals (estimated)

// Render settings
$fn = 50;  // Smoothness of curved surfaces

// Main motor body
module motor_body() {
    // Main cylindrical body
    color([0.8, 0.8, 0.8])
    cylinder(d=motor_body_diameter, h=motor_body_length);
    
    // Back cap with wire terminals
    translate([0, 0, motor_body_length]) {
        color([0.3, 0.3, 0.3])
        cylinder(d=motor_body_diameter, h=1);
        
        // Terminals (wires)
        color([0.9, 0, 0])  // Red wire
        translate([-1.5, 0, 0.5])
        cylinder(d=0.5, h=terminal_length);
        
        color([0, 0, 0])  // Black wire
        translate([1.5, 0, 0.5])
        cylinder(d=0.5, h=terminal_length);
    }
}

// Motor shaft with precise D-cut and flange
module motor_shaft() {
    color([0.7, 0.7, 0.7]) {
        // Shaft with D-cut
        translate([0, 0, -shaft_length]) {
            difference() {
                // Basic shaft cylinder
                cylinder(d=shaft_diameter, h=shaft_length);
                
                // D-cut on the shaft (flat side)
                // For a 2mm shaft with 0.5mm depth cut
                translate([shaft_diameter/2 +0.5, 0, 0])
                cube([shaft_diameter, shaft_diameter, shaft_length/2], center=true);
            }
        }
        
        // Flange/collar at the base of the shaft
        translate([0, 0, -0.5])
        cylinder(d=3.5, h=0.5); // A small flange with diameter 3.5mm
    }
}

// Complete motor assembly
module dc_motor() {
    motor_body();
    motor_shaft();
}

// Render the motor
dc_motor();



// Add dimensions for reference
color([0, 0, 0])
translate([-15, 0, 0])
text("Ø6mm", size=1.5);

color([0, 0, 0])
translate([0, -15, -shaft_length/2])
text("Ø2mm", size=1.5);

color([0, 0, 0])
translate([10, 0, motor_body_length/2])
text("L=16.35mm", size=1.5);