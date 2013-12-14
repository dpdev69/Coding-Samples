`timescale 1ns / 1ps

module multiplier_test;

	// Inputs
	reg [3:0] input1;
	reg [3:0] input2;

	// Outputs
	wire [7:0] product;

	// Instantiate the Unit Under Test (UUT)
	multiplier uut (
		.product(product), 
		.input1(input1), 
		.input2(input2)
	);

	integer i = 0;
	initial begin
		// Initialize Inputs
		input1 = 0000;
		input2 = 0000;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		for (i = 0; i < 16; i = i + 1)
		begin
			input1 = i;
			input2 = i;
			#10 $display("input1 input2 = %b %b", input1, input2);
		end
	end
endmodule
