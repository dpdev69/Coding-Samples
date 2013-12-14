`timescale 1ns / 1ps

module lookahead_carry_adder_test;
// Inputs
    reg [3:0] A;
    reg [3:0] B;
    reg C_in;

    // Outputs
    wire [3:0] Sum;
    wire C_out;
    wire PG;
    wire GG;

    // Instantiate the Unit Under Test (UUT)
    lookahead_carry_adder uut (
    .Sum(Sum), 
    .C_out(C_out), 
    .PG(PG), 
    .GG(GG), 
    .A(A), 
    .B(B), 
    .C_in(C_in)
    );
	 
    initial begin
    // Initialize Inputs
    A = 0; B = 0; C_in = 0;
    // Wait 100 ns for global reset to finish
    #100;
        
    // Add stimulus here
    A=4'b0001;B=4'b0000;C_in=1'b0;
    #10 A=4'b100;B=4'b0011;C_in=1'b0;
    #10 A=4'b1101;B=4'b1010;C_in=1'b1;
    #10 A=4'b1110;B=4'b1001;C_in=1'b0;
    #10 A=4'b1111;B=4'b1010;C_in=1'b0;
    end    
endmodule
