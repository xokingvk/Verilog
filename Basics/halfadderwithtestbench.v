module halfaddergatelevel(input a,b, output s,c);
  xnor(s,a,b);
  and(c,a,b);
endmodule
module halfadder(input a,b, output reg sum,carry);
  always@(*)
    begin
      sum = a ^ b;
      carry = a & b;
    end
endmodule

module tb;
  reg at,bt;
  wire sumt,carryt;
  
  halfadder ha1(at,bt,sumt,carryt);
  initial
    begin
      $monitor("%b and %b         question: %b and %b",sumt,carryt,at,bt);
      {at,bt}=2'b00;
      #1;
  
      {at,bt}=2'b01;
      #1;
     
      {at,bt}=2'b10;
      #1;
      {at,bt}=2'b11;
      #1;
    end
endmodule