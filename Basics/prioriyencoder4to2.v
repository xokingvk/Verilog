module priorityencoder4to2behaviourmodel (input [3:0]d, output reg [1:0]y);
    always @(*) begin
    casex (d)
        4'b0001: y = 2'b00;
        4'b001x: y = 2'b01;
        4'b01xx: y = 2'b10;
        4'b1xxx: y = 2'b11;
        default: y = 2'bxx;
    endcase    
    end 
endmodule

module priorityencoder4to2tb();
    reg [3:0]d;
    wire [1:0]y;
    integer m;
    priorityencoder4to2behaviourmodel p1(d,y);
    initial begin
        $monitor ("%b    %b    %b    %b    %b    %b",d[3],d[2],d[1],d[0],y[1],y[0]);
        for (m =0;m < 16;m =  m+1) begin
            d = m;
            #1;
        end
    end


endmodule