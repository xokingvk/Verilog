module demultiplexer4x1behaviourmodel(input [1:0]s,input y, output reg[3:0]i);
    always @(*) begin
        i =4'b0000;
        case (s)
            2'b00: i[0] = y;
            2'b01: i[1] = y;
            2'b10: i[2] = y;
            2'b11: i[3] = y;
            default: i =4'b0000;
        endcase
    end
endmodule

module demultiplexer4x1tb();
    reg y;
    reg [1:0]s;
    wire [3:0]i;
    integer m;
    demultiplexer4x1behaviourmodel m2(s,y,i);
    /*initial begin
        $monitor("%b    %b    %b    %b    %b    %b    %b",s[1],s[0],y,i[0],i[1],i[2],i[3]);
        y = 1'b1;
        s= 2'b00;
        #1;
        s= 2'b01;
        #1;
        s= 2'b10;
        #1;
        s= 2'b11;
        #1;
    end */
    initial begin
        $monitor("%b    %b    %b    %b    %b    %b    %b",s[1],s[0],y,i[0],i[1],i[2],i[3]);
        for (m =0;m<8 ;m=m+1) begin
            {s,y} =m;
            #1;
        end
    end

endmodule