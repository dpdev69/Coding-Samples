`timescale 1ns / 1ps
module ripple_carry_adder(
    output [3:0] Sum,
    output C_out,
	 input [3:0] A,
    input [3:0] B,
    input C_in
    );

	wire c1,c2,c3;
	full_adder FA1(Sum[0],c1,A[0],B[0],C_in),
				  FA2(Sum[1],c2,A[1],B[1],c1),
				  FA3(Sum[2],c3,A[2],B[2],c2),
				  FA4(Sum[3],C_out,A[3],B[3],c3);			  
endmodule
