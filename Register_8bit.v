module Register_8bit #(parameter N = 8)(In, Reset, CLK, Out, WE, RE);

output reg [N-1:0] Out;
input [N-1:0] In;
input Reset, CLK, WE, RE;
reg [N-1:0] Int;

always @(posedge CLK) 	
		if (Reset)
		begin
			Out = 8'bZ;
			Int = 48'bz;
		end
		else begin
			if(WE)
				Int = In;
			if(RE)
				Out = Int;
			else begin 
			Out = 8'bz; 
			Int = Int; end
		end	
    
endmodule 