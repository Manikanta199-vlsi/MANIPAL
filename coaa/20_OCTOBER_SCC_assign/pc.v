 // pc.v
 2 // ---------------------------
 3 // 4-bit Program Counter (PC)
 4 // ---------------------------
 5 // • Holds address of current instruction (0–15)
 6 // • Increments by +1 on every clock’s rising edge
 7 // • Asynchronous reset sets PC back to 0
 8 // • Wraps naturally (mod 16)
 9
10 module pc (
11     input  wire clk,       // system clock
12     input  wire reset,     // asynchronous active-high reset
13     output reg  [3:0] pc_out  // current program counter value (4 bits)
14 );
15
16     always @(posedge clk or posedge reset) begin
17         if (reset)
18             pc_out <= 4'b0000;        // reset PC to 0
19         else
20             pc_out <= pc_out + 1'b1;  // increment each clock
21     end
22
