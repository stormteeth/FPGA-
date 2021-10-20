module lab7(right,col,keyV,enable,ledC,ledR,runV,clk,seg_out,seg_sele,rst,row,set);
output [1:0] right;
output [2:0] col;
output [3:0] seg_sele,runV,keyV;
output enable;
output [7:0] seg_out,ledC,ledR;
input clk,rst,set;
input [3:0] row;
wire out_clock,start,enable;
wire [3:0] keyV,runV;
wire [1:0] right;
div d1(out_clock,clk,rst);
Random R1(runV,set,rst,clk,start);
keaypad k1(col,keyV,enable,row,clk,rst);
compare c1(right,enable,keyV,runV,start,rst,clk);
shild s1(ledR,ledC,right,rst,out_clock);
seg7 o(seg_out,seg_sele,keyV);
endmodule
//------------------------------------------------------------
module div(out_clock,in_clk,reset);
output out_clock;
input in_clk;
input reset;
reg[27:0] tmp;
assign out_clock = tmp[23];
always @( posedge in_clk or negedge reset)
begin
   if(~reset) begin
      tmp <= 27'd0;
   end
   else begin
      tmp<=tmp+27'd1;
   end
end
endmodule
//--------------------------------------------
module Random(value,set,rst,clk,start);
output reg [3:0] value;
output reg start;
input set,rst,clk;
reg [3:0] seedcnt;

always@(posedge clk or negedge rst)
begin
   if(~rst)
      seedcnt <= 4'd0;
   else 
      seedcnt <= seedcnt+1;
end
always@(posedge set or negedge rst)
begin
   if(set)
	   start<=1;
	else
	   start<=0;
   if(~rst)begin
	   value<=4'd0;
	   start<=0;
		end
	else begin
	start<=1;
	   if(value==4'd0)
		   value<=seedcnt;
   else begin
	   value[0]<=value[3]^value[2];
		value[1]<=value[2]^value[1];
		value[2]<=value[1]^value[0];
		value[3]<=value[0]^value[3];
	end
	end
end
endmodule
//--------------------------------------------
module compare(right,enable,value1,value2,start,rst,clk);
output reg [1:0] right;
input start,rst,clk,enable;
input [3:0] value1,value2;
always@(posedge clk or negedge rst)
begin
   if(~rst)begin
	   right<=0;
	end
	else begin
   if(start == 1 && enable == 1)begin
	   if(value1>value2)
		   right<=1;
		else if(value1<value2)
		   right<=2;
		else if(value1==value2)
		   right<=3;
		end
	   else begin
	      right<=0;
	   end
	end
end
endmodule
//-----------------------------------------------
module shild(row,column,switch,rst,clk);
output reg[7:0]row,column;
input rst,clk;
input [1:0] switch;
reg[11:0]devcnt;
always@(posedge clk or negedge rst)
begin
   if(~rst)
	   row<=8'b1111_1110;
	else
	   row<={row[6:0],row[7]};
end
always@(row,switch)begin
   if(switch==0)
		column<=8'd0;
   if(switch==1)begin
	   case(row)
		8'b0111_1111:column<=~8'b00011000;
		8'b1011_1111:column<=~8'b00011000;
		8'b1101_1111:column<=~8'b00011000;
		8'b1110_1111:column<=~8'b00011000;
		8'b1111_0111:column<=~8'b10011001;
		8'b1111_1011:column<=~8'b01011010;
		8'b1111_1101:column<=~8'b00111100;
		8'b1111_1110:column<=~8'b00011000;
		default:column<=8'd0;
		endcase
	end
	if(switch==2)begin
		   case(row)
		8'b0111_1111:column<=~8'b00011000;
		8'b1011_1111:column<=~8'b00111100;
		8'b1101_1111:column<=~8'b01011010;
		8'b1110_1111:column<=~8'b10011001;
		8'b1111_0111:column<=~8'b00011000;
		8'b1111_1011:column<=~8'b00011000;
		8'b1111_1101:column<=~8'b00011000;
		8'b1111_1110:column<=~8'b00011000;
		default:column<=8'd0;
		endcase
	end
	if(switch==3)begin
	      case(row)
		8'b0111_1111:column<=~8'b00111100;
		8'b1011_1111:column<=~8'b01000010;
		8'b1101_1111:column<=~8'b10000001;
		8'b1110_1111:column<=~8'b10000001;
		8'b1111_0111:column<=~8'b10000001;
		8'b1111_1011:column<=~8'b10000001;
		8'b1111_1101:column<=~8'b01000010;
		8'b1111_1110:column<=~8'b00111100;
		default:column<=8'd0;
		endcase
	end
end
endmodule
//-----------------------------------------------------
module keaypad(column,value,enable,row,clk,rst);
output reg [2:0]column;
output reg [3:0]value;
output reg enable;
reg[16:0]devcnt;
input [3:0]row;
input clk,rst;

always@(posedge clk or negedge rst)begin
   if(~rst)
	   devcnt<=0;
	else
	   devcnt<=devcnt+1;
end
always@(posedge devcnt[16] or negedge rst)begin
   if(~rst)
	   column<=3'b110;
	else
	   column<={column[1:0],column[2]};
end
always@(posedge devcnt[16] or negedge rst)begin
   if(~rst)begin
	   value<=4'b0;
		enable<=0;
	end
	else begin
	   case(column)
		3'b110:begin
		   case(row)
			4'b0111:begin value<=4'd3; enable<=1; end
			4'b1011:begin value<=4'd6; enable<=1; end
			4'b1101:begin value<=4'd9; enable<=1; end
			4'b1110:begin value<=4'd11; enable<=1; end
			default:begin value<=value; enable<=0; end
			endcase
		end
		3'b101:begin
		   case(row)
			4'b0111:begin value<=4'd2; enable<=1; end
			4'b1011:begin value<=4'd5; enable<=1; end
			4'b1101:begin value<=4'd8; enable<=1; end
			4'b1110:begin value<=4'd0; enable<=1; end
			default:begin value<=value; enable<=0; end
			endcase
		end
		3'b011:begin
		   case(row)
			4'b0111:begin value<=4'd1; enable<=1; end
			4'b1011:begin value<=4'd4; enable<=1; end
			4'b1101:begin value<=4'd7; enable<=1; end
			4'b1110:begin value<=4'd10; enable<=1; end
			default:begin value<=value; enable<=0; end
			endcase
		end
      default:begin value<=4'd0; enable<=0; end
      endcase
   end
end
endmodule
//-----------------------------------------------------------
module seg7(seg7_out,seg7_select,in);
output reg [7:0] seg7_out;
output [3:0] seg7_select;
input [3:0] in;

assign seg7_select=4'b0000;
always @(*)begin
	case(in)
	4'd0: begin seg7_out=8'b00000011; end
	4'd1: begin seg7_out=8'b10011111; end
	4'd2: begin seg7_out=8'b00100101; end
	4'd3: begin seg7_out=8'b00001101; end
	4'd4: begin seg7_out=8'b10011001; end
	4'd5: begin seg7_out=8'b01001001; end
	4'd6: begin seg7_out=8'b01000001; end
	4'd7: begin seg7_out=8'b00011111; end
	4'd8: begin seg7_out=8'b00000001; end
	4'd9: begin seg7_out=8'b00001001; end
	4'd10: begin seg7_out=8'b00010001; end
	4'd11: begin seg7_out=8'b11000001; end
	4'd12: begin seg7_out=8'b01100001; end
	4'd13: begin seg7_out=8'b10000101; end
	4'd14: begin seg7_out=8'b01100001; end
	4'd15: begin seg7_out=8'b01110001; end
	default:;
	endcase
end
endmodule
