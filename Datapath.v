module Datapath(Multiplier, Multiplicand, Reset, Start, CLK, Equal, Over1, DoneO, Over2, DoneR, S, StartR, DONE, Out,Out_M_1,check_Rounding);
input [31:0] Multiplier, Multiplicand;
input Reset, CLK, DONE, StartR, Start;
input [1:0] S;
output Equal, DoneO, Over2, Over1, DoneR;
output [31:0] Out;
wire [7:0] ExO;
wire [22:0] MO;
wire [7:0]O1, O2;
wire [7:0]Sum, Sum1;
wire [47:0]OutM;
wire [23:0] M_er, M_cand;
wire [31:0] OutT, OutT1;
wire WE, RE, St_M, sign;
output [47:0] Out_M_1;
assign Out_M_1 = OutM;
output [22:0] check_Rounding;
assign check_Rounding = MO;
Comparator0 C0(.In1(Multiplier[31:0]), .In2(Multiplicand[31:0]), .Equal(Equal), .Start(Start));

ALU AD(.In1(Multiplier[30:23]), .In2(Multiplicand[30:23]), .Out(Sum), .Over(Over1));

Register_8bit #(.N(8))Reg(.In(Sum), .Reset(Reset), .CLK(CLK), .Out(Sum1), .WE(WE), .RE(RE));

Enable_Reg_Mul E(.CLK(CLK),.Start_Counter(Start), .RE(RE), .WE(WE), .Start_Muti(St_M));

Sign_Extend I1(.In(Multiplier[22:0]), .Out(M_er), .St_SE(~Equal));

Sign_Extend I2(.In(Multiplicand[22:0]), .Out(M_cand), .St_SE(~Equal));

Multi Mu(.Multiplier(M_er), .Multiplicand(M_cand), .CLK(CLK), .Reset(Reset), .Start(St_M), .Out_M(OutM), .DoneO(DoneO));

Rounding R( .StartR(StartR), .Ex(Sum1), .M(OutM), .ExO(ExO), .MO(MO), .Over2(Over2), .DoneR(DoneR));

Sign_bit Sig(.SignA(Multiplier[31]), .SignB(Multiplicand[31]), .Sign(sign));

Concatenation_32bit C32(.In1(sign), .In2(ExO[7:0]), .In3(MO[22:0]), .Out(OutT));

mux4_1_32bit M3(.S(S), .In(OutT), .Out(OutT1));

TriState #(.N(32)) TriS(.Out(Out), .En(DONE), .In(OutT1));
endmodule
