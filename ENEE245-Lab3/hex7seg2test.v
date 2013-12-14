`timescale 1ns / 1ps

module hex7seg2test;

	// Inputs
	reg [3:0] x;

	// Outputs
	wire [6:0] y;

	// Instantiate the Unit Under Test (UUT)
	hex7seg2 uut (
		.x(x), 
		.y(y)
	);

	integer i = 0;
	initial begin
	x[0] = 0;
	x[1] = 0;
	x[2] = 0;
	x[3] = 0;
	
	#10 $display("Starting test");
	for (i = 0; i < 16; i = i + 1)
	begin
		{x[0],x[1],x[2],x[3]} = i;
		#10 $display("x[0] x[1] x[2] x[3] = %b %b %b %b", x[0], x[1], x[2], x[3]);
	end
	end
endmodule


