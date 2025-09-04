`timescale 1ns/1ps

// ================= Block A (Register File) =================
module regfile (
    input  wire       clk,
    input  wire       we,             // write enable
    input  wire [31:0] wdata,         // data to write
    input  wire [1:0] write_addr,     // 2-bit write address
    input  wire [1:0] read_addr1,     // read address for port 1
    input  wire [1:0] read_addr2,     // read address for port 2

    output reg  [31:0] readdata1,     // output 1
    output reg  [31:0] readdata2,     // output 2

    // debug outputs
    output wire [31:0] r0_debug,
    output wire [31:0] r1_debug,
    output wire [31:0] r2_debug,
    output wire [31:0] r3_debug
);

    // internal registers
    reg [31:0] r0, r1, r2, r3;

    // WRITE + READ logic (synchronous)
    always @(posedge clk) begin
        // Write
        if (we) begin
            case (write_addr)
                2'b00: r0 <= wdata;
                2'b01: r1 <= wdata;
                2'b10: r2 <= wdata;
                2'b11: r3 <= wdata;
            endcase
        end

        // Read both ports independently
        case (read_addr1)
            2'b00: readdata1 <= r0;
            2'b01: readdata1 <= r1;
            2'b10: readdata1 <= r2;
            2'b11: readdata1 <= r3;
        endcase

        case (read_addr2)
            2'b00: readdata2 <= r0;
            2'b01: readdata2 <= r1;
            2'b10: readdata2 <= r2;
            2'b11: readdata2 <= r3;
        endcase
    end

    // connect internal regs to debug outputs
    assign r0_debug = r0;
    assign r1_debug = r1;
    assign r2_debug = r2;
    assign r3_debug = r3;

endmodule


// ================= Block B (Logic Unit) =================
module blockB (
    input  wire [31:0] readdata1,
    input  wire [31:0] readdata2,
    input  wire [1:0]  Paddr,     // operation select
    output reg  [31:0] ReadOut
);

    reg [31:0] r4, r5, r6, r7;

    always @(*) begin
        case (Paddr)
            2'b00: begin
                r4 = readdata1 & readdata2;
                ReadOut = r4;
            end
            2'b01: begin
                r5 = readdata1 | readdata2;
                ReadOut = r5;
            end
            2'b10: begin
                r6 = ~readdata1;
                ReadOut = r6;
            end
            2'b11: begin
                r7 = readdata1 ^ readdata2;
                ReadOut = r7;
            end
        endcase
    end
endmodule
