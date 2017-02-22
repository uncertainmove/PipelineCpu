`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/21 09:03:21
// Design Name: 
// Module Name: regfiles
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


module regfiles
#(parameter WIDTH = 32)
(
    input [WIDTH-1:0]data_in,
    input [4:0]r1_num,
    input [4:0]r2_num,
    input [4:0]w_num,
    input we,
    input clk,
    output [WIDTH-1:0]r1,
    output [WIDTH-1:0]r2,
    output [WIDTH-1:0]s0,
    output [WIDTH-1:0]s1,
    output [WIDTH-1:0]s2,
    output [WIDTH-1:0]s3,
    output [WIDTH-1:0]s4,
    output [WIDTH-1:0]v0,
    output [WIDTH-1:0]a0
    );
    wire w_num_check;
    // reg
    reg [WIDTH-1:0]regfile[0:31];
    integer i;

    initial begin
        for(i = 0; i < WIDTH; i = i + 1) begin
            regfile[i] <= {32{1'b0}};
        end
    end

    assign w_num_check = w_num[0] || w_num[1] || w_num[2] || w_num[3] || w_num[4];
    assign r1 = regfile[r1_num];
    assign r2 = regfile[r2_num];
    assign s0 = regfile[16];
    assign s1 = regfile[17];
    assign s2 = regfile[18];
    assign s3 = regfile[19];
    assign s4 = regfile[20];
    assign v0 = regfile[2];
    assign a0 = regfile[4];

    always @(posedge clk) begin
        if(we && w_num_check) begin
            regfile[w_num] <= data_in;
        end
        else if(we && !w_num_check) begin
            regfile[w_num] <= 32'b0;
        end
    end
endmodule
