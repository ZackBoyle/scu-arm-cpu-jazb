module instr_decode(
    input [15:0] instr,
    output [3:0] instr_step,
    output [3:0] rr0,
    output [3:0] rr1,
    output shift,
    output [31:0] imm,
    output ALU_src,
    output [3:0] wr,
    output mem_r,
    output mem_w,
    output wd_src,
    output [1:0] shift_mode
);

    always @(*) begin
        /*
        Shift (immediate), add, subtract, move, and compare
        */
        if (instr[15:14] == 2'b00) begin
            casez (instr[13:9])
                // LSL (imm)
                5'b000??: begin
                    instr_step = 4'b0100; // 16 bit instr
                    rr0 = instr[5:3];
                    rr1 = 4'b0000;
                    shift = 1'b1;
                    imm = {27'b0, instr[10:6]};
                    ALU_src = 1'b1;
                    wr = instr[2:0];
                    mem_r = 0;
                    mem_w = 0;
                    wd_src = 1;
                    shift_mode = 2'b00;
                end
                // LSR (imm)
                5'b000??: begin
                    instr_step = 4'b0100; // 16 bit instr
                    rr0 = instr[5:3];
                    rr1 = 4'b0000;
                    shift = 1'b1;
                    imm = {27'b0, instr[10:6]};
                    ALU_src = 1'b1;
                    wr = instr[2:0];
                    mem_r = 0;
                    mem_w = 0;
                    wd_src = 1;
                    shift_mode = 2'b01;
                end               

                default: 
            endcase
        end
    end

endmodule