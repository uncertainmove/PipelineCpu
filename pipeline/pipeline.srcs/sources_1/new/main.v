`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2017/02/20 21:02:46
// Design Name: 
// Module Name: main
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


module main
#(parameter WIDTH = 32)
(
    input clk_src,
    input [15:0]choose,
    output [7:0]anodes,
    output [7:0]cnodes
    );
    wire [WIDTH-1:0]pc_1, pc_2, pc_3, pc_4, pc_5, pc_next;
    wire [WIDTH-1:0]ir_1, ir_2, ir_3, ir_4, ir_5;
    // ID
    wire jal_ID, mem_write_ID, reg_dst_ID;
    wire [3:0]alu_op_ID;
    wire [4:0]rs_ID, rt_ID, rd_ID, s_ID;
    wire [15:0]imm_offset_ID;
    wire [19:0]control_ID;
    wire [WIDTH-1:0]r1_ID, r2_ID, s0_ID, s1_ID, s2_ID, s3_ID, s4_ID, a0_ID, v0_ID;
    // load_use
    wire load_use;
    // EX
    wire jump_EX, jr_EX, bne_EX, beq_EX, branch_EX;
    wire data_src_EX, alu_src_EX, s_src_EX, bltz_EX, mem_read_EX, mem_write_EX, reg_dst_EX;
    wire [4:0]rs_EX, rt_EX, rd_EX, s_EX, w_num_EX;
    wire [3:0]alu_op_EX;
    wire [15:0]imm_offset_EX;
    wire [WIDTH-1:0]r_EX, x_EX, r1_EX, r2_EX;
    wire [11:0]control_EX;
    // Mem
    wire [WIDTH-1:0]r_Mem, r2_Mem;
    wire [4:0]rs_Mem, rt_Mem, rd_Mem, w_num_Mem;
    wire reg_dst_Mem, mem_read_Mem, mem_write_Mem;
    wire [9:0]control_Mem;
    // Wb
    wire [WIDTH-1:0]data_Wb, r_Wb, data;
    wire [4:0]w_num_Wb;
    wire [1:0]lbu_choose_Wb;
    wire reg_write_Wb, mem_reg_Wb, jal_Wb, syscall_Wb, lbu_Wb, halt;
    reg [WIDTH-1:0]lbu_data_Wb;
    // redirect
    wire Wb_Mem, Mem_EX_x, Mem_EX_y, Wb_EX_x, Wb_EX_y, Wb_EX_r2, Wb_ID_r1, Wb_ID_r2;
    // reg
    reg [WIDTH-1:0]pc_reg, a0_reg, _clk;
    // clk
    wire clk;
    // ram
    reg [WIDTH-1:0]ram[0:1024];
    wire [WIDTH-1:0]data_Mem;
    reg halt_reg;
    // rom
    reg [WIDTH-1:0]rom[0:511];

    initial begin
        $readmemh("/home/uncertainmove/Document/logism/cpu/测试用例/benchmark.hex", rom);
        halt_reg <= 1'b0;
        pc_reg <= {32{1'b0}};
        lbu_data_Wb <= {32{1'b0}};
        // data_Mem <= {32{1'b0}};
        a0_reg <= {32{1'b0}};
        _clk <= {32{1'b0}};
    end

    always @(posedge clk_src) begin
        _clk <= _clk + 1;
    end

    assign clk = halt_reg ? 1'b1 : _clk[20];

    assign pc_1 = pc_reg + 4;
    assign ir_1 = rom[pc_reg[10:2]];
    assign x_EX = Mem_EX_x ? r_Mem : (Wb_EX_x ? data : (s_src_EX ? r2_EX : r1_EX));
    assign pc_next = jr_EX ? x_EX : (jump_EX ? ({pc_3[31:28], ir_3[25:0], 2'b00}) : (branch_EX ? ({{16{imm_offset_EX[15]}}, imm_offset_EX} << 2) + pc_3 : pc_1));

    // halt
    always @(posedge clk) begin
        halt_reg <= halt;
    end
    
    // IF 
    always @(posedge clk) begin
        if(!load_use) begin
            pc_reg <= pc_next;
        end
    end

    // IF_ID
    IF_ID #(WIDTH) if_id (
        .pc(pc_1),
        .instruction(ir_1),
        .clk(clk),
        .enable(!load_use),
        .clear(branch_EX || jump_EX || jr_EX),
        .pc_reg(pc_2),
        .inst_reg(ir_2)
    );

    // ID
    controller #(WIDTH) CONTROLLER (
        .instruction(ir_2),
        .jal(jal_ID),
        .alu_op(alu_op_ID),
        .mem_write(mem_write_ID),
        .reg_dst(reg_dst_ID),
        .control(control_ID)

    );
    instruction_translate #(WIDTH) TRANSLATE (
        .instruction(ir_2),
        .rs(rs_ID),
        .rt(rt_ID),
        .rd(rd_ID),
        .s(s_ID),
        .imm_offset(imm_offset_ID)
    );
    regfiles #(WIDTH) REGFILES (
        .data_in(data),
        .r1_num(rs_ID),
        .r2_num(rt_ID),
        .w_num(w_num_Wb),
        .we(reg_write_Wb),
        .clk(clk),
        .r1(r1_ID),
        .r2(r2_ID),
        .s0(s0_ID),
        .s1(s1_ID),
        .s2(s2_ID),
        .s3(s3_ID),
        .s4(s4_ID),
        .v0(v0_ID),
        .a0(a0_ID)
    );

    // ID_EX
    ID_EX #(WIDTH) id_ex (
        .w_num(mem_write_ID ? 5'b00000 : (jal_ID ? 5'b11111 : (reg_dst_ID ? rd_ID : rt_ID))),
        .control(control_ID),
        .imm_offset(imm_offset_ID),
        .ir(ir_2),
        .pc(pc_2),
        .r1(Wb_ID_r1 ? data : r1_ID),
        .r2(Wb_ID_r2 ? data : r2_ID),
        .rs(rs_ID),
        .rt(rt_ID),
        .rd(rd_ID),
        .alu_op(alu_op_ID),
        .s(s_ID),
        .clk(clk),
        .clear(branch_EX || jump_EX || jr_EX),
        .load_use(load_use),
        .w_num_reg(w_num_EX),
        .imm_offset_reg(imm_offset_EX),
        .ir_reg(ir_3),
        .pc_reg(pc_3),
        .r1_reg(r1_EX),
        .r2_reg(r2_EX),
        .rs_reg(rs_EX),
        .rt_reg(rt_EX),
        .rd_reg(rd_EX),
        .alu_op_reg(alu_op_EX),
        .s_reg(s_EX),
        .control_next(control_EX),
        .jump(jump_EX),
        .jr(jr_EX),
        .bne(bne_EX),
        .beq(beq_EX),
        .data_src(data_src_EX),
        .alu_src(alu_src_EX),
        .s_src(s_src_EX),
        .bltz(bltz_EX),
        .mem_read_EX(mem_read_EX),
        .mem_write_EX(mem_write_EX),
        .reg_dst_EX(reg_dst_EX)
    );

    // branch
    branch BRANCH (
        .bne(bne_EX),
        .beq(beq_EX),
        .equal(equal),
        .bltz(bltz_EX),
        .r(r_EX[0]),
        .branch(branch_EX)
    );

    // ALU
    ALU #(WIDTH) alu (
        .x(Mem_EX_x ? r_Mem : (Wb_EX_x ? data : (s_src_EX ? r2_EX : r1_EX))),
        .y(Mem_EX_y ? r_Mem : (Wb_EX_y ? data : (bltz_EX ? {32{1'b0}} : (s_src_EX ? {{27{1'b0}}, s_EX} : (alu_src_EX ? (data_src_EX ? {{16{1'b0}}, imm_offset_EX} : {{16{imm_offset_EX[15]}}, imm_offset_EX}) : r2_EX))))),
        .alu_op(alu_op_EX),
        .result(r_EX),
        .result2(),
        .of(),
        .uof(),
        .equal(equal)
    );

    // EX_Mem
    EX_Mem #(WIDTH) ex_mem (
        .pc(pc_3),
        .ir(ir_3),
        .r(r_EX),
        .r2(Wb_EX_r2 ? data : r2_EX),
        .control(control_EX),
        .w_num(w_num_EX),
        .rs(rs_EX),
        .rt(rt_EX),
        .rd(rd_EX),
        .clk(clk),
        .pc_reg(pc_4),
        .ir_reg(ir_4),
        .r_reg(r_Mem),
        .r2_reg(r2_Mem),
        .w_num_reg(w_num_Mem),
        .rs_reg(rs_Mem),
        .rt_reg(rt_Mem),
        .rd_reg(rd_Mem),
        .control_next(control_Mem),
        .mem_write_Mem(mem_write_Mem),
        .mem_read_Mem(mem_read_Mem),
        .reg_dst_Mem(reg_dst_Mem)
    );

    // Mem
    // always @(posedge mem_read_Mem) begin
    //    if(mem_read_Mem) begin
    //        data_Mem <= ram[r_Mem[9:0] >> 2];
    //    end
    // end
    assign data_Mem = mem_read_Mem ? ram[r_Mem[9:0] >> 2] : data_Mem;
    always @(posedge clk) begin
        if(mem_write_Mem) begin
            ram[r_Mem[9:0] >> 2] <= (Wb_Mem ? r_Wb : r2_Mem);
        end
    end

    // Mem_Wb
    Mem_Wb #(WIDTH) mem_wb(
        .pc(pc_4),
        .ir(ir_4),
        .r(r_Mem),
        .data(data_Mem),
        .r2(r2_Mem),
        .control(control_Mem),
        .w_num(w_num_Mem),
        .rs(rs_Mem),
        .rt(rt_Mem),
        .rd(rd_Mem),
        .lbu_choose(r_Mem[1:0]),
        .clk(clk),
        .pc_reg(pc_5),
        .ir_reg(ir_5),
        .r_reg(r_Wb),
        .data_reg(data_Wb),
        .r2_reg(),
        .w_num_reg(w_num_Wb),
        .rs_reg(),
        .rt_reg(),
        .rd_reg(),
        .lbu_choose_reg(lbu_choose_Wb),
        .syscall(syscall_Wb),
        .mem_reg(mem_reg_Wb),
        .jal(jal_Wb),
        .reg_write(reg_write_Wb),
        .reg_dst(),
        .lbu(lbu_Wb),
        .mfc0(),
        .mtc0(),
        .cp0_write(),
        .eret()
    );

    // Wb
    always @(*) begin
        case(lbu_choose_Wb)
            2'b00:
            begin
                lbu_data_Wb <= {{24{1'b0}}, {8{1'b1}}};
            end
            2'b01:
            begin
                lbu_data_Wb <= {{16{1'b0}}, {8{1'b1}}, {8{1'b0}}};
            end
            2'b10:
            begin
                lbu_data_Wb <= {{8{1'b0}}, {8{1'b1}}, {16{1'b0}}};
            end
            2'b11:
            begin
                lbu_data_Wb <= {{8{1'b1}}, {24{1'b0}}};
            end
        endcase
    end
    assign data = lbu_Wb ? (data_Wb & lbu_data_Wb) : (jal_Wb ? pc_5 : (mem_reg_Wb ? r_Wb : data_Wb));
    assign halt = syscall_Wb && (v0_ID == {{28{1'b0}}, 4'b1010});

    // data_redirect
    data_redirect  DATA_REDIRECT (
        .rs_ID(rs_ID),
        .rt_ID(rt_ID),
        .rs_EX(rs_EX),
        .rt_EX(rt_EX),
        .rt_Mem(rt_Mem),
        .w_num_Mem(w_num_Mem),
        .w_num_Wb(w_num_Wb),
        .reg_dst_ID(reg_dst_ID),
        .mem_write_EX(mem_write_EX),
        .reg_dst_EX(reg_dst_EX),
        .mem_write_Mem(mem_write_Mem),
        .s_src_EX(s_src_EX),
        .bne_EX(bne_EX),
        .beq_EX(beq_EX),
        .Mem_EX_X(Mem_EX_x),
        .Mem_EX_Y(Mem_EX_y),
        .Wb_EX_X(Wb_EX_x),
        .Wb_EX_Y(Wb_EX_y),
        .Wb_EX_r2(Wb_EX_r2),
        .Wb_Mem(Wb_Mem),
        .Wb_ID_r1(Wb_ID_r1),
        .Wb_ID_r2(Wb_ID_r2)
    );

    // load_use
    load_use_check LOAD_USE_CHECK (
        .rs_ID(rs_ID),
        .rt_ID(rt_ID),
        .rt_EX(rt_EX),
        .mem_read(mem_read_EX),
        .load_use(load_use)
    );
    
    // display
    always @(posedge clk) begin
        if(syscall_Wb && !halt) begin
            a0_reg <= a0_ID;
        end
    end
    display #(WIDTH) DISPLAY (
        .a0(choose[0] ? ram[0] : (choose[1] ? ram[1] : (choose[2] ? ram[2] : (choose[3] ? ram[3] : (choose[4] ? ram[4] : (choose[5] ? ram[5] : (choose[6] ? ram[6] : (choose[7] ? ram[7] : (choose[8] ? ram[8] : (choose[9] ? ram[9] : (choose[10] ? ram[10] : (choose[11] ? ram[11] : (choose[12] ? ram[12] : (choose[13] ? ram[13] : (choose[14] ? ram[14] : (choose[15] ? ram[15] : a0_reg)))))))))))))))),
        .clk(_clk[15]),
        .anodes(anodes),
        .cnodes(cnodes)
    );

endmodule
