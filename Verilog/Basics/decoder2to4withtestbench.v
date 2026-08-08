module decoderbehaviourmodel(input [1:0]y, input i, output reg [3:0]d);
    always @(*) begin
        d = 4'b0000;
        if (!i) begin
        case (y)
            2'b00: d=4'b1110;
            2'b01: d=4'b1101;
            2'b10: d=4'b1011;
            2'b11: d=4'b0111;
        endcase
        end
        else begin
            d = 4'b1111;
        end
    end
endmodule

module tb();
    integer m;
    reg [1:0]y;
    reg i;
    wire [3:0]d;
    decoderbehaviourmodel d1(y,i,d);
    initial begin
        $monitor("%b    %b    %b    %b    %b    %b    %b",i,y[0],y[1],d[0],d[1],d[2],d[3]);
        {i,y}= 3'b100;
        #1;
        for (m =0; m<4; m = m+1) begin
            i = 1'b0;
            y = m;
            #1;
        end
    end
endmodule