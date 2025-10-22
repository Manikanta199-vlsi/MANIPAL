// regfile.v
// ------------------------------------------------------------
// 8 x 8-bit General Purpose Register File (R0-R7)
// ------------------------------------------------------------
// • Reads two source registers (rs1, rs2) combinationally
// • Writes to destination register (rd) on rising clock if WE=1
// • Random initial values assigned to registers for testing
// ------------------------------------------------------------

module regfile (
    input  wire        clk,        // system clock
    input  wire        WE,         // write enable
    input  wire [2:0]  rs1,        // source register 1 index (0-7)
    input  wire [2:0]  rs2,        // source register 2 index (0-7)
    input  wire [2:0]  rd,         // destination register index (0-7)
    input  wire [7:0]  write_data, // data to write into rd
    output reg  [7:0]  read_data1, // value read from rs1
    output reg  [7:0]  read_data2  // value read from rs2
);

    reg [7:0] R [0:7]; // 8 registers, 8-bit each

    // Initialize registers with random 8-bit values for simulation
    initial begin
        R[0] = 8'h12;
        R[1] = 8'hA5;
        R[2] = 8'h3C;
        R[3] = 8'h7F;
        R[4] = 8'hD2;
        R[5] = 8'hE8;
        R[6] = 8'h01;
        R[7] = 8'h9B;
    end

    // Combinational read
    always @(*) begin
        read_data1 = R[rs1];
        read_data2 = R[rs2];
    end

    // Sequential write on clock rising edge
    always @(posedge clk) begin
        if (WE) begin
            R[rd] <= write_data;
        end
    end

endmodule
