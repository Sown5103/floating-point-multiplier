module Enable_Reg_Mul(CLK, Start_Counter, RE, WE, Start_Muti);
input CLK, Start_Counter;
output reg RE, WE, Start_Muti;
reg [4:0]d; 
//initial Start_Muti = 1;
always @(posedge CLK)
	if( Start_Counter) begin
		Start_Muti = 1;
		d = 0;WE =1; RE = 0;
		end
	else begin
		if( d > 0)begin
			if(d == 25)begin
				RE = 1; WE =0; Start_Muti = 0;end
			else begin
				WE = 0; RE =0; d = d + 5'd1; Start_Muti = 0;end	
		end		
		else begin
			 d= 1; WE =0; RE = 0; Start_Muti = 0;
			end
		end
	
endmodule
	