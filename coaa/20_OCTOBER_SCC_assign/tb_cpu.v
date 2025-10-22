// tb_cpu.v
// ------------------------------------------------------------
// Testbench for Single-Cycle CPU with Register Visibility
// ------------------------------------------------------------

`timescale 1ns/1ps

module tb_cpu;

    reg clk;
    reg reset;

    // -----------------------------
    // CPU instance wires
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
    // Instantiate CPU
    // -----------------------------
    cpu UUT (
        .clk(clk),
        .reset(reset)
    );

    // -----------------------------
    // Clock generation
    // -----------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    // -----------------------------
    // Reset
    // -----------------------------
    initial begin
        reset = 1;
        #12;
        reset = 0;
    end

    // -----------------------------
    // Waveform dump
    // -----------------------------
    initial begin
        $dumpfile("cpu_wave.vcd");
        $dumpvars(0, tb_cpu);

        #200 $finish; // run for 200ns
    end

    // -----------------------------
    // Instruction Memory Contents
    // -----------------------------
    wire [15:0] A0  = UUT.u_instr_mem.mem[0];
    wire [15:0] A1  = UUT.u_instr_mem.mem[1];
    wire [15:0] A2  = UUT.u_instr_mem.mem[2];
    wire [15:0] A3  = UUT.u_instr_mem.mem[3];
    wire [15:0] A4  = UUT.u_instr_mem.mem[4];
    wire [15:0] A5  = UUT.u_instr_mem.mem[5];
    wire [15:0] A6  = UUT.u_instr_mem.mem[6];
    wire [15:0] A7  = UUT.u_instr_mem.mem[7];
    wire [15:0] A8  = UUT.u_instr_mem.mem[8];
    wire [15:0] A9  = UUT.u_instr_mem.mem[9];
    wire [15:0] A10 = UUT.u_instr_mem.mem[10];
    wire [15:0] A11 = UUT.u_instr_mem.mem[11];
    wire [15:0] A12 = UUT.u_instr_mem.mem[12];
    wire [15:0] A13 = UUT.u_instr_mem.mem[13];
    wire [15:0] A14 = UUT.u_instr_mem.mem[14];
    wire [15:0] A15 = UUT.u_instr_mem.mem[15];

    // -----------------------------
    // Decoder Outputs
    // -----------------------------
    wire [4:0] dec_rd     = UUT.u_decoder.rd;
    wire [2:0] dec_rs1    = UUT.u_decoder.rs1;
    wire [2:0] dec_rs2    = UUT.u_decoder.rs2;
    wire [3:0] dec_opcode = UUT.u_decoder.opcode;
    wire       dec_WE     = UUT.u_decoder.WE;

    // -----------------------------
    // Register File Outputs
    // -----------------------------
    wire [7:0] reg_read_data1 = UUT.u_regfile.read_data1;
    wire [7:0] reg_read_data2 = UUT.u_regfile.read_data2;
    wire [7:0] reg_write_data = UUT.u_regfile.write_data;

    // Expose all 8 registers
    wire [7:0] R0 = UUT.u_regfile.R[0];
    wire [7:0] R1 = UUT.u_regfile.R[1];
    wire [7:0] R2 = UUT.u_regfile.R[2];
    wire [7:0] R3 = UUT.u_regfile.R[3];
    wire [7:0] R4 = UUT.u_regfile.R[4];
    wire [7:0] R5 = UUT.u_regfile.R[5];
    wire [7:0] R6 = UUT.u_regfile.R[6];
    wire [7:0] R7 = UUT.u_regfile.R[7];

    // -----------------------------
    // ALU Output
    // -----------------------------
    wire [7:0] alu_out = UUT.u_alu.alu_result;

endmodule
