module barrelShifter(
    input  [31:0] d0,  // Input data
    input  [31:0]  d1, // Shift amount   
    input  [1:0]  shiftMode,     // Mode: 00 = Left Shift, 01 = Right Shift, 10 = Rotate Left, 11 = Rotate Right
    output reg [31:0] shifted  // Shifted output
);
    
    always @(*) begin
        case (shiftMode)
            2'b00: shifted = d0 << d1;  // Logical Left Shift
            2'b01: shifted = d0 >> d1;  // Logical Right Shift
            2'b10: shifted = (d0 << d1) | (d0 >> (32 - d1)); // Rotate Left
            2'b11: shifted = (d0 >> d1) | (d0 << (32 - d1)); // Rotate Right
            default: shifted = d0;
        endcase
    end
    
endmodule
