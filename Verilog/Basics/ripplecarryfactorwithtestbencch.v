module fulladder (input a,b,cin, output reg s,c);
    always@(*) begin
        s = a^b^cin;
        c = (a&b) | (b&cin) | (cin&a);  
    end
endmodule

module ripplecarry(input [3:0]a,input[3:0]b,input cin, output [3:0]sum,output cout);
    wire w1,w2,w3;
    fulladder fa1(a[0],b[0],cin,sum[0],w1);
    fulladder fa2(a[1],b[1],w1,sum[1],w2);
    fulladder fa3(a[2],b[2],w2,sum[2],w3);
    fulladder fa4(a[3],b[3],w3,sum[3],cout);
endmodule

module tb;
    reg [3:0] at, bt;
    reg ct;
    wire [3:0]st;
    wire cti;
    ripplecarry ra1(at,bt,ct,st,cti);
    initial begin
        {at,bt,ct}=9'b111111111;
        #1
        $display ("%b  %b   %b   %b     %b",at,bt,ct,st,cti);
    end
endmodule