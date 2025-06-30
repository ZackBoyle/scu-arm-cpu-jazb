module mux2to132bit (
    input  [31:0] in0, in1,  // Two 32-bit inputs
    input         sel,       // Select signal
    output [31:0] out        // 32-bit output
);
    
    assign out = sel ? in1 : in0; // Select input based on sel
    
endmodule
