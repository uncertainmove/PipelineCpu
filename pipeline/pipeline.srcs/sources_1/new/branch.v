`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/20 17:31:27
// Design Name: 
// Module Name: branch
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


module branch
(
    input bne,
    input beq,
    input equal,
    input bltz,
    input r,
    output branch
    );

    assign branch = (!equal && bne) || (equal && beq) || (bltz && r);
endmodule
