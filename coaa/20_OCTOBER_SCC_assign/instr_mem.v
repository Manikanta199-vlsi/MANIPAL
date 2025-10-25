// instr_mem.v
// ------------------------------------------------------------
// 16 x 16-bit Instruction Memory (A0–A15)
// All instructions are ALU operations with WE=1
// ------------------------------------------------------------

module instr_mem (
    input  wire [3:0] addr,          // program counter input (0–15)
    output reg  [15:0] instruction   // 16-bit instruction output
);

    reg [15:0] mem [0:15];

    initial begin
        // A0 — ADD R1 + R2 → R3
        mem[0]  = {5'b00011, 3'b010, 3'b001, 4'b0000, 1'b1};
        // A1 — SUB R4 - R5 → R6
        mem[1]  = {5'b00110, 3'b101, 3'b100, 4'b0001, 1'b1};
        // A2 — AND R2 & R7 → R1
        mem[2]  = {5'b00001, 3'b111, 3'b010, 4'b0010, 1'b1};
        // A3 — OR R0 | R3 → R4
        mem[3]  = {5'b00100, 3'b011, 3'b000, 4'b0011, 1'b1};
        // A4 — XOR R5 ^ R6 → R7
        mem[4]  = {5'b00111, 3'b110, 3'b101, 4'b0100, 1'b1};
        // A5 — NOT R2 → R0
        mem[5]  = {5'b00000, 3'b000, 3'b010, 4'b0101, 1'b1};
        // A6 — SHL R1 → R2
        mem[6]  = {5'b00010, 3'b000, 3'b001, 4'b0110, 1'b1};
        // A7 — SHR R3 → R1
        mem[7]  = {5'b00001, 3'b011, 3'b011, 4'b0111, 1'b1};
        // A8 — GT R4 > R2 → R5
        mem[8]  = {5'b00101, 3'b010, 3'b100, 4'b1000, 1'b1};
        // A9 — LT R6 < R7 → R0
        mem[9]  = {5'b00000, 3'b111, 3'b110, 4'b1001, 1'b1};
        // A10 — EQ R1 == R3 → R2
        mem[10] = {5'b00010, 3'b011, 3'b001, 4'b1010, 1'b1};
        // A11 — NEQ R0 != R5 → R4
        mem[11] = {5'b00100, 3'b101, 3'b000, 4'b1011, 1'b1};
        // A12 — INC R2 → R2
        mem[12] = {5'b00010, 3'b010, 3'b010, 4'b1100, 1'b1};
        // A13 — DEC R7 → R7
        mem[13] = {5'b00111, 3'b111, 3'b111, 4'b1101, 1'b1};
        // A14 — NOP (for completeness, but WE=1, passes A)
        mem[14] = {5'b00000, 3'b000, 3'b000, 4'b1110, 1'b1};
        // A15 — ADD R5 + R3 → R6
        mem[15] = {5'b00110, 3'b011, 3'b101, 4'b0000, 1'b1};
    end

    always @(*) begin
        instruction = mem[addr];
    end

endmodule

