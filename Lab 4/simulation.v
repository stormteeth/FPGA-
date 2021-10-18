module simulation;
	reg clk;
	reg in;
	reg rst;
	reg set;
	reg [3:0] a;

	// Outputs
	wire [3:0] value;
	wire led;
	wire [3:0] outselect;
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	lab4 uut (
		.value(value), 
		.led(led), 
		.outselect(outselect), 
		.out(out), 
		.clk(clk), 
		.in(in), 
		.rst(rst), 
		.set(set), 
		.a(a)
	);
always #5 clk=~clk;
	initial begin
		clk = 0;
		in = 1;
		rst = 1;
		set = 1;
		a = 0;
		#1 rst = 0;
		#1 rst = 1;
		
		#43 set = 0;
		#5  set = 1;
		    in = 0;
			 
		#45 in = 1;
		#5 a = 4'd5;
		#10 a = 4'd1;
		
		#20 $finish;
	end
      
endmodule

