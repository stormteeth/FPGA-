 ### [題目](https://github.com/stormteeth/FPGA-#lab-6)
這次主要的部份是使用LED矩陣去顯示我們的RGY的文字，LED矩陣式是利用快速掃描的方式來顯現我們想要它顯示的圖，所以如果將我們的LED矩陣接上除頻器的話可以看到他緩慢地從左上由左而右依序跑到右下。
```verilog
8'b0111_1111:column<=~8'b00111000;
8'b1011_1111:column<=~8'b00100100;
8'b1101_1111:column<=~8'b00100100;
8'b1110_1111:column<=~8'b00111000;
8'b1111_0111:column<=~8'b00110000;
8'b1111_1011:column<=~8'b00101000;
8'b1111_1101:column<=~8'b00100100;
8'b1111_1110:column<=~8'b00100010;
```
可以看到由ROW的第一列跑column第一行->第二行->第三行->...->第八行，再換ROW第二行執行。依序跑完後可以看出此為排R。

最外層:

![](result/Lab6-1.png)

中間層:

![](result/Lab6-2.png)

模擬波型:

![](result/Lab6-3.png)

![](result/Lab6-4.png)

LED矩陣顯示黃燈Y

![](result/Lab6-5.png)

LED矩陣顯示紅燈R

![](result/Lab6-7.png)

LED矩陣顯示綠燈G
