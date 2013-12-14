module sqrt_test;
	// Inputs
	reg clk;
	reg clr;
	reg go;
	reg [7:0] sw;

	// Outputs
	wire done;
	wire [3:0] root;

	// Instantiates the Unit Under Test
	sqrt uut (
		.clk(clk),
		.clr(clr),
		.go(go)
		.sw(sw)
		.done(done)
		.root(root)
	);

	always
		#10 clk = ~clk;

	integer i;
	initial begin
		clk = 0;
		clr = 1;
	
		for (i = 0; i <= 16; i = i + 1)
		begin
			clk = 0;
			clr = 1;
			go = 1;
			sw = i;
			#35 clr = 0;
		end
	end
endmodule
