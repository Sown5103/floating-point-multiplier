module Sign_Extend(In, Out, St_SE);
input St_SE;
input [22:0] In;
output reg[23:0] Out;
reg [23:0]Int;
always @(St_SE)
	if(St_SE)begin
		Int = In + 24'b0;
		Out = Int + 8388608;end
	else begin
		Int = 24'bz;
		Out = 24'bz;
		end 
	
endmodule