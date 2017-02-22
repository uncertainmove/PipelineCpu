`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/22 10:57:02
// Design Name: 
// Module Name: test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_ALU(

);
    reg [31:0]x,y;
    reg [3:0]alu_op;
    wire [31:0]result;
    parameter TIME = 40;
    ALU #(32) alu (
        .x(x),
        .y(y),
        .alu_op(alu_op),
        .result(result),
        .result2(),
        .of(),
        .uof(),
        .equal()
    );

    initial begin
        #TIME $finish;
    end

    always begin
        #5 x=0;y=0;alu_op=10;
        #5 x=32'hffffffff;y=16;alu_op=0;
        #5 x=32'hffff0000;y=32'h0000ffff;alu_op=8;
        #5 x=32'hffff0000;y=32'h0fff0000;alu_op=7;
        #5 x=32'hffff0000;y=32'h0fff0000;alu_op=9;
        #5 x=32'hffff0000;y=32'h0fff0000;alu_op=11;
        #5 x=32'hffff0000;y=32'h0fff0000;alu_op=12;
    end
endmodule
