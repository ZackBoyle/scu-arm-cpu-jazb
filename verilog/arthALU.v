module arthALU(
    input [31:0] d0, d1,  // Data inputs
    input [2:0] operation, // Operation select
    input updateFlags,  // Flag write enable
    output reg [31:0] ALUResult, // Calculated result
    output reg [31:0] ASPROut   // ASPR Out
);

    // Temporary values of C and V flags
    reg V;
    reg C;

    always @(*) begin
        case (op)
            3'b000: begin // Addition
                {C, result} = d0 + d1;
                V = (d0[31] == d1[31]) && (result[31] != d0[31]);
            end
            3'b001: begin // Subtraction
                {C, result} = d0 - d1;
                V = (d0[31] != d1[31]) && (result[31] != d0[31]);
            end
            3'b010: result = d0 & d1;  // Bitwise AND
            3'b011: result = d0 | d1;  // Bitwise OR
            3'b100: result = d0 ^ d1;  // Bitwise XOR
            3'b101: result = d0;     // Bitwise NOT (on a)
            default: result = 32'b0; // Default case
        endcase
    end

    always @(*) begin
        if (updateFlags) begin
            // N flag is set when 2s compliment of result is negative 
            case (result[31])
                1'b0: ASPROut[31] = 1'b0;
                1'b1: ASPROut[31] = 1'b1;
                default: ASPROut[31] = 1'b0;
            endcase

            // Z flag is set when result is 0
            case (result)
                32'b0: ASPROut[30] = 1'b1;
                default: ASPROut[30] = 1'b0;
            endcase

            // C flag is set when a carryout condition occurs
            ASPROut[29] = C;

            // V flag is set when an overflow occurs
            ASPROut[28] = V;
        end
    end

endmodule