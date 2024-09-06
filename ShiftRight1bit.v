module ShiftRight1bit #(parameter N = 48)(In, Out);
input [N-1:0]In;
output [N-1:0]Out;

assign Out = In >> 1;

endmodule