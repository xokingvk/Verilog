module srflipflopgatelevel(input s,r,clk, output q,qbar);
    wire w1,w2,w3,w4,mq,mqbar,clkinv;
    not(clkinv,clk);
    //master
    nor(w1,s,clk);
    nor(w2,r,clk);
    nor(mq,w2,mqbar);
    nor(mqbar,w1,mqbar);

    nor(w3,mq,clkinv);
    nor(w4,mqbar,clkinv);
    //slave
    nor(q,w4,qbar);
    nor(qbar,w3,q);
endmodule

module srflipflopbehaviourlevel(input s,r,clk, output reg q,qbar);
    always @(posedge clk) begin
            case ({s,r})
                2'b11: {q,qbar} <= 2'bxx; // invalid
                2'b01: {q,qbar} <= 2'b01; //reset
                2'b10: {q,qbar} <= 2'b10; //set
                2'b00: {q,qbar} <= {q,qbar}; //hold
                default: {q,qbar} <= 2'bxx;
            endcase
    end
endmodule

module tb;
    reg s,r,clk;
    wire q,qbar;
    integer m;
    srflipflopbehaviourlevel s1(s,r,clk,q,qbar);
    initial begin
        $monitor("%b     %b     %b     %b     %b",clk,s,r,q,qbar);
        for (m = 7;m>=0;m=m-1) begin
            {s,r,clk} = m;
            #1;
        end    
    end
endmodule