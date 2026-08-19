module dlatchgatelevel (input clk,d,output q,qbar);
    wire w1,w2,w3,w4,d0,clkinv,mq,mqbar;
    not(d0,d);
    not(clkinv,clk);
    //master
    and(w1,d0,clk);
    and(w2,d,clk);
    nor(mq,w1,mqbar);
    nor(mqbar,w2,mq);

    and(w3,mq,clkinv);
    and(w4,mqbar,clkinv);
    //slave
    nor(q,w3,qbar);
    nor(qbar,w4,q);
endmodule

module dlatchbehaviourlevel (input clk,d, output reg q,qbar);
    always @(posedge clk) begin
        q<=d;
        qbar <= ~d;
    end
endmodule

module tb;
    reg d,clk;
    wire q,qbar;
    integer m;
    dlatchbehaviourlevel d2(clk,d,q,qbar);
    initial begin
        $monitor("%b      %b      %b      %b",clk,d,q,qbar);
        for (m = 3;m>=0;m=m-1) begin
            {d,clk} = m;
            #2;
        end
    end
endmodule