`timescale 1ns / 1ps

module clkconvertertest;

	// Inputs
	reg clock1;
	reg reset;
	
	// Outputs
	wire clock2;
	
	// Instantiate the Unit Under Test (UUT)
	clkconverter uut (
		.clock1(clock1), 
		.reset(reset), 
		.clock2(clock2)
	);

	// Initialize the inputs
	initial begin
	clock1 = 0;
	reset = 1;

	#100;
	reset = 0;
	end
	
	always begin
	#10
	clock1 = ~clock1;
	end       
endmodule


