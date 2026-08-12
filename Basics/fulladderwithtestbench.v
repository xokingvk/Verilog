module fulladdergatelevel(input a,b,cin, output s,c);
    xnor(s,a,b,cin);
    wire w1,w2,w3;
    and(w1,a,b);
    and(w2,a,cin);
    and(w3,b,cin);
    or(s,w1,w2,w3);
endmodule

module fulladder(input a,b,cin, output reg s,c);
    always @(*) begin
        s = a^b^cin;
        c = (a&b) | (a&cin) | (b&cin);
    end
endmodule

module tb;
    reg at,bt,cint;
    wire st,ct;
    fulladder fa1(at,bt,cint,st,ct);
    initial begin
        $monitor("a=%b   b=%b   cin=%b      s=%b   c=%b",at,bt,cint,st,ct);
        {at,bt,cint} = 3'b000;
        #1;
        {at,bt,cint} = 3'b001;
        #1;
        {at,bt,cint} = 3'b010;
        #1;
        {at,bt,cint} = 3'b011;
        #1;
        {at,bt,cint} = 3'b100;
        #1;
        {at,bt,cint} = 3'b101;
        #1;
        {at,bt,cint} = 3'b110;
        #1;
        {at,bt,cint} = 3'b111;
        #1;
    end
    initial begin
        $dumpfile("fulladder.vcd");
        $dumpvars(0,tb);
    end
endmodule