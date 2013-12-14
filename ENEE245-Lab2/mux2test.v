`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:30:57 10/21/2013
// Design Name:   mux21
// Module Name:   C:/Users/etaylor5/Desktop/New folder/mux21_top/mux2test.v
// Project Name:  mux21_top
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux21
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mux2test;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;
	reg s;

	// Outputs
	wire [3:0] z;

	// Instantiate the Unit Under Test (UUT)
	mux21 uut (
		.a(a), 
		.b(b), 
		.s(s), 
		.z(z)
	);
	
	// Initialize Inputs
	initial begin
	a = 0;
	b = 1;
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

