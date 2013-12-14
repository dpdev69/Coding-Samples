`timescale 1ns / 1ps

module hex7seg1(
    input wire [3:0] x,
    output reg a,
    output reg b,
    output reg c,
    output reg d,
    output reg e,
    output reg f,
    output reg g
    );
	//Continuous Assignment Statement
	always @(*)
	
	// For input x = 0000
	if (x[0] == 0 && x[1] == 0 && x[2] == 0 && x[3] == 0)
		begin
			a = 1;
			b = 1;
			c = 1;
			d = 1;
			e = 1;
			f = 1;
			g = 0;
		end
		
	// For input x = 0001
	else if (x[0] == 1 && x[1] == 0 && x[2] == 0 && x[3] == 0)
		begin
			a = 1;
			b = 0;
			c = 0;
			d = 1;
			e = 1;
			f = 1;
			g = 1;
		end
		
	// For input x = 0010
	else if (x[0] == 0 && x[1] == 1 && x[2] == 0 && x[3] == 0)
		begin
			a = 0;
			b = 0;
			c = 1;
			d = 0;
			e = 0;
			f = 1;
			g = 0;
		end
	
	// For input x = 0011
	else if (x[0] == 1 && x[1] == 1 && x[2] == 0 && x[3] == 0)
		begin
			a = 0;
			b = 0;
			c = 0;
			d = 0;
			e = 1;
			f = 1;
			g = 0;
		end
		
	// For input x = 0100
	else if (x[0] == 0 && x[1] == 0 && x[2] == 1 && x[3] == 0)
		begin
			a = 1;
			b = 0;
			c = 0;
			d = 1;
			e = 1;
			f = 0;
			g = 0;
		end
	
	// For input x = 0101
	else if (x[0] == 1 && x[1] == 0 && x[2] == 1 && x[3] == 0)
		begin
			a = 0;
			b = 1;
			c = 0;
			d = 0;
			e = 1;
			f = 0;
			g = 0;
		end
		
	// For input x = 0110
	else if (x[0] == 0 && x[1] == 1 && x[2] == 1 && x[3] == 0)
		begin
			a = 0;
			b = 1;
			c = 0;
			d = 0;
			e = 0;
			f = 0;
			g = 0;
		end
		
	// For input x = 0111
	else if (x[0] == 1 && x[1] == 1 && x[2] == 1 && x[3] == 0)
		begin
			a = 0;
			b = 0;
			c = 0;
			d = 1;
			e = 1;
			f = 1;
			g = 1;
		end
		
	// For input x = 1000
	else if (x[0] == 0 && x[1] == 0 && x[2] == 0 && x[3] == 1)
		begin
			a = 0;
			b = 0;
			c = 0;
			d = 0;
			e = 0;
			f = 0;
			g = 0;
		end
		
	// For input x = 1001
	else if (x[0] == 1 && x[1] == 0 && x[2] == 0 && x[3] == 1)
		begin
			a = 0;
			b = 0;
			c = 0;
			d = 0;
			e = 1;
			f = 0;
			g = 0;
		end
		
	// For input x = 1010
	else if (x[0] == 0 && x[1] == 1 && x[2] == 0 && x[3] == 1)
		begin
			a = 0;
			b = 0;
			c = 0;
			d = 1;
			e = 0;
			f = 0;
			g = 0;
		end
		
	// For input x = 1011
	else if (x[0] == 1 && x[1] == 1 && x[2] == 0 && x[3] == 1)
		begin
			a = 1;
			b = 1;
			c = 0;
			d = 0;
			e = 0;
			f = 0;
			g = 0;
		end
		
	// For input x = 1100
	else if (x[0] == 0 && x[1] == 0 && x[2] == 1 && x[3] == 1)
		begin
			a = 0;
			b = 1;
			c = 1;
			d = 0;
			e = 0;
			f = 0;
			g = 1;
		end
		
	// For input x = 1101
	else if (x[0] == 1 && x[1] == 0 && x[2] == 1 && x[3] == 1)
		begin
			a = 1;
			b = 0;
			c = 0;
			d = 0;
			e = 0;
			f = 1;
			g = 0;
		end
		
	// For input x = 1110
	else if (x[0] == 0 && x[1] == 1 && x[2] == 1 && x[3] == 1)
		begin
			a = 0;
			b = 1;
			c = 1;
			d = 0;
			e = 0;
			f = 0;
			g = 0;
		end
	
	// For input x = 1111
	else if (x[0] == 1 && x[1] == 1 && x[2] == 1 && x[3] == 1)
		begin
			a = 0;
			b = 1;
			c = 1;
			d = 1;
			e = 0;
			f = 0;
			g = 0;
		end
endmodule
