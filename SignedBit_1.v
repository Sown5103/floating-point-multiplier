module SignedBit_1 #(parameter N = 48, M = 24)(InH, InL, z);
input [N-1:0] InL;
input [M-1:0] InH;
 reg [N-1:0] a;
 reg [N:0]b;
output reg [N-1:0] z;
always @(InL[0])
	if(InL[0])begin
	a=InH << M;
	b=(InL + a+ 48'b0)>>1;
	z = b[N-1:0];
	end
	else z = InL>>1;
   
endmodule