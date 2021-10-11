module lab2(cntout,clk,rst,speedup,speedD,ctr1);
output [3:0] cntout;
input clk;
input rst;
input speedup;
input speedD;
input ctr1;
wire divclk;
div d1(divclk,clk,rst,speedup,speedD);
cnt4 c1(cntout,divclk,rst,ctr1);
endmodule

module div(divclkout,clk,rst,speedup,speedD);
output divclkout;
input clk;
input rst;
input speedup;
input speedD;
reg [25:0] divclk;
reg [4:0] speed;
assign divclkout = divclk[speed];

always@(posedge clk or negedge rst)begin
    if(~rst)
        divclk <= 26'd0;
    else begin
        divclk <= divclk + 1'd1;
    end
end

always@(speedup,speedD,rst)begin
    if(~rst)
        speed = 5'd23;
    else if(~speedup)
        speed = 5'd22;
    else if(~speedD)
	speed = 5'd24;
    else
        speed = 5'd23;	
end
endmodule
	
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
