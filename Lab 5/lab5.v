module lab5(segout,segselect,ledout,clk,speedD,rst,speedU);
input clk,rst,speedD,speedU;
wire clked1,clked2;
wire out_clk;
wire [3:0] sec;
output [2:0] ledout;
output [3:0] segselect;
output [7:0] segout;
botton b1(clked1,speedD,clk,rst);
botton b2(clked2,speedU,clk,rst);
div d1(out_clk,clk,rst,clked2,clked1);
FSM f1(ledout,sec,out_clk,rst);
seg7 s1(segout,segselect,sec);
endmodule
//-----------------------------------------------
module botton(clked,in,clk,rst);
input in,clk,rst;
output reg clked;
reg [23:0]decnt;
parameter bound=24'hffffff;
always@(posedge clk or negedge rst)begin
	if(~rst)begin
		decnt<=0;
		clked<=0;
	end
	else begin
		if(~in)begin
			if(decnt<bound)begin
				decnt<=decnt+1;
				clked<=1;
			end
			else begin
				decnt<=decnt;
				clked<=1;
			end
		end
		else begin
			decnt<=0;
			clked<=0;
		end
	end
end
endmodule
//------------------------------------------
module div(divclkout,clk,rst,speedup,speedD);
output divclkout;
   input clk;
	input rst;
	input speedup;
	input speedD;

reg [25:0] divclk;
reg [4:0] speed;
assign divclkout = divclk[speed];

always@(posedge clk or negedge rst)
begin
   if(~rst)
	   divclk <= 26'd0;
	else begin
	   divclk <= divclk + 1'd1;
	end
end

always@(posedge clk or negedge rst)
begin
   if(~rst)
	   speed = 5'd23;
	else if(speedup)
	   speed = 5'd21;
	else if(speedD)
	   speed = 5'd25;
	else
      speed = 5'd23;	
end
endmodule
//----------------------------------------------
module FSM(ledout,sec,clk,rst);
output reg [3:0]sec;
output reg [2:0]ledout;
reg [1:0]state;
input clk,rst;
parameter init=2'd0,red=2'd1,green=2'd2,yellow=2'd3;
always@(posedge clk or negedge rst)
begin
   if(~rst)
	   begin
		   sec<=4'd0;
			state<=init;
		end
	else begin
	   case(state)
		   init:begin
			   sec<=4'd0;
				state<=red;
			end
			red:begin
			   if(sec<4'd9)
				   sec<=sec+1;
				else begin
				   sec<=4'd0;
					state<=green;
				end
			end
			green:begin
			   if(sec<4'd6)
				   sec<=sec+1;
				else begin
				   sec<=4'd0;
					state<=yellow;
				end
			end
			yellow:begin
			   if(sec<4'd3)
				   sec<=sec+1;
				else begin
				   sec<=4'd0;
					state<=red;
				end
			end
			default:begin
			   sec<=4'd0;
				state<=init;
		   end
		endcase
	end
end
always@(state)begin
   case(state)
	   init:ledout<=3'b000;
		red:ledout<=3'b100;
		green:ledout<=3'b010;
		yellow:ledout<=3'b001;
		default:ledout<=2'b000;
	endcase
end
endmodule
//-----------------------------------------------
module seg7(out,outselect,in);
   input [3:0] in;
	output [3:0] outselect;
	output reg [7:0] out;
assign outselect=4'b0000;
always@(*)begin
   case(in)
	4'd0:  begin out=8'b00000011; end
	4'd1:  begin out=8'b10011111; end
	4'd2:  begin out=8'b00100101; end
	4'd3:  begin out=8'b00001101; end
	4'd4:  begin out=8'b10011001; end
	4'd5:  begin out=8'b01001001; end
	4'd6:  begin out=8'b01000001; end
	4'd7:  begin out=8'b00011111; end
	4'd8:  begin out=8'b00000001; end
	4'd9:  begin out=8'b00001001; end
	4'd9:  begin out=8'b00001001; end
	4'd10: begin out=8'b00010001; end
	4'd11: begin out=8'b11000001; end
	4'd12: begin out=8'b11000001; end
	4'd13: begin out=8'b10000101; end
	4'd14: begin out=8'b01100001; end
	4'd15: begin out=8'b01110001; end
   default:;
	endcase
end
endmodule
