`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:17:11 11/25/2013 
// Design Name: 
// Module Name:    Sequential_Multiplier 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Sequential_Multiplier #(parameter N = 4)(
    input clk,
	 input reset,
	 input [N-1:0] A,
	 input [N-1:0] B,
	 output [2*N-1:0] Product,
	 output [6:0] seg,
	 output [3:0] AN, 
	output zero,
	output wire reset_datapath,
	output wire enable_a,
	output wire enable_b,
	output wire ld_shift_a,
	output wire ld_shift_b,
	output wire ldp,
	output wire complete,
	output wire psel,
	output wire [2:0] state
	 );


	
	wire clk1k;
	wire [1:0] s;
	wire [6:0] x;
	
	clk1K clkconveter(.clk(clk),.clk1k(clk1k));
	
	anode_drv anode_uut(.clk(clk1k),.reset(reset),.ce(1),.sel(s),.AN(AN));
	
	mux_41c mux_uut(.a(A),.b(B),.c(Product[7:4]),.d(Product[3:0]),.s(s),.y(x));
	
	hex7seg_case decoder(.x(x),.a(seg[6]),.b(seg[5]),.c(seg[4]),.d(seg[3]),.e(seg[2]),.f(seg[1]),.g(seg[0]));
	
	mutl_ctrlpath cp(
		.clk(clk),
		.restart(reset),
		.zero(zero),
		.reset_datapath(reset_datapath),
		.enable_a(enable_a),
		.ld_shift_a(ld_shift_a),
		.enable_b(enable_b),
		.ld_shift_b(ld_shift_b),
		.LdP(ldp),
		.complete(complete),
		.state(state)
	);
	
	mult_datapath dp(
		.clk(clk),
		.reset(reset_datapath),
		.enable_a(enable_a),
		.ld_shift_a(ld_shift_a),
		.enable_b(enable_b),
		.ld_shift_b(ld_shift_b),
		.LdP(ldp),
		.psel(psel),
		.A(A),
		.B(B),
		.R(Product),
		.zero(zero),
		.lsb_b(psel)
	);
		
endmodule
