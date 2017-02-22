`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/21 10:36:20
// Design Name: 
// Module Name: ALU
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


module ALU
#(parameter WIDTH = 32)
(
    input signed [WIDTH-1:0]x,
    input signed [WIDTH-1:0]y,
    input [3:0]alu_op,
    output reg [WIDTH-1:0]result,
    output reg [WIDTH-1:0]result2,
    output reg of,
    output reg uof,
    output equal
    );
    wire signed [WIDTH-1:0]r_sll, r_sra, r_srl, r_mul, r_div, r_add, r_sub,  r_and, r_or, r_xor, r_nor, r_slt, r_sltu;
    wire uof_add, of_add, uof_sub, of_sub;
    wire [WIDTH:0]r_addu, r_adds;

    // equal
    assign equal = (x == y);
    // sll
    assign r_sll = x << y;
    // sra
    assign r_sra = x >>> y;
    // srl
    assign r_srl = x >> y;
    // r_mul
    assign r_mul = x * y;
    // r_div
    assign r_div = x / y;
    // r_add
    assign r_add = x + y;
    assign r_adds = {{x[31]}, x} + {{y[31]}, y};
    assign r_addu = {1'b0, x} + {1'b0, y};
    assign uof_add = r_addu[32];
    assign of_add = r_adds[32] ^ r_adds[31];
    // r_sub
    assign r_sub = x - y;
    assign uof_sub = (!x[31] && y[31]) || (x[31] && y[31] && r_sub[31]) || (!x[31] && !y[31] && r_sub[31]);
    assign of_sub = (!x[31] && y[31] && r_sub[31]) || (x[31] && !y[31] && !r_sub[31]);
    // r_and
    assign r_and = x & y;
    // r_or
    assign r_or = x | y;
    // r_xor
    assign r_xor = x ^ y;
    // r_nor
    assign r_nor = ~(x | y);
    // r_slt
    assign r_slt = (x < y) ? 1 : 0;
    // sltu
    assign r_sltu = ({1'b0, x} < {1'b0, y}) ? 1 : 0;

    always @ (*) begin 
        case(alu_op)
            4'b0000:
                begin
                    result = r_sll;
                    result2 = 32'b0;
                    uof = 1'b0;
                    of = 1'b0;
                end
            4'b0001:
                begin
                    result = r_sra;
                    result2 = 32'b0;
                    uof = 1'b0;
                    of = 1'b0;
                end
            4'b0010:
                begin
                    result = r_srl;
                    result2 = 32'b0;
                    uof = 1'b0;
                    of = 1'b0;
                end
            4'b0011:
                begin
                    result = r_mul;
                    result2 = 32'b0;
                    uof = 1'b0;
                    of = 1'b0;
                end
            4'b0100:
                begin
                    result = r_div;
                    result2 = 32'b0;
                    uof = 1'b0;
                    of = 1'b0;
                end
            4'b0101:
                begin
                    result = r_add;
                    result2 = 32'b0;
                    uof = uof_add;
                    of = of_add;
                end
            4'b0110:
                begin
                    result = r_sub;
                    result2 = 32'b0;
                    uof = uof_sub;
                    of = of_sub;
                end
            4'b0111:
                begin
                    result = r_and;
                    result2 = 32'b0;
                    uof = 1'b0;
                    of = 1'b0;
                end
            4'b1000:
                begin
                    result = r_or;
                    result2 = 32'b0;
                    uof = 1'b0;
                    of = 1'b0;
                end
            4'b1001:
                begin
                    result = r_xor;
                    result2 = 32'b0;
                    uof = 1'b0;
                    of = 1'b0;
                end
            4'b1010:
                begin
                    result = r_nor;
                    result2 = 32'b0;
                    uof = 1'b0;
                    of = 1'b0;
                end
            4'b1011:
                begin
                    result = r_slt;
                    result2 = 32'b0;
                    uof = 1'b0;
                    of = 1'b0;
                end
            4'b1100:
                begin
                    result = r_sltu;
                    result2 = 32'b0;
                    uof = 1'b0;
                    of = 1'b0;
                end
        endcase
    end
endmodule
