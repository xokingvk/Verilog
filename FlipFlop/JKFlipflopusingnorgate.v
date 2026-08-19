module jkflipflopgatelevel(input j,k,clk, output q,qbar);
    wire w1,w2,mq,mqbar,w3,w4,clkinv;
    not (clkinv,clk);
    //master when clk =1;
    and(w1,j,clk,qbar);
    and(w2,k,clk,q);
    nor(mq,w2,mqbar);
    nor(mqbar,w1,mqbar);

    and(w3,mq,clkinv);
    and(w4,mqbar,clkinv);
    //slave
    nor(q,w4,qbar);
    nor(q,w3,qbar);
endmodule