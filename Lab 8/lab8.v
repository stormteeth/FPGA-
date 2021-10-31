module lab8(lcd_db,lcd_en,lcd_rw,lcd_rs,clk,rst);
output reg [7:0]lcd_db;
output reg lcd_en,lcd_rs;
output lcd_rw;
input clk,rst;

assign lcd_rw=1'b0;
parameter idle=4'd0,setup_mode=4'd1,write_mode=4'd2,setup_display=4'd3,write_display=4'd4,setup_clear=4'd5,write_clear=4'd6;
parameter setup_position=4'd7,write_position=4'd8,setup_data=4'd9,write_data=4'd10;
reg [3:0]state;
reg [3:0]datacnt;

wire [7:0]romdata[7:0];
assign romdata[0]=8'h55;
assign romdata[1]=8'h30;
assign romdata[2]=8'h35;
assign romdata[3]=8'h35;
assign romdata[4]=8'h32;
assign romdata[5]=8'h30;
assign romdata[6]=8'h37;
assign romdata[7]=8'h32;
reg[19:0]divclk;
always@(posedge clk or negedge rst)begin
   if(~rst)
	   divclk<=20'd0;
	else
	   divclk<=divclk+1;
end

always@(posedge divclk[19] or negedge rst)begin
   if(~rst)begin
	  state<=idle;
	  datacnt<=4'd0;
	 end
	 else begin
	    case(state)
		    idle:begin
			    datacnt<=4'd0;
				 state<=setup_mode;
			 end
			 //----Mode Command--------
			 setup_mode:state<=write_mode;
			 write_mode:state<=setup_display;
			 //----Display Command-----
			 setup_display:state<=write_display;
			 write_display:state<=setup_clear;
		    //----Clear Command-------
			 setup_clear:state<=write_clear;
			 write_clear:state<=setup_position;
			 //----Position Command----
 			 setup_position:state<=write_position;
			 write_position:state<=setup_data;
          //----Data----------------
			 setup_data:state<=write_data;
			 write_data:begin
			    if(datacnt<4'd7)begin
				    datacnt<=datacnt+1;
					 state<=setup_data;
				 end
				 else
				    state<=state;
			 end
			 default:state<=idle;
		 endcase
	end
end
//-----------------------------------------
always@(state)begin
   case(state)
	   idle:begin
		   lcd_en<=1'b1;
			lcd_rs<=1'b0;
			lcd_db<=8'd0;
		end
	//--------mode command--------
		setup_mode:begin
		   lcd_en<=1'b1;
			lcd_rs<=1'b0;
			lcd_db<=8'b0011_1000;
		end
		write_mode:begin
		   lcd_en<=1'b0;
			lcd_rs<=1'b0;
			lcd_db<=8'b0011_1000;
		end
	//------display command-------
		setup_display:begin
		   lcd_en<=1'b1;
			lcd_rs<=1'b0;
			lcd_db<=8'b0000_1110;
		end
		write_display:begin
		   lcd_en<=1'b0;
			lcd_rs<=1'b0;
			lcd_db<=8'b0000_1110;
		end
	//---------clear command------
		setup_clear:begin
		   lcd_en<=1'b1;
			lcd_rs<=1'b0;
			lcd_db<=8'b0000_0001;
		end
		write_clear:begin
		   lcd_en<=1'b0;
			lcd_rs<=1'b0;
			lcd_db<=8'b0000_0001;
		end
   //------position command------		
		setup_position:begin
		   lcd_en<=1'b1;
			lcd_rs<=1'b0;
			lcd_db<=8'b1000_0000;
		end	
		write_position:begin
		   lcd_en<=1'b0;
			lcd_rs<=1'b0;
			lcd_db<=8'b1000_0000;
		end	
   //------data------------------  		
		setup_data:begin
		   lcd_en<=1'b1;
			lcd_rs<=1'b1;
			lcd_db<=romdata[datacnt];
		end
		write_data:begin
		   lcd_en<=1'b0;
			lcd_rs<=1'b1;
			lcd_db<=romdata[datacnt];
		end
		
		default:begin
		   lcd_en<=1'b1;
			lcd_rs<=1'b0;
			lcd_db<=8'b0;	
      end
   endcase
end	
endmodule
