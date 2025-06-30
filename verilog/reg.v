module reg(
	input [31:0] D, 
	input we, 
	input clk, 
	output reg [31:0] Q);
	
	always @(posedge clk) begin
		if (we) Q <= D;
	end
endmodule