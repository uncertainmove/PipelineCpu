`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/20 17:26:22
// Design Name: 
// Module Name: EXMem
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


module EX_Mem
#(parameter WIDTH = 32)
(
    input [WIDTH-1:0]pc,
    input [WIDTH-1:0]ir,
    input [WIDTH-1:0]r,
    input [WIDTH-1:0]r2,
    input [11:0]control,
    input [4:0]w_num,
    input [4:0]rs,
    input [4:0]rt,
    input [4:0]rd,
    input clk,
    output reg [WIDTH-1:0]pc_reg,
    output reg [WIDTH-1:0]ir_reg,
    output reg [WIDTH-1:0]r_reg,
    output reg [WIDTH-1:0]r2_reg,
    output reg [4:0]w_num_reg,
    output reg [4:0]rs_reg,
    output reg [4:0]rt_reg,
    output reg [4:0]rd_reg,
    output [9:0]control_next,
    output mem_write_Mem,
    output mem_read_Mem,
    output reg_dst_Mem
    );

    reg [11:0]control_reg;

    initial begin
        pc_reg <= {32{1'b0}};
        ir_reg <= {32{1'b0}};
        r_reg <= {32{1'b0}};
        r2_reg <= {32{1'b0}};
        w_num_reg <= 5'b00000;
        rs_reg <= 5'b00000;
        rt_reg <= 5'b00000;
        rd_reg <= 5'b00000;
        control_reg <= {12{1'b0}};
    end

    assign control_next = control_reg[11:2];
    assign mem_write_Mem = control_reg[0];
    assign mem_read_Mem = control_reg[1];
    assign reg_dst_Mem = control_reg[6];

    always @(posedge clk) begin
        pc_reg <= pc;
        ir_reg <= ir;
        r_reg <= r;
        r2_reg <= r2;
        control_reg <= control;
        rs_reg <= rs;
        rt_reg <= rt;
        rd_reg <= rd;
        w_num_reg <= w_num;
    end
endmodule
