module demultiplexer2x1gatelevelmodel(input s,y, output [1:0]i);
    wire s0;
    not(s0,s);
    and(i[0],s0,y);
    and(i[1],s,y);
endmodule

module demultiplexer2x1behaviourmodel(input s,y, output reg [1:0]i);
    always@(*) begin
        i=2'b00;
    case (s)
        0: i[0]=y;
        1: i[1]=y;
    endcase
    end
endmodule

module tb;
    wire [1:0]i;
    reg s,y;
    integer m;
    demultiplexer4x1behaviourmodel m1(s,y,i);
    initial begin
        $monitor("%b   %b   %b   %b",s,y,i[0],i[1]);
        for (m = 0;m<4;m=m+1) begin
            {s,y} = m;
            #1; 
        end
    end
endmodule