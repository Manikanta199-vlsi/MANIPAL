// decoder.v
// ------------------------------------------------------------
// Decodes a 16-bit instruction into control and data fields
// ------------------------------------------------------------
// Instruction format:
//  [15:11] → RD (destination register)
//  [10:8]  → RS2 (source register 2)
//  [7:5]   → RS1 (source register 1)
//  [4:1]   → OPCODE (defines ALU operation)
//  [0]     → WE (Write Enable flag)
// ------------------------------------------------------------

module decoder (
    input  wire [15:0] instruction,  // 16-bit instruction input
    output reg  [4:0]  rd,           // destination register
    output reg  [2:0]  rs1,          // source register 1
    output reg  [2:0]  rs2,          // source register 2
    output reg  [3:0]  opcode,       // ALU operation code
    output reg         WE            // write enable
);

    always @(*) begin
        // Extract individual fields from the instruction
        rd     = instruction[15:11];
        rs2    = instruction[10:8];
        rs1    = instruction[7:5];
        opcode = instruction[4:1];
        WE     = instruction[0];
    end

endmodule
