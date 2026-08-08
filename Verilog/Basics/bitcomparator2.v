module bitcomparator2 (input [1:0]a,b, output gt,eq,lt);
    wire w1,w2,w3,w4,w5,w6,w7,w8;
    not n1(altera0,a[0]);
    not n2(altera1,a[1]);
    not n3(alterb0,b[0]);
    not n4(alterb1,b[1]);

    // for A=B code:
    xnor x1(w1,a[1],b[1]);
    xnor x2(w2,a[0],b[0]);
    and(eq,w1,w2);

    //for A<B code:
    and(w3,altera1,b[1]);
    and(w4,altera0,b[0]);
    and(w5,w4,w1);
    or(lt,w3,w5);

    //for A>B code:
    and(w6,a[1],alterb1);
    and(w7,a[0],alterb0);
    and(w8,w7,w1);
    or(gt,w6,w8);
endmodule



//test
module tb;
reg[1:0]a,b;
wire gt,eq,lt;

bitcomparator2 uut(a,b,gt,eq,lt);
integer i,j;
initial begin
    $display("a b | gt eq lt");
    for (i=0;i<4;i=i+1) begin
        for (j=0;j<4;j=j+1) begin
            a=i; b=j;
            #10;
            $display("%b %b | %b %b %b",a,b,gt,eq,lt);
        end
    end
    $finish;
end
endmodule