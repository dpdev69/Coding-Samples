`timescale 1ns / 1ps

module clkconverter(
    input clock1,
    input reset,
    output reg clock2,
	 output reg [15:0] counter
    );

	always @(posedge clock1)
	begin
		if(reset)
			begin
				counter <= 0;
				clock2 <= 0;
			end
		else begin
			if(counter < 25000)
				begin
					counter <= counter + 1;
				end
			else
				begin
					clock2 <= ~clock2;
					counter <= 0;
				end
			end
		end
endmodule
