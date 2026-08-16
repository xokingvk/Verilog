module  srlatchgatelevel(input s,r,e, output q,qbar);
    nand(q,s,qbar,e);
    nand(qbar,r,q,e);
endmodule

module srlatchbehaviourmodel (input s,r,e,output reg q,qbar);
    always @(*) begin
        if (e)
        case ({s,r})
            2'b00: {q,qbar}<=2'bxx; //invalid
            2'b01: {q,qbar}<=2'b10; //reset
            2'b10: {q,qbar}<=2'b01; //set
            2'b11: {q,qbar}<={q,qbar}; //hold
            default: {q,qbar}<=2'bxx;
        endcase
        else 
            {q,qbar} <={q,qbar};
    end
endmodule

module srlatchtb;
    reg s,r,e;
    wire q,qbar;
    integer m;
    srlatchbehaviourmodel s1(s,r,e,q,qbar);
    initial begin
        $monitor("%b     %b     %b     %b     %b",e,s,r,q,qbar);
        for (m=0;m<8;m=m+1) begin
            {e,s,r} = m;
            #1;
        end
    end
    initial begin
        $dumpfile("SRlatchusingnand.vcd");
        $dumpvars(0,srlatchtb);
    end
endmodule