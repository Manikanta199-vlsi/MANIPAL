

// pc.v
// ---------------------------
// 4-bit Program Counter (PC)
// ---------------------------
// • Holds address of current instruction (0–15)
// • Increments by +1 on every clock’s rising edge
// • Asynchronous reset sets PC back to 0
// • Wraps naturally (mod 16)

module pc (
    input  wire clk,       // system clock
    input  wire reset,     // asynchronous active-high reset
    output reg  [3:0] pc_out  // current program counter value (4 bits)
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 4'b0000;        // reset PC to 0
        else
            pc_out <= pc_out + 1'b1;  // increment each clock
    end

endmodule
