module lab4(value,led,outselect,out,clk,in,rst,set,a);
input clk,in,rst,set;
input [3:0] a;
wire divclk;
wire [3:0] sum;
output [3:0] value;
output [3:0] outselect;
output [7:0] out;
output led;
botton b1(divclk,in,clk,rst);
Random r1(value,set,rst,clk,divclk);
N4add a1(sum,led,value,a);
seg7 s1(out,outselect,sum);
endmodule
//--------除彈跳---------------------------------------
module botton(divclk,in,clk,rst);
input in,clk,rst;
output reg divclk;
reg [23:0]decnt;
parameter bound=24'hffffff;
always@(posedge clk or negedge rst)begin
	if(~rst)begin
		decnt<=0;
		divclk<=0;
	end
	else begin
        	if(~in)begin
	    		if(decnt<bound)begin
	        		decnt<=decnt+1;
				divclk<=1;
	    		end
	    		else begin
	        		decnt<=decnt;
				divclk<=1;
            		end
		end
		else begin
	    		decnt<=0;
	    		divclk<=0;
		end
    	end
end
endmodule
//---------4位元---------------------------------
module N4add(d,o,a,b);

wire [3:0] s,cout;
output [3:0]d;
output o;
input [3:0]a,b;

fa fa1(.s(s[0]),.cout(cout[0]),.a(a[0]),.b(~b[0]),.cin(cout[3]));
fa fa2(.s(s[1]),.cout(cout[1]),.a(a[1]),.b(~b[1]),.cin(cout[0]));
fa fa3(.s(s[2]),.cout(cout[2]),.a(a[2]),.b(~b[2]),.cin(cout[1]));
fa fa4(.s(s[3]),.cout(cout[3]),.a(a[3]),.b(~b[3]),.cin(cout[2]));
assign d[0]=s[0]^(~cout[3]);
assign d[1]=s[1]^(~cout[3]);
assign d[2]=s[2]^(~cout[3]);
assign d[3]=s[3]^(~cout[3]);
assign o=~cout[3];

endmodule
//-------------------------------------------
module fa(s,cout,a,b,cin);
output s,cout;
input a,b,cin;

assign s=~a^~b^cin;
assign cout = (~a&~b) | (cin&(~a^~b));
endmodule
//-----------亂數---------------------------------
module Random(value,set,rst,clk,start);
output reg [3:0] value;
input set,rst,clk,start;
reg [3:0] seedcnt;

always@(posedge clk or negedge rst)begin
    if(~rst)
        seedcnt <= 4'd0;
    else 
        seedcnt <= seedcnt+1;
end
always@(posedge start or negedge set)begin
	if(~set)
        	value<=seedcnt;
    	else begin
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
//-------------七段--------------------------------
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
