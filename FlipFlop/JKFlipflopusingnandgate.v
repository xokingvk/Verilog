module jkflipflopgatelevel(input j,k,clk, output q,qbar);
    wire w1,w2,mq,mqbar,w3,w4,clkinv;
    not (clkinv,clk);
    //master
    nand(w1,j,clk,qbar);
    nand(w2,k,clk,q);
    nand(mq,w1,mqbar);
    nand(mqbar,mq);

    nand(w3,mq,clkinv);
    nand(w4,mqbar,clkinv);

    //slave
    nand(q,w3,qbar);
    nand(qbar,w4,q);
endmodule
