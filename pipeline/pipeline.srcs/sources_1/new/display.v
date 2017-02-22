`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/22 13:27:30
// Design Name: 
// Module Name: display
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


module display
#(parameter WIDTH = 32)
(
    input [WIDTH-1:0]a0,    
    input clk,
    output reg [7:0]anodes,
    output reg [7:0]cnodes
    );

    reg [2:0]count;
    wire [7:0]seg_data_1, seg_data_2, seg_data_3, seg_data_4, seg_data_5, seg_data_6, seg_data_7, seg_data_8;

    bcd_to_segment SEC1 (
        .bcd_data(a0[3:0]),
        .seg_data(seg_data_1)
    );
    bcd_to_segment SEC2 (
        .bcd_data(a0[7:4]),
        .seg_data(seg_data_2)
    );
    bcd_to_segment SEC3 (
        .bcd_data(a0[11:8]),
        .seg_data(seg_data_3)
    );
    bcd_to_segment SEC4 (
        .bcd_data(a0[15:12]),
        .seg_data(seg_data_4)
    );
    bcd_to_segment SEC5 (
        .bcd_data(a0[19:16]),
        .seg_data(seg_data_5)
    );
    bcd_to_segment SEC6 (
        .bcd_data(a0[23:20]),
        .seg_data(seg_data_6)
    );
    bcd_to_segment SEC7 (
        .bcd_data(a0[27:24]),
        .seg_data(seg_data_7)
    );
    bcd_to_segment SEC8 (
        .bcd_data(a0[31:28]),
        .seg_data(seg_data_8)
    );

    initial begin
        count <= 0;
        anodes <= 0;
        cnodes <= 0;
    end
    
    always @(posedge clk) begin
        count = count + 1;
    end

    always @(count) begin
        case (count)
        3'b000: begin
            anodes = 8'b11111110;
            cnodes = seg_data_1;
        end
        3'b001: begin
            anodes = 8'b11111101;
            cnodes = seg_data_2;
        end
        3'b010:  begin
            anodes = 8'b11111011;
            cnodes = seg_data_3;
        end
        3'b011: begin
            anodes = 8'b11110111;
            cnodes = seg_data_4;
        end
        3'b100: begin
            anodes = 8'b11101111;
            cnodes = seg_data_5;
        end
        3'b101: begin
            anodes = 8'b11011111;
            cnodes = seg_data_6;
        end
        3'b110: begin
            anodes = 8'b10111111;
            cnodes = seg_data_7;
        end
        3'b111: begin
            anodes = 8'b01111111;
            cnodes = seg_data_8;
        end
        endcase
    end
endmodule
