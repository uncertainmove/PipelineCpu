`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/20 17:27:31
// Design Name: 
// Module Name: instruction_translate
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


module instruction_translate
#(parameter WIDTH = 32)
(
    input [WIDTH-1:0]instruction,
    output [4:0]rs,
    output [4:0]rt,
    output [4:0]rd,
    output [4:0]s,
    output [15:0]imm_offset
    );

    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign s = instruction[10:6];
    assign imm_offset = instruction[15:0];
endmodule
