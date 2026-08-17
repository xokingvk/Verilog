module dlatchgatelevel(input e, d,output q,qbar);
    wire w1,w2;
    wire d0;
    not(d0,d);
    nand(w1,d,e);
    nand(w1,d0,e);
    nand(q,w1,qbar);
    nand(qbar,w2,q);
endmodule

module dlatchbehaviourlevel(input e,d,output reg q,qbar);
    always @(*) begin
        if (e)
            case (d)
                1'b0: {q,qbar}<=2'b01; //reset
                1'b1: {q,qbar}<=2'b10; //set
                default: {q,qbar} <=2'bxx;
            endcase
        else
            {q,qbar}<={q,qbar}; //hold
    end
endmodule

module tb;
   reg e,d;
   wire q,qbar;
   dlatchbehaviourlevel d1(e,d,q,qbar);
    initial begin
        $monitor("%b      %b      %b      %b",e,d,q,qbar);
        {e,d} = 2'b10;
        #1;
        {e,d} = 2'b11;
        #1;
        {e,d} = 2'b00;
        #1;
        {e,d} = 2'b01;
        #1;
    end
endmodule