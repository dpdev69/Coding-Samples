// Verilog test fixture created from schematic C:\Users\etaylor5\Desktop\New folder\lab5\fulladder.sch - Fri Oct 11 18:45:58 2013

`timescale 1ns / 1ps

module fulladder_fulladder_sch_tb();

// Inputs
   reg a;
   reg b;
   reg c_in;

// Output
   wire s_out;
   wire c_out;

// Bidirs

// Instantiate the UUT
   fulladder UUT (
		.a(a), 
		.b(b), 
		.c_in(c_in), 
		.s_out(s_out), 
		.c_out(c_out)
   );
// Initialize Inputs
	integer i = 0;
	initial begin
	c_in = 0;
	a = 0;
	b = 0;
	#10 $display("Starting test");
	for (i = 0; i < 8; i = i + 1)
	begin
		{c_in,a,b} = i;
		#10 $display("c_in a b = %b%b%b, {c_out,s_out} = %b%b", c_in, a, b, c_out, s_out);
		if ({c_out,s_out} != (a+b+c_in))
			$display("Error: {c_out,s_out} should be %b, but is %b", (a+b+c_in), {c_out,s_out});
		end
	end
endmodule
