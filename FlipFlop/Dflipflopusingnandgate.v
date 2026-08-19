module dflipflopgatelevel(input clk, d,output q,qbar);
    wire w1,w2,w3,w4,mq,mqbar;
    wire d0,clkinv;
    not(d0,d);
    not(clkinv,clk);
    //master
    nand(w1,d,clk);
    nand(w2,d0,clk);
    nand(mq,w1,mqbar);
    nand(mqbar,w2,mq);

    nand(w3,mq,clkinv);
    nand(w4,mqbar,clkinv);

    //slave
    nand(q,w3,qbar);
    nand(qbar,w4,q);
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