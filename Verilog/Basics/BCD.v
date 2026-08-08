module fulladder (input a,b,cin, output s,c);
    assign s=a^b^cin;
    assign c=(a&b) | (a&cin) | (b&cin);
endmodule

module ripplecarryadder(input [3:0]ar, input [3:0]br,input car,output [3:0]sar, output cout);
    wire w1,w2,w3;
    fulladder fa1(ar[0],br[0],car,sar[0],w1);
    fulladder fa2(ar[1],br[1],w1,sar[1],w2);
    fulladder fa3(ar[2],br[2],w2,sar[2],w3);
    fulladder fa4(ar[3],br[3],w3,sar[3],cout);
endmodule

module bcd(input [3:0]ad,input [3:0]bd,input cin, output [3:0]sd, output coutd);
    wire [3:0] sumtemp;
    wire couttemp;
    wire w1,w2,w3;
    wire [3:0]btemp;
    ripplecarryadder ra1(ad,bd,cin,sumtemp,couttemp);
    and(w1,sumtemp[3],sumtemp[2]);
    and(w2,sumtemp[1],sumtemp[0]);
    or(w3,w1,w2,couttemp);
    assign btemp[0]=1'b0;
    assign btemp[1]=w3;
    assign btemp[2]=w3;
    assign btemp[3]=1'b0;   
    ripplecarryadder ra2(sumtemp,btemp,1'b0,sd,coutd);
endmodule