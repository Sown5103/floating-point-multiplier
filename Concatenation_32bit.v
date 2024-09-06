module Concatenation_32bit(In1, In2, In3, Out);
input In1;
input [7:0] In2;
input [22:0] In3;
output [31:0] Out;

assign Out = { In1, In2, In3 };

endmodule
