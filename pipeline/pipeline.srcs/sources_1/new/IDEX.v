`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/20 17:26:10
// Design Name: 
// Module Name: IDEX
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


module ID_EX
#(parameter WIDTH = 32)
(
    input [4:0]w_num,
    input [19:0]control,
    input [15:0]imm_offset,
    input [WIDTH-1:0]ir,
    input [WIDTH-1:0]pc,
    input [WIDTH-1:0]r1,
    input [WIDTH-1:0]r2,
    input [4:0]rs,
    input [4:0]rt,
    input [4:0]rd,
    input [3:0]alu_op,
    input [4:0]s,
    input clk,
    input clear,
    input load_use,
    output reg [4:0]w_num_reg,
    output reg [15:0]imm_offset_reg,
    output reg [WIDTH-1:0]ir_reg,
    output reg [WIDTH-1:0]pc_reg,
    output reg [WIDTH-1:0]r1_reg,
    output reg [WIDTH-1:0]r2_reg,
    output reg [4:0]rs_reg,
    output reg [4:0]rt_reg,
    output reg [4:0]rd_reg,
    output reg [3:0]alu_op_reg,
    output reg [4:0]s_reg,
    output [11:0]control_next,
    output jump,
    output jr,
    output bne,
    output beq,
    output data_src,
    output alu_src,
    output s_src,
    output bltz,
    output mem_read_EX,
    output mem_write_EX,
    output reg_dst_EX
    );
    // reg 
    reg [19:0]control_reg;
    // reg [4:0]w_num_reg, rs_reg, rt_reg, rd_reg, s_reg;
    // reg [3:0]alu_op_reg;
    // reg [19:0]control_reg;
    // reg [15:0]imm_offset_reg;
    // reg [WIDTH-1:0]ir_reg, pc_reg, r1_reg, r2_reg;

    initial begin
        w_num_reg <= 5'b00000;
        imm_offset_reg <= {16{1'b0}};
        pc_reg <= {32{1'b0}};
        r1_reg <= {32{1'b0}};
        r2_reg <= {32{1'b0}};
        control_reg <= {20{1'b0}};
        ir_reg <= {32{1'b0}};
        rs_reg <= 5'b00000;
        rt_reg <= 5'b00000;
        rd_reg <= 5'b00000;
        alu_op_reg <= 4'b0000;
        s_reg <= 5'b00000;
    end

    // control
    assign control_next = control_reg[19:8];
    assign jump = control_reg[0];
    assign jr = control_reg[1];
    assign bne = control_reg[2];
    assign beq = control_reg[3];
    assign data_src = control_reg[4];
    assign alu_src = control_reg[5];
    assign s_src = control_reg[6];
    assign bltz = control_reg[7];
    assign mem_read_EX = control_reg[9];
    assign mem_write_EX = control_reg[8];
    assign reg_dst_EX = control_reg[14];

    always @(posedge clk) begin
        if(!(load_use || clear)) begin
            w_num_reg <= w_num;
            imm_offset_reg <= imm_offset;
            pc_reg <= pc;
            r1_reg <= r1;
            r2_reg <= r2;
            control_reg <= control;
            ir_reg <= ir;
            rs_reg <= rs;
            rt_reg <= rt;
            rd_reg <= rd;
            alu_op_reg <= alu_op;
            s_reg <= s;
        end
        else begin
            w_num_reg = 5'b0;
            imm_offset_reg = 16'b0;
            pc_reg = 32'b0;
            r1_reg = 32'b0;
            r2_reg = 32'b0;
            control_reg = 24'b0;
            ir_reg = 32'b0;
            rs_reg = 5'b0;
            rt_reg = 5'b0;
            rd_reg = 5'b0;
            alu_op_reg = 4'b0;
            s_reg = 5'b0;
        end
    end
endmodule
