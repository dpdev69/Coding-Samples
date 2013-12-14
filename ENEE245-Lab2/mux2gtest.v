`timescale 1ns / 1ps

module mux2gtest;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;
	reg s;

	// Outputs
	wire [3:0] z;

	// Instantiate the Unit Under Test (UUT)
	mux2g uut (
		.a(a), 
		.b(b), 
		.s(s), 
		.z(z)
	);

	// Initialize Outputs
		initial begin
			a = 1;
			b = 0;
			s = 0;
	
			#100;
	
			s = 1;
	
			#100;
	
			s = 0;
	
			#100;
	
			s = 1;
	
			#100;
	
			s = 0;
	
			#100;
	
			s = 1;
		end
endmodule

