module Add_24bit(In1, In2, Out, Over);
input [23:0]In1, In2;
output [23:0]Out;
output Over;
wire [24:0] OutT;
assign OutT = In1 + In2;
assign Over = OutT[24];
assign Out = OutT[23:0];
endmodule