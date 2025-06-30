module mux3to1 (
    input  [31:0] in0,   // First input
    input  [31:0] in1,   // Second input
    input  [31:0] in2,   // Third input
    input  [1:0]  sel,   // 2-bit selector
    output reg [31:0] out
);
    
    always @(*) begin
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            default: out = 32'b0;
        endcase
    end
    
endmodule