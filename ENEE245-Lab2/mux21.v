`timescale 1ns / 1ps

module mux21(
    input wire [3:0] a,
    input wire [3:0] b,
    input wire s,
    output reg [3:0] z
    );


	always @(*)
		if (s == 0)
			z = a;
		else
			z = b;
			
	mux2g
	M2 (.a(a), .b(b), .s(s), .z(z));

endmodule
