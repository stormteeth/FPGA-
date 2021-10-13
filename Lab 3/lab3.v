module lab3(sum,led,clk,in,rst,ctr,a);
input clk,in,rst,ctr;
input [3:0] a;
wire divclk;
wire [3:0]cntout;
output [3:0] sum;
output led;
button b1(divclk,in,clk,rst);
cnt4 c1(cntout,divclk,rst,ctr);
N4add a1(sum,led,cntout,a);
endmodule
//-----------------------------------------------
module button(divclk,in,clk,rst);
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
//------------------------------------------
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
//--------------------------------------------
module cnt4(cntout, clk, rst, ctr1);
output reg [3:0] cntout;
input clk,rst,ctr1;

always@(posedge clk or negedge rst)begin
    if(~rst)
        cntout <= 4'd0;
    else begin
        if(ctr1)
            cntout<=cntout+4'd1;
        else
            cntout<=cntout-4'd1;
    end
end
endmodule
