`timescale 1ns / 1ps

module mux41case(
    input wire [3:0] a,
    input wire [1:0] s,
    output reg z
    );

always @(*)
	case(s)
		0: z = a[0];
		1: z = a[1];
		2: z = a[2];
		3: z = a[3];
		default: z = a[0];
	endcase
endmodule
