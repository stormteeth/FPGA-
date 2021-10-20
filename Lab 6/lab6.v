module lab6(segout,row,column,segselect,clk ,rst);
output [7:0]segout,row,column;
output [3:0]segselect;
input clk,rst;
wire clked1,clked2;
wire [2:0] switch;
wire out_clk1,out_clk2;
wire[3:0]sec;
div d1(out_clk1,out_clk2,clk,rst);
seg7 o(segout,segselect,sec);
FSM U(switch,sec,out_clk1,rst);
shild S(row,column,switch,rst,out_clk2);
endmodule
//---------------------------------------------------------
module FSM(switch,sec,clk,rst);
output reg [3:0] sec;
output reg [2:0]switch;
reg[1:0]state;
input clk,rst;
reg[24:0]devcnt;
parameter  init=2'd0,red=2'd1,green=2'd2,yellow=2'd3;
always @(posedge clk or negedge rst)begin
   if(~rst) begin
      sec<=4'd9;
      state<=init;
      switch<=0;
   end
   else begin
      case(state)
         init:begin
            sec<=4'd9;
            state<=red;
	    switch<=1;
         end
         red:begin
            if(sec>4'd0)
               sec<=sec-1;
            else begin
               sec<=4'd6;
               state<=green;
	       switch<=2;
            end
         end
         green:begin
            if(sec>4'd0)
               sec<=sec-1;
            else begin
               sec<=4'd3;
               state<=yellow;
	       switch<=3;
            end
         end
         yellow:begin
            if(sec>4'd0)
               sec<=sec-1;
            else begin
               sec<=4'd9;
               state<=red;
	       switch<=1;
            end
         end
         default:begin
            switch<=0;
            sec<=4'd9;
            state<=init;
         end
      endcase
   end
end
endmodule
//------------------------------------------------------------
module div(out_clock1,out_clock2,in_clk,reset);
output out_clock1,out_clock2;
input in_clk;
input reset;
reg[27:0] tmp;
assign out_clock1 = tmp[23];
assign out_clock2 = tmp[12];
always@(posedge in_clk or negedge reset)begin
   if(~reset)begin
      tmp <= 27'd0;
   end
   else begin
      tmp<=tmp+27'd1;
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
//---------------LED矩陣-------------------------------
module shild(row,column,switch,rst,clk);
output reg[7:0]row,column;
input rst,clk;
input [2:0] switch;
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
         8'b0111_1111:column<=~8'b00111000;
	 8'b1011_1111:column<=~8'b00100100;
	 8'b1101_1111:column<=~8'b00100100;
	 8'b1110_1111:column<=~8'b00111000;
	 8'b1111_0111:column<=~8'b00110000;
	 8'b1111_1011:column<=~8'b00101000;
	 8'b1111_1101:column<=~8'b00100100;
	 8'b1111_1110:column<=~8'b00100010;
	 default:column<=8'd0;
      endcase
   end
   if(switch==2)begin
      case(row)
         8'b0111_1111:column<=~8'b00000000;
	 8'b1011_1111:column<=~8'b00111100;
	 8'b1101_1111:column<=~8'b01000000;
	 8'b1110_1111:column<=~8'b01000000;
	 8'b1111_0111:column<=~8'b01001110;
	 8'b1111_1011:column<=~8'b01000010;
	 8'b1111_1101:column<=~8'b00111110;
	 8'b1111_1110:column<=~8'b00000010;
	 default:column<=8'd0;
      endcase
   end
   if(switch==3)begin
      case(row)
         8'b0111_1111:column<=~8'b00000000;
	 8'b1011_1111:column<=~8'b11000011;
	 8'b1101_1111:column<=~8'b01100110;
	 8'b1110_1111:column<=~8'b00011000;
	 8'b1111_0111:column<=~8'b00011000;
	 8'b1111_1011:column<=~8'b00011000;
	 8'b1111_1101:column<=~8'b00011000;
	 8'b1111_1110:column<=~8'b00011000;
	 default:column<=8'd0;
      endcase
   end
end
endmodule
