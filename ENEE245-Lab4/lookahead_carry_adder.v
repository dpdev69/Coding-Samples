`timescale 1ns / 1ps

module lookahead_carry_adder(
    input [3:0] A,
    input [3:0] B,
    input C_in,
    output [3:0] Sum,
    output PG,
    output GG,
    output C_out
    );
    wire [3:0] G,P,C;
	 
    assign G = A & B; //Generate
    assign P = A ^ B; //Propagate
    assign C[0] = C_in;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign C_out = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) |(P[3] & P[2] & P[1] & P[0] & C[0]);
    assign Sum = P ^ C;
   
    assign PG = P[3] & P[2] & P[1] & P[0];
    assign GG = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);

endmodule
