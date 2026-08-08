module fulladder(input a,b,cin, output s,c);
    assign s = a^b^cin;
    assign c = (a&b) | (b&c) | (a&c);
endmodule


module ripplefactorcarry(input [3:0]ar,input [3:0]br,input car, output [3:0]sr,output cout);
    wire w1,w2,w3;
    fulladder fa1(.a(ar[0]),.b(br[0]),.cin(car),.s(sr[0]),.c(w1));
    fulladder fa2(.a(ar[1]),.b(br[1]),.cin(w1),.s(sr[1]),.c(w2));
    fulladder fa3(.a(ar[2]),.b(br[2]),.cin(w2),.s(sr[2]),.c(w3));
    fulladder fa4(.a(ar[3]),.b(br[3]),.cin(w3),.s(sr[3]),.c(cout));
endmodule