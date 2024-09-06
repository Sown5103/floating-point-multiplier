module Multi_float (Multiplier, Multiplicand, CLK, Start, Reset, Out ,DONE, Q, S, Over2, Over1, Equal, check_Out_M,check_Rounding);
input [31:0] Multiplier, Multiplicand;
input CLK, Reset, Start;
output [31:0] Out;
output [2:0] Q;
output [1:0] S;
output wire Equal, Over2, Over1, DONE ;
wire DoneR, DoneO, StartR;
wire  [22:0] MO;
wire [31:0] OutT, OutT1;
output [47:0] check_Out_M;
output [22:0] check_Rounding;
wire [31:0] x, y;
Controller CT( .Reset(Reset), .CLK(CLK), .Start(Start), .Equal(Equal), .Over1(Over1), .DoneO(DoneO), .Over2(Over2), .DoneR(DoneR),
						  .StartR(StartR), .S(S), .DONE(DONE), .Q(Q),.Multiplier_o(x),.Multiplicand_o(y),.Multiplier_i(Multiplier),.Multiplicand_i(Multiplicand));				 

Datapath DT(.Multiplier(x), .Multiplicand(y), .Reset(Reset), .CLK(CLK), .Equal(Equal), .Over1(Over1), .DoneO(DoneO), .Over2(Over2), .DoneR(DoneR),
					 .S(S), .StartR(StartR), .DONE(DONE), .Out(Out), .Start(Start),.Out_M_1(check_Out_M),.check_Rounding(check_Rounding));
					
endmodule              
								