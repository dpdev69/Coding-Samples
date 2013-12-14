`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:56:46 11/12/2012
// Design Name:   VendingMachine
// Module Name:   D:/Work/T.A/ENEE245/Lab11/VendingMachine_tb.v
// Project Name:  Lab11
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: VendingMachine
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module VendingMachine_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [2:0] coin;
	reg [3:0] select;

	// Outputs
	wire [7:0] price;
	wire [7:0] total_money;
	wire [3:0] product;

	// Instantiate the Unit Under Test (UUT)
	VendingMachine uut (
		.clk(clk), 
		.reset(reset), 
		.coin(coin), 
		.select(select), 
		.price(price), 
		.total_money(total_money), 
		.product(product)
	);
	
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	initial begin
		coin = 0;
		select = 0;
		// Initialize Inputs
		reset = 0;
		
		// Wait 100 ns for global reset to finish
		#20;
		reset = 1;
		#20 reset = 0;
		
		#20 coin = 3'b001;
		#20 coin = 3'b010;
		#20 coin = 3'b100;
		#20 coin = 3'b000;
		#20 coin = 3'b100;
		#20 coin = 3'b000;
		#20 coin = 3'b100;
		#20 coin = 3'b000;
		#10 select = 4'b1000;
		
        
		// Add stimulus here

	end
      
endmodule

