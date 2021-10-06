module lab1(d,o,cout,a,b);
wire [3:0] s;
output [3:0]cout,d;
output o;
input [3:0]a,b;

fa fa1(.s(s[0]),.cout(cout[0]),.a(a[0]),.b(~b[0]),.cin(cout[3]));
fa fa2(.s(s[1]),.cout(cout[1]),.a(a[1]),.b(~b[1]),.cin(cout[0]));
fa fa3(.s(s[2]),.cout(cout[2]),.a(a[2]),.b(~b[2]),.cin(cout[1]));
fa fa4(.s(s[3]),.cout(cout[3]),.a(a[3]),.b(~b[3]),.cin(cout[2]));
assign d[0]=s[0]^(~cout[3]);
assign d[1]=s[1]^(~cout[3]);
assign d[2]=s[2]^(~cout[3]);
assign d[3]=s[3]^(~cout[3]);
assign o=~cout[3];
endmodule

module fa(s,cout,a,b,cin);
output s,cout;
input a,b,cin;

assign s=a^b^cin;
assign cout = (a&b) | (cin&(a^b));
endmodule
