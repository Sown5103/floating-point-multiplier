module Mux2 #(parameter N=48)(In1, In0, S, Out);
input [N-1:0] In1, In0;
input S;
output [N-1:0] Out;

assign Out = S ? In1: In0;

endmodule
