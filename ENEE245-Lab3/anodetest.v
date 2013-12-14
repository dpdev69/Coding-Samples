`timescale 1ns / 1ps

module anodetest;

	// Inputs
	reg c;
	reg clock;
	reg reset;

	// Outputs
	wire output1;
	wire output2;
	wire a;
	wire q;

	// Instantiate the Unit Under Test (UUT)
	anode uut (
		.c(c), 
		.clock(clock), 
		.reset(reset), 
		.output1(output1), 
		.output2(output2), 
		.a(a), 
		.q(q)
	);

	initial begin
		// Initialize Inputs
		c = 1;
		clock = 0;
		reset = 1;

		#100;
		reset = 0;
	end
		
	always begin
		#10
		clock = ~clock;
	end 
endmodule
