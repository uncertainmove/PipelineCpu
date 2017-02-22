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


module test(

);
    reg clk;
    reg [15:0]choose;
    wire [7:0]anodes, cnodes;
    parameter TIME = 23000;
    main #(32) MAIN (
        .clk_src(clk),
        .choose(choose),
        .anodes(anodes),
        .cnodes(cnodes)
    );

    initial begin
        clk = 0;
        choose = 0;
        #TIME $finish;
    end

    always begin
        #5 clk = ~clk;
    end
endmodule
