`timescale 1ns/10ps
module traffic_light (clk,rst,pass,R,G,Y);
input clk , rst , pass ;
output  R,G,Y;

reg [11:0] count = 0;
reg  R,G,Y;
reg [2:0] state ;
reg [1:0]  ct = 0;
parameter G1=3'b000, N1=3'b001, G2=3'b010, N2=3'b011, G3=3'b100, Y1=3'b101, R1=3'b110;
parameter cycle1024='d1024 , cycle512='d512 , cycle128='d128;



always @(posedge clk or rst or  pass)
  begin
    if(rst==1)
	   begin
		   state <= G1;
			count <= 0;
		end
	  else
	    begin
		    if(pass==1)
	         begin 
				  if(state == G1)
				    begin
					 state <= G1;
					 end
				 else 
					 begin
					 state <= G1;
					 count <= 0;
					 end
				 end
			 else
				begin
		      case(state)
		      G1: begin
			      if(count < 'd1023 )
				      begin 
					   state <= G1; 
					   count <= count +1;
					   end
						else if (count < 'd1024 && ct <'d2)
						begin
						  
						  state <= G1;
						  count <= count + 1;
						  ct <= ct +1;

						  
						end
				   else
				      begin
					   state <= N1; 
					   count = 0;
					   end
					 end
			   N1: begin
			         if(count < 'd127  )
				      begin 
					   state <= N1; 
					   count <= count +1;
					   end
				      else
				      begin
					   state <= G2; 
					   count = 0;
					   end
					 end
			   G2: begin
			         if(count < 'd127 )
				      begin 
					   state <= G2;
					   count <= count +1;
					   end
				      else
				      begin
					   state <= N2;
					   count = 0;
					   end
					 end
			   N2: begin
			         if(count < 'd127 )
				      begin 
					   state <= N2;
					   count <= count +1;
					   end
				      else
				      begin
					   state <= G3;
					   count = 0;
					   end
					 end
			   G3: begin
			         if(count < 'd127 )
				      begin 
					   state <= G3;
					   count <= count +1;
					   end
				      else
				      begin
					   state <= Y1;
					   count = 0;
					   end
					 end
			   Y1: begin
			         if(count < 'd511 )
				      begin 
					   state <= Y1;
					   count <= count +1;
					   end
						
				      else
				      begin
					   state <= R1;
					   count <= 0;
					   end
					  end
			    R1: begin
			         if(count < 'd1023 )
				      begin 
					   state <= R1;
					   count <= count +1;
					   end
						
				      else
				      begin
					   state <= G1;
					   count = 0;
					   end
					  end
			   
		    endcase
	       end
      end
end	
			 

always @(state)
begin
  case(state)
      G1:begin G<=1'b1;Y<=1'b0;R<=1'b0; end
      N1:begin G<=1'b0;Y<=1'b0;R<=1'b0; end
      G2:begin G<=1'b1;Y<=1'b0;R<=1'b0; end
      N2:begin G<=1'b0;Y<=1'b0;R<=1'b0; end
      G3:begin G<=1'b1;Y<=1'b0;R<=1'b0; end
      Y1:begin G<=1'b0;Y<=1'b1;R<=1'b0; end
      R1:begin G<=1'b0;Y<=1'b0;R<=1'b1; end
      endcase
end
endmodule

