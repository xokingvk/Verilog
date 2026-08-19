module srflipflopgatelevel(input s,r,clk, output q,qbar);
    wire w1,w2,w3,w4,mq,mqbar;
    not (clkinv,clk);
    //master
    nand(w1,s,clk);
    nand(w2,r,clk);
    nand(mq,w1,mqbar);
    nand(mqbar,w2,mq);

    nand(w3,mq,clkinv);
    nand(w4,mq,clkinv);
    //slave
    nand(q,w3,qbar);
    nand(qbar,w4,q);
endmodule

module srflipflopbehaviourmodel (input s,r,clk, output reg q,qbar);
    always @(posedge clk) begin
        case ({s,r})
            2'b00: {q,qbar} <= 2'bxx; //invalid
            2'b10: {q,qbar} <= 2'b01;//reset
            2'b01: {q,qbar} <= 2'b10; //set
            2'b11: {q,qbar} <= {q,qbar}; //hold
            default: {q,qbar}<=2'bxx;
        endcase
    end
endmodule

module tb;
    reg s,r,clk;
    wire q,qbar;
    integer m;
    srflipflopbehaviourmodel s2(s,r,clk,q,qbar);
    initial begin
        $monitor("%b     %b     %b     %b     %b",clk,s,r,q,qbar);
        for (m=0;m<8;m=m+1) begin
            {s,r,clk}=m;
            #1;
        end
    end
endmodule