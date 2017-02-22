`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/20 17:31:27
// Design Name: 
// Module Name: data_redirect
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


module data_redirect
(
    input [4:0]rs_ID,
    input [4:0]rt_ID,
    input [4:0]rs_EX,
    input [4:0]rt_EX,
    input [4:0]rt_Mem,
    input [4:0]w_num_Mem,
    input [4:0]w_num_Wb,
    input reg_dst_ID,
    input mem_write_EX,
    input reg_dst_EX,
    input mem_write_Mem,
    input s_src_EX,
    input bne_EX,
    input beq_EX,
    output Mem_EX_X,
    output Mem_EX_Y,
    output Wb_EX_X,
    output Wb_EX_Y,
    output Wb_EX_r2,
    output Wb_Mem,
    output Wb_ID_r1,
    output Wb_ID_r2
    );
    wire rs_EX_check, rs_ID_check, rt_ID_check, rt_EX_check, rt_Mem_check;

    assign rs_ID_check = rs_ID[0] || rs_ID[1] || rs_ID[2] || rs_ID[3] || rs_ID[4];
    assign rs_EX_check = rs_EX[0] || rs_EX[1] || rs_EX[2] || rs_EX[3] || rs_EX[4];
    assign rt_ID_check = rt_ID[0] || rt_ID[1] || rt_ID[2] || rt_ID[3] || rt_ID[4];
    assign rt_EX_check = rt_EX[0] || rt_EX[1] || rt_EX[2] || rt_EX[3] || rt_EX[4];
    assign rt_Mem_check = rt_Mem[0] || rt_Mem[1] || rt_Mem[2] || rt_Mem[3] || rt_Mem[4];
    assign Mem_EX_X = (((rs_EX == w_num_Mem) ? 1'b1 : 1'b0) && rs_EX_check) || (s_src_EX && ((rt_EX == w_num_Mem) ? 1 : 0) && (reg_dst_EX || bne_EX || beq_EX) && rt_EX_check);
    assign Mem_EX_Y = !s_src_EX && ((rt_EX == w_num_Mem) ? 1'b1 : 1'b0) && (reg_dst_EX || bne_EX || beq_EX) && rt_EX_check;
    assign Wb_EX_X = ((rs_EX == w_num_Wb) ? 1'b1 : 1'b0) && rs_EX_check;
    assign Wb_EX_Y = ((rt_EX == w_num_Wb) ? 1'b1 : 1'b0) && rt_EX_check && reg_dst_EX;
    assign Wb_EX_r2 = ((rt_EX == w_num_Wb) ? 1'b1 : 1'b0) && rt_EX_check && mem_write_EX;
    assign Wb_Mem = ((rt_Mem == w_num_Wb) ? 1'b1 : 1'b0) && rt_Mem_check && mem_write_Mem;
    assign Wb_ID_r1 = ((rs_ID == w_num_Wb) ? 1'b1 : 1'b0) && rs_ID_check;
    assign Wb_ID_r2 = ((rt_ID == w_num_Wb) ? 1'b1 : 1'b0) && rt_ID_check && reg_dst_ID;
endmodule
