module Rounding (StartR, Ex, M, ExO, MO, Over2, DoneR);
input [7:0]Ex;
input [47:0]M;
input StartR;
output reg [7:0]ExO;
output reg [22:0]MO;
output reg DoneR;
reg [24:0] MOt;
output reg Over2;
reg [7:0] Ext;
reg [47:0] Mt;
// initial begin Over2 = 0;  DoneR = 0; end
always @(M[47] )
	if (StartR) begin	
		if(M[47] == 1'b1)
		begin 
			if(Ex == 8'd254)
				begin
					Over2 =1 ;
					Mt = 48'bz;
					Ext = 8'bZ;
					DoneR = 0; 
				end
			else begin
				Mt = M>>1;
				Ext = (Ex +1);
				Over2 = 0;
				DoneR = 1;
				end
			end
		else begin		
				Mt = M;
				Over2 = 0;
				Ext = Ex;
				DoneR = 1; end
		end
	
always@(Mt[22])	
	if(Mt[22] == 1'b1)begin
		MOt[24:0] = Mt[47:23] + 25'd1 ;
		if(MOt[24]) begin
				MO[22:0] = MOt[23:1];
				ExO = Ext + 1;
			end
		else begin
			MO[22:0] = MOt[22:0];
			ExO = Ext;
		    end
	end
	else begin
		MO[22:0] = Mt[45:23];
		ExO = Ext;

	end
	
endmodule	
		
