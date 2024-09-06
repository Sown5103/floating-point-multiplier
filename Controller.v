module Controller (CLK, Start, Reset, Equal, Over1, DoneO, Over2, DoneR, StartR, S, DONE,  Q,Multiplier_o,Multiplier_i,Multiplicand_o,Multiplicand_i);
input CLK, Start, Reset, Equal, Over1, Over2, DoneO, DoneR;
output reg StartR, DONE;
output reg [1:0]S;
output reg [2:0]Q;

input [31:0] Multiplier_i,Multiplicand_i;
output reg [31:0] Multiplier_o,Multiplicand_o;


initial begin
	StartR = 0;
	DONE = 0;
	S = 2'b0;
	Q = 3'd0;
	
end

parameter
	s0 = 3'd0,
	s1 = 3'd1,
	s2 = 3'd2,
	s3 = 3'd3,
	s4 = 3'd4;
	
always @(posedge CLK)
begin
	if(Reset) 
	Q = s0;
	else
		case(Q)
		s0:
			if(Start) Q = s1;
			else Q = s0;
		s1: 
		if(Start) 
			Q = s1;
		else begin
			if( Equal == 0 && Over1 == 0) 
				Q = s2;
			else Q = s1;
		end
		s2:
			if(DoneO == 1) Q = s3;
			else Q = s2;
		s3: 			
			if(DoneR) Q = s4;
			else Q = s3;
		s4: 
			Q = s4;
		endcase
end

always @(Q)
	case(Q)
		s0:
			begin
				StartR = 0;
				S[1:0] = 2'bz;
				DONE = 0;
			end
		s1:
			begin
				StartR = 0;
				Multiplier_o = Multiplier_i;
				Multiplicand_o = Multiplicand_i;
				if(Equal)begin
					S[1:0] = 2'b10;
					DONE = 1; end
				else if(Over1) begin
					S[1:0] = 2'b01;
					DONE = 1; end
				else begin
					S[1:0] = 2'bz;
					DONE = 0; end
			end
		s2:
			begin
				StartR = 0;
				S[1:0] = 2'bz;
				DONE = 0;
			end
		s3:
			begin 
			StartR = 1;
			if(Over2 ==0)begin
				
				S[1:0] = 2'bz;
				DONE = 0; end
		
			else begin
				
				S[1:0] = 2'b01;
				DONE = 1; end
			end
		s4:
		begin
		if(DoneR) begin
				StartR = 0;
				S[1:0] = 2'b00;
				DONE = 1; end
		end
	endcase
endmodule
			