`timescale 1ns / 1ps 

module simulation; 
// Inputs 
reg clk; 
reg rst; 
reg speedup; 
reg speedD; 
reg ctr1; 

// Outputs 
wire [3:0] cntout; 

// Instantiate the Unit Under Test (UUT) 
lab2 uut (.cntout(cntout),.clk(clk),.rst(rst),
           .speedup(speedup),.speedD(speedD),.ctr1(ctr1)); 

always #5 clk=~clk; 

initial begin 
// Initialize Inputs 
rst = 0; 
ctr1 = 1; 
speedup = 0; 
speedD = 1; 
 
#50 rst = 1; 
    ctr1 = 0; 
    speedup = 1; 
    speedD = 0; 

#50 ctr1 = 1; 
end 
endmodule
