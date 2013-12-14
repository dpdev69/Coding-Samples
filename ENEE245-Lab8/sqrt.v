module sqrt(
	input wire clk,
	input wire clr,
	input wire go,
	input wire [7:0] sw,
	output wire done,
	output wire [3:0] root
);

wire lteflg, ald, sqld, dld, outld;
assign done = outld;

sqrt_control sqrt1 (.clk(clk), .clr(clr), .lteflg(lteflg), .go(go), .ald(ald), .sqld(sqld), .dld(dld), 
.outld(outld));
sqrt_path sqrt2 (.clk(clk), .reset(clr), .ald(ald), .sqld(sqld), .dld(dld), .outld(outld), .sw(sw), 
.lteflag(lteflag), .root(root));
endmodule
