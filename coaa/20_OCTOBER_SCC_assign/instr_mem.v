 // instr_mem.v
 2 // ------------------------------------------------------------
 3 // 16 x 16-bit Instruction Memory (A0–A15)
 4 // All instructions are ALU operations with WE=1
 5 // ------------------------------------------------------------
 6
 7 module instr_mem (
 8     input  wire [3:0] addr,          // program counter input (0–15)
 9     output reg  [15:0] instruction   // 16-bit instruction output
10 );
11
12     reg [15:0] mem [0:15];
13
14     initial begin
15         // A0 — ADD R1 + R2 → R3
16         mem[0]  = {5'b00011, 3'b010, 3'b001, 4'b0000, 1'b1};
17         // A1 — SUB R4 - R5 → R6
18         mem[1]  = {5'b00110, 3'b101, 3'b100, 4'b0001, 1'b1};
19         // A2 — AND R2 & R7 → R1
20         mem[2]  = {5'b00001, 3'b111, 3'b010, 4'b0010, 1'b1};
21         // A3 — OR R0 | R3 → R4
22         mem[3]  = {5'b00100, 3'b011, 3'b000, 4'b0011, 1'b1};
23         // A4 — XOR R5 ^ R6 → R7
24         mem[4]  = {5'b00111, 3'b110, 3'b101, 4'b0100, 1'b1};
25         // A5 — NOT R2 → R0
26         mem[5]  = {5'b00000, 3'b000, 3'b010, 4'b0101, 1'b1};
27         // A6 — SHL R1 → R2
28         mem[6]  = {5'b00010, 3'b000, 3'b001, 4'b0110, 1'b1};
29         // A7 — SHR R3 → R1
30         mem[7]  = {5'b00001, 3'b011, 3'b011, 4'b0111, 1'b1};
31         // A8 — GT R4 > R2 → R5
32         mem[8]  = {5'b00101, 3'b010, 3'b100, 4'b1000, 1'b1};
33         // A9 — LT R6 < R7 → R0
34         mem[9]  = {5'b00000, 3'b111, 3'b110, 4'b1001, 1'b1};

	           // A10 — EQ R1 == R3 → R2
36         mem[10] = {5'b00010, 3'b011, 3'b001, 4'b1010, 1'b1};
37         // A11 — NEQ R0 != R5 → R4
38         mem[11] = {5'b00100, 3'b101, 3'b000, 4'b1011, 1'b1};
39         // A12 — INC R2 → R2
40         mem[12] = {5'b00010, 3'b010, 3'b010, 4'b1100, 1'b1};
41         // A13 — DEC R7 → R7
42         mem[13] = {5'b00111, 3'b111, 3'b111, 4'b1101, 1'b1};
43         // A14 — NOP (for completeness, but WE=1, passes A)
44         mem[14] = {5'b00000, 3'b000, 3'b000, 4'b1110, 1'b1};
45         // A15 — ADD R5 + R3 → R6
46         mem[15] = {5'b00110, 3'b011, 3'b101, 4'b0000, 1'b1};
47     end
48
49     always @(*) begin
50         instruction = mem[addr];
51     end
52
53 endmodule
