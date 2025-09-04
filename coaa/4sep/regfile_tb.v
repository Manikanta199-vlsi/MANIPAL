`timescale 1ns/1ps

module tb;

    reg clk;
    reg we;
    reg [31:0] wdata;
    reg [1:0] write_addr;
    reg [1:0] read_addr1, read_addr2;
    reg [1:0] Paddr;

    wire [31:0] readdata1, readdata2;
    wire [31:0] ReadOut;
    wire [31:0] r0_debug, r1_debug, r2_debug, r3_debug;

    // Instantiate regfile
    regfile RF (
        .clk(clk),
        .we(we),
        .wdata(wdata),
        .write_addr(write_addr),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .readdata1(readdata1),
        .readdata2(readdata2),
        .r0_debug(r0_debug),
        .r1_debug(r1_debug),
        .r2_debug(r2_debug),
        .r3_debug(r3_debug)
    );

    // Instantiate blockB
    blockB B (
        .readdata1(readdata1),
        .readdata2(readdata2),
        .Paddr(Paddr),
        .ReadOut(ReadOut)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns period

    initial begin
        $dumpfile("regfile_blockB.vcd");
        $dumpvars(0, tb);

        // Initialize
        we = 0; wdata = 0; write_addr = 0;
        read_addr1 = 0; read_addr2 = 0;
        Paddr = 0;

        #10;
        
        // Write values into registers
        #10 we = 1; write_addr = 2'b00; wdata = 32'hAAAA1111;
        #10 we = 1; write_addr = 2'b01; wdata = 32'hBBBB2222;
        #10 we = 1; write_addr = 2'b10; wdata = 32'hCCCC3333;
        #10 we = 1; write_addr = 2'b11; wdata = 32'hDDDD4444;
        #10 we = 0;

        // Read into readdata1
        #10 read_addr1 = 2'b00;
        #10 read_addr1 = 2'b01;
	#10 read_addr1 = 2'b10;
	#10 read_addr1 = 2'b11;


        // Read into readdata2
        #10 read_addr2 = 2'b00;
	#10 read_addr2 = 2'b01;
        #10 read_addr2 = 2'b10;
	#10 read_addr2 = 2'b11;








        // Write different values to r0 and r1
        we = 1; write_addr = 2'b00; wdata = 32'hDDDD4444; #10;
        write_addr = 2'b01; wdata = 32'hAAAA1111; #10;
        we = 0;

        // Test AND operation
        read_addr1 = 2'b00; read_addr2 = 2'b01; Paddr = 2'b00; #10;
        $display("AND: %h & %h = %h", readdata1, readdata2, ReadOut);

        // Test OR operation
        Paddr = 2'b01; #10;
        $display("OR: %h | %h = %h", readdata1, readdata2, ReadOut);

        // Test NOT (on read_addr1)
        Paddr = 2'b10; #10;
        $display("NOT: ~%h = %h", readdata1, ReadOut);

        // Test XOR
        Paddr = 2'b11; #10;
        $display("XOR: %h ^ %h = %h", readdata1, readdata2, ReadOut);

        $finish;
    end

endmodule
