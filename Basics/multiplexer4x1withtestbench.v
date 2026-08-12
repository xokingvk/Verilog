module multiplexergatelevelmodel (input [1:0]s, input [3:0]i, output y);
    wire s0,s1,a,b,c,d;
    not(s0,s[0]);
    not(s1,s[1]);
    and(a,s1,s0,i[0]);
    and(b,s1,s[0],i[1]);
    and(c,s[1],s0,i[2]);
    and(d,s[1],s[0],i[3]);


endmodule

module multiplexerbehaviousmodel (input [1:0]s, input [3:0] i, output reg y);
    always @(*) begin
        case (s)
            2'b00: y = i[0];
            2'b01: y = i[1];
            2'b10: y = i[2];
            2'b11: y = i[3];
            default: y=0; 
        endcase
    end
endmodule

module multiplexertb;
    reg [1:0]s;
    reg [3:0]i;
    wire y;
    integer m;
    multiplexerbehaviousmodel m2(s,i,y);
    initial begin
        $display("S1  S0      I0  I1  I2  I3        Y");
        $monitor("%b   %b       %b   %b   %b   %b         %b",s[1],s[0],i[0],i[1],i[2],i[3],y);
        {s[1],s[0],i[0],i[1],i[2],i[3]} = 6'b001000;
        #1;
        {s[1],s[0],i[0],i[1],i[2],i[3]} = 6'b010100;
        #1;
        {s[1],s[0],i[0],i[1],i[2],i[3]} = 6'b100010;
        #1;
        {s[1],s[0],i[0],i[1],i[2],i[3]} = 6'b110001;
        #1;
        /*for (m = 0;m<65;m=m+1) begin
            {s[0],s[1],i[0],i[1],i[2],i[3]}=m;
            #1;
        end */
    end
    initial begin
        $dumpfile("Multiplexer4x1.vcd");
        $dumpvars(0,multiplexertb);
    end
endmodule