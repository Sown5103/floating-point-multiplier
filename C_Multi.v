module C_Multi(CLK, Start, Reset, DoneC, Init_En, WE, DoneO, RE );
input CLK, Start, Reset, DoneC;
reg [1:0] S;
output reg DoneO,Init_En, WE, RE;
always @(S)
	case(S)
	0:
	begin
		Init_En = 0;
		RE =0;
		WE =0;
		DoneO =0;
	end
	1:begin
		Init_En = 1;
		RE = 1;
		WE =1;
		DoneO =0;end
	2:begin
		Init_En = 0;
		RE = 1;
		WE =1;
		DoneO =0;end
	3:begin
		Init_En = 0;
		RE =1;
		WE =0;
		DoneO =1;end
	endcase
always @(posedge CLK or posedge Reset)
	if(Reset)
		S = 0;
	else begin
	case(S)
		0:
		begin
			if(Start == 1)
				S = 1;
			else S =0;
		end
		1:
		begin
			if(Start == 0)
				S = 2;
			else 
				S = 1;
		end
		2:
		begin
			if(DoneC ==1)
				S = 3;
			else begin
				if(Start == 0)
					 S = 2;
				else S = 1;
			end
		end
		3:
		begin	
			if(Start == 0)
				S = 3;
				else S = 1;
		end
	endcase
	end
endmodule 
	