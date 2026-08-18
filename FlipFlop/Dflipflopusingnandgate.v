module dflipflopgatelevel(input clk, d,output q,qbar);
    wire w1,w2;
    wire d0;
    not(d0,d);
    nand(w1,d,clk);
    nand(w1,d0,clk);
    nand(q,w1,qbar);
    nand(qbar,w2,q);
endmodule

module dlatchbehaviourlevel(input clk,d,output reg q,qbar);
    always @(poseedge clk) begin
            q<= d;
            qbar <= ~d;
    end
endmodule

module tb;
    reg d,clk;
    wire q,qbar;
    integer m;
    dlatchbehaviourlevel d1(clk,d,q,qbar);
    initial begin
        $monitor("%b      %b      %b      %b",clk,d,q,qbar);
        for (m = 3;m>=0;m=m-1) begin
            {d,clk} = m;
            #2;
        end
    end
endmodule