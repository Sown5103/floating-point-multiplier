module ALU (In1, In2,Out, Over);
input [7:0] In1, In2;
output reg[7:0] Out;
output reg Over;
wire [8:0] OutT ;
initial Over  = 0;
assign OutT = In1 +In2 - 127;
always @(OutT)
	
	if(OutT < 1)begin
		Over = 1; Out = 8'bZ; end
	else if(OutT > 254)begin
		Over = 1;Out = 8'bZ; end
	else begin 
		Over = 0;
		Out[7:0] = OutT [7:0];
		end
endmodule
