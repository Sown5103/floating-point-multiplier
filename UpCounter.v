module UpCounter #(parameter N = 5)(CLK, Reset, EnC, DoneC);
input CLK, Reset, EnC;
output reg DoneC;
reg [N-1:0]Count;

// initial begin
//	DoneC = 1'b0;
//	Count = 5'd0;
// end

always @(posedge CLK or posedge Reset)
	begin
		if(Reset)
			begin
				Count = 5'd0;
				DoneC = 1'b0;
			end
		else if(EnC ==0 )
			begin
				Count = Count + 5'd1;
				if(Count == 5'd24)
					DoneC = 1'b1;
				else DoneC = 1'b0;
			end
		else begin
			Count = 5'd1;
			DoneC = 1'b0; end
	end	
endmodule