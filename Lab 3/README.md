 ### [題目]()
 
 這次的題目最主要的部份在於我們兩個模式在轉換的時候可能會因為震盪頻率過快導致按下按鈕時產生了多次的狀態改變，所以需要使用到除彈跳的概念。那我們除彈跳的做法其實很單純，只要我們用到上個Lab 2的概念便可以達成。
```verilog
reg [23:0]decnt;
parameter bound=24'hffffff;

always@(posedge clk or posedge rst)begin
    if(rst)begin
        decnt<=0;
	divclk<=0;
    end
    else begin
        if(in)begin
	    if(decnt<bound)begin
	        decnt<=decnt+1;
		divclk<=0;
	    end
	    else begin
	        decnt<=decnt;
	        divclk<=1;
	    end
        end
        else begin
            decnt<=0;
	    divclk<=0;
        end
    end
end
```
當我們的晶片以其正常的速度在計數的時候可以看到我們的decnt一直在計數是否有大於bound，我們的bound取24是剛好接近真實世界的1秒，故當我們按滿大約1秒時才會輸出轉換模式的訊號。

最外層:

![](result/Lab3-1)

中間層:

![](result/Lab3-2)

波型模擬:

![](result/Lab3-3)

