`timescale 1ns / 1ps

module seg7control(
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [1:0] s,
    output reg [3:0] control
    );
	 
	always @(*)
	begin
		case(s)
			0: control = a;
			1: control = b;
			2: control = c;
			3: control = d;
		endcase
	end
endmodule
