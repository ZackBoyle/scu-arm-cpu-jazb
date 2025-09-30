module core(
    input enable,
    input clk,
    input [31:0] dataIn,
    input [31:0] instr,
    output [31:0] instr_addr,
    output reg [31:0] dataOut,
    output reg [31:0] dataOut_addr,
    output reg mem_r,
    output reg mem_w
);

    // wire and register declarations
    
    // Decode Stage
    wire [31:0] PC_mux_out;
    reg PC_src;
    wire [3:0] instr_step;
    wire [3:0] rr0_decode;
    wire [3:0] rr1_decode;
    // ADD FLAG ENABLE FOR ARTH ALU
    wire shift;
    reg shift_decode;
    wire [31:0] imm;
    reg [31:0] imm_decode;
    wire ALU_src;
    reg ALU_src_decode;
    wire [3:0] ALU_op;
    reg [3:0] ALU_op_decode;
    wire [3:0] wr;
    reg [3:0] wr_decode;
    wire mem_r_wire;
    reg mem_r_decode;
    wire mem_w_wire;
    reg mem_w_decode;
    wire wd_src;
    reg wd_src_decode;
    wire [1:0] shift_mode;
    reg [1:0] shift_mode_decode;
    wire [31:0] d0_wire;
    reg [31:0] d0;
    wire [31:0] d1_wire;
    reg [31:0] d1;
    wire [31:0] PSR_out;
    reg [31:0] PSR_out_decode;
    wire [31:0] PC_wire;
    reg [31:0] PC_decode;
    wire [31:0] ASPROut_decode;
    wire [31:0] arth_ALU_in1;
    
    // Execute Stage
    wire [31:0] branch_ALU_out;
    wire [31:0] arth_ALU_out;
    wire [31:0] PSR_in;
    wire [31:0] shifter_output;
    wire [31:0] ALUs_out;
    
    reg [31:0] mem_r_exec;
    reg [31:0] mem_w_exec;
    
    reg [31:0] ALUs_out_exec;
    reg [31:0] dataIn_decode;
    reg [3:0] wr_exec;
    reg wd_src_exec;
    reg [31:0] d0_exec;
    reg [31:0] d1_exec;

    
    // Write Back Stage
    wire [31:0] wd_wb;
    reg [31:0] wr_wb;
    
      
    // Module Declarations
    
    // Decode Stage
    mux2to132bit PC_mux(
        .out(PC_mux_out),
        .sel(PC_src),
        .in0(instr_step),
        .in1(branch_ALU_out)
    );
    
    register_32 PC(
        .D(PC_mux_out),
        .Q(instr_addr),
        .we(enable),
        .clk(clk)
    );
    register_32 PSR(
        .D(PSR_in),
        .Q(PSR_out),
        .we(enable),
        .clk(clk)
    );
    
    arthALU PC_ALU(
        .d0(PC_wire),
        .d1(instr_addr), 
        .operation(3'b000),
        .updateFlags(1'b0),
        .ALUResult(PC_wire),
        .ASPROut(ASPROut_decode)
    );
    
    instr_decode decoder(
        .instr(instr),
        .instr_step(instr_step),
        .rr0(rr0_decode),
        .rr1(rr1_decode),
        .shift(shift),
        .imm(imm),
        .ALU_src(ALU_src),
        .ALU_op(ALU_op),
        .wr(wr),
        .mem_r(mem_r_wire),
        .mem_w(mem_w_wire),
        .wd_src(wd_src),
        .shift_mode(shift_mode)
    );
    
    regfile registers(
        .rr0(rr0_decode),    // Read reg 0
        .rr1(rr1_decode),    // Read reg 1
        .wr(wr_wb),     // Write reg
        .wd(wd_wb),     // Written data
        .we(enable),       // Global write enbable
        .clk(clk),      // Clock
        .d0(d0_wire),   // Data out 0
        .d1(d1_wire)   // Data out 1)
    );
    
    // Execute Stage
    arthALU branch_ALU(
        .d0(imm_decode),
        .d1(PC_decode),
        .operation(3'b000),
        .updateFlags(1'b0),
        .ALUResult(branch_ALU_out),
        .ASPROut()
    );
    
    arthALU arth_ALU(
        .d0(d0),
        .d1(arth_ALU_in1),
        .operation(ALU_op_decode),
        .updateFlags(1'b0),
        .ALUResult(arth_ALU_out),
        .ASPROut(PSR_in)
    );
    mux2to132bit arth_ALU_mux(
        .out(arth_ALU_in1),
        .sel(ALU_src_decode),
        .in0(d1),
        .in1(imm_decode) 
    );
    
    barrelShifter shifter(
        .d0(d0),
        .d1(arth_ALU_in1),
        .shiftMode(shift_mode_decode),
        .shifted(shifter_output)
    );
    
    mux2to132bit addr_src_mux(
        .out(ALUs_out),
        .sel(shift_decode),
        .in0(arth_ALU_out),
        .in1(shifter_output) 
    );
    
    // Write Back Stage
    mux2to132bit wb_src_mux(
        .in0(dataIn),
        .in1(ALUs_out_exec),
        .sel(wd_src_exec),
        .out(wd_wb)
    );
    
    always @(posedge clk) begin
         mem_r <= mem_r_exec;
         mem_w <= mem_w_exec;
         
         dataOut <= d1_exec;
         d0_exec <= d0;
         d1_exec <= d1;
         
         PSR_out_decode <= PSR_out;
         PC_decode <= PC_wire;
         
         shift_decode <= shift;
         imm_decode <= imm;
         ALU_src_decode <= ALU_src;
         ALU_op_decode <= ALU_op;
         wr_decode <= wr;
         mem_r_decode <= mem_r_wire;
         mem_w_decode <= mem_w_wire;
         wd_src_decode <= wd_src;
         shift_mode_decode <= shift_mode;
         d0 <= d0_wire;
         d1 <= d1_wire;
    end
endmodule