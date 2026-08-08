module multiplexergatelevelmodel(input [2:0]s, input [7:0]i, output y);
    wire a,b,c,d,e,f,g,h;
    wire s0,s1,s2;
    not(s2,s[0]);
    not(s1,s[1]);
    not(s0,s[2]);
    and(a,s2,s1,s0,i[0]);
    and(b,s2,s1,s[0],i[1]);
    and(c,s2,s[1],s0,i[2]);
    and(d,s2,s[1],s[0],i[3]);
    and(e,s[2],s1,s0,i[4]);
    and(f,s[2],s1,s[0],i[5]);
    and(g,s[2],s[1],s0,i[6]);
    and(h,s[2],s[1],s[0],i[7]);
    or(y,a,b,c,d,e,f,g,h);
endmodule

module multiplexerbehaviourmodel(input [2:0]s, input [7:0]i, output reg y);
    always @(*) begin
        case (s)
            3'b000: y = i[0];
            3'b001: y = i[1];
            3'b010: y = i[2];
            3'b011: y = i[3];
            3'b100: y = i[4];
            3'b101: y = i[5];
            3'b110: y = i[6];
            3'b111: y = i[7];
            default: y =0; 
        endcase
    end
endmodule

module multiplexertb;
    reg [2:0]s;
    reg [7:0]i;
    wire y;
    multiplexerbehaviourmodel m3(s,i,y);
    initial begin
        $monitor("%b    %b    %b    %b    %b    %b    %b    %b    %b    %b    %b    %b",s[2],s[1],s[0],i[0],i[1],i[2],i[3],i[4],i[5],i[6],i[7],y);
        {s[2],s[1],s[0],i[0],i[1],i[2],i[3],i[4],i[5],i[6],i[7]} = 11'b00010000000;
        #1;
        {s[2],s[1],s[0],i[0],i[1],i[2],i[3],i[4],i[5],i[6],i[7]} = 11'b00101000000;
        #1;
        {s[2],s[1],s[0],i[0],i[1],i[2],i[3],i[4],i[5],i[6],i[7]} = 11'b01000100000;
        #1;
        {s[2],s[1],s[0],i[0],i[1],i[2],i[3],i[4],i[5],i[6],i[7]} = 11'b01100010000;
        #1;
        {s[2],s[1],s[0],i[0],i[1],i[2],i[3],i[4],i[5],i[6],i[7]} = 11'b10000001000;
        #1;
        {s[2],s[1],s[0],i[0],i[1],i[2],i[3],i[4],i[5],i[6],i[7]} = 11'b10100000100;
        #1;
        {s[2],s[1],s[0],i[0],i[1],i[2],i[3],i[4],i[5],i[6],i[7]} = 11'b11000000010;
        #1;
        {s,i} = 11'b11110000000;
        #1;
    end
    initial begin
        $dumpfile("Multiplexer8x1,vcd");
        $dumpvars(0,multiplexertb);
    end
endmodule