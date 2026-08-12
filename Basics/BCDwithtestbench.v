module bcd(input [3:0]ab, input [3:0]bb, input cin, output [3:0]sumbr, output cout );
    reg [4:0] temp;
    always@(*) begin
        temp = ab + bb +cin;
        if (temp >'d9)
            temp = 4'b0110 + temp;
        else
            temp = temp;
    end
    assign sumbr = temp[3:0];
    assign cout = temp[4];
endmodule
module bcdtb;
    reg [3:0] at,bt;
    reg ct;
    wire [3:0]sumt;
    wire cot;
    bcd b1(at,bt,ct,sumt,cot);
    initial begin
        {at,bt,ct}=9'b011001000;
        #1
        $monitor("%b   %b   %b   %b   %b",at,bt,ct,sumt,cot);
    end



endmodule