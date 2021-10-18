module T;

	// Inputs
	reg clk;
	reg speedD;
	reg rst;
	reg speedU;

	// Outputs
	wire [7:0] segout;
	wire [3:0] segselect;
	wire [2:0] ledout;

	// Instantiate the Unit Under Test (UUT)
	lab5 uut (
		.segout(segout), 
		.segselect(segselect), 
		.ledout(ledout), 
		.clk(clk), 
		.speedD(speedD), 
		.rst(rst), 
		.speedU(speedU)
	);
   always #5 clk=~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		speedD = 0;
		rst = 0;
		speedU = 0;
		#10 rst = 1;
		#30 speedD = 0;
		    speedU = 1;

		#300 speedD = 1;
		    speedU = 0;
		 // Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule
