module Shift_right_1b(In, Out);
input [48:0]In;
output [47:0]Out;

assign Out = In>>1;

endmodule
