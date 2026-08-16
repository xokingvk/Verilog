module srlatchgatelevelmodel(input s,r,output q,qbar);
    nor(qbar,s,q,e);
    nor(q,r,e,qbar);
endmodule

module srlatchbehaviourlevel(input s,r,e, output reg q,qbar);
    always @(*) begin
        if (e)
        case ({s,r})
            2'b11: {q,qbar}<=2'bxx; //invalid
            2'b10: {q,qbar}<=2'b10; //set
            2'b01: {q,qbar}<=2'b01; //reset
            2'b00: {q,qbar}<={q,qbar}; //hold
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
    srlatchbehaviourlevel s2(s,r,e,q,qbar);
    initial begin
        $monitor("%b     %b     %b     %b     %b",e,s,r,q,qbar);
        for (m=7;m>=0;m=m-1) begin
            {e,s,r} = m;
            #1;
        end
    end
endmodule