`timescale 1ns / 1ps

module hex7seg2(
    input wire [3:0] x,
    output reg [6:0] y
    );

	always @(*)
		case(x)
			0: y = 'b0000001;
			1: y = 'b1001111;
			2: y = 'b0010010;
			3: y = 'b0000110;
			4: y = 'b1001100;
			5: y = 'b0100100;
			6: y = 'b0100000;
			7: y = 'b0001111;
			8: y = 'b0000000;
			9: y = 'b0000100;
			10: y = 'b0001000;
			11: y = 'b1100000;
			12: y = 'b0110001;
			13: y = 'b1000010;
			14: y = 'b0110000;
			15: y = 'b0111000;
			default: y = 'b0000001;
		endcase
endmodule
