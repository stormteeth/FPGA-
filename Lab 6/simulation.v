`timescale 1ns / 1ps
module simulation;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [7:0] segout;
	wire [7:0] row;
	wire [7:0] column;
	wire [3:0] segselect;

	// Instantiate the Unit Under Test (UUT)
	lab6 uut (
		.segout(segout), 
		.row(row), 
		.column(column), 
		.segselect(segselect), 
		.clk(clk), 
		.rst(rst)
	);
 always #5 clk=~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
   #1 rst = 0;
   #1 rst = 1;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule
