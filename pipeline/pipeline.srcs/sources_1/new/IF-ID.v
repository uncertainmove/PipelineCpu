`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/20 17:25:25
// Design Name: 
// Module Name: IF-ID
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


module IF_ID
#(parameter WIDTH = 32)
(
    input [WIDTH-1:0]pc,
    input [WIDTH-1:0]instruction,
    input clk,
    input enable,
    input clear,
    output reg [WIDTH-1:0]pc_reg,
    output reg [WIDTH-1:0]inst_reg
    );
    // reg [WIDTH-1:0]pc_reg, inst_reg;

    initial begin
        pc_reg <= {(WIDTH-1){1'b0}};
        inst_reg <= {(WIDTH-1){1'b0}};
    end

    // assign pc = pc_reg;
    // assign instruction = inst_reg;
    
    // pc_reg && inst_reg
    always @(posedge clk) begin
        if(enable) begin
            pc_reg <= clear ? {32{1'b0}} : pc;
            inst_reg <= clear ? {32{1'b0}} : instruction;
        end
    end
endmodule
