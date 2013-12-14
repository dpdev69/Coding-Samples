`timescale 1ns / 1ps

module anode(
    input c,
    input clock,
    input reset,
    output reg output1,
    output reg output2,
    output reg [3:0] a,
    output reg [1:0] q
    );

	always @(posedge clock)
		begin
			if(c == 1)
				begin
					if(reset == 1)
						q <= 0;
					else
						q <= q + 1;
				end
			case(q)
				0: a = 4'b1110;
				1: a = 4'b1101;
				2: a = 4'b1011;
				3: a = 4'b0111;
				default: a = 4'b1110;
			endcase
		end
		assign {output1, output2} = q;
endmodule
