module Sign_extend_M #(parameter N = 48, M = 24)(In, Out);
input [M-1:0]In;
output [N-1:0]Out;

assign Out = In + 48'b0;

endmodule
