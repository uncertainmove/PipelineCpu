`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/20 17:26:22
// Design Name: 
// Module Name: MemWb
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


module Mem_Wb
#(parameter WIDTH = 32)
(
    input [WIDTH-1:0]pc,
    input [WIDTH-1:0]ir,
    input [WIDTH-1:0]r,
    input [WIDTH-1:0]data,
    input [WIDTH-1:0]r2,
    input [9:0]control,
    input [4:0]w_num,
    input [4:0]rs,
    input [4:0]rt,
    input [4:0]rd,
    input [1:0]lbu_choose,
    input clk,
    output reg [WIDTH-1:0]pc_reg,
    output reg [WIDTH-1:0]ir_reg,
    output reg [WIDTH-1:0]r_reg,
    output reg [WIDTH-1:0]data_reg,
    output reg [WIDTH-1:0]r2_reg,
    output reg [4:0]w_num_reg,
    output reg [4:0]rs_reg,
    output reg [4:0]rt_reg,
    output reg [4:0]rd_reg,
    output reg [1:0]lbu_choose_reg,
    output syscall,
    output mem_reg,
    output jal,
    output reg_write,
    output reg_dst,
    output lbu,
    output mfc0,
    output mtc0,
    output cp0_write,
    output eret
    );
    reg [9:0]control_reg;

    initial begin
        pc_reg <= {32{1'b0}};
        ir_reg <= {32{1'b0}};
        r_reg <= {32{1'b0}};
        data_reg <= {32{1'b0}};
        r2_reg <= {32{1'b0}};
        w_num_reg <= 5'b00000;
        rs_reg <= 5'b00000;
        rt_reg <= 5'b00000;
        rd_reg <= 5'b00000;
        lbu_choose_reg <= 2'b00;
        control_reg <= {10{1'b0}};
    end

    assign syscall = control_reg[0];
    assign mem_reg = control_reg[1];
    assign jal = control_reg[2];
    assign reg_write = control_reg[3];
    assign reg_dst = control_reg[4];
    assign lbu = control_reg[5];
    assign mfc0 = control_reg[6];
    assign mtc0 = control_reg[7];
    assign cp0_write = control_reg[8];
    assign eret = control_reg[9];

    always @(posedge clk) begin
        pc_reg <= pc;
        ir_reg <= ir;
        r_reg <= r;
        data_reg <= data;
        r2_reg <= r2;
        w_num_reg <= w_num;
        rs_reg <= rs;
        rt_reg <= rt;
        rd_reg <= rd;
        lbu_choose_reg <= lbu_choose;
        control_reg <= control;
    end
endmodule
