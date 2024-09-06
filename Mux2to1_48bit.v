module Mux2to1_48bit(In1, In0, Out, S);
input [48:0] In1;
input [47:0] In0;
input S;
output [48:0] Out;

assign Out = S? In1:In0;

endmodule
