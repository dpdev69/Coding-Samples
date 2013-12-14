`timescale 1ns / 1ps

module mux41casetest;

	// Inputs
	reg [3:0] a;
	reg [1:0] s;

	// Outputs
	wire z;

	// Instantiate the Unit Under Test (UUT)
	mux41case uut (
		.a(a), 
		.s(s), 
		.z(z)
	);

	initial begin
		// Initialize Inputs
		a = 1;
		s = 1;

		#100;
  		s = 0;
		
		#100
		s = 2;
	
		#100
		a = 0;
		s = 3;
	end
endmodule

