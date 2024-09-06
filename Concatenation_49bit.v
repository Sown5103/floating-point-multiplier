module Concatenation_49bit( In1, In2, InOv, Out);
input [23:0] In1;
input [23:0] In2;
input InOv;
output [48: 0] Out;

assign Out = {InOv, In1, In2};

endmodule
