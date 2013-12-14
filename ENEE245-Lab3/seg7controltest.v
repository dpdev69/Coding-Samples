`timescale 1ns / 1ps

module seg7controltest;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;
	reg [3:0] c;
	reg [3:0] d;
	reg [1:0] s;

	// Outputs
	wire [3:0] control;

	// Instantiate the Unit Under Test (UUT)
	seg7control uut (
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.s(s), 
		.control(control)
	);

	integer i = 0;
	initial begin
		// Initialize Inputs
		a = 1;
		b = 2;
		c = 4;
		d = 8;
		s = 0;

		#100;
        
		for(i = 0; i < 4; i = i + 1)
		begin
			s = i;
			#10;
		end
	end    
endmodule

