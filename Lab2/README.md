### [題目](https://github.com/stormteeth/FPGA-#lab-2)
這題最主要的部份是控制FPGA版的時脈，這題提到了加速與減速故我將一秒設為正常速度。

在繼續之前需要提到一個概念那便是除頻器，我們假設我們的震盪晶片是1Hz，所以他每秒會加一。那如果我們在編寫時以一個暫存來計數clock便可調整我們的速度
  ```verilog
  always@(posedge clock)begin
  
  end
  ```

以這塊板子來說其自帶的震盪晶片頻率為40MHz，故我們在設計除頻器時
