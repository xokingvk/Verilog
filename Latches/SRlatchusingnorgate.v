module srlatchgatelevelmodel(input s,r,output q,qbar);
    nor(qbar,s,q);
    nor(q,r,qbar);
endmodule

module srlatchbehaviourlevel(input s,r, output reg q,qbar);
    always @(*) begin
        case ({s,r})
            2'b11: {q,qbar}<=2'bxx; //invalid
            2'b10: {q,qbar}<=2'b10; //set
            2'b01: {q,qbar}<=2'b01; //reset
            2'b00: {q,qbar}<={q,qbar}; //hold
            default: {q,qbar}<=2'bxx; 
        endcase
    end
endmodule

module srlatchtb;
    reg s,r;
    wire q,qbar;
    integer m;
    srlatchbehaviourlevel s2(s,r,q,qbar);
    initial begin
        $monitor("%b     %b     %b     %b",s,r,q,qbar);
        for (m=3;m>=0;m=m-1) begin
            {s,r} <= m;
            #1;
        end
        $display("   ");
        {s,r} <= 2'b11;
        #1;
        {s,r} <= 2'b01;
        #1;
        {s,r} <= 2'b10;
        #1;
        {s,r} <= 2'b00;
        #1;
    end
endmodule