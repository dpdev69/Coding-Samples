`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:03:19 11/07/2013
// Design Name:   booth_multiplier
// Module Name:   C:/Users/etaylor5/New folder/lab09/booth_multiplier_test.v
// Project Name:  lab09
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: booth_multiplier
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module booth_multiplier_test;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;

	// Outputs
	wire [7:0] product;

	// Instantiate the Unit Under Test (UUT)
	booth_multiplier uut (
		.product(product), 
		.a(a), 
		.b(b)
	);
	
	integer i = 0;
	initial begin
		// Initialize Inputs
		a = 0000;
		b = 0000;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		for (i = 0; i < 16; i = i + 1)
		begin
			a = i;
			b = i;
			#10 $display("a b = %b %b", a, b);
		end
	end
endmodule

