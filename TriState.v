module TriState #(parameter N = 48)(Out, En, In);
input [N-1:0]In;
input En;
output [N-1:0]Out;
assign 
	Out = En ? In : 48'bz;
endmodule