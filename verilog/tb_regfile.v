module regfile_tb;

    // Testbench signals
    reg [3:0] rr0, rr1, wr;
    reg [31:0] wd;
    reg we, clk;
    wire [31:0] d0, d1;
    
    // Instantiate the register file
    regfile uut (
        .rr0(rr0),
        .rr1(rr1),
        .wr(wr),
        .wd(wd),
        .we(we),
        .clk(clk),
        .d0(d0),
        .d1(d1)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    initial begin
        // Initialize signals
        clk = 0;
        we = 0;
        wr = 0;
        wd = 0;
        rr0 = 0;
        rr1 = 0;
        
        // Reset phase
        #10;
        
        // Write to all registers
        we = 1;
        for (integer i = 0; i < 16; i = i + 1) begin
            wr = i;
            wd = i * 32'h11111111;
            #10;
        end
        
        // Disable write enable
        we = 0;
        
        // Read from all registers and verify
        for (integer i = 0; i < 16; i = i + 1) begin
            rr0 = i;
            rr1 = (i + 1) % 16; // Read next register in parallel
            #10;
            if (d0 === (i * 32'h11111111))
                $display("PASS: Read d0 from R%0d = %h", rr0, d0);
            else
                $display("FAIL: Read d0 from R%0d = %h, expected %h", rr0, d0, i * 32'h11111111);
            
            if (d1 === ((i + 1) % 16) * 32'h11111111)
                $display("PASS: Read d1 from R%0d = %h", rr1, d1);
            else
                $display("FAIL: Read d1 from R%0d = %h, expected %h", rr1, d1, ((i + 1) % 16) * 32'h11111111);
        end
        
        // End simulation
        #20;
        $finish;
    end

endmodule
