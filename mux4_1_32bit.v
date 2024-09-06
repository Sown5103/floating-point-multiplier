module mux4_1_32bit(S, In, Out);
input [1:0]S;
input [31:0] In;
output reg [31:0]Out;

always @(S)
	if(S[1:0] == 2'b00)
		Out = In;
	else if(S[1:0] == 2'b01)
		Out[31:0] = 32'bZ;
	else Out = 0;
	
endmodule
		