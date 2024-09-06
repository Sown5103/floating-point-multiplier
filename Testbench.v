`timescale 1ns/1ps
module Testbench();
reg CLK = 0, Start = 0, Reset = 0;
reg [31:0]In1, In2;
wire  [31:0]Out;
wire DONE;
wire [2:0] Q;
wire [1:0] S;
wire Over1, Over2, Equal;
initial begin
	Start = 0;
	Reset = 1;
	CLK = 0;
	In1 = 32'b01000001100001100110011001100110; //16.8 and 18.1
	In2 = 32'b01000001100100001100110011001101;
	#20 Reset = 0; 
	#70 Start = 1;
	#30 Start = 0;
	#600 Reset = 1; 
	In1 = 32'd0; // equal 
	In2 = 32'b01000100010001010100011111011111;
	#10 Start = 0;
	#10 Reset = 0; 
	Start = 1;
	#20 Start = 0;
	#1000 Reset = 1; 
	In1 = 32'b01000111111100000000000000000000; // over1
	In2 = 32'b01111001001000000000000000000000;
	#10 Start = 0;
	#10 Reset = 0; 
	Start = 1;
	#20 Start = 0;
	#1000 Reset = 1; 
	In1 = 32'b01000101111100000000000000000000; // over2
	In2 = 32'b01111001001000000000000000000000;
	#10 Start = 0;
	#10 Reset = 0; 
	Start = 1;
	#20 Start = 0;
	#3000 $stop;
	end
always  #10 CLK = ~ CLK;
Multi_float MF(.Multiplier(In1), .Multiplicand(In2), .CLK(CLK), .Start(Start), .Reset(Reset), .Out(Out) ,.DONE(DONE), .Q(Q), .S(S), .Over2(Over2), .Over1(Over1), .Equal(Equal));

endmodule 
	
	


