module lab9(column,seg7_out,seg7_selected,Fout,Tout,row,clk,rst);
output [2:0]column;
output [7:0]seg7_out;
output [3:0]seg7_selected;
output Fout,Tout;
input [3:0] row;
input clk,rst;
wire enable;
wire [3:0]keyV,seg7value;
wire [3:0]out0,out1,out2,out3;
div d1(out_clock,clk,rst);
keaypad k1(column,keyV,enable,row,out_clock,rst);
FSM f1(out0,out1,out2,out3,Fout,Tout,keyV,enable,rst,clk);
seg7out_switch s1(seg7_selected,seg7value,out_clock,rst,out0,out1,out2,out3);
seg7 o(seg7_out,seg7value);
endmodule
//------------------------------------------------------------
module div(out_clock,in_clk,reset);
output out_clock;
input in_clk;
input reset;
reg[27:0] tmp;
assign out_clock = tmp[12];
always @( posedge in_clk or negedge reset)begin
   if(~reset) begin
      tmp <= 27'd0;
   end
   else begin
      tmp<=tmp+27'd1;
   end
end
endmodule
//--------------------------------------------
module FSM(out0,out1,out2,out3,Fout,Tout,keyV,keyevent,rst,clk);
output reg  Fout,Tout;
output [3:0]out0,out1,out2,out3;
input rst,clk,keyevent;
input [3:0] keyV;
reg [2:0]keycount,state;
reg [3:0]buffer[3:0];
assign out0=buffer[0];
assign out1=buffer[1];
assign out2=buffer[2];
assign out3=buffer[3];

integer i;
parameter init=3'd0,waitkey=3'd1,checkinput=3'd2, compare=3'd3,true=3'd4,false=3'd5;
parameter pwd0=4'd2,pwd1=4'd0,pwd2=4'd7,pwd3=4'd2;

always@(posedge clk or negedge rst)begin
   if(~rst)begin
      state<=init;
      keycount<=3'd0;
      for(i=0;i<4;i=i+1)
         buffer[i]<=4'd0;
   end
   else begin
      case(state)
         init:begin
            state<=waitkey;
	 end
	 waitkey:begin
            if(keyevent==1)begin
               buffer[keycount]<=keyV;
               keycount<=keycount+1;
               state<=checkinput;
            end
         end
         checkinput:begin
            if(keyevent==0 && keycount<4)
               state<=waitkey;
            else if(keycount==4)
               state<=compare;
         end
         compare:begin
            if(pwd0==buffer[0] && pwd1==buffer[1] && pwd2==buffer[2] && pwd3==buffer[3])begin
               Tout<=1;
               Fout<=0;
            end
            else begin
               Tout<=0;
               Fout<=1;		
	    end
         end
         default:begin
	    state<=init;
            keycount<=3'd0;
            for(i=0;i<4;i=i+1)
               buffer[i]<=4'd0;
         end
      endcase
   end
end
endmodule
//-----------------------------------------------------
module keaypad(column,value,enable,row,clk,rst);
output reg [2:0]column;
output reg [3:0]value;
output reg enable;
reg[1:0]unscan;
input [3:0]row;
input clk,rst;
always@(posedge clk or negedge rst)begin
   if(~rst)
      column<=3'b110;
   else
      column<={column[1:0],column[2]};
end
always@(posedge clk or negedge rst)begin
   if(~rst)begin
      value<=4'd0;
      enable<=0;
      unscan<=0;
   end
   else begin
      case(column)
         3'b110:begin
            case(row)
               4'b0111:begin value<=4'd3; enable<=1;unscan<=0; end
               4'b1011:begin value<=4'd6; enable<=1;unscan<=0; end
               4'b1101:begin value<=4'd9; enable<=1;unscan<=0; end
               4'b1110:begin value<=4'd11; enable<=1;unscan<=0; end
               default:begin 
                  if(unscan!=2'd3)begin
                     unscan<=unscan+1;
                     value<=value;
                     enable<=enable;
                  end
                  else begin
                     unscan<=unscan;
                     value<=0;
                     enable<=0;
                  end
               end
            endcase
         end
         3'b101:begin
            case(row)
               4'b0111:begin value<=4'd2; enable<=1;unscan<=0; end
               4'b1011:begin value<=4'd5; enable<=1;unscan<=0; end
               4'b1101:begin value<=4'd8; enable<=1;unscan<=0; end
               4'b1110:begin value<=4'd0; enable<=1;unscan<=0; end
               default:begin 
                  if(unscan!=2'd3)begin
                     unscan<=unscan+1;
                     value<=value;
                     enable<=enable;
                  end
                  else begin
                     unscan<=unscan;
                     value<=0;
                     enable<=0;
                  end
               end
            endcase
         end
         3'b011:begin
            case(row)
               4'b0111:begin value<=4'd1; enable<=1;unscan<=0; end
               4'b1011:begin value<=4'd4; enable<=1;unscan<=0; end
               4'b1101:begin value<=4'd7; enable<=1;unscan<=0; end
               4'b1110:begin value<=4'd10; enable<=1;unscan<=0; end
               default:begin 
                  if(unscan!=2'd3)begin
                     unscan<=unscan+1;
                     value<=value;
                     enable<=enable;
                  end
                  else begin
                     unscan<=unscan;
                     value<=0;
                     enable<=0;
                  end
               end
            endcase
         end
         default:begin value<=4'd0; enable<=0;unscan<=0; end
      endcase
   end
end
endmodule
//--------------------------------------------
module seg7out_switch(seg7_select,seg7value,clk,rst,in0,in1,in2,in3);
output reg [3:0] seg7_select,seg7value;
input [3:0] in0,in1,in2,in3;
input clk,rst;
always@(posedge clk or negedge rst)begin
   if(~rst)
      seg7_select<=4'b0111;
   else
      seg7_select<={seg7_select[2:0],seg7_select[3]};
end	
always@(*)begin
   case(seg7_select)
      4'b0111:seg7value<=in0;
      4'b1011:seg7value<=in1;
      4'b1101:seg7value<=in2;
      4'b1110:seg7value<=in3;
      default:seg7value<=4'd0;
   endcase
end
endmodule
//-----------------------------------------------------------
module seg7(seg7_out,in);
output reg [7:0] seg7_out;
input [3:0] in;
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
