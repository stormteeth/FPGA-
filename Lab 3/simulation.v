module a;

	// Inputs
	reg clk;
	reg in;
	reg rst;
	reg ctr;
	reg [3:0] a;

	// Outputs
	wire [3:0] sum;
	wire led;

	// Instantiate the Unit Under Test (UUT)
	lab3 uut (
		.sum(sum), 
		.led(led), 
		.clk(clk), 
		.in(in), 
		.rst(rst), 
		.ctr(ctr), 
		.a(a)
	);
	initial 
	clk = 0;
	always #5 clk=~clk;
   	initial begin
		// Initialize Inputs
      in=1;
		a=0;
		ctr=0;
      rst=1;
		#1 rst=0;
		#1 rst=1;
//------------------------
      #1 in=0;
		#30 in=1;
		#30 in=0;
		#30 in=1;
		#30 in=0;
	end
      
endmodule
