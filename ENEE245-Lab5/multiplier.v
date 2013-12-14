`timescale 1ns / 1ps

module multiplier(product, input1, input2);
	output [7:0] product;
	input [3:0] input1;
	input [3:0] input2;
	
	assign product[0] = (input1[0] & input2[0]);
	
	wire x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17;
	halfadder HA1(product[1], x1, (input1[1] & input2[0]), (input1[0] & input2[1]));
	fulladder FA1(x2, x3, input1[1] & input2[1], (input1[0] & input2[2]), x1);
	fulladder FA2(x4, x5, (input1[1] & input2[2]), (input1[0] & input2[3]), x3);
	halfadder HA2(x6, x7, (input1[1] & input2[3]), x5);
	halfadder HA3(product[2], x15, x2, (input1[2] & input2[0]));
	fulladder FA5(x14, x16, x4, (input1[2] & input2[1]), x15);
	fulladder FA4(x13, x17, x6, (input1[2] & input2[2]), x16);
	fulladder FA3(x9, x8, x7, (input1[2] & input2[3]), x17);
	halfadder HA4(product[3], x12, x14, (input1[3] & input2[0]));
	fulladder FA8(product[4], x11, x13, (input1[3] & input2[1]), x12);
	fulladder FA7(product[5], x10, x9, (input1[3] & input2[2]), x11);
	fulladder FA6(product[6], product[7], x8, (input1[3] & input2[3]), x10);
endmodule
