module labT;

	// Inputs
	reg clk;
	reg rst;
	reg [3:0] row;
	reg set;

	// Outputs
	wire [1:0] right;
	wire [2:0] col;
	wire [3:0] keyV;
	wire enable;
	wire [7:0] ledC;
	wire [7:0] ledR;
	wire [3:0] runV;
	wire [7:0] seg_out;
	wire [3:0] seg_sele;

	// Instantiate the Unit Under Test (UUT)
	lab7 uut (
		.right(right), 
		.col(col), 
		.keyV(keyV), 
		.enable(enable), 
		.ledC(ledC), 
		.ledR(ledR), 
		.runV(runV), 
		.clk(clk), 
		.seg_out(seg_out), 
		.seg_sele(seg_sele), 
		.rst(rst), 
		.row(row), 
		.set(set)
	);
   always #5 clk=~clk;
	initial begin
		clk = 0;
		rst = 0;
		#5 rst = 1'b0;
		#5 rst = 1'b1;
   end
	initial begin
	row = 4'b0111;
	set = 0;
	#25 set = 1'b1;
	#1 set = 1'b0;
	#5000000 row = 4'b1110;
	end    
endmodule
