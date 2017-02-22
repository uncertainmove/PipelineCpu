`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/20 17:31:27
// Design Name: 
// Module Name: load_use_check
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


module load_use_check
(
    input [4:0]rs_ID,
    input [4:0]rt_ID,
    input [4:0]rt_EX,
    input mem_read,
    output load_use
    );

    assign load_use = (((rs_ID == rt_EX) ? 1'b1 : 1'b0) || ((rt_ID == rt_EX) ? 1'b1 : 1'b0)) && mem_read;
endmodule
