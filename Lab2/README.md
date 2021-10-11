### [題目](https://github.com/stormteeth/FPGA-#lab-2)
這題最主要的部份是控制FPGA版的時脈，這題提到了加速與減速故我將一秒設為正常速度。

在繼續之前需要提到一個概念那便是除頻器，我們假設我們的震盪晶片是1Hz，所以他每秒會加一。以下面程式碼來說我們給了divclk 5個位元，從0到15所以正常跑完需要16秒。那如果我們在編寫時以一個暫存來計數clock便可調整我們的速度speed便是指我們的divclkout是根據divclk的第二個位元來輸出的
  ```verilog
  output divclkout;
  input clk;
  reg [4:0] divclk;
  reg speed = 1'b1;
  assign divclkout = divclk[speed];
  always@(posedge clk)begin
      divclk <= divclk + 1'd1;
  end
  ```

以這塊板子來說其自帶的震盪晶片頻率為40MHz，故我們在設計除頻器時
