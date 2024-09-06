module Comparator0(In1, In2, Equal, Start);
input [31:0] In1, In2;
input Start;
output reg Equal;
reg O1, O2;
wire [1:0]O3;
always @(In1)
	if(Start) begin
		if(In1 == 0)
			O1 = 1;
		else O1 = 0;
	end
always @(In2)
	if(Start) begin
		if(In2 ==0)
			O2 = 1;
		else O2 =0;
	end
assign O3 = O1 + O2 + 2'b0;
always @( O3)
	if(Start) begin
	 if(O3 == 0)
		Equal =0;
	 else Equal =1;
	end
endmodule 
		