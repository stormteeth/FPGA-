`timescale 1ns / 1ps 

module simulation; 

 

// Inputs 

reg clk; 

reg rst; 

 

// Outputs 

wire [7:0] lcd_db; 

wire lcd_en; 

wire lcd_rw; 

wire lcd_rs; 

 

// Instantiate the Unit Under Test (UUT) 

lab8 uut ( 

.lcd_db(lcd_db),  

.lcd_en(lcd_en),  

.lcd_rw(lcd_rw),  

.lcd_rs(lcd_rs),  

.clk(clk),  

.rst(rst) 

); 

 

   always #5 clk=~clk; 

initial begin 

// Initialize Inputs 

      clk=0; 

rst=1; 

#1 rst = 0; 

#1 rst = 1; 

// Wait 100 ns for global reset to finish 

#100; 

end 

endmodule