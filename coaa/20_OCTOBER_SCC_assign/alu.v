// alu.v
// ------------------------------------------------------------
// 8-bit ALU supporting 14 operations
// Inputs: opcode, read_data1 (A), read_data2 (B)
// Output: result (alu_result)
// ------------------------------------------------------------

module alu (
    input  wire [3:0] opcode,       // ALU operation code
    input  wire [7:0] read_data1,   // A
    input  wire [7:0] read_data2,   // B
    output reg  [7:0] alu_result    // Result
);

    always @(*) begin
        case (opcode)
            4'b0000: alu_result = read_data1 + read_data2;  // ADD
            4'b0001: alu_result = read_data1 - read_data2;  // SUB
            4'b0010: alu_result = read_data1 & read_data2;  // AND
            4'b0011: alu_result = read_data1 | read_data2;  // OR
            4'b0100: alu_result = read_data1 ^ read_data2;  // XOR
            4'b0101: alu_result = ~read_data1;              // NOT (on A)
            4'b0110: alu_result = read_data1 << 1;          // SHL
            4'b0111: alu_result = read_data1 >> 1;          // SHR
            4'b1000: alu_result = (read_data1 > read_data2) ? 8'b1 : 8'b0; // GT
            4'b1001: alu_result = (read_data1 < read_data2) ? 8'b1 : 8'b0; // LT
            4'b1010: alu_result = (read_data1 == read_data2) ? 8'b1 : 8'b0; // EQ
            4'b1011: alu_result = (read_data1 != read_data2) ? 8'b1 : 8'b0; // NEQ
            4'b1100: alu_result = read_data1 + 1;           // INC
            4'b1101: alu_result = read_data1 - 1;           // DEC
            4'b1110: alu_result = read_data1;               // NOP (pass A)
            default: alu_result = 8'b0;                     // default
        endcase
    end

endmodule
