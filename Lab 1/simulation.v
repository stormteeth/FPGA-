`timescale 1ns / 1ps
module simulation;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;

	// Outputs
	wire [3:0] d;
	wire [3:0] cout;

	// Instantiate the Unit Under Test (UUT)
	lab1 uut (
		.d(d), 
		.cout(cout), 
		.a(a), 
		.b(b)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 15;
		// Wait 100 ns for global reset to finish
		#100 $finish;
        
		// Add stimulus here

	end
      
endmodule
