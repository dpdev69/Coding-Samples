`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:26:44 11/12/2012 
// Design Name: 
// Module Name:    VendingMachine 
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
module VendingMachine(
    input clk,
    input reset,
    input [2:0] coin,
    input [3:0] select,
    output reg [7:0] price,
    output reg [7:0] total_money,
    output reg [3:0] product
    );


	parameter [1:0] S0 = 2'b00,//IDLE
						 S1 = 2'b01,//Count Money
						 S2 = 2'b10,//Dispense Product
						 S3 = 2'b11;// Dispense Change
			
	parameter [7:0] P0 = 8'b01010101,//55
						 P1 = 8'b01100000,//60
						 P2 = 8'b01100101,//65
						 P3 = 8'b01110000;//70
						 
	/*parameter [7:0] C0 = 8'b00000101,//nickel 5
						 C1 = 8'b00010000,//dime 10
						 C2 = 8'b00100101;//quarter 25
	*/

   reg [1:0] state,next_state;

	always @(*)
		case(select)
			4'b0001:
				price <= P0;
			4'b0010:
				price <= P1;
			4'b0100:
				price <= P2;
			4'b1000:
				price <= P3;
			default: price <= 8'd0;
		endcase
	
	always @(posedge clk or posedge reset)
		if (reset) state <= S0;
		else state <= next_state;
		
	always @(*)
		begin
		next_state = S0;
		case (state)
			S0:
				if (coin) next_state = S1;
				else 
					case (select) 
						4'b0001:
							if (total_money < P0) next_state = S3;
							else next_state = S2;
						4'b0010:
							if (total_money < P1) next_state = S3;
							else next_state = S2;
						4'b0100:
							if (total_money < P2) next_state = S3;
							else next_state = S2;
						4'b1000:
							if (total_money < P3) next_state = S3;
							else next_state = S2;
						default: next_state = S0;
					endcase
			S1:
				next_state = S0;
			S2:
				next_state = S3;
			S3: 
				next_state = S0;
			default: next_state = S0;
		endcase
		end
	
		
	always @(posedge clk or posedge reset)
		if (reset)
			begin	
			total_money <= 7'd0;
			product <= 4'b0000;
			end
		else begin
			case(state)
				//S0:
				S1:
					case(coin)
						3'b001:
							if (total_money[3:0]) begin
								total_money[3:0] <= 4'b0000; 
								total_money[7:4] <= total_money[7:4] + 1'b1;
								end
							else total_money <= {total_money[7:4],4'b0101};
						3'b010:
							total_money[7:4] <= total_money[7:4] + 1'b1;
						3'b100:
							if (total_money[3:0]) begin
								total_money[3:0] <= 4'b0000; 
								total_money[7:4] <= total_money[7:4] + 2'b11;
								end
							else begin
								total_money[7:4] <= total_money[7:4] + 2'b10;
								total_money[3:0] <= 4'b0101;
							end
						default:
							total_money <= total_money;
					endcase
				S2:
					case(select)
						4'b0001:
							begin
							product <= 4'b0001;
							if (total_money[3:0]) begin
								total_money[3:0] <= 4'b0000;
								total_money[7:4] <= total_money[7:4] - 3'b101;
								end
							else begin
								total_money[3:0] <= 4'b0101;
								total_money[7:4] <= total_money[7:4] - 3'b110;
							end
							end
						4'b0010:
							begin
							product <= 4'b0010;
							total_money[7:4] <= total_money[7:4] - 3'b110;
							if (total_money[3:0]) begin
								total_money[3:0] <= 4'b0101;
								end
							else begin
								total_money[3:0] <= 4'b0000;
							end
							end
						4'b0100:
							begin
							product <= 4'b0100;
							if (total_money[3:0]) begin
								total_money[3:0] <= 4'b0000;
								total_money[7:4] <= total_money[7:4] - 3'b110;
								end
							else begin
								total_money[3:0] <= 4'b0101;
								total_money[7:4] <= total_money[7:4] - 3'b111;
							end
							end
						4'b1000:
							begin
							product <= 4'b1000;
							total_money[7:4] <= total_money[7:4] - 3'b111;
							if (total_money[3:0]) begin
								total_money[3:0] <= 4'b0101;
								end
							else begin
								total_money[3:0] <= 4'b0000;
							end
							end
						default: total_money <= 4'b0000;
					endcase
				S3:
					begin
					total_money <= 8'd0;
					product <= 4'b0000;
					end
				endcase
			end
					
							
							

							
				 
			

endmodule
