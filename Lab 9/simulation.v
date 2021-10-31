module simulation;

	// Inputs
	reg [3:0] row;
	reg clk;
	reg rst;

	// Outputs
	wire [2:0] column;
	wire [7:0] seg7_out;
	wire [3:0] seg7_selected;
	wire Fout;
	wire Tout;

	// Instantiate the Unit Under Test (UUT)
	lab9 uut (
		.column(column), 
		.seg7_out(seg7_out), 
		.seg7_selected(seg7_selected), 
		.Fout(Fout), 
		.Tout(Tout), 
		.row(row), 
		.clk(clk), 
		.rst(rst)
	);
   always #5 clk=~clk;
	initial begin
		// Initialize Inputs
		row = 0;
		clk = 0;
		rst = 0;
      //value1-------2
		#10 rst = 1;
		#80 row = 4'b0111;
      #20 row = 4'b0000;
      //value1-------0
		#90 row = 4'b1110;
      #20 row = 4'b0000;
      //value1-------3
		#90 row = 4'b0111;
      #20 row = 4'b0000;
      //value1-------6
		#90 row = 4'b1011;
      #20 row = 4'b0000;
	end
      
endmodule
