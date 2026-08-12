module multiplexergatelevelmodel (input s, input [1:0] i, output y);
    wire s0, a,b;
    not (s0,s);
    and(a,s0,i[0]);
    and(b,s,i[1]);
    or(y,a,b);
endmodule

module multiplexerdataflowmodel(input s, input [1:0] i, output y);
    assign y = (i[0]&(!s)) | (i[1]&s);
endmodule

module multiplexerbehaviousmodel(input s,input [1:0] i, output reg y);
    always @(*) begin
    case (s)
        0: y = i[0];
        1: y = i[1]; 
        default: y = 0;
    endcase    
    end
endmodule

module multiplexertb;
    reg s;
    reg [1:0]i;
    wire y;
    multiplexerbehaviousmodel m1(s,i,y);
    integer m;
    initial begin
        $monitor("%b  %b  %b  %b",s,i[0],i[1],y);
       for (m=0;m<8;m=m+1) begin
        {s,i[0],i[1]}=m;
        #1;
       end
    end
    initial begin
        $dumpfile("Multiplexer2x1.vcd");
        $dumpvars(0,multiplexertb);
    end
endmodule