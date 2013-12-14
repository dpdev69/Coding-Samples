`timescale 1ns / 1ps

module booth_multiplier(product, a, b);

input [3:0] a, b;
output [7:0] product;

reg [2:0] cc[1:0];
reg [4:0] pp[1:0];
reg [7:0] spp[1:0];
reg [7:0] prod;
wire [4:0] inv_a;
integer i, j;

assign inv_a = {~a[3], ~a}+1;
always @(a or b or inv_a)
begin
	cc[0] = {b[1], b[0], 1'b0};
	for (i = 1; i < 2; i = i + 1)
		cc[i] = {b[2*i+1], b[2*i], b[2*i-1]};
	for (i = 0; i < 2; i = i + 1)
	begin
		case(cc[i])
			3'b001 , 3'b010 : pp[i] = {a[3], a};
			3'b011 : pp[i] = {a, 1'b0};
			3'b100 : pp[i] = {inv_a[3:0], 1'b0};
			3'b101 , 3'b110 : pp[i] = inv_a;
			default: pp[i] = 0;
		endcase
		spp[i] = $signed(pp[i]);
		for(j = 0; j < i; j = j + 1)
			spp[i] = {spp[i], 2'b00};
	end
	prod = spp[0];
	for(i = 1; i < 2; i = i + 1)
		prod = prod + spp[i];
	end
	assign product = prod;
endmodule
