// cpu.v
// ------------------------------------------------------------
// Top module for Single-Cycle CPU
// ------------------------------------------------------------

module cpu (
    input  wire clk,
    input  wire reset
);

    // -----------------------------
    // Wires between modules
    // -----------------------------
    wire [3:0] pc_out;
    wire [15:0] instruction;

    wire [4:0] rd;
    wire [2:0] rs1;
    wire [2:0] rs2;
    wire [3:0] opcode;
    wire       WE;

    wire [7:0] read_data1;
    wire [7:0] read_data2;
    wire [7:0] alu_result;

    // -----------------------------
    // Instantiate Program Counter
    // -----------------------------
    pc u_pc (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out)
    );

    // -----------------------------
    // Instantiate Instruction Memory
    // -----------------------------
    instr_mem u_instr_mem (
        .addr(pc_out),
        .instruction(instruction)
    );

    // -----------------------------
    // Instantiate Decoder
    // -----------------------------
    decoder u_decoder (
        .instruction(instruction),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .opcode(opcode),
        .WE(WE)
    );

    // -----------------------------
    // Instantiate Register File
    // -----------------------------
    regfile u_regfile (
        .clk(clk),
        .WE(WE),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd[2:0]),        // lower 3 bits of rd (R0-R7)
        .write_data(alu_result),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // -----------------------------
    // Instantiate ALU
    // -----------------------------
    alu u_alu (
        .opcode(opcode),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .alu_result(alu_result)
    );

endmodule
