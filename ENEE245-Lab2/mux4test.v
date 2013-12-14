// Verilog test fixture created from schematic C:\Users\etaylor5\Desktop\New folder\mux21_top\mux41.sch - Mon Oct 21 01:16:51 2013

`timescale 1ns / 1ps

module mux41_mux41_sch_tb();

// Inputs
   reg [3:0] a;
   reg [3:0] b;
   reg [3:0] c;
   reg [3:0] d;
   reg s1;
   reg s2;

// Output
   wire [3:0] z;

// Bidirs

// Instantiate the UUT
   mux41 UUT (
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.z(z), 
		.s1(s1), 
		.s2(s2)
   );
	
// Initialize Inputs
	initial begin
		a = 1;
		b = 0;
		c = 0;
		d = 1;
		s1 = 0;
		s2 = 0;
		
		#100;
		
		s1 = 1;
		s2 = 1;
		
		#100;
		
		s1 = 0;
		s2 = 1;
		
		#100;
		
		s1 = 1;
		s2 = 1;
		
		#100
		
		s1 = 1;
		s2 = 0;
		
				
		#100;
		
		s1 = 1;
		s2 = 1;
		
		#100;
		
		s1 = 0;
		s2 = 1;
	end
endmodule
