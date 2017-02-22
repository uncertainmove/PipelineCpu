`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/20 17:24:43
// Design Name: controller
// Module Name: controller
// Project Name: pipeline
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


module controller
#(parameter WIDTH = 32)
(
    input [WIDTH-1:0]instruction, 
    output [3:0]alu_op, 
    output reg_dst, 
    output mem_write, 
    // output mem_read,  
    // output reg_write,  
    // output jump,  
    // output jr,  
    // output bne,  
    // output beq,  
    // output bltz,
    // output mem_reg,  
    // output syscall,  
    // output alu_src,  
    output jal,  
    // output s_src,  
    // output data_src,  
    // output lbu,  
    // output mfc0,  
    // output mtc0,  
    // output cp0_write,  
    // output eret,
    output [19:0]control
    );
    wire [5:0]func, op;
    wire [4:0]bltz_inst;
    wire [4:0]interrupt;
    wire _op, lw, sw, slti, j, sltiu, eret, mfc0, mtc0;
    wire add, addi, addiu, addu, _and, andi, sll, sra, srl, sub, _or,  ori, _nor, slt, sltu, _xor;

    // there will not be used
    assign control = {eret, cp0_write, mtc0, mfc0, lbu, reg_dst, reg_write, jal, mem_reg, syscall, mem_read, mem_write, bltz, s_src, alu_src, data_src, beq, bne, jr, jump};

    assign func = instruction[5:0];
    assign bltz_inst = instruction[20:16];
    assign interrupt = instruction[25:20];
    assign op = instruction[31:26];

    // _op is a transition signal (1)
    assign _op = !op[0] & !op[1] & !op[2] & !op[3] & !op[4] & !op[5];

    // normal signal not need _op (14)
    assign lw = op[0] & op[1] & op[5] & !op[2] & !op[3] & !op[4];
    assign sw = op[0] & op[1] & op[3] & op[5] & !op[2] & !op[4];
    assign beq = op[2] & !op[0] & !op[1] & !op[3] & !op[4] & !op[5];
    assign bne = op[0] & op[2] & !op[1] & !op[3] & !op[4] & !op[5];
    assign slti = op[1] & op[3] & !op[0] & !op[2] & !op[4] & !op[5];
    assign j = op[1] & !op[0] & !op[2] & !op[3] & !op[4] & !op[5];
    assign jal = op[0] & op[1] & !op[2] & !op[3] & !op[4] & !op[5];
    assign sltiu = op[0] & op[1] & op[3] & !op[2] & !op[4] & !op[5];
    assign lbu = op[2] & op[5] & !op[0] & !op[1] & !op[3] & !op[4];
    assign bltz = op[0] & !op[1] & !op[2] & !op[3] & !op[4] & !op[5] & !bltz_inst[0] & !bltz_inst[1] & !bltz_inst[2] & !bltz_inst[3] & !bltz_inst[4] ;
    assign addi = op[3] & !op[0] & !op[1] & !op[2] & !op[4] & !op[5];
    assign addiu = op[0] & op[3] & !op[1] & !op[2] & !op[4] & !op[5];
    assign andi = op[2] & op[3] & !op[0] & !op[1] & !op[4] & !op[5];
    assign ori = op[0] & op[2] & op[3] & !op[1] & !op[4] & !op[5];

    // normal signal need _op (14)
    assign add = func[5] & !func[0] & !func[1] & !func[2] & !func[3] & !func[4] & _op;
    assign addu = func[0] & func[5] & !func[1] & !func[2] & !func[3] & !func[4] & _op;
    assign _and = func[2] & func[5] & !func[0] & !func[1] & !func[3] & !func[4] & _op;
    assign sll = !func[0] & !func[1] & !func[2] & !func[3] & !func[4] & !func[5] & _op;
    assign sra = func[0] & func[1] & !func[2] & !func[3] & !func[4] & !func[5] & _op;
    assign srl = func[1] & !func[0] & !func[2] & !func[3] & !func[4] & !func[5] & _op;
    assign sub = func[1] & func[5] & !func[0] & !func[2] & !func[3] & !func[4] & _op;
    assign _or = func[0] & func[2] & func[5] & !func[1] & !func[3] & !func[4] & _op;
    assign _nor = func[0] & func[1] & func[2] & func[5] & !func[3] & !func[4] & _op;
    assign slt = func[1] & func[3] & func[5] & !func[0] & !func[2] & !func[4] & _op;
    assign sltu = func[0] & func[1] & func[3] & func[5] & !func[2] & !func[4] & _op;
    assign jr = func[3] & !func[0] & !func[1] & !func[2] & !func[4] & !func[5] & _op;
    assign syscall = func[2] & func[3] & !func[0] & !func[1] & !func[4] & !func[5] & _op;
    assign _xor = func[1] & func[2] & func[5] & !func[0] & !func[3] & !func[4] & _op;

    // interrupt signal (3)
    assign eret = op[4] & !op[0] & !op[1] & !op[2] & !op[3] & !op[5] & func[3] & func[4] & !func[0] & func[1] & !func[2] & !func[5];
    assign mfc0 = op[4] & !op[0] & !op[1] & !op[2] & !op[3] & !op[5] & !interrupt[0] & !interrupt[1] & !interrupt[2] & !interrupt[3] & !interrupt[4];
    assign mtc0 = op[4] & !op[0] & !op[1] & !op[2] & !op[3] & !op[5] & interrupt[2] & !interrupt[0] & !interrupt[1] & !interrupt[3] & !interrupt[4];

    // control signal
    assign reg_dst = add || addu || _and || sll || sra || srl || sub || _or || _nor || slt || sltu || _xor;
    assign jump = jr || jal || j;
    assign reg_write = add || addu || _and || sll || sra || srl || sub || _or || _nor || slt || sltu || _xor || lbu || sltiu || ori || andi || addi || jal || addiu || slti || lw || mfc0; 
    assign mem_read = lw || lbu;
    assign mem_write = sw;
    assign alu_src = ori || andi || addi || lw || addiu || slti || sw || lbu || sltiu;
    assign mem_reg = add || addu || _and || sll || sra || srl || sub || _or || _nor || slt || sltu || _xor || sltiu || ori || andi || addi || addiu || slti;
    assign s_src = sll || srl || sra;
    assign data_src = andi || sltiu || ori;
    assign cp0_write = eret || mtc0;
    assign alu_op = ({4{(lbu || add || addiu || addi || sw || lw || addu)}} & 4'b0101) | ({4{sra}} & 4'b0001) | ({4{_xor}} & 4'b1001) | ({4{srl}} & 4'b0010) | ({4{_and || andi}} & 4'b0111) | ({4{_nor}} & 4'b1010) | ({4{sll}} & 4'b0000) | ({4{sltu || sltiu}} & 4'b1100) | ({4{sub}} & 4'b0110) | ({4{ori || _or}} & 4'b1000) | ({4{slt || bltz || slti}} & 4'b1011);
endmodule
