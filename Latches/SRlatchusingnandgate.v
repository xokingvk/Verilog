module  srlatchgatelevel(input s,r, output q,qbar);
    nand(q,s,qbar);
    nand(qbar,r,q);
endmodule

module srlatchbehaviourmodel (input s,r,output reg q,qbar);
    always @(*) begin
        case ({s,r})
            2'b00: {q,qbar}<=2'bxx; //invalid
            2'b01: {q,qbar}<=2'b10; //reset
            2'b10: {q,qbar}<=2'b01; //set
            2'b11: {q,qbar}<={q,qbar}; //hold
            default: {q,qbar}<=2'bxx; 
        endcase
    end
endmodule

module srlatchtb;
    reg s,r;
    wire q,qbar;
    integer m;
    srlatchbehaviourmodel s1(s,r,q,qbar);
    initial begin
        $monitor("%b     %b     %b     %b",s,r,q,qbar);
        for (m=0;m<4;m=m+1) begin
            {s,r} <= m;
            #1;
        end
        $display("   ");
        {s,r} = 2'b00;
        #1;
        {s,r} = 2'b10;
        #1;
        {s,r} = 2'b01;
        #1;
        {s,r} = 2'b11;
        #1;
    end
    initial begin
        $dumpfile("SRlatchusingnand.vcd");
        $dumpvars(0,srlatchtb);
    end
endmodule