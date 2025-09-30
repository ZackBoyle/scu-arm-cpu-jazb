module regfile(
    input [3:0] rr0,    // Read reg 0
    input [3:0] rr1,    // Read reg 1
    input [3:0] wr,     // Write reg
    input [3:0] wd,     // Written data
    input we,       // Global write enbable
    input clk,      // Clock
    output reg [31:0] d0,   // Data out 0
    output reg [31:0] d1   // Data out 1
);

    wire [31:0] rOut [0:15];    // Output of every reg in an array
    wire [15:0] writeAddrDecoded;

    decoder4to16 writeAddrDecoder(.in(wr), .enable(we), .out(writeAddrDecoded)); // Decode write address

    // Reg module declarations
    register_32 R0(.D(wd), .Q(rOut[0]), .we(writeAddrDecoded[0]), .clk(clk));
    register_32 R1(.D(wd), .Q(rOut[1]), .we(writeAddrDecoded[1]), .clk(clk));
    register_32 R2(.D(wd), .Q(rOut[2]), .we(writeAddrDecoded[2]), .clk(clk));
    register_32 R3(.D(wd), .Q(rOut[3]), .we(writeAddrDecoded[3]), .clk(clk));
    register_32 R4(.D(wd), .Q(rOut[4]), .we(writeAddrDecoded[4]), .clk(clk));
    register_32 R5(.D(wd), .Q(rOut[5]), .we(writeAddrDecoded[5]), .clk(clk));
    register_32 R6(.D(wd), .Q(rOut[6]), .we(writeAddrDecoded[6]), .clk(clk));
    register_32 R7(.D(wd), .Q(rOut[7]), .we(writeAddrDecoded[7]), .clk(clk));
    register_32 R8(.D(wd), .Q(rOut[8]), .we(writeAddrDecoded[8]), .clk(clk));
    register_32 R9(.D(wd), .Q(rOut[9]), .we(writeAddrDecoded[9]), .clk(clk));
    register_32 R10(.D(wd), .Q(rOut[10]), .we(writeAddrDecoded[10]), .clk(clk));
    register_32 R11(.D(wd), .Q(rOut[11]), .we(writeAddrDecoded[11]), .clk(clk));
    register_32 R12(.D(wd), .Q(rOut[12]), .we(writeAddrDecoded[12]), .clk(clk));
    register_32 SP(.D(wd), .Q(rOut[13]), .we(writeAddrDecoded[13]), .clk(clk));
    register_32 LR(.D(wd), .Q(rOut[14]), .we(writeAddrDecoded[14]), .clk(clk));
    register_32 PC(.D(wd), .Q(rOut[15]), .we(writeAddrDecoded[15]), .clk(clk));

    // Read data logic
    always @(posedge clk) begin
        case (rr0)
                4'h0: d0 <= rOut[0];
                4'h1: d0 <= rOut[1];
                4'h2: d0 <= rOut[2];
                4'h3: d0 <= rOut[3];
                4'h4: d0 <= rOut[4];
                4'h5: d0 <= rOut[5];
                4'h6: d0 <= rOut[6];
                4'h7: d0 <= rOut[7];
                4'h8: d0 <= rOut[8];
                4'h9: d0 <= rOut[9];
                4'hA: d0 <= rOut[10];
                4'hB: d0 <= rOut[11];
                4'hC: d0 <= rOut[12];
                4'hD: d0 <= rOut[13];
                4'hE: d0 <= rOut[14];
                4'hF: d0 <= rOut[15];
        endcase
        case (rr1)
                4'h0: d1 <= rOut[0];
                4'h1: d1 <= rOut[1];
                4'h2: d1 <= rOut[2];
                4'h3: d1 <= rOut[3];
                4'h4: d1 <= rOut[4];
                4'h5: d1 <= rOut[5];
                4'h6: d1 <= rOut[6];
                4'h7: d1 <= rOut[7];
                4'h8: d1 <= rOut[8];
                4'h9: d1 <= rOut[9];
                4'hA: d1 <= rOut[10];
                4'hB: d1 <= rOut[11];
                4'hC: d1 <= rOut[12];
                4'hD: d1 <= rOut[13];
                4'hE: d1 <= rOut[14];
                4'hF: d1 <= rOut[15];
        endcase
    end

endmodule