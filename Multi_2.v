module Multi(   input wire          CLK,
                input wire          Start,
                input wire          Reset,
                input wire [23:0]   Multiplier,
                input wire [23:0]   Multiplicand,
                output reg [47:0]   Out_M,
                output reg          DoneO);
                
	reg  [6:0] 		round_reg;
	reg				round_add;            
    reg  [23:0]     plier_r;
    reg  [23:0]     plicand_r;
    reg  [47:0]     product_r;
    
    wire  [23:0]     plier_w;
    wire  [23:0]     plicand_w;
    wire  [47:0]     product_w;
    wire  [47:0]     temp1,temp2,temp3;
    
       
    
   always @(posedge CLK or negedge Reset)	
	begin
		if(Reset == 1'b0) begin
			round_reg 			<= 7'b0;
			round_add			<= 1'b0;
		end
		else if(Start) begin
				round_add			<= 1'b1;
				round_reg 			<= round_reg + 1'b1;
			end
			else if (round_reg == 7'd25) begin
				round_reg  		<= 7'b0;
				round_add		<= 1'b0;
			end
			else begin
				round_add			<= round_add;
				round_reg 			<= round_reg + round_add;
			end
	
	end   
	
	assign plier_w = Start ? Multiplier : plier_r;
	assign plicand_w = Start ? Multiplicand : plicand_r;  
	      
    
   assign temp1 = Start ? {{24{1'b0}},plier_w} : product_r; 
   assign temp2 = temp1[0] ? (temp1 + {plicand_w,{24{1'b0}}}) : temp1;
   assign product_w = temp2 >> 1;

   
	always @(posedge CLK or negedge Reset)	
	begin
		if(Reset == 1'b0) begin
			plier_r             <= 24'b0;
			plicand_r           <= 24'b0;
			product_r           <= 48'b0;
		end
		else begin
		   plier_r             <= plier_w;
			plicand_r           <= plicand_w;
			product_r           <= product_w;
		end
	end       
	 
	always @(posedge CLK or negedge Reset)	
	begin
		if(Reset == 1'b0) begin
			Out_M 			<= 48'b0;
			DoneO			<= 1'b0;

		end
		else if(round_reg == 7'd24) begin
         Out_M 			<= product_r;
			DoneO			<= 1'b1;
		end
		else begin
			Out_M 			<= 48'b0;
			DoneO			<= 1'b0;
		end
	end 	
	      
endmodule
