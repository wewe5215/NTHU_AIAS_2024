module InstMem(
  input         clock,
  input  [14:0] io_raddr,
  output [31:0] io_inst
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [7:0] memory [0:32767]; // @[InstMem.scala 15:19]
  wire  memory_rdata_MPORT_en; // @[InstMem.scala 15:19]
  wire [14:0] memory_rdata_MPORT_addr; // @[InstMem.scala 15:19]
  wire [7:0] memory_rdata_MPORT_data; // @[InstMem.scala 15:19]
  wire  memory_rdata_MPORT_1_en; // @[InstMem.scala 15:19]
  wire [14:0] memory_rdata_MPORT_1_addr; // @[InstMem.scala 15:19]
  wire [7:0] memory_rdata_MPORT_1_data; // @[InstMem.scala 15:19]
  wire  memory_rdata_MPORT_2_en; // @[InstMem.scala 15:19]
  wire [14:0] memory_rdata_MPORT_2_addr; // @[InstMem.scala 15:19]
  wire [7:0] memory_rdata_MPORT_2_data; // @[InstMem.scala 15:19]
  wire  memory_rdata_MPORT_3_en; // @[InstMem.scala 15:19]
  wire [14:0] memory_rdata_MPORT_3_addr; // @[InstMem.scala 15:19]
  wire [7:0] memory_rdata_MPORT_3_data; // @[InstMem.scala 15:19]
  wire [15:0] _rdata_T_6 = {{1'd0}, io_raddr}; // @[InstMem.scala 23:22]
  wire [15:0] rdata_lo = {memory_rdata_MPORT_2_data,memory_rdata_MPORT_3_data}; // @[Cat.scala 33:92]
  wire [15:0] rdata_hi = {memory_rdata_MPORT_data,memory_rdata_MPORT_1_data}; // @[Cat.scala 33:92]
  assign memory_rdata_MPORT_en = 1'h1;
  assign memory_rdata_MPORT_addr = io_raddr + 15'h3;
  assign memory_rdata_MPORT_data = memory[memory_rdata_MPORT_addr]; // @[InstMem.scala 15:19]
  assign memory_rdata_MPORT_1_en = 1'h1;
  assign memory_rdata_MPORT_1_addr = io_raddr + 15'h2;
  assign memory_rdata_MPORT_1_data = memory[memory_rdata_MPORT_1_addr]; // @[InstMem.scala 15:19]
  assign memory_rdata_MPORT_2_en = 1'h1;
  assign memory_rdata_MPORT_2_addr = io_raddr + 15'h1;
  assign memory_rdata_MPORT_2_data = memory[memory_rdata_MPORT_2_addr]; // @[InstMem.scala 15:19]
  assign memory_rdata_MPORT_3_en = 1'h1;
  assign memory_rdata_MPORT_3_addr = _rdata_T_6[14:0];
  assign memory_rdata_MPORT_3_data = memory[memory_rdata_MPORT_3_addr]; // @[InstMem.scala 15:19]
  assign io_inst = {rdata_hi,rdata_lo}; // @[Cat.scala 33:92]
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32768; initvar = initvar+1)
    memory[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Controller(
  input         clock,
  input         reset,
  input  [31:0] io_Inst,
  input         io_BrEq,
  input         io_BrLT,
  input         io_aw_ready,
  output        io_aw_valid,
  input         io_w_ready,
  output        io_w_valid,
  output        io_b_ready,
  input         io_b_valid,
  input         io_ar_ready,
  output        io_ar_valid,
  output        io_r_ready,
  input         io_r_valid,
  output [1:0]  io_PCSel,
  output [2:0]  io_ImmSel,
  output        io_RegWEn,
  output        io_BrUn,
  output        io_ASel,
  output [1:0]  io_BSel,
  output [14:0] io_ALUSel,
  output [1:0]  io_WBSel,
  output        io_Lui,
  output        io_Hcf
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [6:0] opcode = io_Inst[6:0]; // @[Controller.scala 43:23]
  wire [2:0] funct3 = io_Inst[14:12]; // @[Controller.scala 44:23]
  wire [6:0] funct7 = io_Inst[31:25]; // @[Controller.scala 45:23]
  wire [4:0] rs2 = io_Inst[24:20]; // @[Controller.scala 46:23]
  reg [2:0] DataMemAccessState; // @[Controller.scala 56:35]
  wire  isDataLoad = opcode == 7'h3; // @[Controller.scala 61:26]
  wire  isDataStore = opcode == 7'h23; // @[Controller.scala 62:26]
  wire  _T = 3'h0 == DataMemAccessState; // @[Controller.scala 102:30]
  wire [2:0] _DataMemAccessState_T = io_ar_ready ? 3'h2 : 3'h1; // @[Controller.scala 105:34]
  wire [2:0] _DataMemAccessState_T_2 = io_aw_ready & io_w_ready ? 3'h4 : 3'h3; // @[Controller.scala 107:34]
  wire  _T_1 = 3'h1 == DataMemAccessState; // @[Controller.scala 102:30]
  wire  _T_2 = 3'h2 == DataMemAccessState; // @[Controller.scala 102:30]
  wire [2:0] _DataMemAccessState_T_4 = io_r_valid ? 3'h0 : 3'h2; // @[Controller.scala 116:32]
  wire  _T_3 = 3'h3 == DataMemAccessState; // @[Controller.scala 102:30]
  wire  _T_4 = 3'h4 == DataMemAccessState; // @[Controller.scala 102:30]
  wire [2:0] _DataMemAccessState_T_7 = io_b_valid ? 3'h0 : 3'h4; // @[Controller.scala 122:32]
  wire [2:0] _GEN_2 = 3'h4 == DataMemAccessState ? _DataMemAccessState_T_7 : DataMemAccessState; // @[Controller.scala 102:30 122:26 56:35]
  wire [2:0] _GEN_3 = 3'h3 == DataMemAccessState ? _DataMemAccessState_T_2 : _GEN_2; // @[Controller.scala 102:30 119:26]
  wire  _GEN_9 = _T_3 ? 1'h0 : _T_4; // @[Controller.scala 128:30 97:18]
  wire  _GEN_11 = _T_2 ? 1'h0 : _T_3; // @[Controller.scala 128:30 80:21]
  wire  _GEN_12 = _T_2 ? 1'h0 : _GEN_9; // @[Controller.scala 128:30 97:18]
  wire  _GEN_14 = _T_1 ? 1'h0 : _T_2; // @[Controller.scala 128:30 78:19]
  wire  _GEN_15 = _T_1 ? 1'h0 : _GEN_11; // @[Controller.scala 128:30 80:21]
  wire  _GEN_16 = _T_1 ? 1'h0 : _GEN_12; // @[Controller.scala 128:30 97:18]
  wire [14:0] _alu_op_T = {funct7,5'h0,funct3}; // @[Cat.scala 33:92]
  wire [14:0] _alu_op_T_1 = {funct7,5'h1f,funct3}; // @[Cat.scala 33:92]
  wire [14:0] _GEN_21 = funct7 == 7'h4 & funct3 == 3'h4 ? _alu_op_T : _alu_op_T_1; // @[Controller.scala 154:61 156:14 160:13]
  wire  _T_15 = funct3 == 3'h5; // @[Controller.scala 163:17]
  wire  _T_20 = funct3 == 3'h1; // @[Controller.scala 168:23]
  wire  _T_26 = _T_20 | _T_15; // @[Controller.scala 173:38]
  wire [14:0] _alu_op_T_4 = {funct7,rs2,funct3}; // @[Cat.scala 33:92]
  wire [14:0] _alu_op_T_6 = {12'h1f,funct3}; // @[Cat.scala 33:92]
  wire [14:0] _GEN_22 = _T_26 ? _alu_op_T_1 : _alu_op_T_6; // @[Controller.scala 178:62 181:13 185:14]
  wire [14:0] _GEN_23 = (_T_20 | _T_15) & funct7[4] ? _alu_op_T_4 : _GEN_22; // @[Controller.scala 173:86 176:13]
  wire [14:0] _GEN_24 = funct3 == 3'h1 & funct7[2] ? _alu_op_T_1 : _GEN_23; // @[Controller.scala 168:60 171:13]
  wire [14:0] _GEN_25 = funct3 == 3'h5 & (funct7 == 7'h30 | funct7 == 7'h24) ? _alu_op_T_1 : _GEN_24; // @[Controller.scala 163:90 166:13]
  wire [14:0] _GEN_26 = opcode == 7'h13 ? _GEN_25 : 15'hf8; // @[Controller.scala 162:32 189:12]
  wire  _io_PCSel_T = ~io_BrEq; // @[Controller.scala 209:23]
  wire  _io_PCSel_T_1 = ~io_BrLT; // @[Controller.scala 211:23]
  wire  _io_PCSel_T_6 = 3'h1 == funct3 ? _io_PCSel_T : 3'h0 == funct3 & io_BrEq; // @[Mux.scala 81:58]
  wire  _io_PCSel_T_8 = 3'h4 == funct3 ? io_BrLT : _io_PCSel_T_6; // @[Mux.scala 81:58]
  wire  _io_PCSel_T_10 = 3'h5 == funct3 ? _io_PCSel_T_1 : _io_PCSel_T_8; // @[Mux.scala 81:58]
  wire  _io_PCSel_T_12 = 3'h6 == funct3 ? io_BrLT : _io_PCSel_T_10; // @[Mux.scala 81:58]
  wire  _io_PCSel_T_14 = 3'h7 == funct3 ? _io_PCSel_T_1 : _io_PCSel_T_12; // @[Mux.scala 81:58]
  wire  _io_PCSel_T_20 = 7'h6f == opcode | (7'h67 == opcode | 7'h63 == opcode & _io_PCSel_T_14); // @[Mux.scala 81:58]
  wire [1:0] _GEN_28 = isDataLoad | isDataStore ? 2'h2 : {{1'd0}, _io_PCSel_T_20}; // @[Controller.scala 197:38 198:18 200:18]
  wire [1:0] _io_PCSel_T_21 = io_r_valid ? 2'h0 : 2'h2; // @[Controller.scala 226:22]
  wire [1:0] _io_PCSel_T_22 = io_b_valid ? 2'h0 : 2'h2; // @[Controller.scala 232:22]
  wire [1:0] _GEN_29 = _T_4 ? _io_PCSel_T_22 : 2'h0; // @[Controller.scala 194:12 195:30 232:16]
  wire [1:0] _GEN_30 = _T_3 ? 2'h2 : _GEN_29; // @[Controller.scala 195:30 229:16]
  wire [1:0] _GEN_31 = _T_2 ? _io_PCSel_T_21 : _GEN_30; // @[Controller.scala 195:30 226:16]
  wire [1:0] _GEN_32 = _T_1 ? 2'h2 : _GEN_31; // @[Controller.scala 195:30 223:16]
  wire  _io_ImmSel_T_3 = 7'h3 == opcode | 7'h13 == opcode; // @[Mux.scala 81:58]
  wire [1:0] _io_ImmSel_T_5 = 7'h23 == opcode ? 2'h2 : {{1'd0}, _io_ImmSel_T_3}; // @[Mux.scala 81:58]
  wire [1:0] _io_ImmSel_T_7 = 7'h63 == opcode ? 2'h3 : _io_ImmSel_T_5; // @[Mux.scala 81:58]
  wire [1:0] _io_ImmSel_T_9 = 7'h67 == opcode ? 2'h1 : _io_ImmSel_T_7; // @[Mux.scala 81:58]
  wire [2:0] _io_ImmSel_T_11 = 7'h6f == opcode ? 3'h4 : {{1'd0}, _io_ImmSel_T_9}; // @[Mux.scala 81:58]
  wire [2:0] _io_ImmSel_T_13 = 7'h37 == opcode ? 3'h5 : _io_ImmSel_T_11; // @[Mux.scala 81:58]
  wire  _io_BSel_T_1 = 7'h33 == opcode ? 1'h0 : 1'h1; // @[Mux.scala 81:58]
  wire  _io_RegWEn_T_11 = 7'h37 == opcode | (7'h17 == opcode | (7'h33 == opcode | (7'h13 == opcode | (7'h6f == opcode | 7'h67
     == opcode)))); // @[Mux.scala 81:58]
  wire  _GEN_36 = _T_2 & (io_r_valid & isDataLoad); // @[Controller.scala 283:30 302:17]
  wire  _GEN_37 = _T_1 ? 1'h0 : _GEN_36; // @[Controller.scala 283:30 299:17]
  wire  _io_WBSel_T_1 = 7'h3 == opcode ? 1'h0 : 1'h1; // @[Mux.scala 81:58]
  wire [1:0] _io_WBSel_T_3 = 7'h67 == opcode ? 2'h2 : {{1'd0}, _io_WBSel_T_1}; // @[Mux.scala 81:58]
  assign io_aw_valid = _T ? isDataStore : _GEN_15; // @[Controller.scala 128:30 131:19]
  assign io_w_valid = _T ? isDataStore : _GEN_15; // @[Controller.scala 128:30 131:19]
  assign io_b_ready = _T ? 1'h0 : _GEN_16; // @[Controller.scala 128:30 97:18]
  assign io_ar_valid = _T ? isDataLoad : _T_1; // @[Controller.scala 128:30 130:20]
  assign io_r_ready = _T ? 1'h0 : _GEN_14; // @[Controller.scala 128:30 78:19]
  assign io_PCSel = _T ? _GEN_28 : _GEN_32; // @[Controller.scala 195:30]
  assign io_ImmSel = 7'h17 == opcode ? 3'h5 : _io_ImmSel_T_13; // @[Mux.scala 81:58]
  assign io_RegWEn = _T ? _io_RegWEn_T_11 : _GEN_37; // @[Controller.scala 283:30 285:17]
  assign io_BrUn = io_Inst[13]; // @[Controller.scala 239:22]
  assign io_ASel = 7'h17 == opcode | (7'h6f == opcode | 7'h63 == opcode); // @[Mux.scala 81:58]
  assign io_BSel = {{1'd0}, _io_BSel_T_1}; // @[Controller.scala 271:11]
  assign io_ALUSel = opcode == 7'h33 ? _GEN_21 : _GEN_26; // @[Controller.scala 153:23]
  assign io_WBSel = 7'h6f == opcode ? 2'h2 : _io_WBSel_T_3; // @[Mux.scala 81:58]
  assign io_Lui = opcode == 7'h37; // @[Controller.scala 244:21]
  assign io_Hcf = opcode == 7'hb; // @[Controller.scala 323:20]
  always @(posedge clock) begin
    if (reset) begin // @[Controller.scala 56:35]
      DataMemAccessState <= 3'h0; // @[Controller.scala 56:35]
    end else if (3'h0 == DataMemAccessState) begin // @[Controller.scala 102:30]
      if (isDataLoad) begin // @[Controller.scala 104:24]
        DataMemAccessState <= _DataMemAccessState_T; // @[Controller.scala 105:28]
      end else if (isDataStore) begin // @[Controller.scala 106:31]
        DataMemAccessState <= _DataMemAccessState_T_2; // @[Controller.scala 107:28]
      end else begin
        DataMemAccessState <= 3'h0; // @[Controller.scala 109:28]
      end
    end else if (3'h1 == DataMemAccessState) begin // @[Controller.scala 102:30]
      DataMemAccessState <= _DataMemAccessState_T; // @[Controller.scala 113:26]
    end else if (3'h2 == DataMemAccessState) begin // @[Controller.scala 102:30]
      DataMemAccessState <= _DataMemAccessState_T_4; // @[Controller.scala 116:26]
    end else begin
      DataMemAccessState <= _GEN_3;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  DataMemAccessState = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PC(
  input         clock,
  input         reset,
  input         io_Hcf,
  input  [1:0]  io_PCSel,
  input  [31:0] io_alu_out,
  output [14:0] io_pc
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pcReg; // @[PC.scala 14:22]
  wire [31:0] _pcReg_T_1 = pcReg + 32'h4; // @[PC.scala 19:13]
  wire [31:0] _pcReg_T_3 = io_alu_out & 32'hfffffffc; // @[PC.scala 22:28]
  wire [31:0] _pcReg_T_7 = 2'h2 == io_PCSel ? pcReg : _pcReg_T_1; // @[Mux.scala 81:58]
  assign io_pc = pcReg[14:0]; // @[PC.scala 30:9]
  always @(posedge clock) begin
    if (reset) begin // @[PC.scala 14:22]
      pcReg <= 32'h0; // @[PC.scala 14:22]
    end else if (~io_Hcf) begin // @[PC.scala 16:17]
      if (2'h0 == io_PCSel) begin // @[Mux.scala 81:58]
        pcReg <= _pcReg_T_1;
      end else if (2'h1 == io_PCSel) begin // @[Mux.scala 81:58]
        pcReg <= _pcReg_T_3;
      end else begin
        pcReg <= _pcReg_T_7;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pcReg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ImmGen(
  input  [24:0] io_inst_31_7,
  input  [2:0]  io_ImmSel,
  output [31:0] io_imm
);
  wire [31:0] inst_shift = {io_inst_31_7,7'h0}; // @[Cat.scala 33:92]
  wire [31:0] _simm_T_2 = {20'h0,inst_shift[31:20]}; // @[ImmGen.scala 28:52]
  wire [12:0] _simm_T_8 = {inst_shift[31],inst_shift[7],inst_shift[30:25],inst_shift[11:8],1'h0}; // @[ImmGen.scala 30:101]
  wire [11:0] _simm_T_14 = {inst_shift[31],inst_shift[30:25],inst_shift[11:8],inst_shift[7]}; // @[ImmGen.scala 33:91]
  wire [31:0] _simm_T_17 = {inst_shift[31:12],12'h0}; // @[ImmGen.scala 36:52]
  wire [20:0] _simm_T_23 = {inst_shift[31],inst_shift[19:12],inst_shift[20],inst_shift[30:21],1'h0}; // @[ImmGen.scala 39:103]
  wire [31:0] _simm_T_27 = 3'h1 == io_ImmSel ? $signed(_simm_T_2) : $signed(32'sh0); // @[Mux.scala 81:58]
  wire [31:0] _simm_T_29 = 3'h3 == io_ImmSel ? $signed({{19{_simm_T_8[12]}},_simm_T_8}) : $signed(_simm_T_27); // @[Mux.scala 81:58]
  wire [31:0] _simm_T_31 = 3'h2 == io_ImmSel ? $signed({{20{_simm_T_14[11]}},_simm_T_14}) : $signed(_simm_T_29); // @[Mux.scala 81:58]
  wire [31:0] _simm_T_33 = 3'h5 == io_ImmSel ? $signed(_simm_T_17) : $signed(_simm_T_31); // @[Mux.scala 81:58]
  assign io_imm = 3'h4 == io_ImmSel ? $signed({{11{_simm_T_23[20]}},_simm_T_23}) : $signed(_simm_T_33); // @[ImmGen.scala 43:18]
endmodule
module RegFile(
  input         clock,
  input         reset,
  input         io_wen,
  input  [4:0]  io_waddr,
  input  [31:0] io_wdata,
  input  [4:0]  io_raddr_0,
  input  [4:0]  io_raddr_1,
  output [31:0] io_rdata_0,
  output [31:0] io_rdata_1,
  output [31:0] io_regs_1,
  output [31:0] io_regs_2,
  output [31:0] io_regs_3,
  output [31:0] io_regs_4,
  output [31:0] io_regs_5,
  output [31:0] io_regs_6,
  output [31:0] io_regs_7,
  output [31:0] io_regs_8,
  output [31:0] io_regs_9,
  output [31:0] io_regs_10,
  output [31:0] io_regs_11,
  output [31:0] io_regs_12,
  output [31:0] io_regs_13,
  output [31:0] io_regs_14,
  output [31:0] io_regs_15,
  output [31:0] io_regs_16,
  output [31:0] io_regs_17,
  output [31:0] io_regs_18,
  output [31:0] io_regs_19,
  output [31:0] io_regs_20,
  output [31:0] io_regs_21,
  output [31:0] io_regs_22,
  output [31:0] io_regs_23,
  output [31:0] io_regs_24,
  output [31:0] io_regs_25,
  output [31:0] io_regs_26,
  output [31:0] io_regs_27,
  output [31:0] io_regs_28,
  output [31:0] io_regs_29,
  output [31:0] io_regs_30,
  output [31:0] io_regs_31
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] _regs_T_1 = 32'h10000 - 32'h1; // @[RegFile.scala 15:77]
  reg [31:0] regs_1; // @[RegFile.scala 15:21]
  reg [31:0] regs_2; // @[RegFile.scala 15:21]
  reg [31:0] regs_3; // @[RegFile.scala 15:21]
  reg [31:0] regs_4; // @[RegFile.scala 15:21]
  reg [31:0] regs_5; // @[RegFile.scala 15:21]
  reg [31:0] regs_6; // @[RegFile.scala 15:21]
  reg [31:0] regs_7; // @[RegFile.scala 15:21]
  reg [31:0] regs_8; // @[RegFile.scala 15:21]
  reg [31:0] regs_9; // @[RegFile.scala 15:21]
  reg [31:0] regs_10; // @[RegFile.scala 15:21]
  reg [31:0] regs_11; // @[RegFile.scala 15:21]
  reg [31:0] regs_12; // @[RegFile.scala 15:21]
  reg [31:0] regs_13; // @[RegFile.scala 15:21]
  reg [31:0] regs_14; // @[RegFile.scala 15:21]
  reg [31:0] regs_15; // @[RegFile.scala 15:21]
  reg [31:0] regs_16; // @[RegFile.scala 15:21]
  reg [31:0] regs_17; // @[RegFile.scala 15:21]
  reg [31:0] regs_18; // @[RegFile.scala 15:21]
  reg [31:0] regs_19; // @[RegFile.scala 15:21]
  reg [31:0] regs_20; // @[RegFile.scala 15:21]
  reg [31:0] regs_21; // @[RegFile.scala 15:21]
  reg [31:0] regs_22; // @[RegFile.scala 15:21]
  reg [31:0] regs_23; // @[RegFile.scala 15:21]
  reg [31:0] regs_24; // @[RegFile.scala 15:21]
  reg [31:0] regs_25; // @[RegFile.scala 15:21]
  reg [31:0] regs_26; // @[RegFile.scala 15:21]
  reg [31:0] regs_27; // @[RegFile.scala 15:21]
  reg [31:0] regs_28; // @[RegFile.scala 15:21]
  reg [31:0] regs_29; // @[RegFile.scala 15:21]
  reg [31:0] regs_30; // @[RegFile.scala 15:21]
  reg [31:0] regs_31; // @[RegFile.scala 15:21]
  wire [31:0] _GEN_1 = 5'h1 == io_raddr_0 ? regs_1 : 32'h0; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_2 = 5'h2 == io_raddr_0 ? regs_2 : _GEN_1; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_3 = 5'h3 == io_raddr_0 ? regs_3 : _GEN_2; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_4 = 5'h4 == io_raddr_0 ? regs_4 : _GEN_3; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_5 = 5'h5 == io_raddr_0 ? regs_5 : _GEN_4; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_6 = 5'h6 == io_raddr_0 ? regs_6 : _GEN_5; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_7 = 5'h7 == io_raddr_0 ? regs_7 : _GEN_6; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_8 = 5'h8 == io_raddr_0 ? regs_8 : _GEN_7; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_9 = 5'h9 == io_raddr_0 ? regs_9 : _GEN_8; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_10 = 5'ha == io_raddr_0 ? regs_10 : _GEN_9; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_11 = 5'hb == io_raddr_0 ? regs_11 : _GEN_10; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_12 = 5'hc == io_raddr_0 ? regs_12 : _GEN_11; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_13 = 5'hd == io_raddr_0 ? regs_13 : _GEN_12; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_14 = 5'he == io_raddr_0 ? regs_14 : _GEN_13; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_15 = 5'hf == io_raddr_0 ? regs_15 : _GEN_14; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_16 = 5'h10 == io_raddr_0 ? regs_16 : _GEN_15; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_17 = 5'h11 == io_raddr_0 ? regs_17 : _GEN_16; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_18 = 5'h12 == io_raddr_0 ? regs_18 : _GEN_17; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_19 = 5'h13 == io_raddr_0 ? regs_19 : _GEN_18; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_20 = 5'h14 == io_raddr_0 ? regs_20 : _GEN_19; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_21 = 5'h15 == io_raddr_0 ? regs_21 : _GEN_20; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_22 = 5'h16 == io_raddr_0 ? regs_22 : _GEN_21; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_23 = 5'h17 == io_raddr_0 ? regs_23 : _GEN_22; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_24 = 5'h18 == io_raddr_0 ? regs_24 : _GEN_23; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_25 = 5'h19 == io_raddr_0 ? regs_25 : _GEN_24; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_26 = 5'h1a == io_raddr_0 ? regs_26 : _GEN_25; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_27 = 5'h1b == io_raddr_0 ? regs_27 : _GEN_26; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_28 = 5'h1c == io_raddr_0 ? regs_28 : _GEN_27; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_29 = 5'h1d == io_raddr_0 ? regs_29 : _GEN_28; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_30 = 5'h1e == io_raddr_0 ? regs_30 : _GEN_29; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_33 = 5'h1 == io_raddr_1 ? regs_1 : 32'h0; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_34 = 5'h2 == io_raddr_1 ? regs_2 : _GEN_33; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_35 = 5'h3 == io_raddr_1 ? regs_3 : _GEN_34; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_36 = 5'h4 == io_raddr_1 ? regs_4 : _GEN_35; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_37 = 5'h5 == io_raddr_1 ? regs_5 : _GEN_36; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_38 = 5'h6 == io_raddr_1 ? regs_6 : _GEN_37; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_39 = 5'h7 == io_raddr_1 ? regs_7 : _GEN_38; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_40 = 5'h8 == io_raddr_1 ? regs_8 : _GEN_39; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_41 = 5'h9 == io_raddr_1 ? regs_9 : _GEN_40; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_42 = 5'ha == io_raddr_1 ? regs_10 : _GEN_41; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_43 = 5'hb == io_raddr_1 ? regs_11 : _GEN_42; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_44 = 5'hc == io_raddr_1 ? regs_12 : _GEN_43; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_45 = 5'hd == io_raddr_1 ? regs_13 : _GEN_44; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_46 = 5'he == io_raddr_1 ? regs_14 : _GEN_45; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_47 = 5'hf == io_raddr_1 ? regs_15 : _GEN_46; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_48 = 5'h10 == io_raddr_1 ? regs_16 : _GEN_47; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_49 = 5'h11 == io_raddr_1 ? regs_17 : _GEN_48; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_50 = 5'h12 == io_raddr_1 ? regs_18 : _GEN_49; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_51 = 5'h13 == io_raddr_1 ? regs_19 : _GEN_50; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_52 = 5'h14 == io_raddr_1 ? regs_20 : _GEN_51; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_53 = 5'h15 == io_raddr_1 ? regs_21 : _GEN_52; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_54 = 5'h16 == io_raddr_1 ? regs_22 : _GEN_53; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_55 = 5'h17 == io_raddr_1 ? regs_23 : _GEN_54; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_56 = 5'h18 == io_raddr_1 ? regs_24 : _GEN_55; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_57 = 5'h19 == io_raddr_1 ? regs_25 : _GEN_56; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_58 = 5'h1a == io_raddr_1 ? regs_26 : _GEN_57; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_59 = 5'h1b == io_raddr_1 ? regs_27 : _GEN_58; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_60 = 5'h1c == io_raddr_1 ? regs_28 : _GEN_59; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_61 = 5'h1d == io_raddr_1 ? regs_29 : _GEN_60; // @[RegFile.scala 18:{59,59}]
  wire [31:0] _GEN_62 = 5'h1e == io_raddr_1 ? regs_30 : _GEN_61; // @[RegFile.scala 18:{59,59}]
  assign io_rdata_0 = 5'h1f == io_raddr_0 ? regs_31 : _GEN_30; // @[RegFile.scala 18:{59,59}]
  assign io_rdata_1 = 5'h1f == io_raddr_1 ? regs_31 : _GEN_62; // @[RegFile.scala 18:{59,59}]
  assign io_regs_1 = regs_1; // @[RegFile.scala 22:11]
  assign io_regs_2 = regs_2; // @[RegFile.scala 22:11]
  assign io_regs_3 = regs_3; // @[RegFile.scala 22:11]
  assign io_regs_4 = regs_4; // @[RegFile.scala 22:11]
  assign io_regs_5 = regs_5; // @[RegFile.scala 22:11]
  assign io_regs_6 = regs_6; // @[RegFile.scala 22:11]
  assign io_regs_7 = regs_7; // @[RegFile.scala 22:11]
  assign io_regs_8 = regs_8; // @[RegFile.scala 22:11]
  assign io_regs_9 = regs_9; // @[RegFile.scala 22:11]
  assign io_regs_10 = regs_10; // @[RegFile.scala 22:11]
  assign io_regs_11 = regs_11; // @[RegFile.scala 22:11]
  assign io_regs_12 = regs_12; // @[RegFile.scala 22:11]
  assign io_regs_13 = regs_13; // @[RegFile.scala 22:11]
  assign io_regs_14 = regs_14; // @[RegFile.scala 22:11]
  assign io_regs_15 = regs_15; // @[RegFile.scala 22:11]
  assign io_regs_16 = regs_16; // @[RegFile.scala 22:11]
  assign io_regs_17 = regs_17; // @[RegFile.scala 22:11]
  assign io_regs_18 = regs_18; // @[RegFile.scala 22:11]
  assign io_regs_19 = regs_19; // @[RegFile.scala 22:11]
  assign io_regs_20 = regs_20; // @[RegFile.scala 22:11]
  assign io_regs_21 = regs_21; // @[RegFile.scala 22:11]
  assign io_regs_22 = regs_22; // @[RegFile.scala 22:11]
  assign io_regs_23 = regs_23; // @[RegFile.scala 22:11]
  assign io_regs_24 = regs_24; // @[RegFile.scala 22:11]
  assign io_regs_25 = regs_25; // @[RegFile.scala 22:11]
  assign io_regs_26 = regs_26; // @[RegFile.scala 22:11]
  assign io_regs_27 = regs_27; // @[RegFile.scala 22:11]
  assign io_regs_28 = regs_28; // @[RegFile.scala 22:11]
  assign io_regs_29 = regs_29; // @[RegFile.scala 22:11]
  assign io_regs_30 = regs_30; // @[RegFile.scala 22:11]
  assign io_regs_31 = regs_31; // @[RegFile.scala 22:11]
  always @(posedge clock) begin
    if (reset) begin // @[RegFile.scala 15:21]
      regs_1 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h1 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_1 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_2 <= _regs_T_1; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h2 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_2 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_3 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h3 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_3 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_4 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h4 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_4 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_5 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h5 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_5 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_6 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h6 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_6 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_7 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h7 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_7 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_8 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h8 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_8 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_9 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h9 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_9 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_10 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'ha == io_waddr) begin // @[RegFile.scala 19:33]
        regs_10 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_11 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'hb == io_waddr) begin // @[RegFile.scala 19:33]
        regs_11 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_12 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'hc == io_waddr) begin // @[RegFile.scala 19:33]
        regs_12 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_13 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'hd == io_waddr) begin // @[RegFile.scala 19:33]
        regs_13 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_14 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'he == io_waddr) begin // @[RegFile.scala 19:33]
        regs_14 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_15 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'hf == io_waddr) begin // @[RegFile.scala 19:33]
        regs_15 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_16 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h10 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_16 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_17 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h11 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_17 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_18 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h12 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_18 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_19 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h13 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_19 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_20 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h14 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_20 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_21 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h15 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_21 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_22 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h16 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_22 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_23 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h17 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_23 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_24 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h18 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_24 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_25 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h19 == io_waddr) begin // @[RegFile.scala 19:33]
        regs_25 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_26 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h1a == io_waddr) begin // @[RegFile.scala 19:33]
        regs_26 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_27 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h1b == io_waddr) begin // @[RegFile.scala 19:33]
        regs_27 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_28 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h1c == io_waddr) begin // @[RegFile.scala 19:33]
        regs_28 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_29 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h1d == io_waddr) begin // @[RegFile.scala 19:33]
        regs_29 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_30 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h1e == io_waddr) begin // @[RegFile.scala 19:33]
        regs_30 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
    if (reset) begin // @[RegFile.scala 15:21]
      regs_31 <= 32'h0; // @[RegFile.scala 15:21]
    end else if (io_wen) begin // @[RegFile.scala 19:16]
      if (5'h1f == io_waddr) begin // @[RegFile.scala 19:33]
        regs_31 <= io_wdata; // @[RegFile.scala 19:33]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regs_1 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  regs_2 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  regs_3 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  regs_4 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  regs_5 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  regs_6 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  regs_7 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  regs_8 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  regs_9 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  regs_10 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  regs_11 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  regs_12 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  regs_13 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  regs_14 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  regs_15 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  regs_16 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  regs_17 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  regs_18 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  regs_19 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  regs_20 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  regs_21 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  regs_22 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  regs_23 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  regs_24 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  regs_25 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  regs_26 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  regs_27 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  regs_28 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  regs_29 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  regs_30 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  regs_31 = _RAND_30[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ALU(
  input  [31:0] io_src1,
  input  [31:0] io_src2,
  input  [14:0] io_ALUSel,
  output [31:0] io_out
);
  wire [31:0] _io_out_T_1 = io_src1 + io_src2; // @[ALU.scala 28:33]
  wire [62:0] _GEN_0 = {{31'd0}, io_src1}; // @[ALU.scala 29:33]
  wire [62:0] _io_out_T_3 = _GEN_0 << io_src2[4:0]; // @[ALU.scala 29:33]
  wire [31:0] _io_out_T_4 = io_src1; // @[ALU.scala 30:37]
  wire [31:0] _io_out_T_5 = io_src2; // @[ALU.scala 30:54]
  wire  _io_out_T_6 = $signed(io_src1) < $signed(io_src2); // @[ALU.scala 30:44]
  wire  _io_out_T_8 = io_src1 < io_src2; // @[ALU.scala 31:38]
  wire [31:0] _io_out_T_10 = io_src1 ^ io_src2; // @[ALU.scala 32:33]
  wire [31:0] _io_out_T_12 = io_src1 >> io_src2[4:0]; // @[ALU.scala 33:33]
  wire [31:0] _io_out_T_13 = io_src1 | io_src2; // @[ALU.scala 34:32]
  wire [31:0] _io_out_T_14 = io_src1 & io_src2; // @[ALU.scala 35:33]
  wire [31:0] _io_out_T_16 = io_src1 - io_src2; // @[ALU.scala 36:33]
  wire [31:0] _io_out_T_20 = $signed(io_src1) >>> io_src2[4:0]; // @[ALU.scala 37:59]
  wire [63:0] _io_out_T_21 = io_src1 * io_src2; // @[ALU.scala 38:33]
  wire  _T_14 = io_src1 == 32'h0; // @[ALU.scala 42:27]
  wire [1:0] _GEN_1 = io_src1[31:29] == 3'h1 ? 2'h2 : {{1'd0}, io_src1[31:30] == 2'h1}; // @[ALU.scala 45:67 46:22]
  wire [1:0] _GEN_2 = io_src1[31:28] == 4'h1 ? 2'h3 : _GEN_1; // @[ALU.scala 45:67 46:22]
  wire [2:0] _GEN_3 = io_src1[31:27] == 5'h1 ? 3'h4 : {{1'd0}, _GEN_2}; // @[ALU.scala 45:67 46:22]
  wire [2:0] _GEN_4 = io_src1[31:26] == 6'h1 ? 3'h5 : _GEN_3; // @[ALU.scala 45:67 46:22]
  wire [2:0] _GEN_5 = io_src1[31:25] == 7'h1 ? 3'h6 : _GEN_4; // @[ALU.scala 45:67 46:22]
  wire [2:0] _GEN_6 = io_src1[31:24] == 8'h1 ? 3'h7 : _GEN_5; // @[ALU.scala 45:67 46:22]
  wire [3:0] _GEN_7 = io_src1[31:23] == 9'h1 ? 4'h8 : {{1'd0}, _GEN_6}; // @[ALU.scala 45:67 46:22]
  wire [3:0] _GEN_8 = io_src1[31:22] == 10'h1 ? 4'h9 : _GEN_7; // @[ALU.scala 45:67 46:22]
  wire [3:0] _GEN_9 = io_src1[31:21] == 11'h1 ? 4'ha : _GEN_8; // @[ALU.scala 45:67 46:22]
  wire [3:0] _GEN_10 = io_src1[31:20] == 12'h1 ? 4'hb : _GEN_9; // @[ALU.scala 45:67 46:22]
  wire [3:0] _GEN_11 = io_src1[31:19] == 13'h1 ? 4'hc : _GEN_10; // @[ALU.scala 45:67 46:22]
  wire [3:0] _GEN_12 = io_src1[31:18] == 14'h1 ? 4'hd : _GEN_11; // @[ALU.scala 45:67 46:22]
  wire [3:0] _GEN_13 = io_src1[31:17] == 15'h1 ? 4'he : _GEN_12; // @[ALU.scala 45:67 46:22]
  wire [3:0] _GEN_14 = io_src1[31:16] == 16'h1 ? 4'hf : _GEN_13; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_15 = io_src1[31:15] == 17'h1 ? 5'h10 : {{1'd0}, _GEN_14}; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_16 = io_src1[31:14] == 18'h1 ? 5'h11 : _GEN_15; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_17 = io_src1[31:13] == 19'h1 ? 5'h12 : _GEN_16; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_18 = io_src1[31:12] == 20'h1 ? 5'h13 : _GEN_17; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_19 = io_src1[31:11] == 21'h1 ? 5'h14 : _GEN_18; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_20 = io_src1[31:10] == 22'h1 ? 5'h15 : _GEN_19; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_21 = io_src1[31:9] == 23'h1 ? 5'h16 : _GEN_20; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_22 = io_src1[31:8] == 24'h1 ? 5'h17 : _GEN_21; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_23 = io_src1[31:7] == 25'h1 ? 5'h18 : _GEN_22; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_24 = io_src1[31:6] == 26'h1 ? 5'h19 : _GEN_23; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_25 = io_src1[31:5] == 27'h1 ? 5'h1a : _GEN_24; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_26 = io_src1[31:4] == 28'h1 ? 5'h1b : _GEN_25; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_27 = io_src1[31:3] == 29'h1 ? 5'h1c : _GEN_26; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_28 = io_src1[31:2] == 30'h1 ? 5'h1d : _GEN_27; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_29 = io_src1[31:1] == 31'h1 ? 5'h1e : _GEN_28; // @[ALU.scala 45:67 46:22]
  wire [4:0] _GEN_30 = io_src1 == 32'h1 ? 5'h1f : _GEN_29; // @[ALU.scala 45:67 46:22]
  wire [5:0] _GEN_31 = io_src1 == 32'h0 ? 6'h20 : {{1'd0}, _GEN_30}; // @[ALU.scala 42:{36,45}]
  wire [5:0] _GEN_32 = io_src1[31] ? 6'h0 : _GEN_31; // @[ALU.scala 41:{33,42}]
  wire [1:0] _GEN_34 = io_src1[2:0] == 3'h4 ? 2'h2 : {{1'd0}, io_src1[1:0] == 2'h2}; // @[ALU.scala 57:61 58:22]
  wire [1:0] _GEN_35 = io_src1[3:0] == 4'h8 ? 2'h3 : _GEN_34; // @[ALU.scala 57:61 58:22]
  wire [2:0] _GEN_36 = io_src1[4:0] == 5'h10 ? 3'h4 : {{1'd0}, _GEN_35}; // @[ALU.scala 57:61 58:22]
  wire [2:0] _GEN_37 = io_src1[5:0] == 6'h20 ? 3'h5 : _GEN_36; // @[ALU.scala 57:61 58:22]
  wire [2:0] _GEN_38 = io_src1[6:0] == 7'h40 ? 3'h6 : _GEN_37; // @[ALU.scala 57:61 58:22]
  wire [2:0] _GEN_39 = io_src1[7:0] == 8'h80 ? 3'h7 : _GEN_38; // @[ALU.scala 57:61 58:22]
  wire [3:0] _GEN_40 = io_src1[8:0] == 9'h100 ? 4'h8 : {{1'd0}, _GEN_39}; // @[ALU.scala 57:61 58:22]
  wire [3:0] _GEN_41 = io_src1[9:0] == 10'h200 ? 4'h9 : _GEN_40; // @[ALU.scala 57:61 58:22]
  wire [3:0] _GEN_42 = io_src1[10:0] == 11'h400 ? 4'ha : _GEN_41; // @[ALU.scala 57:61 58:22]
  wire [3:0] _GEN_43 = io_src1[11:0] == 12'h800 ? 4'hb : _GEN_42; // @[ALU.scala 57:61 58:22]
  wire [3:0] _GEN_44 = io_src1[12:0] == 13'h1000 ? 4'hc : _GEN_43; // @[ALU.scala 57:61 58:22]
  wire [3:0] _GEN_45 = io_src1[13:0] == 14'h2000 ? 4'hd : _GEN_44; // @[ALU.scala 57:61 58:22]
  wire [3:0] _GEN_46 = io_src1[14:0] == 15'h4000 ? 4'he : _GEN_45; // @[ALU.scala 57:61 58:22]
  wire [3:0] _GEN_47 = io_src1[15:0] == 16'h8000 ? 4'hf : _GEN_46; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_48 = io_src1[16:0] == 17'h10000 ? 5'h10 : {{1'd0}, _GEN_47}; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_49 = io_src1[17:0] == 18'h20000 ? 5'h11 : _GEN_48; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_50 = io_src1[18:0] == 19'h40000 ? 5'h12 : _GEN_49; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_51 = io_src1[19:0] == 20'h80000 ? 5'h13 : _GEN_50; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_52 = io_src1[20:0] == 21'h100000 ? 5'h14 : _GEN_51; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_53 = io_src1[21:0] == 22'h200000 ? 5'h15 : _GEN_52; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_54 = io_src1[22:0] == 23'h400000 ? 5'h16 : _GEN_53; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_55 = io_src1[23:0] == 24'h800000 ? 5'h17 : _GEN_54; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_56 = io_src1[24:0] == 25'h1000000 ? 5'h18 : _GEN_55; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_57 = io_src1[25:0] == 26'h2000000 ? 5'h19 : _GEN_56; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_58 = io_src1[26:0] == 27'h4000000 ? 5'h1a : _GEN_57; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_59 = io_src1[27:0] == 28'h8000000 ? 5'h1b : _GEN_58; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_60 = io_src1[28:0] == 29'h10000000 ? 5'h1c : _GEN_59; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_61 = io_src1[29:0] == 30'h20000000 ? 5'h1d : _GEN_60; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_62 = io_src1[30:0] == 31'h40000000 ? 5'h1e : _GEN_61; // @[ALU.scala 57:61 58:22]
  wire [4:0] _GEN_63 = io_src1 == 32'h80000000 ? 5'h1f : _GEN_62; // @[ALU.scala 57:61 58:22]
  wire [5:0] _GEN_64 = _T_14 ? 6'h20 : {{1'd0}, _GEN_63}; // @[ALU.scala 54:{36,45}]
  wire [5:0] _GEN_65 = io_src1[0] ? 6'h0 : _GEN_64; // @[ALU.scala 53:{32,41}]
  wire [6:0] _io_out_T_23 = {6'h0,io_src1[0]}; // @[ALU.scala 64:26]
  wire [6:0] _io_out_T_25 = {6'h0,io_src1[1]}; // @[ALU.scala 64:51]
  wire [6:0] _io_out_T_27 = _io_out_T_23 + _io_out_T_25; // @[ALU.scala 64:40]
  wire [6:0] _io_out_T_29 = {6'h0,io_src1[2]}; // @[ALU.scala 64:76]
  wire [6:0] _io_out_T_31 = _io_out_T_27 + _io_out_T_29; // @[ALU.scala 64:65]
  wire [6:0] _io_out_T_33 = {6'h0,io_src1[3]}; // @[ALU.scala 64:101]
  wire [6:0] _io_out_T_35 = _io_out_T_31 + _io_out_T_33; // @[ALU.scala 64:90]
  wire [6:0] _io_out_T_37 = {6'h0,io_src1[4]}; // @[ALU.scala 65:18]
  wire [6:0] _io_out_T_39 = _io_out_T_35 + _io_out_T_37; // @[ALU.scala 64:115]
  wire [6:0] _io_out_T_41 = {6'h0,io_src1[5]}; // @[ALU.scala 65:43]
  wire [6:0] _io_out_T_43 = _io_out_T_39 + _io_out_T_41; // @[ALU.scala 65:32]
  wire [6:0] _io_out_T_45 = {6'h0,io_src1[6]}; // @[ALU.scala 65:68]
  wire [6:0] _io_out_T_47 = _io_out_T_43 + _io_out_T_45; // @[ALU.scala 65:57]
  wire [6:0] _io_out_T_49 = {6'h0,io_src1[7]}; // @[ALU.scala 65:93]
  wire [6:0] _io_out_T_51 = _io_out_T_47 + _io_out_T_49; // @[ALU.scala 65:82]
  wire [6:0] _io_out_T_53 = {6'h0,io_src1[8]}; // @[ALU.scala 66:18]
  wire [6:0] _io_out_T_55 = _io_out_T_51 + _io_out_T_53; // @[ALU.scala 65:107]
  wire [6:0] _io_out_T_57 = {6'h0,io_src1[9]}; // @[ALU.scala 66:43]
  wire [6:0] _io_out_T_59 = _io_out_T_55 + _io_out_T_57; // @[ALU.scala 66:32]
  wire [6:0] _io_out_T_61 = {6'h0,io_src1[10]}; // @[ALU.scala 66:68]
  wire [6:0] _io_out_T_63 = _io_out_T_59 + _io_out_T_61; // @[ALU.scala 66:57]
  wire [6:0] _io_out_T_65 = {6'h0,io_src1[11]}; // @[ALU.scala 66:94]
  wire [6:0] _io_out_T_67 = _io_out_T_63 + _io_out_T_65; // @[ALU.scala 66:83]
  wire [6:0] _io_out_T_69 = {6'h0,io_src1[12]}; // @[ALU.scala 67:18]
  wire [6:0] _io_out_T_71 = _io_out_T_67 + _io_out_T_69; // @[ALU.scala 66:109]
  wire [6:0] _io_out_T_73 = {6'h0,io_src1[13]}; // @[ALU.scala 67:44]
  wire [6:0] _io_out_T_75 = _io_out_T_71 + _io_out_T_73; // @[ALU.scala 67:33]
  wire [6:0] _io_out_T_77 = {6'h0,io_src1[14]}; // @[ALU.scala 67:70]
  wire [6:0] _io_out_T_79 = _io_out_T_75 + _io_out_T_77; // @[ALU.scala 67:59]
  wire [6:0] _io_out_T_81 = {6'h0,io_src1[15]}; // @[ALU.scala 67:96]
  wire [6:0] _io_out_T_83 = _io_out_T_79 + _io_out_T_81; // @[ALU.scala 67:85]
  wire [6:0] _io_out_T_85 = {6'h0,io_src1[16]}; // @[ALU.scala 68:18]
  wire [6:0] _io_out_T_87 = _io_out_T_83 + _io_out_T_85; // @[ALU.scala 67:111]
  wire [6:0] _io_out_T_89 = {6'h0,io_src1[17]}; // @[ALU.scala 68:44]
  wire [6:0] _io_out_T_91 = _io_out_T_87 + _io_out_T_89; // @[ALU.scala 68:33]
  wire [6:0] _io_out_T_93 = {6'h0,io_src1[18]}; // @[ALU.scala 68:70]
  wire [6:0] _io_out_T_95 = _io_out_T_91 + _io_out_T_93; // @[ALU.scala 68:59]
  wire [6:0] _io_out_T_97 = {6'h0,io_src1[19]}; // @[ALU.scala 68:96]
  wire [6:0] _io_out_T_99 = _io_out_T_95 + _io_out_T_97; // @[ALU.scala 68:85]
  wire [6:0] _io_out_T_101 = {6'h0,io_src1[20]}; // @[ALU.scala 69:18]
  wire [6:0] _io_out_T_103 = _io_out_T_99 + _io_out_T_101; // @[ALU.scala 68:111]
  wire [6:0] _io_out_T_105 = {6'h0,io_src1[21]}; // @[ALU.scala 69:44]
  wire [6:0] _io_out_T_107 = _io_out_T_103 + _io_out_T_105; // @[ALU.scala 69:33]
  wire [6:0] _io_out_T_109 = {6'h0,io_src1[22]}; // @[ALU.scala 69:70]
  wire [6:0] _io_out_T_111 = _io_out_T_107 + _io_out_T_109; // @[ALU.scala 69:59]
  wire [6:0] _io_out_T_113 = {6'h0,io_src1[23]}; // @[ALU.scala 69:96]
  wire [6:0] _io_out_T_115 = _io_out_T_111 + _io_out_T_113; // @[ALU.scala 69:85]
  wire [6:0] _io_out_T_117 = {6'h0,io_src1[24]}; // @[ALU.scala 70:18]
  wire [6:0] _io_out_T_119 = _io_out_T_115 + _io_out_T_117; // @[ALU.scala 69:111]
  wire [6:0] _io_out_T_121 = {6'h0,io_src1[25]}; // @[ALU.scala 70:44]
  wire [6:0] _io_out_T_123 = _io_out_T_119 + _io_out_T_121; // @[ALU.scala 70:33]
  wire [6:0] _io_out_T_125 = {6'h0,io_src1[26]}; // @[ALU.scala 70:70]
  wire [6:0] _io_out_T_127 = _io_out_T_123 + _io_out_T_125; // @[ALU.scala 70:59]
  wire [6:0] _io_out_T_129 = {6'h0,io_src1[27]}; // @[ALU.scala 70:96]
  wire [6:0] _io_out_T_131 = _io_out_T_127 + _io_out_T_129; // @[ALU.scala 70:85]
  wire [6:0] _io_out_T_133 = {6'h0,io_src1[28]}; // @[ALU.scala 71:18]
  wire [6:0] _io_out_T_135 = _io_out_T_131 + _io_out_T_133; // @[ALU.scala 70:111]
  wire [6:0] _io_out_T_137 = {6'h0,io_src1[29]}; // @[ALU.scala 71:44]
  wire [6:0] _io_out_T_139 = _io_out_T_135 + _io_out_T_137; // @[ALU.scala 71:33]
  wire [6:0] _io_out_T_141 = {6'h0,io_src1[30]}; // @[ALU.scala 71:70]
  wire [6:0] _io_out_T_143 = _io_out_T_139 + _io_out_T_141; // @[ALU.scala 71:59]
  wire [6:0] _io_out_T_145 = {6'h0,io_src1[31]}; // @[ALU.scala 71:96]
  wire [6:0] _io_out_T_147 = _io_out_T_143 + _io_out_T_145; // @[ALU.scala 71:85]
  wire [31:0] _io_out_T_148 = ~io_src2; // @[ALU.scala 74:37]
  wire [31:0] _io_out_T_149 = io_src1 & _io_out_T_148; // @[ALU.scala 74:34]
  wire [31:0] _io_out_T_151 = io_src1 | _io_out_T_148; // @[ALU.scala 75:33]
  wire [31:0] _io_out_T_153 = ~_io_out_T_10; // @[ALU.scala 76:26]
  wire [31:0] _io_out_T_157 = _io_out_T_6 ? io_src1 : io_src2; // @[ALU.scala 77:28]
  wire [31:0] _io_out_T_159 = _io_out_T_8 ? io_src1 : io_src2; // @[ALU.scala 78:29]
  wire [31:0] _io_out_T_163 = _io_out_T_6 ? io_src2 : io_src1; // @[ALU.scala 79:28]
  wire [31:0] _io_out_T_165 = _io_out_T_8 ? io_src2 : io_src1; // @[ALU.scala 80:29]
  wire [23:0] _io_out_T_168 = io_src1[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _io_out_T_170 = {_io_out_T_168,io_src1[7:0]}; // @[Cat.scala 33:92]
  wire [15:0] _io_out_T_173 = io_src1[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _io_out_T_175 = {_io_out_T_173,io_src1[15:0]}; // @[Cat.scala 33:92]
  wire [62:0] _io_out_T_177 = 63'h1 << io_src2[4:0]; // @[ALU.scala 85:48]
  wire [62:0] _io_out_T_178 = ~_io_out_T_177; // @[ALU.scala 85:36]
  wire [62:0] _GEN_101 = {{31'd0}, io_src1}; // @[ALU.scala 85:34]
  wire [62:0] _io_out_T_179 = _GEN_101 & _io_out_T_178; // @[ALU.scala 85:34]
  wire [62:0] _io_out_T_182 = _GEN_101 | _io_out_T_177; // @[ALU.scala 86:34]
  wire [62:0] _io_out_T_185 = _GEN_101 ^ _io_out_T_177; // @[ALU.scala 87:34]
  wire [31:0] _io_out_T_188 = _io_out_T_12 & 32'h1; // @[ALU.scala 88:53]
  wire [5:0] _io_out_T_192 = {1'h0,io_src2[4:0]}; // @[ALU.scala 90:88]
  wire [5:0] _io_out_T_194 = 6'h20 - _io_out_T_192; // @[ALU.scala 90:77]
  wire [31:0] _io_out_T_195 = io_src1 >> _io_out_T_194; // @[ALU.scala 90:63]
  wire [62:0] _GEN_104 = {{31'd0}, _io_out_T_195}; // @[ALU.scala 90:52]
  wire [62:0] _io_out_T_196 = _io_out_T_3 | _GEN_104; // @[ALU.scala 90:52]
  wire [94:0] _GEN_33 = {{63'd0}, io_src1}; // @[ALU.scala 91:63]
  wire [94:0] _io_out_T_203 = _GEN_33 << _io_out_T_194; // @[ALU.scala 91:63]
  wire [94:0] _GEN_105 = {{63'd0}, _io_out_T_12}; // @[ALU.scala 91:52]
  wire [94:0] _io_out_T_204 = _GEN_105 | _io_out_T_203; // @[ALU.scala 91:52]
  wire [32:0] _io_out_T_205 = {io_src1, 1'h0}; // @[ALU.scala 93:47]
  wire [32:0] _GEN_106 = {{1'd0}, io_src2}; // @[ALU.scala 93:36]
  wire [32:0] _io_out_T_207 = _GEN_106 + _io_out_T_205; // @[ALU.scala 93:36]
  wire [33:0] _GEN_107 = {io_src1, 2'h0}; // @[ALU.scala 94:47]
  wire [34:0] _io_out_T_208 = {{1'd0}, _GEN_107}; // @[ALU.scala 94:47]
  wire [34:0] _GEN_108 = {{3'd0}, io_src2}; // @[ALU.scala 94:36]
  wire [34:0] _io_out_T_210 = _GEN_108 + _io_out_T_208; // @[ALU.scala 94:36]
  wire [34:0] _io_out_T_211 = {io_src1, 3'h0}; // @[ALU.scala 95:47]
  wire [34:0] _io_out_T_213 = _GEN_108 + _io_out_T_211; // @[ALU.scala 95:36]
  wire [31:0] _io_out_T_218 = {io_src1[7:0],io_src1[15:8],io_src1[23:16],io_src1[31:24]}; // @[Cat.scala 33:92]
  wire [31:0] _io_out_T_220 = {16'h0,io_src1[15:0]}; // @[Cat.scala 33:92]
  wire [7:0] _io_out_T_223 = io_src1[31:24] == 8'h0 ? 8'h0 : 8'hff; // @[ALU.scala 103:12]
  wire [7:0] _io_out_T_226 = io_src1[23:16] == 8'h0 ? 8'h0 : 8'hff; // @[ALU.scala 104:12]
  wire [7:0] _io_out_T_229 = io_src1[15:8] == 8'h0 ? 8'h0 : 8'hff; // @[ALU.scala 105:12]
  wire [7:0] _io_out_T_232 = io_src1[7:0] == 8'h0 ? 8'h0 : 8'hff; // @[ALU.scala 106:12]
  wire [31:0] _io_out_T_233 = {_io_out_T_223,_io_out_T_226,_io_out_T_229,_io_out_T_232}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_66 = 15'h143d == io_ALUSel ? _io_out_T_233 : 32'h0; // @[ALU.scala 102:14 26:10 27:21]
  wire [31:0] _GEN_67 = 15'h404 == io_ALUSel ? _io_out_T_220 : _GEN_66; // @[ALU.scala 27:21 99:25]
  wire [31:0] _GEN_68 = 15'h34c5 == io_ALUSel ? _io_out_T_218 : _GEN_67; // @[ALU.scala 27:21 97:23]
  wire [34:0] _GEN_69 = 15'h10fe == io_ALUSel ? _io_out_T_213 : {{3'd0}, _GEN_68}; // @[ALU.scala 27:21 95:25]
  wire [34:0] _GEN_70 = 15'h10fc == io_ALUSel ? _io_out_T_210 : _GEN_69; // @[ALU.scala 27:21 94:25]
  wire [34:0] _GEN_71 = 15'h10fa == io_ALUSel ? {{2'd0}, _io_out_T_207} : _GEN_70; // @[ALU.scala 27:21 93:25]
  wire [94:0] _GEN_72 = 15'h30fd == io_ALUSel ? _io_out_T_204 : {{60'd0}, _GEN_71}; // @[ALU.scala 27:21 91:22]
  wire [94:0] _GEN_73 = 15'h30f9 == io_ALUSel ? {{32'd0}, _io_out_T_196} : _GEN_72; // @[ALU.scala 27:21 90:22]
  wire [94:0] _GEN_74 = 15'h24fd == io_ALUSel ? {{63'd0}, _io_out_T_188} : _GEN_73; // @[ALU.scala 27:21 88:23]
  wire [94:0] _GEN_75 = 15'h34f9 == io_ALUSel ? {{32'd0}, _io_out_T_185} : _GEN_74; // @[ALU.scala 27:21 87:23]
  wire [94:0] _GEN_76 = 15'h14f9 == io_ALUSel ? {{32'd0}, _io_out_T_182} : _GEN_75; // @[ALU.scala 27:21 86:23]
  wire [94:0] _GEN_77 = 15'h24f9 == io_ALUSel ? {{32'd0}, _io_out_T_179} : _GEN_76; // @[ALU.scala 27:21 85:23]
  wire [94:0] _GEN_78 = 15'h3029 == io_ALUSel ? {{63'd0}, _io_out_T_175} : _GEN_77; // @[ALU.scala 27:21 83:25]
  wire [94:0] _GEN_79 = 15'h3021 == io_ALUSel ? {{63'd0}, _io_out_T_170} : _GEN_78; // @[ALU.scala 27:21 82:25]
  wire [94:0] _GEN_80 = 15'h5ff == io_ALUSel ? {{63'd0}, _io_out_T_165} : _GEN_79; // @[ALU.scala 27:21 80:23]
  wire [94:0] _GEN_81 = 15'h5fe == io_ALUSel ? {{63'd0}, _io_out_T_163} : _GEN_80; // @[ALU.scala 27:21 79:22]
  wire [94:0] _GEN_82 = 15'h5fd == io_ALUSel ? {{63'd0}, _io_out_T_159} : _GEN_81; // @[ALU.scala 27:21 78:23]
  wire [94:0] _GEN_83 = 15'h5fc == io_ALUSel ? {{63'd0}, _io_out_T_157} : _GEN_82; // @[ALU.scala 27:21 77:22]
  wire [94:0] _GEN_84 = 15'h20fc == io_ALUSel ? {{63'd0}, _io_out_T_153} : _GEN_83; // @[ALU.scala 27:21 76:23]
  wire [94:0] _GEN_85 = 15'h20fe == io_ALUSel ? {{63'd0}, _io_out_T_151} : _GEN_84; // @[ALU.scala 27:21 75:22]
  wire [94:0] _GEN_86 = 15'h20ff == io_ALUSel ? {{63'd0}, _io_out_T_149} : _GEN_85; // @[ALU.scala 27:21 74:23]
  wire [94:0] _GEN_87 = 15'h3011 == io_ALUSel ? {{88'd0}, _io_out_T_147} : _GEN_86; // @[ALU.scala 27:21 64:14]
  wire [94:0] _GEN_88 = 15'h3009 == io_ALUSel ? {{89'd0}, _GEN_65} : _GEN_87; // @[ALU.scala 27:21]
  wire [94:0] _GEN_89 = 15'h3001 == io_ALUSel ? {{89'd0}, _GEN_32} : _GEN_88; // @[ALU.scala 27:21]
  wire [94:0] _GEN_90 = 15'h1f8 == io_ALUSel ? {{31'd0}, _io_out_T_21} : _GEN_89; // @[ALU.scala 27:21 38:22]
  wire [94:0] _GEN_91 = 15'h20fd == io_ALUSel ? {{63'd0}, _io_out_T_20} : _GEN_90; // @[ALU.scala 27:21 37:22]
  wire [94:0] _GEN_92 = 15'h20f8 == io_ALUSel ? {{63'd0}, _io_out_T_16} : _GEN_91; // @[ALU.scala 27:21 36:22]
  wire [94:0] _GEN_93 = 15'hff == io_ALUSel ? {{63'd0}, _io_out_T_14} : _GEN_92; // @[ALU.scala 27:21 35:22]
  wire [94:0] _GEN_94 = 15'hfe == io_ALUSel ? {{63'd0}, _io_out_T_13} : _GEN_93; // @[ALU.scala 27:21 34:21]
  wire [94:0] _GEN_95 = 15'hfd == io_ALUSel ? {{63'd0}, _io_out_T_12} : _GEN_94; // @[ALU.scala 27:21 33:22]
  wire [94:0] _GEN_96 = 15'hfc == io_ALUSel ? {{63'd0}, _io_out_T_10} : _GEN_95; // @[ALU.scala 27:21 32:22]
  wire [94:0] _GEN_97 = 15'hfb == io_ALUSel ? {{94'd0}, io_src1 < io_src2} : _GEN_96; // @[ALU.scala 27:21 31:23]
  wire [94:0] _GEN_98 = 15'hfa == io_ALUSel ? {{94'd0}, $signed(_io_out_T_4) < $signed(_io_out_T_5)} : _GEN_97; // @[ALU.scala 27:21 30:22]
  wire [94:0] _GEN_99 = 15'hf9 == io_ALUSel ? {{32'd0}, _io_out_T_3} : _GEN_98; // @[ALU.scala 27:21 29:22]
  wire [94:0] _GEN_100 = 15'hf8 == io_ALUSel ? {{63'd0}, _io_out_T_1} : _GEN_99; // @[ALU.scala 27:21 28:22]
  assign io_out = _GEN_100[31:0];
endmodule
module BranchComp(
  input         io_BrUn,
  input  [31:0] io_src1,
  input  [31:0] io_src2,
  output        io_BrEq,
  output        io_BrLT
);
  wire  _T = io_src1 < io_src2; // @[BranchComp.scala 20:18]
  wire  _T_3 = $signed(io_src1) < $signed(io_src2); // @[BranchComp.scala 22:25]
  assign io_BrEq = io_src1 == io_src2; // @[BranchComp.scala 25:21]
  assign io_BrLT = io_BrUn ? _T : _T_3; // @[BranchComp.scala 19:17]
endmodule
module SingleCycleCPU(
  input         clock,
  input         reset,
  input         io_master_aw_ready,
  output        io_master_aw_valid,
  output [31:0] io_master_aw_bits_addr,
  input         io_master_w_ready,
  output        io_master_w_valid,
  output [31:0] io_master_w_bits_data,
  output [3:0]  io_master_w_bits_strb,
  output        io_master_b_ready,
  input         io_master_b_valid,
  input         io_master_ar_ready,
  output        io_master_ar_valid,
  output [31:0] io_master_ar_bits_addr,
  output        io_master_r_ready,
  input         io_master_r_valid,
  input  [31:0] io_master_r_bits_data,
  output [14:0] io_pc,
  output [31:0] io_regs_1,
  output [31:0] io_regs_2,
  output [31:0] io_regs_3,
  output [31:0] io_regs_4,
  output [31:0] io_regs_5,
  output [31:0] io_regs_6,
  output [31:0] io_regs_7,
  output [31:0] io_regs_8,
  output [31:0] io_regs_9,
  output [31:0] io_regs_10,
  output [31:0] io_regs_11,
  output [31:0] io_regs_12,
  output [31:0] io_regs_13,
  output [31:0] io_regs_14,
  output [31:0] io_regs_15,
  output [31:0] io_regs_16,
  output [31:0] io_regs_17,
  output [31:0] io_regs_18,
  output [31:0] io_regs_19,
  output [31:0] io_regs_20,
  output [31:0] io_regs_21,
  output [31:0] io_regs_22,
  output [31:0] io_regs_23,
  output [31:0] io_regs_24,
  output [31:0] io_regs_25,
  output [31:0] io_regs_26,
  output [31:0] io_regs_27,
  output [31:0] io_regs_28,
  output [31:0] io_regs_29,
  output [31:0] io_regs_30,
  output [31:0] io_regs_31,
  output        io_Hcf
);
  wire  im_clock; // @[SigleCycleCPU.scala 26:19]
  wire [14:0] im_io_raddr; // @[SigleCycleCPU.scala 26:19]
  wire [31:0] im_io_inst; // @[SigleCycleCPU.scala 26:19]
  wire  ct_clock; // @[SigleCycleCPU.scala 27:19]
  wire  ct_reset; // @[SigleCycleCPU.scala 27:19]
  wire [31:0] ct_io_Inst; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_BrEq; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_BrLT; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_aw_ready; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_aw_valid; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_w_ready; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_w_valid; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_b_ready; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_b_valid; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_ar_ready; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_ar_valid; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_r_ready; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_r_valid; // @[SigleCycleCPU.scala 27:19]
  wire [1:0] ct_io_PCSel; // @[SigleCycleCPU.scala 27:19]
  wire [2:0] ct_io_ImmSel; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_RegWEn; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_BrUn; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_ASel; // @[SigleCycleCPU.scala 27:19]
  wire [1:0] ct_io_BSel; // @[SigleCycleCPU.scala 27:19]
  wire [14:0] ct_io_ALUSel; // @[SigleCycleCPU.scala 27:19]
  wire [1:0] ct_io_WBSel; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_Lui; // @[SigleCycleCPU.scala 27:19]
  wire  ct_io_Hcf; // @[SigleCycleCPU.scala 27:19]
  wire  pc_clock; // @[SigleCycleCPU.scala 28:19]
  wire  pc_reset; // @[SigleCycleCPU.scala 28:19]
  wire  pc_io_Hcf; // @[SigleCycleCPU.scala 28:19]
  wire [1:0] pc_io_PCSel; // @[SigleCycleCPU.scala 28:19]
  wire [31:0] pc_io_alu_out; // @[SigleCycleCPU.scala 28:19]
  wire [14:0] pc_io_pc; // @[SigleCycleCPU.scala 28:19]
  wire [24:0] ig_io_inst_31_7; // @[SigleCycleCPU.scala 29:19]
  wire [2:0] ig_io_ImmSel; // @[SigleCycleCPU.scala 29:19]
  wire [31:0] ig_io_imm; // @[SigleCycleCPU.scala 29:19]
  wire  rf_clock; // @[SigleCycleCPU.scala 30:19]
  wire  rf_reset; // @[SigleCycleCPU.scala 30:19]
  wire  rf_io_wen; // @[SigleCycleCPU.scala 30:19]
  wire [4:0] rf_io_waddr; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_wdata; // @[SigleCycleCPU.scala 30:19]
  wire [4:0] rf_io_raddr_0; // @[SigleCycleCPU.scala 30:19]
  wire [4:0] rf_io_raddr_1; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_rdata_0; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_rdata_1; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_1; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_2; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_3; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_4; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_5; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_6; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_7; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_8; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_9; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_10; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_11; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_12; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_13; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_14; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_15; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_16; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_17; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_18; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_19; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_20; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_21; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_22; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_23; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_24; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_25; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_26; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_27; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_28; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_29; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_30; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] rf_io_regs_31; // @[SigleCycleCPU.scala 30:19]
  wire [31:0] alu_io_src1; // @[SigleCycleCPU.scala 31:19]
  wire [31:0] alu_io_src2; // @[SigleCycleCPU.scala 31:19]
  wire [14:0] alu_io_ALUSel; // @[SigleCycleCPU.scala 31:19]
  wire [31:0] alu_io_out; // @[SigleCycleCPU.scala 31:19]
  wire  bc_io_BrUn; // @[SigleCycleCPU.scala 32:19]
  wire [31:0] bc_io_src1; // @[SigleCycleCPU.scala 32:19]
  wire [31:0] bc_io_src2; // @[SigleCycleCPU.scala 32:19]
  wire  bc_io_BrEq; // @[SigleCycleCPU.scala 32:19]
  wire  bc_io_BrLT; // @[SigleCycleCPU.scala 32:19]
  wire [6:0] opcode = im_io_inst[6:0]; // @[SigleCycleCPU.scala 43:26]
  wire [2:0] funct3 = im_io_inst[14:12]; // @[SigleCycleCPU.scala 47:26]
  wire [23:0] _rf_io_wdata_T_3 = io_master_r_bits_data[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _rf_io_wdata_T_5 = {_rf_io_wdata_T_3,io_master_r_bits_data[7:0]}; // @[Cat.scala 33:92]
  wire [15:0] _rf_io_wdata_T_8 = io_master_r_bits_data[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _rf_io_wdata_T_10 = {_rf_io_wdata_T_8,io_master_r_bits_data[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _rf_io_wdata_T_13 = {24'h0,io_master_r_bits_data[7:0]}; // @[Cat.scala 33:92]
  wire [31:0] _rf_io_wdata_T_15 = {16'h0,io_master_r_bits_data[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _rf_io_wdata_T_17 = 3'h0 == funct3 ? _rf_io_wdata_T_5 : io_master_r_bits_data; // @[Mux.scala 81:58]
  wire [31:0] _rf_io_wdata_T_19 = 3'h1 == funct3 ? _rf_io_wdata_T_10 : _rf_io_wdata_T_17; // @[Mux.scala 81:58]
  wire [31:0] _rf_io_wdata_T_21 = 3'h2 == funct3 ? io_master_r_bits_data : _rf_io_wdata_T_19; // @[Mux.scala 81:58]
  wire [31:0] _rf_io_wdata_T_23 = 3'h4 == funct3 ? _rf_io_wdata_T_13 : _rf_io_wdata_T_21; // @[Mux.scala 81:58]
  wire [31:0] _rf_io_wdata_T_25 = 3'h5 == funct3 ? _rf_io_wdata_T_15 : _rf_io_wdata_T_23; // @[Mux.scala 81:58]
  wire [14:0] _rf_io_wdata_T_27 = pc_io_pc + 15'h4; // @[SigleCycleCPU.scala 83:24]
  wire [31:0] _rf_io_wdata_T_29 = 2'h0 == ct_io_WBSel ? _rf_io_wdata_T_25 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _rf_io_wdata_T_31 = 2'h1 == ct_io_WBSel ? alu_io_out : _rf_io_wdata_T_29; // @[Mux.scala 81:58]
  wire [31:0] rdata_or_zero = ct_io_Lui ? 32'h0 : rf_io_rdata_0; // @[SigleCycleCPU.scala 89:25]
  wire [31:0] _alu_io_src2_T_1 = 2'h0 == ct_io_BSel ? rf_io_rdata_1 : 32'h0; // @[Mux.scala 81:58]
  wire [1:0] _io_master_w_bits_strb_T_3 = 3'h1 == funct3 ? 2'h3 : {{1'd0}, 3'h0 == funct3}; // @[Mux.scala 81:58]
  wire [3:0] _io_master_w_bits_strb_T_5 = 3'h2 == funct3 ? 4'hf : {{2'd0}, _io_master_w_bits_strb_T_3}; // @[Mux.scala 81:58]
  InstMem im ( // @[SigleCycleCPU.scala 26:19]
    .clock(im_clock),
    .io_raddr(im_io_raddr),
    .io_inst(im_io_inst)
  );
  Controller ct ( // @[SigleCycleCPU.scala 27:19]
    .clock(ct_clock),
    .reset(ct_reset),
    .io_Inst(ct_io_Inst),
    .io_BrEq(ct_io_BrEq),
    .io_BrLT(ct_io_BrLT),
    .io_aw_ready(ct_io_aw_ready),
    .io_aw_valid(ct_io_aw_valid),
    .io_w_ready(ct_io_w_ready),
    .io_w_valid(ct_io_w_valid),
    .io_b_ready(ct_io_b_ready),
    .io_b_valid(ct_io_b_valid),
    .io_ar_ready(ct_io_ar_ready),
    .io_ar_valid(ct_io_ar_valid),
    .io_r_ready(ct_io_r_ready),
    .io_r_valid(ct_io_r_valid),
    .io_PCSel(ct_io_PCSel),
    .io_ImmSel(ct_io_ImmSel),
    .io_RegWEn(ct_io_RegWEn),
    .io_BrUn(ct_io_BrUn),
    .io_ASel(ct_io_ASel),
    .io_BSel(ct_io_BSel),
    .io_ALUSel(ct_io_ALUSel),
    .io_WBSel(ct_io_WBSel),
    .io_Lui(ct_io_Lui),
    .io_Hcf(ct_io_Hcf)
  );
  PC pc ( // @[SigleCycleCPU.scala 28:19]
    .clock(pc_clock),
    .reset(pc_reset),
    .io_Hcf(pc_io_Hcf),
    .io_PCSel(pc_io_PCSel),
    .io_alu_out(pc_io_alu_out),
    .io_pc(pc_io_pc)
  );
  ImmGen ig ( // @[SigleCycleCPU.scala 29:19]
    .io_inst_31_7(ig_io_inst_31_7),
    .io_ImmSel(ig_io_ImmSel),
    .io_imm(ig_io_imm)
  );
  RegFile rf ( // @[SigleCycleCPU.scala 30:19]
    .clock(rf_clock),
    .reset(rf_reset),
    .io_wen(rf_io_wen),
    .io_waddr(rf_io_waddr),
    .io_wdata(rf_io_wdata),
    .io_raddr_0(rf_io_raddr_0),
    .io_raddr_1(rf_io_raddr_1),
    .io_rdata_0(rf_io_rdata_0),
    .io_rdata_1(rf_io_rdata_1),
    .io_regs_1(rf_io_regs_1),
    .io_regs_2(rf_io_regs_2),
    .io_regs_3(rf_io_regs_3),
    .io_regs_4(rf_io_regs_4),
    .io_regs_5(rf_io_regs_5),
    .io_regs_6(rf_io_regs_6),
    .io_regs_7(rf_io_regs_7),
    .io_regs_8(rf_io_regs_8),
    .io_regs_9(rf_io_regs_9),
    .io_regs_10(rf_io_regs_10),
    .io_regs_11(rf_io_regs_11),
    .io_regs_12(rf_io_regs_12),
    .io_regs_13(rf_io_regs_13),
    .io_regs_14(rf_io_regs_14),
    .io_regs_15(rf_io_regs_15),
    .io_regs_16(rf_io_regs_16),
    .io_regs_17(rf_io_regs_17),
    .io_regs_18(rf_io_regs_18),
    .io_regs_19(rf_io_regs_19),
    .io_regs_20(rf_io_regs_20),
    .io_regs_21(rf_io_regs_21),
    .io_regs_22(rf_io_regs_22),
    .io_regs_23(rf_io_regs_23),
    .io_regs_24(rf_io_regs_24),
    .io_regs_25(rf_io_regs_25),
    .io_regs_26(rf_io_regs_26),
    .io_regs_27(rf_io_regs_27),
    .io_regs_28(rf_io_regs_28),
    .io_regs_29(rf_io_regs_29),
    .io_regs_30(rf_io_regs_30),
    .io_regs_31(rf_io_regs_31)
  );
  ALU alu ( // @[SigleCycleCPU.scala 31:19]
    .io_src1(alu_io_src1),
    .io_src2(alu_io_src2),
    .io_ALUSel(alu_io_ALUSel),
    .io_out(alu_io_out)
  );
  BranchComp bc ( // @[SigleCycleCPU.scala 32:19]
    .io_BrUn(bc_io_BrUn),
    .io_src1(bc_io_src1),
    .io_src2(bc_io_src2),
    .io_BrEq(bc_io_BrEq),
    .io_BrLT(bc_io_BrLT)
  );
  assign io_master_aw_valid = ct_io_aw_valid; // @[SigleCycleCPU.scala 120:16]
  assign io_master_aw_bits_addr = alu_io_out; // @[SigleCycleCPU.scala 127:26]
  assign io_master_w_valid = ct_io_w_valid; // @[SigleCycleCPU.scala 121:15]
  assign io_master_w_bits_data = rf_io_rdata_1; // @[SigleCycleCPU.scala 128:25]
  assign io_master_w_bits_strb = 7'h23 == opcode ? _io_master_w_bits_strb_T_5 : 4'h0; // @[Mux.scala 81:58]
  assign io_master_b_ready = ct_io_b_ready; // @[SigleCycleCPU.scala 122:15]
  assign io_master_ar_valid = ct_io_ar_valid; // @[SigleCycleCPU.scala 123:16]
  assign io_master_ar_bits_addr = alu_io_out; // @[SigleCycleCPU.scala 126:27]
  assign io_master_r_ready = ct_io_r_ready; // @[SigleCycleCPU.scala 124:15]
  assign io_pc = pc_io_pc; // @[SigleCycleCPU.scala 144:17]
  assign io_regs_1 = rf_io_regs_1; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_2 = rf_io_regs_2; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_3 = rf_io_regs_3; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_4 = rf_io_regs_4; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_5 = rf_io_regs_5; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_6 = rf_io_regs_6; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_7 = rf_io_regs_7; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_8 = rf_io_regs_8; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_9 = rf_io_regs_9; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_10 = rf_io_regs_10; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_11 = rf_io_regs_11; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_12 = rf_io_regs_12; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_13 = rf_io_regs_13; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_14 = rf_io_regs_14; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_15 = rf_io_regs_15; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_16 = rf_io_regs_16; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_17 = rf_io_regs_17; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_18 = rf_io_regs_18; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_19 = rf_io_regs_19; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_20 = rf_io_regs_20; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_21 = rf_io_regs_21; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_22 = rf_io_regs_22; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_23 = rf_io_regs_23; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_24 = rf_io_regs_24; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_25 = rf_io_regs_25; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_26 = rf_io_regs_26; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_27 = rf_io_regs_27; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_28 = rf_io_regs_28; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_29 = rf_io_regs_29; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_30 = rf_io_regs_30; // @[SigleCycleCPU.scala 145:17]
  assign io_regs_31 = rf_io_regs_31; // @[SigleCycleCPU.scala 145:17]
  assign io_Hcf = ct_io_Hcf; // @[SigleCycleCPU.scala 146:17]
  assign im_clock = clock;
  assign im_io_raddr = pc_io_pc; // @[SigleCycleCPU.scala 56:14]
  assign ct_clock = clock;
  assign ct_reset = reset;
  assign ct_io_Inst = im_io_inst; // @[SigleCycleCPU.scala 115:13]
  assign ct_io_BrEq = bc_io_BrEq; // @[SigleCycleCPU.scala 116:13]
  assign ct_io_BrLT = bc_io_BrLT; // @[SigleCycleCPU.scala 117:13]
  assign ct_io_aw_ready = io_master_aw_ready; // @[SigleCycleCPU.scala 120:16]
  assign ct_io_w_ready = io_master_w_ready; // @[SigleCycleCPU.scala 121:15]
  assign ct_io_b_valid = io_master_b_valid; // @[SigleCycleCPU.scala 122:15]
  assign ct_io_ar_ready = io_master_ar_ready; // @[SigleCycleCPU.scala 123:16]
  assign ct_io_r_valid = io_master_r_valid; // @[SigleCycleCPU.scala 124:15]
  assign pc_clock = clock;
  assign pc_reset = reset;
  assign pc_io_Hcf = ct_io_Hcf; // @[SigleCycleCPU.scala 53:17]
  assign pc_io_PCSel = ct_io_PCSel; // @[SigleCycleCPU.scala 51:17]
  assign pc_io_alu_out = alu_io_out; // @[SigleCycleCPU.scala 52:17]
  assign ig_io_inst_31_7 = im_io_inst[31:7]; // @[SigleCycleCPU.scala 48:26]
  assign ig_io_ImmSel = ct_io_ImmSel; // @[SigleCycleCPU.scala 59:18]
  assign rf_clock = clock;
  assign rf_reset = reset;
  assign rf_io_wen = ct_io_RegWEn; // @[SigleCycleCPU.scala 65:18]
  assign rf_io_waddr = im_io_inst[11:7]; // @[SigleCycleCPU.scala 44:26]
  assign rf_io_wdata = 2'h2 == ct_io_WBSel ? {{17'd0}, _rf_io_wdata_T_27} : _rf_io_wdata_T_31; // @[Mux.scala 81:58]
  assign rf_io_raddr_0 = im_io_inst[19:15]; // @[SigleCycleCPU.scala 45:26]
  assign rf_io_raddr_1 = im_io_inst[24:20]; // @[SigleCycleCPU.scala 46:26]
  assign alu_io_src1 = ct_io_ASel ? {{17'd0}, pc_io_pc} : rdata_or_zero; // @[Mux.scala 81:58]
  assign alu_io_src2 = 2'h1 == ct_io_BSel ? ig_io_imm : _alu_io_src2_T_1; // @[Mux.scala 81:58]
  assign alu_io_ALUSel = ct_io_ALUSel; // @[SigleCycleCPU.scala 106:16]
  assign bc_io_BrUn = ct_io_BrUn; // @[SigleCycleCPU.scala 110:13]
  assign bc_io_src1 = rf_io_rdata_0; // @[SigleCycleCPU.scala 111:13]
  assign bc_io_src2 = rf_io_rdata_1; // @[SigleCycleCPU.scala 112:13]
endmodule
module DataMem(
  input         clock,
  input         reset,
  output        io_slave_aw_ready,
  input         io_slave_aw_valid,
  input  [31:0] io_slave_aw_bits_addr,
  output        io_slave_w_ready,
  input         io_slave_w_valid,
  input  [31:0] io_slave_w_bits_data,
  input  [3:0]  io_slave_w_bits_strb,
  input         io_slave_b_ready,
  output        io_slave_b_valid,
  output        io_slave_ar_ready,
  input         io_slave_ar_valid,
  input  [31:0] io_slave_ar_bits_addr,
  input         io_slave_r_ready,
  output        io_slave_r_valid,
  output [31:0] io_slave_r_bits_data
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] memory [0:65535]; // @[DataMem.scala 23:21]
  wire  memory_MPORT_1_en; // @[DataMem.scala 23:21]
  wire [15:0] memory_MPORT_1_addr; // @[DataMem.scala 23:21]
  wire [7:0] memory_MPORT_1_data; // @[DataMem.scala 23:21]
  wire  memory_MPORT_3_en; // @[DataMem.scala 23:21]
  wire [15:0] memory_MPORT_3_addr; // @[DataMem.scala 23:21]
  wire [7:0] memory_MPORT_3_data; // @[DataMem.scala 23:21]
  wire  memory_MPORT_5_en; // @[DataMem.scala 23:21]
  wire [15:0] memory_MPORT_5_addr; // @[DataMem.scala 23:21]
  wire [7:0] memory_MPORT_5_data; // @[DataMem.scala 23:21]
  wire  memory_MPORT_7_en; // @[DataMem.scala 23:21]
  wire [15:0] memory_MPORT_7_addr; // @[DataMem.scala 23:21]
  wire [7:0] memory_MPORT_7_data; // @[DataMem.scala 23:21]
  wire  memory_io_slave_r_bits_data_MPORT_en; // @[DataMem.scala 23:21]
  wire [15:0] memory_io_slave_r_bits_data_MPORT_addr; // @[DataMem.scala 23:21]
  wire [7:0] memory_io_slave_r_bits_data_MPORT_data; // @[DataMem.scala 23:21]
  wire  memory_io_slave_r_bits_data_MPORT_1_en; // @[DataMem.scala 23:21]
  wire [15:0] memory_io_slave_r_bits_data_MPORT_1_addr; // @[DataMem.scala 23:21]
  wire [7:0] memory_io_slave_r_bits_data_MPORT_1_data; // @[DataMem.scala 23:21]
  wire  memory_io_slave_r_bits_data_MPORT_2_en; // @[DataMem.scala 23:21]
  wire [15:0] memory_io_slave_r_bits_data_MPORT_2_addr; // @[DataMem.scala 23:21]
  wire [7:0] memory_io_slave_r_bits_data_MPORT_2_data; // @[DataMem.scala 23:21]
  wire  memory_io_slave_r_bits_data_MPORT_3_en; // @[DataMem.scala 23:21]
  wire [15:0] memory_io_slave_r_bits_data_MPORT_3_addr; // @[DataMem.scala 23:21]
  wire [7:0] memory_io_slave_r_bits_data_MPORT_3_data; // @[DataMem.scala 23:21]
  wire  memory_io_slave_r_bits_data_MPORT_4_en; // @[DataMem.scala 23:21]
  wire [15:0] memory_io_slave_r_bits_data_MPORT_4_addr; // @[DataMem.scala 23:21]
  wire [7:0] memory_io_slave_r_bits_data_MPORT_4_data; // @[DataMem.scala 23:21]
  wire  memory_io_slave_r_bits_data_MPORT_5_en; // @[DataMem.scala 23:21]
  wire [15:0] memory_io_slave_r_bits_data_MPORT_5_addr; // @[DataMem.scala 23:21]
  wire [7:0] memory_io_slave_r_bits_data_MPORT_5_data; // @[DataMem.scala 23:21]
  wire  memory_io_slave_r_bits_data_MPORT_6_en; // @[DataMem.scala 23:21]
  wire [15:0] memory_io_slave_r_bits_data_MPORT_6_addr; // @[DataMem.scala 23:21]
  wire [7:0] memory_io_slave_r_bits_data_MPORT_6_data; // @[DataMem.scala 23:21]
  wire  memory_io_slave_r_bits_data_MPORT_7_en; // @[DataMem.scala 23:21]
  wire [15:0] memory_io_slave_r_bits_data_MPORT_7_addr; // @[DataMem.scala 23:21]
  wire [7:0] memory_io_slave_r_bits_data_MPORT_7_data; // @[DataMem.scala 23:21]
  wire [7:0] memory_MPORT_data; // @[DataMem.scala 23:21]
  wire [15:0] memory_MPORT_addr; // @[DataMem.scala 23:21]
  wire  memory_MPORT_mask; // @[DataMem.scala 23:21]
  wire  memory_MPORT_en; // @[DataMem.scala 23:21]
  wire [7:0] memory_MPORT_2_data; // @[DataMem.scala 23:21]
  wire [15:0] memory_MPORT_2_addr; // @[DataMem.scala 23:21]
  wire  memory_MPORT_2_mask; // @[DataMem.scala 23:21]
  wire  memory_MPORT_2_en; // @[DataMem.scala 23:21]
  wire [7:0] memory_MPORT_4_data; // @[DataMem.scala 23:21]
  wire [15:0] memory_MPORT_4_addr; // @[DataMem.scala 23:21]
  wire  memory_MPORT_4_mask; // @[DataMem.scala 23:21]
  wire  memory_MPORT_4_en; // @[DataMem.scala 23:21]
  wire [7:0] memory_MPORT_6_data; // @[DataMem.scala 23:21]
  wire [15:0] memory_MPORT_6_addr; // @[DataMem.scala 23:21]
  wire  memory_MPORT_6_mask; // @[DataMem.scala 23:21]
  wire  memory_MPORT_6_en; // @[DataMem.scala 23:21]
  reg [1:0] stateReg; // @[DataMem.scala 21:27]
  reg [31:0] write_addr_reg; // @[DataMem.scala 25:33]
  reg  write_addr_reg_valid; // @[DataMem.scala 26:39]
  reg [31:0] write_data_reg; // @[DataMem.scala 30:33]
  reg  write_data_reg_valid; // @[DataMem.scala 31:39]
  reg [3:0] write_data_reg_strb; // @[DataMem.scala 32:38]
  wire  _T = 2'h0 == stateReg; // @[DataMem.scala 39:22]
  wire  _T_1 = write_data_reg_valid & write_addr_reg_valid; // @[DataMem.scala 43:45]
  wire  _T_2 = 2'h1 == stateReg; // @[DataMem.scala 39:22]
  wire  _T_3 = 2'h2 == stateReg; // @[DataMem.scala 39:22]
  wire [1:0] _stateReg_T_1 = io_slave_b_ready ? 2'h0 : 2'h2; // @[DataMem.scala 53:28]
  wire  _T_4 = io_slave_aw_ready & io_slave_aw_valid; // @[Decoupled.scala 52:35]
  wire  _GEN_6 = _T_4 | write_addr_reg_valid; // @[DataMem.scala 70:28 72:30 26:39]
  wire  _T_5 = io_slave_w_ready & io_slave_w_valid; // @[Decoupled.scala 52:35]
  wire  _GEN_10 = _T_5 | write_data_reg_valid; // @[DataMem.scala 76:27 78:30 31:39]
  wire  _GEN_17 = _T_2 ? 1'h0 : _T_3; // @[DataMem.scala 66:22 83:22]
  reg [31:0] addrReg; // @[DataMem.scala 103:26]
  wire  _T_9 = stateReg == 2'h0; // @[DataMem.scala 105:19]
  wire [31:0] _addrReg_T_1 = io_slave_ar_bits_addr - 32'h8000; // @[DataMem.scala 106:65]
  wire [31:0] _T_12 = write_addr_reg - 32'h8000; // @[DataMem.scala 109:40]
  wire [32:0] _T_13 = {{1'd0}, _T_12}; // @[DataMem.scala 109:53]
  wire [31:0] _T_28 = _T_12 + 32'h1; // @[DataMem.scala 109:53]
  wire [31:0] _T_42 = _T_12 + 32'h2; // @[DataMem.scala 109:53]
  wire [31:0] _T_56 = _T_12 + 32'h3; // @[DataMem.scala 109:53]
  wire [31:0] _io_slave_r_bits_data_T_1 = addrReg + 32'h7; // @[DataMem.scala 121:24]
  wire [31:0] _io_slave_r_bits_data_T_4 = addrReg + 32'h6; // @[DataMem.scala 122:24]
  wire [31:0] _io_slave_r_bits_data_T_7 = addrReg + 32'h5; // @[DataMem.scala 123:24]
  wire [31:0] _io_slave_r_bits_data_T_10 = addrReg + 32'h4; // @[DataMem.scala 124:24]
  wire [31:0] _io_slave_r_bits_data_T_13 = addrReg + 32'h3; // @[DataMem.scala 125:24]
  wire [31:0] _io_slave_r_bits_data_T_16 = addrReg + 32'h2; // @[DataMem.scala 126:24]
  wire [31:0] _io_slave_r_bits_data_T_19 = addrReg + 32'h1; // @[DataMem.scala 127:24]
  wire [63:0] _io_slave_r_bits_data_T_22 = {memory_io_slave_r_bits_data_MPORT_data,
    memory_io_slave_r_bits_data_MPORT_1_data,memory_io_slave_r_bits_data_MPORT_2_data,
    memory_io_slave_r_bits_data_MPORT_3_data,memory_io_slave_r_bits_data_MPORT_4_data,
    memory_io_slave_r_bits_data_MPORT_5_data,memory_io_slave_r_bits_data_MPORT_6_data,
    memory_io_slave_r_bits_data_MPORT_7_data}; // @[Cat.scala 33:92]
  assign memory_MPORT_1_en = _T_9 & _T_1;
  assign memory_MPORT_1_addr = _T_13[15:0];
  assign memory_MPORT_1_data = memory[memory_MPORT_1_addr]; // @[DataMem.scala 23:21]
  assign memory_MPORT_3_en = _T_9 & _T_1;
  assign memory_MPORT_3_addr = _T_28[15:0];
  assign memory_MPORT_3_data = memory[memory_MPORT_3_addr]; // @[DataMem.scala 23:21]
  assign memory_MPORT_5_en = _T_9 & _T_1;
  assign memory_MPORT_5_addr = _T_42[15:0];
  assign memory_MPORT_5_data = memory[memory_MPORT_5_addr]; // @[DataMem.scala 23:21]
  assign memory_MPORT_7_en = _T_9 & _T_1;
  assign memory_MPORT_7_addr = _T_56[15:0];
  assign memory_MPORT_7_data = memory[memory_MPORT_7_addr]; // @[DataMem.scala 23:21]
  assign memory_io_slave_r_bits_data_MPORT_en = 1'h1;
  assign memory_io_slave_r_bits_data_MPORT_addr = _io_slave_r_bits_data_T_1[15:0];
  assign memory_io_slave_r_bits_data_MPORT_data = memory[memory_io_slave_r_bits_data_MPORT_addr]; // @[DataMem.scala 23:21]
  assign memory_io_slave_r_bits_data_MPORT_1_en = 1'h1;
  assign memory_io_slave_r_bits_data_MPORT_1_addr = _io_slave_r_bits_data_T_4[15:0];
  assign memory_io_slave_r_bits_data_MPORT_1_data = memory[memory_io_slave_r_bits_data_MPORT_1_addr]; // @[DataMem.scala 23:21]
  assign memory_io_slave_r_bits_data_MPORT_2_en = 1'h1;
  assign memory_io_slave_r_bits_data_MPORT_2_addr = _io_slave_r_bits_data_T_7[15:0];
  assign memory_io_slave_r_bits_data_MPORT_2_data = memory[memory_io_slave_r_bits_data_MPORT_2_addr]; // @[DataMem.scala 23:21]
  assign memory_io_slave_r_bits_data_MPORT_3_en = 1'h1;
  assign memory_io_slave_r_bits_data_MPORT_3_addr = _io_slave_r_bits_data_T_10[15:0];
  assign memory_io_slave_r_bits_data_MPORT_3_data = memory[memory_io_slave_r_bits_data_MPORT_3_addr]; // @[DataMem.scala 23:21]
  assign memory_io_slave_r_bits_data_MPORT_4_en = 1'h1;
  assign memory_io_slave_r_bits_data_MPORT_4_addr = _io_slave_r_bits_data_T_13[15:0];
  assign memory_io_slave_r_bits_data_MPORT_4_data = memory[memory_io_slave_r_bits_data_MPORT_4_addr]; // @[DataMem.scala 23:21]
  assign memory_io_slave_r_bits_data_MPORT_5_en = 1'h1;
  assign memory_io_slave_r_bits_data_MPORT_5_addr = _io_slave_r_bits_data_T_16[15:0];
  assign memory_io_slave_r_bits_data_MPORT_5_data = memory[memory_io_slave_r_bits_data_MPORT_5_addr]; // @[DataMem.scala 23:21]
  assign memory_io_slave_r_bits_data_MPORT_6_en = 1'h1;
  assign memory_io_slave_r_bits_data_MPORT_6_addr = _io_slave_r_bits_data_T_19[15:0];
  assign memory_io_slave_r_bits_data_MPORT_6_data = memory[memory_io_slave_r_bits_data_MPORT_6_addr]; // @[DataMem.scala 23:21]
  assign memory_io_slave_r_bits_data_MPORT_7_en = 1'h1;
  assign memory_io_slave_r_bits_data_MPORT_7_addr = addrReg[15:0];
  assign memory_io_slave_r_bits_data_MPORT_7_data = memory[memory_io_slave_r_bits_data_MPORT_7_addr]; // @[DataMem.scala 23:21]
  assign memory_MPORT_data = write_data_reg_strb[0] ? write_data_reg[7:0] : memory_MPORT_1_data;
  assign memory_MPORT_addr = _T_13[15:0];
  assign memory_MPORT_mask = 1'h1;
  assign memory_MPORT_en = _T_9 & _T_1;
  assign memory_MPORT_2_data = write_data_reg_strb[1] ? write_data_reg[15:8] : memory_MPORT_3_data;
  assign memory_MPORT_2_addr = _T_28[15:0];
  assign memory_MPORT_2_mask = 1'h1;
  assign memory_MPORT_2_en = _T_9 & _T_1;
  assign memory_MPORT_4_data = write_data_reg_strb[2] ? write_data_reg[23:16] : memory_MPORT_5_data;
  assign memory_MPORT_4_addr = _T_42[15:0];
  assign memory_MPORT_4_mask = 1'h1;
  assign memory_MPORT_4_en = _T_9 & _T_1;
  assign memory_MPORT_6_data = write_data_reg_strb[3] ? write_data_reg[31:24] : memory_MPORT_7_data;
  assign memory_MPORT_6_addr = _T_56[15:0];
  assign memory_MPORT_6_mask = 1'h1;
  assign memory_MPORT_6_en = _T_9 & _T_1;
  assign io_slave_aw_ready = 2'h0 == stateReg; // @[DataMem.scala 83:22]
  assign io_slave_w_ready = 2'h0 == stateReg; // @[DataMem.scala 83:22]
  assign io_slave_b_valid = _T ? 1'h0 : _GEN_17; // @[DataMem.scala 66:22 83:22]
  assign io_slave_ar_ready = 2'h0 == stateReg; // @[DataMem.scala 83:22]
  assign io_slave_r_valid = _T ? 1'h0 : _T_2; // @[DataMem.scala 83:22 59:23]
  assign io_slave_r_bits_data = _io_slave_r_bits_data_T_22[31:0]; // @[DataMem.scala 120:26]
  always @(posedge clock) begin
    if (memory_MPORT_en & memory_MPORT_mask) begin
      memory[memory_MPORT_addr] <= memory_MPORT_data; // @[DataMem.scala 23:21]
    end
    if (memory_MPORT_2_en & memory_MPORT_2_mask) begin
      memory[memory_MPORT_2_addr] <= memory_MPORT_2_data; // @[DataMem.scala 23:21]
    end
    if (memory_MPORT_4_en & memory_MPORT_4_mask) begin
      memory[memory_MPORT_4_addr] <= memory_MPORT_4_data; // @[DataMem.scala 23:21]
    end
    if (memory_MPORT_6_en & memory_MPORT_6_mask) begin
      memory[memory_MPORT_6_addr] <= memory_MPORT_6_data; // @[DataMem.scala 23:21]
    end
    if (reset) begin // @[DataMem.scala 21:27]
      stateReg <= 2'h0; // @[DataMem.scala 21:27]
    end else if (2'h0 == stateReg) begin // @[DataMem.scala 39:22]
      if (io_slave_ar_valid) begin // @[DataMem.scala 41:37]
        stateReg <= 2'h1; // @[DataMem.scala 42:26]
      end else if (write_data_reg_valid & write_addr_reg_valid) begin // @[DataMem.scala 43:69]
        stateReg <= 2'h2; // @[DataMem.scala 44:26]
      end else begin
        stateReg <= 2'h0; // @[DataMem.scala 46:26]
      end
    end else if (2'h1 == stateReg) begin // @[DataMem.scala 39:22]
      if (io_slave_r_ready) begin // @[DataMem.scala 50:28]
        stateReg <= 2'h0;
      end else begin
        stateReg <= 2'h1;
      end
    end else if (2'h2 == stateReg) begin // @[DataMem.scala 39:22]
      stateReg <= _stateReg_T_1; // @[DataMem.scala 53:22]
    end
    if (reset) begin // @[DataMem.scala 25:33]
      write_addr_reg <= 32'h0; // @[DataMem.scala 25:33]
    end else if (_T_4) begin // @[DataMem.scala 70:28]
      write_addr_reg <= io_slave_aw_bits_addr; // @[DataMem.scala 71:24]
    end
    if (reset) begin // @[DataMem.scala 26:39]
      write_addr_reg_valid <= 1'h0; // @[DataMem.scala 26:39]
    end else if (_T) begin // @[DataMem.scala 83:22]
      write_addr_reg_valid <= _GEN_6;
    end else if (_T_2) begin // @[DataMem.scala 83:22]
      write_addr_reg_valid <= _GEN_6;
    end else if (_T_3) begin // @[DataMem.scala 83:22]
      write_addr_reg_valid <= 1'h0; // @[DataMem.scala 97:34]
    end else begin
      write_addr_reg_valid <= _GEN_6;
    end
    if (reset) begin // @[DataMem.scala 30:33]
      write_data_reg <= 32'h0; // @[DataMem.scala 30:33]
    end else if (_T_5) begin // @[DataMem.scala 76:27]
      write_data_reg <= io_slave_w_bits_data; // @[DataMem.scala 77:24]
    end
    if (reset) begin // @[DataMem.scala 31:39]
      write_data_reg_valid <= 1'h0; // @[DataMem.scala 31:39]
    end else if (_T) begin // @[DataMem.scala 83:22]
      write_data_reg_valid <= _GEN_10;
    end else if (_T_2) begin // @[DataMem.scala 83:22]
      write_data_reg_valid <= _GEN_10;
    end else if (_T_3) begin // @[DataMem.scala 83:22]
      write_data_reg_valid <= 1'h0; // @[DataMem.scala 98:34]
    end else begin
      write_data_reg_valid <= _GEN_10;
    end
    if (reset) begin // @[DataMem.scala 32:38]
      write_data_reg_strb <= 4'h0; // @[DataMem.scala 32:38]
    end else if (_T_5) begin // @[DataMem.scala 76:27]
      write_data_reg_strb <= io_slave_w_bits_strb; // @[DataMem.scala 79:29]
    end
    if (reset) begin // @[DataMem.scala 103:26]
      addrReg <= 32'h0; // @[DataMem.scala 103:26]
    end else if (stateReg == 2'h0) begin // @[DataMem.scala 105:30]
      if (io_slave_ar_valid) begin // @[DataMem.scala 106:23]
        addrReg <= _addrReg_T_1;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 65536; initvar = initvar+1)
    memory[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  stateReg = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  write_addr_reg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  write_addr_reg_valid = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  write_data_reg = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  write_data_reg_valid = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  write_data_reg_strb = _RAND_6[3:0];
  _RAND_7 = {1{`RANDOM}};
  addrReg = _RAND_7[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PE(
  input         clock,
  input         io_input_valid,
  input  [7:0]  io_input_bits,
  output        io_fwd_input_valid,
  output [7:0]  io_fwd_input_bits,
  input  [7:0]  io_weight_bits,
  output [7:0]  io_fwd_weight_bits,
  input         io_preload,
  input  [15:0] io_ps,
  output        io_fwd_ps_valid,
  output [15:0] io_fwd_ps_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] weightReg_bits; // @[PE.scala 31:26]
  reg  io_fwd_input_REG_valid; // @[PE.scala 45:26]
  reg [7:0] io_fwd_input_REG_bits; // @[PE.scala 45:26]
  reg  io_fwd_ps_valid_REG; // @[PE.scala 47:29]
  wire [15:0] _io_fwd_ps_bits_T = weightReg_bits * io_input_bits; // @[PE.scala 48:53]
  reg [15:0] io_fwd_ps_bits_REG; // @[PE.scala 48:29]
  assign io_fwd_input_valid = io_fwd_input_REG_valid; // @[PE.scala 45:16]
  assign io_fwd_input_bits = io_fwd_input_REG_bits; // @[PE.scala 45:16]
  assign io_fwd_weight_bits = weightReg_bits; // @[PE.scala 42:23]
  assign io_fwd_ps_valid = io_fwd_ps_valid_REG; // @[PE.scala 47:19]
  assign io_fwd_ps_bits = io_fwd_ps_bits_REG; // @[PE.scala 48:19]
  always @(posedge clock) begin
    if (io_preload) begin // @[PE.scala 38:25]
      weightReg_bits <= io_weight_bits;
    end
    io_fwd_input_REG_valid <= io_input_valid; // @[PE.scala 45:26]
    io_fwd_input_REG_bits <= io_input_bits; // @[PE.scala 45:26]
    io_fwd_ps_valid_REG <= io_input_valid; // @[PE.scala 47:29]
    io_fwd_ps_bits_REG <= io_ps + _io_fwd_ps_bits_T; // @[PE.scala 48:36]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  weightReg_bits = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  io_fwd_input_REG_valid = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  io_fwd_input_REG_bits = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  io_fwd_ps_valid_REG = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  io_fwd_ps_bits_REG = _RAND_4[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module tile(
  input         clock,
  input         io_input_0_valid,
  input  [7:0]  io_input_0_bits,
  input         io_input_1_valid,
  input  [7:0]  io_input_1_bits,
  input         io_input_2_valid,
  input  [7:0]  io_input_2_bits,
  input         io_input_3_valid,
  input  [7:0]  io_input_3_bits,
  input  [7:0]  io_weight_0_bits,
  input  [7:0]  io_weight_1_bits,
  input  [7:0]  io_weight_2_bits,
  input  [7:0]  io_weight_3_bits,
  input         io_preload,
  output        io_output_0_valid,
  output [15:0] io_output_0_bits,
  output        io_output_1_valid,
  output [15:0] io_output_1_bits,
  output        io_output_2_valid,
  output [15:0] io_output_2_bits,
  output        io_output_3_valid,
  output [15:0] io_output_3_bits
);
  wire  PE_clock; // @[tile.scala 23:41]
  wire  PE_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_io_input_bits; // @[tile.scala 23:41]
  wire  PE_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_io_ps; // @[tile.scala 23:41]
  wire  PE_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_1_clock; // @[tile.scala 23:41]
  wire  PE_1_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_1_io_input_bits; // @[tile.scala 23:41]
  wire  PE_1_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_1_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_1_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_1_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_1_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_1_io_ps; // @[tile.scala 23:41]
  wire  PE_1_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_1_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_2_clock; // @[tile.scala 23:41]
  wire  PE_2_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_2_io_input_bits; // @[tile.scala 23:41]
  wire  PE_2_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_2_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_2_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_2_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_2_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_2_io_ps; // @[tile.scala 23:41]
  wire  PE_2_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_2_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_3_clock; // @[tile.scala 23:41]
  wire  PE_3_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_3_io_input_bits; // @[tile.scala 23:41]
  wire  PE_3_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_3_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_3_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_3_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_3_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_3_io_ps; // @[tile.scala 23:41]
  wire  PE_3_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_3_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_4_clock; // @[tile.scala 23:41]
  wire  PE_4_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_4_io_input_bits; // @[tile.scala 23:41]
  wire  PE_4_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_4_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_4_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_4_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_4_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_4_io_ps; // @[tile.scala 23:41]
  wire  PE_4_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_4_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_5_clock; // @[tile.scala 23:41]
  wire  PE_5_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_5_io_input_bits; // @[tile.scala 23:41]
  wire  PE_5_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_5_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_5_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_5_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_5_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_5_io_ps; // @[tile.scala 23:41]
  wire  PE_5_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_5_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_6_clock; // @[tile.scala 23:41]
  wire  PE_6_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_6_io_input_bits; // @[tile.scala 23:41]
  wire  PE_6_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_6_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_6_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_6_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_6_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_6_io_ps; // @[tile.scala 23:41]
  wire  PE_6_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_6_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_7_clock; // @[tile.scala 23:41]
  wire  PE_7_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_7_io_input_bits; // @[tile.scala 23:41]
  wire  PE_7_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_7_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_7_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_7_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_7_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_7_io_ps; // @[tile.scala 23:41]
  wire  PE_7_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_7_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_8_clock; // @[tile.scala 23:41]
  wire  PE_8_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_8_io_input_bits; // @[tile.scala 23:41]
  wire  PE_8_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_8_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_8_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_8_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_8_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_8_io_ps; // @[tile.scala 23:41]
  wire  PE_8_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_8_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_9_clock; // @[tile.scala 23:41]
  wire  PE_9_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_9_io_input_bits; // @[tile.scala 23:41]
  wire  PE_9_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_9_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_9_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_9_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_9_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_9_io_ps; // @[tile.scala 23:41]
  wire  PE_9_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_9_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_10_clock; // @[tile.scala 23:41]
  wire  PE_10_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_10_io_input_bits; // @[tile.scala 23:41]
  wire  PE_10_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_10_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_10_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_10_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_10_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_10_io_ps; // @[tile.scala 23:41]
  wire  PE_10_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_10_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_11_clock; // @[tile.scala 23:41]
  wire  PE_11_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_11_io_input_bits; // @[tile.scala 23:41]
  wire  PE_11_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_11_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_11_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_11_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_11_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_11_io_ps; // @[tile.scala 23:41]
  wire  PE_11_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_11_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_12_clock; // @[tile.scala 23:41]
  wire  PE_12_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_12_io_input_bits; // @[tile.scala 23:41]
  wire  PE_12_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_12_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_12_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_12_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_12_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_12_io_ps; // @[tile.scala 23:41]
  wire  PE_12_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_12_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_13_clock; // @[tile.scala 23:41]
  wire  PE_13_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_13_io_input_bits; // @[tile.scala 23:41]
  wire  PE_13_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_13_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_13_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_13_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_13_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_13_io_ps; // @[tile.scala 23:41]
  wire  PE_13_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_13_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_14_clock; // @[tile.scala 23:41]
  wire  PE_14_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_14_io_input_bits; // @[tile.scala 23:41]
  wire  PE_14_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_14_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_14_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_14_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_14_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_14_io_ps; // @[tile.scala 23:41]
  wire  PE_14_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_14_io_fwd_ps_bits; // @[tile.scala 23:41]
  wire  PE_15_clock; // @[tile.scala 23:41]
  wire  PE_15_io_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_15_io_input_bits; // @[tile.scala 23:41]
  wire  PE_15_io_fwd_input_valid; // @[tile.scala 23:41]
  wire [7:0] PE_15_io_fwd_input_bits; // @[tile.scala 23:41]
  wire [7:0] PE_15_io_weight_bits; // @[tile.scala 23:41]
  wire [7:0] PE_15_io_fwd_weight_bits; // @[tile.scala 23:41]
  wire  PE_15_io_preload; // @[tile.scala 23:41]
  wire [15:0] PE_15_io_ps; // @[tile.scala 23:41]
  wire  PE_15_io_fwd_ps_valid; // @[tile.scala 23:41]
  wire [15:0] PE_15_io_fwd_ps_bits; // @[tile.scala 23:41]
  PE PE ( // @[tile.scala 23:41]
    .clock(PE_clock),
    .io_input_valid(PE_io_input_valid),
    .io_input_bits(PE_io_input_bits),
    .io_fwd_input_valid(PE_io_fwd_input_valid),
    .io_fwd_input_bits(PE_io_fwd_input_bits),
    .io_weight_bits(PE_io_weight_bits),
    .io_fwd_weight_bits(PE_io_fwd_weight_bits),
    .io_preload(PE_io_preload),
    .io_ps(PE_io_ps),
    .io_fwd_ps_valid(PE_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_io_fwd_ps_bits)
  );
  PE PE_1 ( // @[tile.scala 23:41]
    .clock(PE_1_clock),
    .io_input_valid(PE_1_io_input_valid),
    .io_input_bits(PE_1_io_input_bits),
    .io_fwd_input_valid(PE_1_io_fwd_input_valid),
    .io_fwd_input_bits(PE_1_io_fwd_input_bits),
    .io_weight_bits(PE_1_io_weight_bits),
    .io_fwd_weight_bits(PE_1_io_fwd_weight_bits),
    .io_preload(PE_1_io_preload),
    .io_ps(PE_1_io_ps),
    .io_fwd_ps_valid(PE_1_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_1_io_fwd_ps_bits)
  );
  PE PE_2 ( // @[tile.scala 23:41]
    .clock(PE_2_clock),
    .io_input_valid(PE_2_io_input_valid),
    .io_input_bits(PE_2_io_input_bits),
    .io_fwd_input_valid(PE_2_io_fwd_input_valid),
    .io_fwd_input_bits(PE_2_io_fwd_input_bits),
    .io_weight_bits(PE_2_io_weight_bits),
    .io_fwd_weight_bits(PE_2_io_fwd_weight_bits),
    .io_preload(PE_2_io_preload),
    .io_ps(PE_2_io_ps),
    .io_fwd_ps_valid(PE_2_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_2_io_fwd_ps_bits)
  );
  PE PE_3 ( // @[tile.scala 23:41]
    .clock(PE_3_clock),
    .io_input_valid(PE_3_io_input_valid),
    .io_input_bits(PE_3_io_input_bits),
    .io_fwd_input_valid(PE_3_io_fwd_input_valid),
    .io_fwd_input_bits(PE_3_io_fwd_input_bits),
    .io_weight_bits(PE_3_io_weight_bits),
    .io_fwd_weight_bits(PE_3_io_fwd_weight_bits),
    .io_preload(PE_3_io_preload),
    .io_ps(PE_3_io_ps),
    .io_fwd_ps_valid(PE_3_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_3_io_fwd_ps_bits)
  );
  PE PE_4 ( // @[tile.scala 23:41]
    .clock(PE_4_clock),
    .io_input_valid(PE_4_io_input_valid),
    .io_input_bits(PE_4_io_input_bits),
    .io_fwd_input_valid(PE_4_io_fwd_input_valid),
    .io_fwd_input_bits(PE_4_io_fwd_input_bits),
    .io_weight_bits(PE_4_io_weight_bits),
    .io_fwd_weight_bits(PE_4_io_fwd_weight_bits),
    .io_preload(PE_4_io_preload),
    .io_ps(PE_4_io_ps),
    .io_fwd_ps_valid(PE_4_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_4_io_fwd_ps_bits)
  );
  PE PE_5 ( // @[tile.scala 23:41]
    .clock(PE_5_clock),
    .io_input_valid(PE_5_io_input_valid),
    .io_input_bits(PE_5_io_input_bits),
    .io_fwd_input_valid(PE_5_io_fwd_input_valid),
    .io_fwd_input_bits(PE_5_io_fwd_input_bits),
    .io_weight_bits(PE_5_io_weight_bits),
    .io_fwd_weight_bits(PE_5_io_fwd_weight_bits),
    .io_preload(PE_5_io_preload),
    .io_ps(PE_5_io_ps),
    .io_fwd_ps_valid(PE_5_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_5_io_fwd_ps_bits)
  );
  PE PE_6 ( // @[tile.scala 23:41]
    .clock(PE_6_clock),
    .io_input_valid(PE_6_io_input_valid),
    .io_input_bits(PE_6_io_input_bits),
    .io_fwd_input_valid(PE_6_io_fwd_input_valid),
    .io_fwd_input_bits(PE_6_io_fwd_input_bits),
    .io_weight_bits(PE_6_io_weight_bits),
    .io_fwd_weight_bits(PE_6_io_fwd_weight_bits),
    .io_preload(PE_6_io_preload),
    .io_ps(PE_6_io_ps),
    .io_fwd_ps_valid(PE_6_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_6_io_fwd_ps_bits)
  );
  PE PE_7 ( // @[tile.scala 23:41]
    .clock(PE_7_clock),
    .io_input_valid(PE_7_io_input_valid),
    .io_input_bits(PE_7_io_input_bits),
    .io_fwd_input_valid(PE_7_io_fwd_input_valid),
    .io_fwd_input_bits(PE_7_io_fwd_input_bits),
    .io_weight_bits(PE_7_io_weight_bits),
    .io_fwd_weight_bits(PE_7_io_fwd_weight_bits),
    .io_preload(PE_7_io_preload),
    .io_ps(PE_7_io_ps),
    .io_fwd_ps_valid(PE_7_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_7_io_fwd_ps_bits)
  );
  PE PE_8 ( // @[tile.scala 23:41]
    .clock(PE_8_clock),
    .io_input_valid(PE_8_io_input_valid),
    .io_input_bits(PE_8_io_input_bits),
    .io_fwd_input_valid(PE_8_io_fwd_input_valid),
    .io_fwd_input_bits(PE_8_io_fwd_input_bits),
    .io_weight_bits(PE_8_io_weight_bits),
    .io_fwd_weight_bits(PE_8_io_fwd_weight_bits),
    .io_preload(PE_8_io_preload),
    .io_ps(PE_8_io_ps),
    .io_fwd_ps_valid(PE_8_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_8_io_fwd_ps_bits)
  );
  PE PE_9 ( // @[tile.scala 23:41]
    .clock(PE_9_clock),
    .io_input_valid(PE_9_io_input_valid),
    .io_input_bits(PE_9_io_input_bits),
    .io_fwd_input_valid(PE_9_io_fwd_input_valid),
    .io_fwd_input_bits(PE_9_io_fwd_input_bits),
    .io_weight_bits(PE_9_io_weight_bits),
    .io_fwd_weight_bits(PE_9_io_fwd_weight_bits),
    .io_preload(PE_9_io_preload),
    .io_ps(PE_9_io_ps),
    .io_fwd_ps_valid(PE_9_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_9_io_fwd_ps_bits)
  );
  PE PE_10 ( // @[tile.scala 23:41]
    .clock(PE_10_clock),
    .io_input_valid(PE_10_io_input_valid),
    .io_input_bits(PE_10_io_input_bits),
    .io_fwd_input_valid(PE_10_io_fwd_input_valid),
    .io_fwd_input_bits(PE_10_io_fwd_input_bits),
    .io_weight_bits(PE_10_io_weight_bits),
    .io_fwd_weight_bits(PE_10_io_fwd_weight_bits),
    .io_preload(PE_10_io_preload),
    .io_ps(PE_10_io_ps),
    .io_fwd_ps_valid(PE_10_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_10_io_fwd_ps_bits)
  );
  PE PE_11 ( // @[tile.scala 23:41]
    .clock(PE_11_clock),
    .io_input_valid(PE_11_io_input_valid),
    .io_input_bits(PE_11_io_input_bits),
    .io_fwd_input_valid(PE_11_io_fwd_input_valid),
    .io_fwd_input_bits(PE_11_io_fwd_input_bits),
    .io_weight_bits(PE_11_io_weight_bits),
    .io_fwd_weight_bits(PE_11_io_fwd_weight_bits),
    .io_preload(PE_11_io_preload),
    .io_ps(PE_11_io_ps),
    .io_fwd_ps_valid(PE_11_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_11_io_fwd_ps_bits)
  );
  PE PE_12 ( // @[tile.scala 23:41]
    .clock(PE_12_clock),
    .io_input_valid(PE_12_io_input_valid),
    .io_input_bits(PE_12_io_input_bits),
    .io_fwd_input_valid(PE_12_io_fwd_input_valid),
    .io_fwd_input_bits(PE_12_io_fwd_input_bits),
    .io_weight_bits(PE_12_io_weight_bits),
    .io_fwd_weight_bits(PE_12_io_fwd_weight_bits),
    .io_preload(PE_12_io_preload),
    .io_ps(PE_12_io_ps),
    .io_fwd_ps_valid(PE_12_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_12_io_fwd_ps_bits)
  );
  PE PE_13 ( // @[tile.scala 23:41]
    .clock(PE_13_clock),
    .io_input_valid(PE_13_io_input_valid),
    .io_input_bits(PE_13_io_input_bits),
    .io_fwd_input_valid(PE_13_io_fwd_input_valid),
    .io_fwd_input_bits(PE_13_io_fwd_input_bits),
    .io_weight_bits(PE_13_io_weight_bits),
    .io_fwd_weight_bits(PE_13_io_fwd_weight_bits),
    .io_preload(PE_13_io_preload),
    .io_ps(PE_13_io_ps),
    .io_fwd_ps_valid(PE_13_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_13_io_fwd_ps_bits)
  );
  PE PE_14 ( // @[tile.scala 23:41]
    .clock(PE_14_clock),
    .io_input_valid(PE_14_io_input_valid),
    .io_input_bits(PE_14_io_input_bits),
    .io_fwd_input_valid(PE_14_io_fwd_input_valid),
    .io_fwd_input_bits(PE_14_io_fwd_input_bits),
    .io_weight_bits(PE_14_io_weight_bits),
    .io_fwd_weight_bits(PE_14_io_fwd_weight_bits),
    .io_preload(PE_14_io_preload),
    .io_ps(PE_14_io_ps),
    .io_fwd_ps_valid(PE_14_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_14_io_fwd_ps_bits)
  );
  PE PE_15 ( // @[tile.scala 23:41]
    .clock(PE_15_clock),
    .io_input_valid(PE_15_io_input_valid),
    .io_input_bits(PE_15_io_input_bits),
    .io_fwd_input_valid(PE_15_io_fwd_input_valid),
    .io_fwd_input_bits(PE_15_io_fwd_input_bits),
    .io_weight_bits(PE_15_io_weight_bits),
    .io_fwd_weight_bits(PE_15_io_fwd_weight_bits),
    .io_preload(PE_15_io_preload),
    .io_ps(PE_15_io_ps),
    .io_fwd_ps_valid(PE_15_io_fwd_ps_valid),
    .io_fwd_ps_bits(PE_15_io_fwd_ps_bits)
  );
  assign io_output_0_valid = PE_12_io_fwd_ps_valid; // @[tile.scala 53:47]
  assign io_output_0_bits = PE_12_io_fwd_ps_bits; // @[tile.scala 53:47]
  assign io_output_1_valid = PE_13_io_fwd_ps_valid; // @[tile.scala 53:47]
  assign io_output_1_bits = PE_13_io_fwd_ps_bits; // @[tile.scala 53:47]
  assign io_output_2_valid = PE_14_io_fwd_ps_valid; // @[tile.scala 53:47]
  assign io_output_2_bits = PE_14_io_fwd_ps_bits; // @[tile.scala 53:47]
  assign io_output_3_valid = PE_15_io_fwd_ps_valid; // @[tile.scala 53:47]
  assign io_output_3_bits = PE_15_io_fwd_ps_bits; // @[tile.scala 53:47]
  assign PE_clock = clock;
  assign PE_io_input_valid = io_input_0_valid; // @[tile.scala 33:24]
  assign PE_io_input_bits = io_input_0_bits; // @[tile.scala 33:24]
  assign PE_io_weight_bits = io_weight_0_bits; // @[tile.scala 42:25]
  assign PE_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_io_ps = 16'h0; // @[tile.scala 43:21]
  assign PE_1_clock = clock;
  assign PE_1_io_input_valid = PE_io_fwd_input_valid; // @[tile.scala 36:24]
  assign PE_1_io_input_bits = PE_io_fwd_input_bits; // @[tile.scala 36:24]
  assign PE_1_io_weight_bits = io_weight_1_bits; // @[tile.scala 42:25]
  assign PE_1_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_1_io_ps = 16'h0; // @[tile.scala 43:21]
  assign PE_2_clock = clock;
  assign PE_2_io_input_valid = PE_1_io_fwd_input_valid; // @[tile.scala 36:24]
  assign PE_2_io_input_bits = PE_1_io_fwd_input_bits; // @[tile.scala 36:24]
  assign PE_2_io_weight_bits = io_weight_2_bits; // @[tile.scala 42:25]
  assign PE_2_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_2_io_ps = 16'h0; // @[tile.scala 43:21]
  assign PE_3_clock = clock;
  assign PE_3_io_input_valid = PE_2_io_fwd_input_valid; // @[tile.scala 36:24]
  assign PE_3_io_input_bits = PE_2_io_fwd_input_bits; // @[tile.scala 36:24]
  assign PE_3_io_weight_bits = io_weight_3_bits; // @[tile.scala 42:25]
  assign PE_3_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_3_io_ps = 16'h0; // @[tile.scala 43:21]
  assign PE_4_clock = clock;
  assign PE_4_io_input_valid = io_input_1_valid; // @[tile.scala 33:24]
  assign PE_4_io_input_bits = io_input_1_bits; // @[tile.scala 33:24]
  assign PE_4_io_weight_bits = PE_io_fwd_weight_bits; // @[tile.scala 46:25]
  assign PE_4_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_4_io_ps = PE_io_fwd_ps_bits; // @[tile.scala 47:21]
  assign PE_5_clock = clock;
  assign PE_5_io_input_valid = PE_4_io_fwd_input_valid; // @[tile.scala 36:24]
  assign PE_5_io_input_bits = PE_4_io_fwd_input_bits; // @[tile.scala 36:24]
  assign PE_5_io_weight_bits = PE_1_io_fwd_weight_bits; // @[tile.scala 46:25]
  assign PE_5_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_5_io_ps = PE_1_io_fwd_ps_bits; // @[tile.scala 47:21]
  assign PE_6_clock = clock;
  assign PE_6_io_input_valid = PE_5_io_fwd_input_valid; // @[tile.scala 36:24]
  assign PE_6_io_input_bits = PE_5_io_fwd_input_bits; // @[tile.scala 36:24]
  assign PE_6_io_weight_bits = PE_2_io_fwd_weight_bits; // @[tile.scala 46:25]
  assign PE_6_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_6_io_ps = PE_2_io_fwd_ps_bits; // @[tile.scala 47:21]
  assign PE_7_clock = clock;
  assign PE_7_io_input_valid = PE_6_io_fwd_input_valid; // @[tile.scala 36:24]
  assign PE_7_io_input_bits = PE_6_io_fwd_input_bits; // @[tile.scala 36:24]
  assign PE_7_io_weight_bits = PE_3_io_fwd_weight_bits; // @[tile.scala 46:25]
  assign PE_7_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_7_io_ps = PE_3_io_fwd_ps_bits; // @[tile.scala 47:21]
  assign PE_8_clock = clock;
  assign PE_8_io_input_valid = io_input_2_valid; // @[tile.scala 33:24]
  assign PE_8_io_input_bits = io_input_2_bits; // @[tile.scala 33:24]
  assign PE_8_io_weight_bits = PE_4_io_fwd_weight_bits; // @[tile.scala 46:25]
  assign PE_8_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_8_io_ps = PE_4_io_fwd_ps_bits; // @[tile.scala 47:21]
  assign PE_9_clock = clock;
  assign PE_9_io_input_valid = PE_8_io_fwd_input_valid; // @[tile.scala 36:24]
  assign PE_9_io_input_bits = PE_8_io_fwd_input_bits; // @[tile.scala 36:24]
  assign PE_9_io_weight_bits = PE_5_io_fwd_weight_bits; // @[tile.scala 46:25]
  assign PE_9_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_9_io_ps = PE_5_io_fwd_ps_bits; // @[tile.scala 47:21]
  assign PE_10_clock = clock;
  assign PE_10_io_input_valid = PE_9_io_fwd_input_valid; // @[tile.scala 36:24]
  assign PE_10_io_input_bits = PE_9_io_fwd_input_bits; // @[tile.scala 36:24]
  assign PE_10_io_weight_bits = PE_6_io_fwd_weight_bits; // @[tile.scala 46:25]
  assign PE_10_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_10_io_ps = PE_6_io_fwd_ps_bits; // @[tile.scala 47:21]
  assign PE_11_clock = clock;
  assign PE_11_io_input_valid = PE_10_io_fwd_input_valid; // @[tile.scala 36:24]
  assign PE_11_io_input_bits = PE_10_io_fwd_input_bits; // @[tile.scala 36:24]
  assign PE_11_io_weight_bits = PE_7_io_fwd_weight_bits; // @[tile.scala 46:25]
  assign PE_11_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_11_io_ps = PE_7_io_fwd_ps_bits; // @[tile.scala 47:21]
  assign PE_12_clock = clock;
  assign PE_12_io_input_valid = io_input_3_valid; // @[tile.scala 33:24]
  assign PE_12_io_input_bits = io_input_3_bits; // @[tile.scala 33:24]
  assign PE_12_io_weight_bits = PE_8_io_fwd_weight_bits; // @[tile.scala 46:25]
  assign PE_12_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_12_io_ps = PE_8_io_fwd_ps_bits; // @[tile.scala 47:21]
  assign PE_13_clock = clock;
  assign PE_13_io_input_valid = PE_12_io_fwd_input_valid; // @[tile.scala 36:24]
  assign PE_13_io_input_bits = PE_12_io_fwd_input_bits; // @[tile.scala 36:24]
  assign PE_13_io_weight_bits = PE_9_io_fwd_weight_bits; // @[tile.scala 46:25]
  assign PE_13_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_13_io_ps = PE_9_io_fwd_ps_bits; // @[tile.scala 47:21]
  assign PE_14_clock = clock;
  assign PE_14_io_input_valid = PE_13_io_fwd_input_valid; // @[tile.scala 36:24]
  assign PE_14_io_input_bits = PE_13_io_fwd_input_bits; // @[tile.scala 36:24]
  assign PE_14_io_weight_bits = PE_10_io_fwd_weight_bits; // @[tile.scala 46:25]
  assign PE_14_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_14_io_ps = PE_10_io_fwd_ps_bits; // @[tile.scala 47:21]
  assign PE_15_clock = clock;
  assign PE_15_io_input_valid = PE_14_io_fwd_input_valid; // @[tile.scala 36:24]
  assign PE_15_io_input_bits = PE_14_io_fwd_input_bits; // @[tile.scala 36:24]
  assign PE_15_io_weight_bits = PE_11_io_fwd_weight_bits; // @[tile.scala 46:25]
  assign PE_15_io_preload = io_preload; // @[tile.scala 28:24]
  assign PE_15_io_ps = PE_11_io_fwd_ps_bits; // @[tile.scala 47:21]
endmodule
module buffer(
  input        clock,
  input        io_input_0_valid,
  input  [7:0] io_input_0_bits,
  input        io_input_1_valid,
  input  [7:0] io_input_1_bits,
  input        io_input_2_valid,
  input  [7:0] io_input_2_bits,
  input        io_input_3_valid,
  input  [7:0] io_input_3_bits,
  output       io_output_0_valid,
  output [7:0] io_output_0_bits,
  output       io_output_1_valid,
  output [7:0] io_output_1_bits,
  output       io_output_2_valid,
  output [7:0] io_output_2_bits,
  output       io_output_3_valid,
  output [7:0] io_output_3_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  reg  REG_valid; // @[buffer.scala 20:44]
  reg [7:0] REG_bits; // @[buffer.scala 20:44]
  reg  REG_1_valid; // @[buffer.scala 20:44]
  reg [7:0] REG_1_bits; // @[buffer.scala 20:44]
  reg  REG_2_valid; // @[buffer.scala 20:44]
  reg [7:0] REG_2_bits; // @[buffer.scala 20:44]
  reg  REG_3_valid; // @[buffer.scala 20:44]
  reg [7:0] REG_3_bits; // @[buffer.scala 20:44]
  reg  REG_4_valid; // @[buffer.scala 20:44]
  reg [7:0] REG_4_bits; // @[buffer.scala 20:44]
  reg  REG_5_valid; // @[buffer.scala 20:44]
  reg [7:0] REG_5_bits; // @[buffer.scala 20:44]
  assign io_output_0_valid = io_input_0_valid; // @[buffer.scala 17:16]
  assign io_output_0_bits = io_input_0_bits; // @[buffer.scala 17:16]
  assign io_output_1_valid = REG_valid; // @[buffer.scala 31:20]
  assign io_output_1_bits = REG_bits; // @[buffer.scala 31:20]
  assign io_output_2_valid = REG_2_valid; // @[buffer.scala 31:20]
  assign io_output_2_bits = REG_2_bits; // @[buffer.scala 31:20]
  assign io_output_3_valid = REG_5_valid; // @[buffer.scala 31:20]
  assign io_output_3_bits = REG_5_bits; // @[buffer.scala 31:20]
  always @(posedge clock) begin
    REG_valid <= io_input_1_valid; // @[buffer.scala 26:20]
    REG_bits <= io_input_1_bits; // @[buffer.scala 26:20]
    REG_1_valid <= io_input_2_valid; // @[buffer.scala 26:20]
    REG_1_bits <= io_input_2_bits; // @[buffer.scala 26:20]
    REG_2_valid <= REG_1_valid; // @[buffer.scala 29:26]
    REG_2_bits <= REG_1_bits; // @[buffer.scala 28:26]
    REG_3_valid <= io_input_3_valid; // @[buffer.scala 26:20]
    REG_3_bits <= io_input_3_bits; // @[buffer.scala 26:20]
    REG_4_valid <= REG_3_valid; // @[buffer.scala 29:26]
    REG_4_bits <= REG_3_bits; // @[buffer.scala 28:26]
    REG_5_valid <= REG_4_valid; // @[buffer.scala 29:26]
    REG_5_bits <= REG_4_bits; // @[buffer.scala 28:26]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  REG_valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  REG_bits = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  REG_1_valid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  REG_1_bits = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  REG_2_valid = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  REG_2_bits = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  REG_3_valid = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  REG_3_bits = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  REG_4_valid = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  REG_4_bits = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  REG_5_valid = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  REG_5_bits = _RAND_11[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SA(
  input         clock,
  input         reset,
  input         io_mmio_ENABLE_OUT,
  input  [31:0] io_mmio_MATA_MEM_ADDR,
  input  [31:0] io_mmio_MATB_MEM_ADDR,
  input  [31:0] io_mmio_MATC_MEM_ADDR,
  input  [31:0] io_mmio_MAT_MEM_STRIDE,
  output        io_mmio_WEN,
  output        io_mmio_ENABLE_IN,
  output        io_mmio_STATUS_IN,
  output [31:0] io_raddr,
  input  [31:0] io_rdata,
  output        io_wen,
  output [31:0] io_waddr,
  output [31:0] io_wdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  wire  tile_clock; // @[SA.scala 58:29]
  wire  tile_io_input_0_valid; // @[SA.scala 58:29]
  wire [7:0] tile_io_input_0_bits; // @[SA.scala 58:29]
  wire  tile_io_input_1_valid; // @[SA.scala 58:29]
  wire [7:0] tile_io_input_1_bits; // @[SA.scala 58:29]
  wire  tile_io_input_2_valid; // @[SA.scala 58:29]
  wire [7:0] tile_io_input_2_bits; // @[SA.scala 58:29]
  wire  tile_io_input_3_valid; // @[SA.scala 58:29]
  wire [7:0] tile_io_input_3_bits; // @[SA.scala 58:29]
  wire [7:0] tile_io_weight_0_bits; // @[SA.scala 58:29]
  wire [7:0] tile_io_weight_1_bits; // @[SA.scala 58:29]
  wire [7:0] tile_io_weight_2_bits; // @[SA.scala 58:29]
  wire [7:0] tile_io_weight_3_bits; // @[SA.scala 58:29]
  wire  tile_io_preload; // @[SA.scala 58:29]
  wire  tile_io_output_0_valid; // @[SA.scala 58:29]
  wire [15:0] tile_io_output_0_bits; // @[SA.scala 58:29]
  wire  tile_io_output_1_valid; // @[SA.scala 58:29]
  wire [15:0] tile_io_output_1_bits; // @[SA.scala 58:29]
  wire  tile_io_output_2_valid; // @[SA.scala 58:29]
  wire [15:0] tile_io_output_2_bits; // @[SA.scala 58:29]
  wire  tile_io_output_3_valid; // @[SA.scala 58:29]
  wire [15:0] tile_io_output_3_bits; // @[SA.scala 58:29]
  wire  input_buffer_clock; // @[SA.scala 59:29]
  wire  input_buffer_io_input_0_valid; // @[SA.scala 59:29]
  wire [7:0] input_buffer_io_input_0_bits; // @[SA.scala 59:29]
  wire  input_buffer_io_input_1_valid; // @[SA.scala 59:29]
  wire [7:0] input_buffer_io_input_1_bits; // @[SA.scala 59:29]
  wire  input_buffer_io_input_2_valid; // @[SA.scala 59:29]
  wire [7:0] input_buffer_io_input_2_bits; // @[SA.scala 59:29]
  wire  input_buffer_io_input_3_valid; // @[SA.scala 59:29]
  wire [7:0] input_buffer_io_input_3_bits; // @[SA.scala 59:29]
  wire  input_buffer_io_output_0_valid; // @[SA.scala 59:29]
  wire [7:0] input_buffer_io_output_0_bits; // @[SA.scala 59:29]
  wire  input_buffer_io_output_1_valid; // @[SA.scala 59:29]
  wire [7:0] input_buffer_io_output_1_bits; // @[SA.scala 59:29]
  wire  input_buffer_io_output_2_valid; // @[SA.scala 59:29]
  wire [7:0] input_buffer_io_output_2_bits; // @[SA.scala 59:29]
  wire  input_buffer_io_output_3_valid; // @[SA.scala 59:29]
  wire [7:0] input_buffer_io_output_3_bits; // @[SA.scala 59:29]
  wire  output_buffer_clock; // @[SA.scala 60:29]
  wire  output_buffer_io_input_0_valid; // @[SA.scala 60:29]
  wire [7:0] output_buffer_io_input_0_bits; // @[SA.scala 60:29]
  wire  output_buffer_io_input_1_valid; // @[SA.scala 60:29]
  wire [7:0] output_buffer_io_input_1_bits; // @[SA.scala 60:29]
  wire  output_buffer_io_input_2_valid; // @[SA.scala 60:29]
  wire [7:0] output_buffer_io_input_2_bits; // @[SA.scala 60:29]
  wire  output_buffer_io_input_3_valid; // @[SA.scala 60:29]
  wire [7:0] output_buffer_io_input_3_bits; // @[SA.scala 60:29]
  wire  output_buffer_io_output_0_valid; // @[SA.scala 60:29]
  wire [7:0] output_buffer_io_output_0_bits; // @[SA.scala 60:29]
  wire  output_buffer_io_output_1_valid; // @[SA.scala 60:29]
  wire [7:0] output_buffer_io_output_1_bits; // @[SA.scala 60:29]
  wire  output_buffer_io_output_2_valid; // @[SA.scala 60:29]
  wire [7:0] output_buffer_io_output_2_bits; // @[SA.scala 60:29]
  wire  output_buffer_io_output_3_valid; // @[SA.scala 60:29]
  wire [7:0] output_buffer_io_output_3_bits; // @[SA.scala 60:29]
  reg [2:0] stateReg; // @[SA.scala 66:25]
  reg [2:0] weight_cnt; // @[SA.scala 69:27]
  reg [2:0] input_cnt; // @[SA.scala 70:27]
  reg [2:0] output_cnt; // @[SA.scala 71:27]
  reg [2:0] read_accumulated; // @[SA.scala 72:33]
  reg  reading_accumulated; // @[SA.scala 73:36]
  reg [31:0] accumulated_mat_C_0; // @[SA.scala 77:34]
  reg [31:0] accumulated_mat_C_1; // @[SA.scala 77:34]
  reg [31:0] accumulated_mat_C_2; // @[SA.scala 77:34]
  reg [31:0] accumulated_mat_C_3; // @[SA.scala 77:34]
  wire  _tile_io_preload_T = stateReg == 3'h3; // @[SA.scala 81:31]
  wire  _input_buffer_io_input_0_valid_T = stateReg == 3'h5; // @[SA.scala 90:53]
  wire  _io_raddr_T_2 = stateReg == 3'h2 | _tile_io_preload_T; // @[SA.scala 103:29]
  wire [2:0] _io_raddr_T_4 = weight_cnt - 3'h1; // @[SA.scala 104:34]
  wire [4:0] _io_raddr_T_5 = {_io_raddr_T_4, 2'h0}; // @[SA.scala 104:41]
  wire [12:0] _io_raddr_T_7 = _io_raddr_T_5 * io_mmio_MAT_MEM_STRIDE[15:8]; // @[SA.scala 104:47]
  wire [31:0] _GEN_55 = {{19'd0}, _io_raddr_T_7}; // @[SA.scala 104:19]
  wire [31:0] _io_raddr_T_9 = io_mmio_MATB_MEM_ADDR + _GEN_55; // @[SA.scala 104:19]
  wire  _io_raddr_T_11 = stateReg == 3'h6; // @[SA.scala 105:40]
  wire [4:0] _io_raddr_T_13 = {read_accumulated, 2'h0}; // @[SA.scala 106:43]
  wire [12:0] _io_raddr_T_15 = _io_raddr_T_13 * io_mmio_MAT_MEM_STRIDE[23:16]; // @[SA.scala 106:49]
  wire [31:0] _GEN_56 = {{19'd0}, _io_raddr_T_15}; // @[SA.scala 106:23]
  wire [31:0] _io_raddr_T_17 = io_mmio_MATC_MEM_ADDR + _GEN_56; // @[SA.scala 106:23]
  wire [4:0] _io_raddr_T_18 = {input_cnt, 2'h0}; // @[SA.scala 107:36]
  wire [12:0] _io_raddr_T_20 = _io_raddr_T_18 * io_mmio_MAT_MEM_STRIDE[7:0]; // @[SA.scala 107:42]
  wire [31:0] _GEN_57 = {{19'd0}, _io_raddr_T_20}; // @[SA.scala 107:23]
  wire [31:0] _io_raddr_T_22 = io_mmio_MATA_MEM_ADDR + _GEN_57; // @[SA.scala 107:23]
  wire [31:0] _io_raddr_T_23 = input_cnt >= 3'h4 | stateReg == 3'h6 ? _io_raddr_T_17 : _io_raddr_T_22; // @[SA.scala 105:10]
  wire [4:0] _io_waddr_T = {output_cnt, 2'h0}; // @[SA.scala 109:41]
  wire [12:0] _io_waddr_T_2 = _io_waddr_T * io_mmio_MAT_MEM_STRIDE[23:16]; // @[SA.scala 109:47]
  wire [31:0] _GEN_58 = {{19'd0}, _io_waddr_T_2}; // @[SA.scala 109:27]
  wire [31:0] _word_writeData_T = {output_buffer_io_output_0_bits, 24'h0}; // @[SA.scala 113:41]
  wire [23:0] _word_writeData_T_1 = {output_buffer_io_output_1_bits, 16'h0}; // @[SA.scala 113:41]
  wire [15:0] _word_writeData_T_2 = {output_buffer_io_output_2_bits, 8'h0}; // @[SA.scala 113:41]
  wire [7:0] _word_writeData_T_3 = output_buffer_io_output_3_bits; // @[SA.scala 113:41]
  wire [31:0] _GEN_59 = {{8'd0}, _word_writeData_T_1}; // @[SA.scala 114:14]
  wire [31:0] _word_writeData_T_5 = _word_writeData_T + _GEN_59; // @[SA.scala 114:14]
  wire [31:0] _GEN_60 = {{16'd0}, _word_writeData_T_2}; // @[SA.scala 114:14]
  wire [31:0] _word_writeData_T_7 = _word_writeData_T_5 + _GEN_60; // @[SA.scala 114:14]
  wire [31:0] _GEN_61 = {{24'd0}, _word_writeData_T_3}; // @[SA.scala 114:14]
  wire [31:0] _word_writeData_T_9 = _word_writeData_T_7 + _GEN_61; // @[SA.scala 114:14]
  wire [31:0] _GEN_1 = 2'h1 == output_cnt[1:0] ? accumulated_mat_C_1 : accumulated_mat_C_0; // @[SA.scala 114:{20,20}]
  wire [31:0] _GEN_2 = 2'h2 == output_cnt[1:0] ? accumulated_mat_C_2 : _GEN_1; // @[SA.scala 114:{20,20}]
  wire [31:0] _GEN_3 = 2'h3 == output_cnt[1:0] ? accumulated_mat_C_3 : _GEN_2; // @[SA.scala 114:{20,20}]
  wire  _io_mmio_ENABLE_IN_T = stateReg == 3'h7; // @[SA.scala 121:35]
  wire [2:0] _stateReg_T_1 = io_mmio_ENABLE_OUT ? 3'h3 : 3'h1; // @[SA.scala 134:22]
  wire [2:0] _stateReg_T_3 = weight_cnt == 3'h0 ? 3'h4 : 3'h3; // @[SA.scala 138:24]
  wire [2:0] _GEN_4 = io_mmio_ENABLE_OUT ? _stateReg_T_3 : 3'h1; // @[SA.scala 137:32 138:18 140:18]
  wire [2:0] _stateReg_T_4 = io_mmio_ENABLE_OUT ? 3'h5 : 3'h1; // @[SA.scala 144:24]
  wire [2:0] _weight_cnt_T = io_mmio_ENABLE_OUT ? weight_cnt : 3'h4; // @[SA.scala 145:24]
  wire [2:0] _stateReg_T_6 = input_cnt == 3'h7 ? 3'h6 : 3'h5; // @[SA.scala 149:24]
  wire [2:0] _GEN_5 = io_mmio_ENABLE_OUT ? _stateReg_T_6 : 3'h1; // @[SA.scala 148:32 149:18 151:20]
  wire [2:0] _stateReg_T_8 = output_cnt == 3'h3 ? 3'h7 : 3'h6; // @[SA.scala 156:22]
  wire [2:0] _GEN_7 = 3'h7 == stateReg ? 3'h1 : stateReg; // @[SA.scala 126:20 159:16 66:25]
  wire [2:0] _GEN_8 = 3'h6 == stateReg ? _stateReg_T_8 : _GEN_7; // @[SA.scala 126:20 156:16]
  wire [2:0] _GEN_9 = 3'h5 == stateReg ? _GEN_5 : _GEN_8; // @[SA.scala 126:20]
  wire [2:0] _GEN_10 = 3'h5 == stateReg ? _weight_cnt_T : weight_cnt; // @[SA.scala 126:20 69:27]
  wire [2:0] _GEN_11 = 3'h4 == stateReg ? _stateReg_T_4 : _GEN_9; // @[SA.scala 126:20 144:18]
  wire [2:0] _GEN_12 = 3'h4 == stateReg ? _weight_cnt_T : _GEN_10; // @[SA.scala 126:20 145:18]
  wire [2:0] _GEN_13 = 3'h3 == stateReg ? _GEN_4 : _GEN_11; // @[SA.scala 126:20]
  wire [2:0] _GEN_14 = 3'h3 == stateReg ? weight_cnt : _GEN_12; // @[SA.scala 126:20 69:27]
  wire [2:0] _GEN_16 = 3'h2 == stateReg ? weight_cnt : _GEN_14; // @[SA.scala 126:20 69:27]
  wire [2:0] _GEN_18 = 3'h1 == stateReg ? weight_cnt : _GEN_16; // @[SA.scala 126:20 69:27]
  wire [2:0] _GEN_20 = 3'h0 == stateReg ? weight_cnt : _GEN_18; // @[SA.scala 126:20 69:27]
  wire [2:0] _input_cnt_T_1 = input_cnt + 3'h1; // @[SA.scala 167:52]
  wire  _GEN_21 = _input_cnt_T_1 == 3'h4 | reading_accumulated; // @[SA.scala 168:34 169:27 73:36]
  wire  _output_cnt_T = output_buffer_io_output_0_valid; // @[SA.scala 172:35]
  wire [2:0] _GEN_62 = {{2'd0}, _output_cnt_T}; // @[SA.scala 172:30]
  wire [2:0] _output_cnt_T_2 = output_cnt + _GEN_62; // @[SA.scala 172:30]
  wire [2:0] _GEN_22 = _io_mmio_ENABLE_IN_T ? 3'h4 : _GEN_20; // @[SA.scala 173:36 175:16]
  wire [2:0] _GEN_23 = _io_mmio_ENABLE_IN_T ? 3'h0 : input_cnt; // @[SA.scala 173:36 176:16 70:27]
  wire [2:0] _GEN_24 = _io_mmio_ENABLE_IN_T ? 3'h0 : output_cnt; // @[SA.scala 173:36 177:16 71:27]
  wire [2:0] _GEN_25 = _io_mmio_ENABLE_IN_T ? 3'h0 : read_accumulated; // @[SA.scala 173:36 178:22 72:33]
  wire [2:0] _GEN_29 = _io_raddr_T_11 ? read_accumulated : _GEN_25; // @[SA.scala 171:35 72:33]
  wire  _GEN_31 = stateReg == 3'h4 | _input_buffer_io_input_0_valid_T ? _GEN_21 : reading_accumulated; // @[SA.scala 166:64 73:36]
  wire  _GEN_37 = _io_raddr_T_2 ? reading_accumulated : _GEN_31; // @[SA.scala 164:56 73:36]
  wire [2:0] _read_accumulated_T_1 = read_accumulated + 3'h1; // @[SA.scala 184:42]
  wire [2:0] _T_21 = read_accumulated - 3'h1; // @[SA.scala 186:42]
  tile tile ( // @[SA.scala 58:29]
    .clock(tile_clock),
    .io_input_0_valid(tile_io_input_0_valid),
    .io_input_0_bits(tile_io_input_0_bits),
    .io_input_1_valid(tile_io_input_1_valid),
    .io_input_1_bits(tile_io_input_1_bits),
    .io_input_2_valid(tile_io_input_2_valid),
    .io_input_2_bits(tile_io_input_2_bits),
    .io_input_3_valid(tile_io_input_3_valid),
    .io_input_3_bits(tile_io_input_3_bits),
    .io_weight_0_bits(tile_io_weight_0_bits),
    .io_weight_1_bits(tile_io_weight_1_bits),
    .io_weight_2_bits(tile_io_weight_2_bits),
    .io_weight_3_bits(tile_io_weight_3_bits),
    .io_preload(tile_io_preload),
    .io_output_0_valid(tile_io_output_0_valid),
    .io_output_0_bits(tile_io_output_0_bits),
    .io_output_1_valid(tile_io_output_1_valid),
    .io_output_1_bits(tile_io_output_1_bits),
    .io_output_2_valid(tile_io_output_2_valid),
    .io_output_2_bits(tile_io_output_2_bits),
    .io_output_3_valid(tile_io_output_3_valid),
    .io_output_3_bits(tile_io_output_3_bits)
  );
  buffer input_buffer ( // @[SA.scala 59:29]
    .clock(input_buffer_clock),
    .io_input_0_valid(input_buffer_io_input_0_valid),
    .io_input_0_bits(input_buffer_io_input_0_bits),
    .io_input_1_valid(input_buffer_io_input_1_valid),
    .io_input_1_bits(input_buffer_io_input_1_bits),
    .io_input_2_valid(input_buffer_io_input_2_valid),
    .io_input_2_bits(input_buffer_io_input_2_bits),
    .io_input_3_valid(input_buffer_io_input_3_valid),
    .io_input_3_bits(input_buffer_io_input_3_bits),
    .io_output_0_valid(input_buffer_io_output_0_valid),
    .io_output_0_bits(input_buffer_io_output_0_bits),
    .io_output_1_valid(input_buffer_io_output_1_valid),
    .io_output_1_bits(input_buffer_io_output_1_bits),
    .io_output_2_valid(input_buffer_io_output_2_valid),
    .io_output_2_bits(input_buffer_io_output_2_bits),
    .io_output_3_valid(input_buffer_io_output_3_valid),
    .io_output_3_bits(input_buffer_io_output_3_bits)
  );
  buffer output_buffer ( // @[SA.scala 60:29]
    .clock(output_buffer_clock),
    .io_input_0_valid(output_buffer_io_input_0_valid),
    .io_input_0_bits(output_buffer_io_input_0_bits),
    .io_input_1_valid(output_buffer_io_input_1_valid),
    .io_input_1_bits(output_buffer_io_input_1_bits),
    .io_input_2_valid(output_buffer_io_input_2_valid),
    .io_input_2_bits(output_buffer_io_input_2_bits),
    .io_input_3_valid(output_buffer_io_input_3_valid),
    .io_input_3_bits(output_buffer_io_input_3_bits),
    .io_output_0_valid(output_buffer_io_output_0_valid),
    .io_output_0_bits(output_buffer_io_output_0_bits),
    .io_output_1_valid(output_buffer_io_output_1_valid),
    .io_output_1_bits(output_buffer_io_output_1_bits),
    .io_output_2_valid(output_buffer_io_output_2_valid),
    .io_output_2_bits(output_buffer_io_output_2_bits),
    .io_output_3_valid(output_buffer_io_output_3_valid),
    .io_output_3_bits(output_buffer_io_output_3_bits)
  );
  assign io_mmio_WEN = stateReg == 3'h7; // @[SA.scala 123:33]
  assign io_mmio_ENABLE_IN = ~(stateReg == 3'h7); // @[SA.scala 121:24]
  assign io_mmio_STATUS_IN = stateReg == 3'h7; // @[SA.scala 122:33]
  assign io_raddr = _io_raddr_T_2 ? _io_raddr_T_9 : _io_raddr_T_23; // @[SA.scala 102:18]
  assign io_wen = output_buffer_io_output_0_valid; // @[SA.scala 118:12]
  assign io_waddr = io_mmio_MATC_MEM_ADDR + _GEN_58; // @[SA.scala 109:27]
  assign io_wdata = _word_writeData_T_9 + _GEN_3; // @[SA.scala 114:20]
  assign tile_clock = clock;
  assign tile_io_input_0_valid = input_buffer_io_output_0_valid; // @[SA.scala 94:17]
  assign tile_io_input_0_bits = input_buffer_io_output_0_bits; // @[SA.scala 94:17]
  assign tile_io_input_1_valid = input_buffer_io_output_1_valid; // @[SA.scala 94:17]
  assign tile_io_input_1_bits = input_buffer_io_output_1_bits; // @[SA.scala 94:17]
  assign tile_io_input_2_valid = input_buffer_io_output_2_valid; // @[SA.scala 94:17]
  assign tile_io_input_2_bits = input_buffer_io_output_2_bits; // @[SA.scala 94:17]
  assign tile_io_input_3_valid = input_buffer_io_output_3_valid; // @[SA.scala 94:17]
  assign tile_io_input_3_bits = input_buffer_io_output_3_bits; // @[SA.scala 94:17]
  assign tile_io_weight_0_bits = io_rdata[7:0]; // @[SA.scala 83:49]
  assign tile_io_weight_1_bits = io_rdata[15:8]; // @[SA.scala 83:49]
  assign tile_io_weight_2_bits = io_rdata[23:16]; // @[SA.scala 83:49]
  assign tile_io_weight_3_bits = io_rdata[31:24]; // @[SA.scala 83:49]
  assign tile_io_preload = stateReg == 3'h3; // @[SA.scala 81:31]
  assign input_buffer_clock = clock;
  assign input_buffer_io_input_0_valid = stateReg == 3'h5 & input_cnt <= 3'h4; // @[SA.scala 90:69]
  assign input_buffer_io_input_0_bits = io_rdata[7:0]; // @[SA.scala 89:56]
  assign input_buffer_io_input_1_valid = stateReg == 3'h5 & input_cnt <= 3'h4; // @[SA.scala 90:69]
  assign input_buffer_io_input_1_bits = io_rdata[15:8]; // @[SA.scala 89:56]
  assign input_buffer_io_input_2_valid = stateReg == 3'h5 & input_cnt <= 3'h4; // @[SA.scala 90:69]
  assign input_buffer_io_input_2_bits = io_rdata[23:16]; // @[SA.scala 89:56]
  assign input_buffer_io_input_3_valid = stateReg == 3'h5 & input_cnt <= 3'h4; // @[SA.scala 90:69]
  assign input_buffer_io_input_3_bits = io_rdata[31:24]; // @[SA.scala 89:56]
  assign output_buffer_clock = clock;
  assign output_buffer_io_input_0_valid = tile_io_output_3_valid; // @[SA.scala 98:46]
  assign output_buffer_io_input_0_bits = tile_io_output_3_bits[7:0]; // @[SA.scala 98:46]
  assign output_buffer_io_input_1_valid = tile_io_output_2_valid; // @[SA.scala 98:46]
  assign output_buffer_io_input_1_bits = tile_io_output_2_bits[7:0]; // @[SA.scala 98:46]
  assign output_buffer_io_input_2_valid = tile_io_output_1_valid; // @[SA.scala 98:46]
  assign output_buffer_io_input_2_bits = tile_io_output_1_bits[7:0]; // @[SA.scala 98:46]
  assign output_buffer_io_input_3_valid = tile_io_output_0_valid; // @[SA.scala 98:46]
  assign output_buffer_io_input_3_bits = tile_io_output_0_bits[7:0]; // @[SA.scala 98:46]
  always @(posedge clock) begin
    if (reset) begin // @[SA.scala 66:25]
      stateReg <= 3'h0; // @[SA.scala 66:25]
    end else if (3'h0 == stateReg) begin // @[SA.scala 126:20]
      stateReg <= 3'h1; // @[SA.scala 128:16]
    end else if (3'h1 == stateReg) begin // @[SA.scala 126:20]
      if (io_mmio_ENABLE_OUT) begin // @[SA.scala 131:22]
        stateReg <= 3'h2;
      end else begin
        stateReg <= 3'h1;
      end
    end else if (3'h2 == stateReg) begin // @[SA.scala 126:20]
      stateReg <= _stateReg_T_1; // @[SA.scala 134:16]
    end else begin
      stateReg <= _GEN_13;
    end
    if (reset) begin // @[SA.scala 69:27]
      weight_cnt <= 3'h4; // @[SA.scala 69:27]
    end else if (_io_raddr_T_2) begin // @[SA.scala 164:56]
      if (io_mmio_ENABLE_OUT) begin // @[SA.scala 165:22]
        weight_cnt <= _io_raddr_T_4;
      end else begin
        weight_cnt <= 3'h4;
      end
    end else if (stateReg == 3'h4 | _input_buffer_io_input_0_valid_T) begin // @[SA.scala 166:64]
      weight_cnt <= _GEN_20;
    end else if (_io_raddr_T_11) begin // @[SA.scala 171:35]
      weight_cnt <= _GEN_20;
    end else begin
      weight_cnt <= _GEN_22;
    end
    if (reset) begin // @[SA.scala 70:27]
      input_cnt <= 3'h0; // @[SA.scala 70:27]
    end else if (!(_io_raddr_T_2)) begin // @[SA.scala 164:56]
      if (stateReg == 3'h4 | _input_buffer_io_input_0_valid_T) begin // @[SA.scala 166:64]
        if (io_mmio_ENABLE_OUT) begin // @[SA.scala 167:21]
          input_cnt <= _input_cnt_T_1;
        end else begin
          input_cnt <= 3'h0;
        end
      end else if (!(_io_raddr_T_11)) begin // @[SA.scala 171:35]
        input_cnt <= _GEN_23;
      end
    end
    if (reset) begin // @[SA.scala 71:27]
      output_cnt <= 3'h0; // @[SA.scala 71:27]
    end else if (!(_io_raddr_T_2)) begin // @[SA.scala 164:56]
      if (!(stateReg == 3'h4 | _input_buffer_io_input_0_valid_T)) begin // @[SA.scala 166:64]
        if (_io_raddr_T_11) begin // @[SA.scala 171:35]
          output_cnt <= _output_cnt_T_2; // @[SA.scala 172:16]
        end else begin
          output_cnt <= _GEN_24;
        end
      end
    end
    if (reset) begin // @[SA.scala 72:33]
      read_accumulated <= 3'h0; // @[SA.scala 72:33]
    end else if (reading_accumulated) begin // @[SA.scala 183:28]
      read_accumulated <= _read_accumulated_T_1; // @[SA.scala 184:22]
    end else if (!(_io_raddr_T_2)) begin // @[SA.scala 164:56]
      if (!(stateReg == 3'h4 | _input_buffer_io_input_0_valid_T)) begin // @[SA.scala 166:64]
        read_accumulated <= _GEN_29;
      end
    end
    if (reset) begin // @[SA.scala 73:36]
      reading_accumulated <= 1'h0; // @[SA.scala 73:36]
    end else if (reading_accumulated) begin // @[SA.scala 183:28]
      if (_read_accumulated_T_1 == 3'h5) begin // @[SA.scala 188:41]
        reading_accumulated <= 1'h0; // @[SA.scala 189:27]
      end else begin
        reading_accumulated <= _GEN_37;
      end
    end else begin
      reading_accumulated <= _GEN_37;
    end
    if (reset) begin // @[SA.scala 77:34]
      accumulated_mat_C_0 <= 32'h0; // @[SA.scala 77:34]
    end else if (reading_accumulated) begin // @[SA.scala 183:28]
      if (read_accumulated >= 3'h1) begin // @[SA.scala 185:34]
        if (2'h0 == _T_21[1:0]) begin // @[SA.scala 186:49]
          accumulated_mat_C_0 <= io_rdata; // @[SA.scala 186:49]
        end
      end
    end
    if (reset) begin // @[SA.scala 77:34]
      accumulated_mat_C_1 <= 32'h0; // @[SA.scala 77:34]
    end else if (reading_accumulated) begin // @[SA.scala 183:28]
      if (read_accumulated >= 3'h1) begin // @[SA.scala 185:34]
        if (2'h1 == _T_21[1:0]) begin // @[SA.scala 186:49]
          accumulated_mat_C_1 <= io_rdata; // @[SA.scala 186:49]
        end
      end
    end
    if (reset) begin // @[SA.scala 77:34]
      accumulated_mat_C_2 <= 32'h0; // @[SA.scala 77:34]
    end else if (reading_accumulated) begin // @[SA.scala 183:28]
      if (read_accumulated >= 3'h1) begin // @[SA.scala 185:34]
        if (2'h2 == _T_21[1:0]) begin // @[SA.scala 186:49]
          accumulated_mat_C_2 <= io_rdata; // @[SA.scala 186:49]
        end
      end
    end
    if (reset) begin // @[SA.scala 77:34]
      accumulated_mat_C_3 <= 32'h0; // @[SA.scala 77:34]
    end else if (reading_accumulated) begin // @[SA.scala 183:28]
      if (read_accumulated >= 3'h1) begin // @[SA.scala 185:34]
        if (2'h3 == _T_21[1:0]) begin // @[SA.scala 186:49]
          accumulated_mat_C_3 <= io_rdata; // @[SA.scala 186:49]
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  weight_cnt = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  input_cnt = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  output_cnt = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  read_accumulated = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  reading_accumulated = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  accumulated_mat_C_0 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  accumulated_mat_C_1 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  accumulated_mat_C_2 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  accumulated_mat_C_3 = _RAND_9[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MMIO_Regfile(
  input         clock,
  input         reset,
  output        io_mmio_ENABLE_OUT,
  output [31:0] io_mmio_MATA_MEM_ADDR,
  output [31:0] io_mmio_MATB_MEM_ADDR,
  output [31:0] io_mmio_MATC_MEM_ADDR,
  output [31:0] io_mmio_MAT_MEM_STRIDE,
  output [31:0] io_mmio_ENABLE_LOAD,
  output [31:0] io_mmio_SRC_INFO,
  output [31:0] io_mmio_DST_INFO,
  output [31:0] io_mmio_SIZE_CFG_INFO,
  input         io_mmio_WEN,
  input         io_mmio_ENABLE_IN,
  input         io_mmio_STATUS_IN,
  input  [31:0] io_raddr,
  output [31:0] io_rdata,
  input         io_wen,
  input  [31:0] io_waddr,
  input  [31:0] io_wdata,
  input         io_complete_write
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] RegFile_0; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_1; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_2; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_3; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_4; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_5; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_6; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_7; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_8; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_9; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_10; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_11; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_12; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_13; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_14; // @[MMIO_Regfile.scala 78:24]
  reg [31:0] RegFile_15; // @[MMIO_Regfile.scala 78:24]
  reg  io_mmio_ENABLE_OUT_REG; // @[MMIO_Regfile.scala 82:36]
  reg [31:0] io_mmio_MATA_MEM_ADDR_REG; // @[MMIO_Regfile.scala 87:36]
  reg [31:0] io_mmio_MATB_MEM_ADDR_REG; // @[MMIO_Regfile.scala 88:36]
  reg [31:0] io_mmio_MATC_MEM_ADDR_REG; // @[MMIO_Regfile.scala 89:36]
  reg [31:0] io_mmio_MAT_MEM_STRIDE_REG; // @[MMIO_Regfile.scala 90:36]
  reg [31:0] io_mmio_ENABLE_LOAD_REG; // @[MMIO_Regfile.scala 92:36]
  reg [31:0] io_mmio_SRC_INFO_REG; // @[MMIO_Regfile.scala 93:36]
  reg [31:0] io_mmio_DST_INFO_REG; // @[MMIO_Regfile.scala 94:36]
  reg [31:0] io_mmio_SIZE_CFG_INFO_REG; // @[MMIO_Regfile.scala 95:36]
  wire [31:0] _GEN_0 = io_mmio_WEN ? {{31'd0}, io_mmio_STATUS_IN} : RegFile_1; // @[MMIO_Regfile.scala 100:16 99:21 78:24]
  wire [31:0] _GEN_1 = io_mmio_WEN ? {{31'd0}, io_mmio_ENABLE_IN} : RegFile_0; // @[MMIO_Regfile.scala 101:16 99:21 78:24]
  wire  _T = io_waddr < 32'h100; // @[MMIO_Regfile.scala 107:17]
  wire [31:0] _GEN_3 = 4'h1 == io_raddr[3:0] ? RegFile_1 : RegFile_0; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_4 = 4'h2 == io_raddr[3:0] ? RegFile_2 : _GEN_3; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_5 = 4'h3 == io_raddr[3:0] ? RegFile_3 : _GEN_4; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_6 = 4'h4 == io_raddr[3:0] ? RegFile_4 : _GEN_5; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_7 = 4'h5 == io_raddr[3:0] ? RegFile_5 : _GEN_6; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_8 = 4'h6 == io_raddr[3:0] ? RegFile_6 : _GEN_7; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_9 = 4'h7 == io_raddr[3:0] ? RegFile_7 : _GEN_8; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_10 = 4'h8 == io_raddr[3:0] ? RegFile_8 : _GEN_9; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_11 = 4'h9 == io_raddr[3:0] ? RegFile_9 : _GEN_10; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_12 = 4'ha == io_raddr[3:0] ? RegFile_10 : _GEN_11; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_13 = 4'hb == io_raddr[3:0] ? RegFile_11 : _GEN_12; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_14 = 4'hc == io_raddr[3:0] ? RegFile_12 : _GEN_13; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_15 = 4'hd == io_raddr[3:0] ? RegFile_13 : _GEN_14; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_16 = 4'he == io_raddr[3:0] ? RegFile_14 : _GEN_15; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _GEN_17 = 4'hf == io_raddr[3:0] ? RegFile_15 : _GEN_16; // @[MMIO_Regfile.scala 108:{14,14}]
  wire [31:0] _T_2 = io_raddr - 32'h100; // @[MMIO_Regfile.scala 111:21]
  wire [31:0] _GEN_18 = 32'h14 == _T_2 ? RegFile_15 : 32'h0; // @[MMIO_Regfile.scala 106:12 111:32 128:18]
  wire [31:0] _GEN_19 = 32'h10 == _T_2 ? RegFile_14 : _GEN_18; // @[MMIO_Regfile.scala 111:32 125:18]
  wire [31:0] _GEN_20 = 32'hc == _T_2 ? RegFile_13 : _GEN_19; // @[MMIO_Regfile.scala 111:32 122:18]
  wire [31:0] _GEN_21 = 32'h8 == _T_2 ? RegFile_12 : _GEN_20; // @[MMIO_Regfile.scala 111:32 119:18]
  wire [31:0] _GEN_22 = 32'h4 == _T_2 ? RegFile_11 : _GEN_21; // @[MMIO_Regfile.scala 111:32 116:18]
  wire [31:0] _GEN_23 = 32'h0 == _T_2 ? RegFile_10 : _GEN_22; // @[MMIO_Regfile.scala 111:32 113:18]
  wire [31:0] _T_15 = io_waddr - 32'h100; // @[MMIO_Regfile.scala 137:23]
  wire [31:0] _GEN_41 = 32'h14 == _T_15 ? io_wdata : RegFile_15; // @[MMIO_Regfile.scala 137:34 154:23 78:24]
  wire [31:0] _GEN_42 = 32'h10 == _T_15 ? io_wdata : RegFile_14; // @[MMIO_Regfile.scala 137:34 151:23 78:24]
  wire [31:0] _GEN_43 = 32'h10 == _T_15 ? RegFile_15 : _GEN_41; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_44 = 32'hc == _T_15 ? io_wdata : RegFile_13; // @[MMIO_Regfile.scala 137:34 148:23 78:24]
  wire [31:0] _GEN_45 = 32'hc == _T_15 ? RegFile_14 : _GEN_42; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_46 = 32'hc == _T_15 ? RegFile_15 : _GEN_43; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_47 = 32'h8 == _T_15 ? io_wdata : RegFile_12; // @[MMIO_Regfile.scala 137:34 145:23 78:24]
  wire [31:0] _GEN_48 = 32'h8 == _T_15 ? RegFile_13 : _GEN_44; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_49 = 32'h8 == _T_15 ? RegFile_14 : _GEN_45; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_50 = 32'h8 == _T_15 ? RegFile_15 : _GEN_46; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_51 = 32'h4 == _T_15 ? io_wdata : RegFile_11; // @[MMIO_Regfile.scala 137:34 142:23 78:24]
  wire [31:0] _GEN_52 = 32'h4 == _T_15 ? RegFile_12 : _GEN_47; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_53 = 32'h4 == _T_15 ? RegFile_13 : _GEN_48; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_54 = 32'h4 == _T_15 ? RegFile_14 : _GEN_49; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_55 = 32'h4 == _T_15 ? RegFile_15 : _GEN_50; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_56 = 32'h0 == _T_15 ? io_wdata : RegFile_10; // @[MMIO_Regfile.scala 137:34 139:23 78:24]
  wire [31:0] _GEN_57 = 32'h0 == _T_15 ? RegFile_11 : _GEN_51; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_58 = 32'h0 == _T_15 ? RegFile_12 : _GEN_52; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_59 = 32'h0 == _T_15 ? RegFile_13 : _GEN_53; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_60 = 32'h0 == _T_15 ? RegFile_14 : _GEN_54; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_61 = 32'h0 == _T_15 ? RegFile_15 : _GEN_55; // @[MMIO_Regfile.scala 137:34 78:24]
  wire [31:0] _GEN_62 = io_complete_write ? 32'h0 : RegFile_10; // @[MMIO_Regfile.scala 158:33 159:19 78:24]
  wire [31:0] _GEN_63 = io_complete_write ? 32'h1 : RegFile_15; // @[MMIO_Regfile.scala 158:33 160:19 78:24]
  assign io_mmio_ENABLE_OUT = io_mmio_ENABLE_OUT_REG; // @[MMIO_Regfile.scala 82:26]
  assign io_mmio_MATA_MEM_ADDR = io_mmio_MATA_MEM_ADDR_REG; // @[MMIO_Regfile.scala 87:26]
  assign io_mmio_MATB_MEM_ADDR = io_mmio_MATB_MEM_ADDR_REG; // @[MMIO_Regfile.scala 88:26]
  assign io_mmio_MATC_MEM_ADDR = io_mmio_MATC_MEM_ADDR_REG; // @[MMIO_Regfile.scala 89:26]
  assign io_mmio_MAT_MEM_STRIDE = io_mmio_MAT_MEM_STRIDE_REG; // @[MMIO_Regfile.scala 90:26]
  assign io_mmio_ENABLE_LOAD = io_mmio_ENABLE_LOAD_REG; // @[MMIO_Regfile.scala 92:26]
  assign io_mmio_SRC_INFO = io_mmio_SRC_INFO_REG; // @[MMIO_Regfile.scala 93:26]
  assign io_mmio_DST_INFO = io_mmio_DST_INFO_REG; // @[MMIO_Regfile.scala 94:26]
  assign io_mmio_SIZE_CFG_INFO = io_mmio_SIZE_CFG_INFO_REG; // @[MMIO_Regfile.scala 95:26]
  assign io_rdata = io_waddr < 32'h100 ? _GEN_17 : _GEN_23; // @[MMIO_Regfile.scala 107:28 108:14]
  always @(posedge clock) begin
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_0 <= 32'h0; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'h0 == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_0 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end else begin
          RegFile_0 <= _GEN_1;
        end
      end else begin
        RegFile_0 <= _GEN_1;
      end
    end else begin
      RegFile_0 <= _GEN_1;
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_1 <= 32'h0; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'h1 == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_1 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end else begin
          RegFile_1 <= _GEN_0;
        end
      end else begin
        RegFile_1 <= _GEN_0;
      end
    end else begin
      RegFile_1 <= _GEN_0;
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_2 <= 32'h30003; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'h2 == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_2 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_3 <= 32'h30003; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'h3 == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_3 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_4 <= 32'h30003; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'h4 == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_4 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_5 <= 32'h0; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'h5 == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_5 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_6 <= 32'h10; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'h6 == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_6 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_7 <= 32'h20; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'h7 == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_7 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_8 <= 32'h10101; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'h8 == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_8 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_9 <= 32'h30; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'h9 == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_9 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_10 <= 32'h0; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'ha == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_10 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end else if (~io_complete_write & io_waddr >= 32'h100) begin // @[MMIO_Regfile.scala 136:58]
        RegFile_10 <= _GEN_56;
      end else begin
        RegFile_10 <= _GEN_62;
      end
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_11 <= 32'h0; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'hb == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_11 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end else if (~io_complete_write & io_waddr >= 32'h100) begin // @[MMIO_Regfile.scala 136:58]
        RegFile_11 <= _GEN_57;
      end
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_12 <= 32'h0; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'hc == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_12 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end else if (~io_complete_write & io_waddr >= 32'h100) begin // @[MMIO_Regfile.scala 136:58]
        RegFile_12 <= _GEN_58;
      end
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_13 <= 32'h0; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'hd == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_13 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end else if (~io_complete_write & io_waddr >= 32'h100) begin // @[MMIO_Regfile.scala 136:58]
        RegFile_13 <= _GEN_59;
      end
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_14 <= 32'h0; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'he == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_14 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end else if (~io_complete_write & io_waddr >= 32'h100) begin // @[MMIO_Regfile.scala 136:58]
        RegFile_14 <= _GEN_60;
      end
    end
    if (reset) begin // @[MMIO_Regfile.scala 78:24]
      RegFile_15 <= 32'h0; // @[MMIO_Regfile.scala 78:24]
    end else if (io_wen) begin // @[MMIO_Regfile.scala 132:16]
      if (_T) begin // @[MMIO_Regfile.scala 133:30]
        if (4'hf == io_waddr[3:0]) begin // @[MMIO_Regfile.scala 134:25]
          RegFile_15 <= io_wdata; // @[MMIO_Regfile.scala 134:25]
        end
      end else if (~io_complete_write & io_waddr >= 32'h100) begin // @[MMIO_Regfile.scala 136:58]
        RegFile_15 <= _GEN_61;
      end else begin
        RegFile_15 <= _GEN_63;
      end
    end
    io_mmio_ENABLE_OUT_REG <= RegFile_0[0]; // @[MMIO_Regfile.scala 82:47]
    io_mmio_MATA_MEM_ADDR_REG <= RegFile_5; // @[MMIO_Regfile.scala 87:36]
    io_mmio_MATB_MEM_ADDR_REG <= RegFile_6; // @[MMIO_Regfile.scala 88:36]
    io_mmio_MATC_MEM_ADDR_REG <= RegFile_7; // @[MMIO_Regfile.scala 89:36]
    io_mmio_MAT_MEM_STRIDE_REG <= RegFile_8; // @[MMIO_Regfile.scala 90:36]
    io_mmio_ENABLE_LOAD_REG <= RegFile_10; // @[MMIO_Regfile.scala 92:36]
    io_mmio_SRC_INFO_REG <= RegFile_11; // @[MMIO_Regfile.scala 93:36]
    io_mmio_DST_INFO_REG <= RegFile_12; // @[MMIO_Regfile.scala 94:36]
    io_mmio_SIZE_CFG_INFO_REG <= RegFile_13; // @[MMIO_Regfile.scala 95:36]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  RegFile_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  RegFile_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  RegFile_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  RegFile_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  RegFile_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  RegFile_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  RegFile_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  RegFile_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  RegFile_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  RegFile_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  RegFile_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  RegFile_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  RegFile_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  RegFile_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  RegFile_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  RegFile_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  io_mmio_ENABLE_OUT_REG = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  io_mmio_MATA_MEM_ADDR_REG = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  io_mmio_MATB_MEM_ADDR_REG = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  io_mmio_MATC_MEM_ADDR_REG = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  io_mmio_MAT_MEM_STRIDE_REG = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  io_mmio_ENABLE_LOAD_REG = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  io_mmio_SRC_INFO_REG = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  io_mmio_DST_INFO_REG = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  io_mmio_SIZE_CFG_INFO_REG = _RAND_24[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module LocalMem(
  input         clock,
  input  [31:0] io_raddr,
  output [31:0] io_rdata,
  input         io_wen,
  input  [31:0] io_waddr,
  input  [31:0] io_wdata,
  input  [3:0]  io_wstrb
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] localMem [0:32767]; // @[LocalMem.scala 34:29]
  wire  localMem_io_rdata_MPORT_en; // @[LocalMem.scala 34:29]
  wire [14:0] localMem_io_rdata_MPORT_addr; // @[LocalMem.scala 34:29]
  wire [31:0] localMem_io_rdata_MPORT_data; // @[LocalMem.scala 34:29]
  wire [31:0] localMem_MPORT_data; // @[LocalMem.scala 34:29]
  wire [14:0] localMem_MPORT_addr; // @[LocalMem.scala 34:29]
  wire  localMem_MPORT_mask; // @[LocalMem.scala 34:29]
  wire  localMem_MPORT_en; // @[LocalMem.scala 34:29]
  reg  localMem_io_rdata_MPORT_en_pipe_0;
  reg [14:0] localMem_io_rdata_MPORT_addr_pipe_0;
  wire [29:0] raddr_aligned = io_raddr[31:2]; // @[LocalMem.scala 40:44]
  wire [29:0] waddr_aligned = io_waddr[31:2]; // @[LocalMem.scala 41:44]
  wire [7:0] wdata_mask_0 = io_wstrb[0] ? io_wdata[7:0] : 8'h0; // @[LocalMem.scala 53:31]
  wire [7:0] wdata_mask_1 = io_wstrb[1] ? io_wdata[15:8] : 8'h0; // @[LocalMem.scala 53:31]
  wire [7:0] wdata_mask_2 = io_wstrb[2] ? io_wdata[23:16] : 8'h0; // @[LocalMem.scala 53:31]
  wire [7:0] wdata_mask_3 = io_wstrb[3] ? io_wdata[31:24] : 8'h0; // @[LocalMem.scala 53:31]
  wire [15:0] lo = {wdata_mask_1,wdata_mask_0}; // @[LocalMem.scala 60:54]
  wire [15:0] hi = {wdata_mask_3,wdata_mask_2}; // @[LocalMem.scala 60:54]
  assign localMem_io_rdata_MPORT_en = localMem_io_rdata_MPORT_en_pipe_0;
  assign localMem_io_rdata_MPORT_addr = localMem_io_rdata_MPORT_addr_pipe_0;
  assign localMem_io_rdata_MPORT_data = localMem[localMem_io_rdata_MPORT_addr]; // @[LocalMem.scala 34:29]
  assign localMem_MPORT_data = {hi,lo};
  assign localMem_MPORT_addr = waddr_aligned[14:0];
  assign localMem_MPORT_mask = 1'h1;
  assign localMem_MPORT_en = io_wen;
  assign io_rdata = localMem_io_rdata_MPORT_data; // @[LocalMem.scala 47:12]
  always @(posedge clock) begin
    if (localMem_MPORT_en & localMem_MPORT_mask) begin
      localMem[localMem_MPORT_addr] <= localMem_MPORT_data; // @[LocalMem.scala 34:29]
    end
    localMem_io_rdata_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      localMem_io_rdata_MPORT_addr_pipe_0 <= raddr_aligned[14:0];
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32768; initvar = initvar+1)
    localMem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  localMem_io_rdata_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  localMem_io_rdata_MPORT_addr_pipe_0 = _RAND_2[14:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Memory_Mapped(
  input         clock,
  input         reset,
  output        io_slave_aw_ready,
  input         io_slave_aw_valid,
  input  [31:0] io_slave_aw_bits_addr,
  output        io_slave_w_ready,
  input         io_slave_w_valid,
  input  [31:0] io_slave_w_bits_data,
  input  [3:0]  io_slave_w_bits_strb,
  output        io_slave_b_valid,
  output        io_slave_ar_ready,
  input         io_slave_ar_valid,
  input  [31:0] io_slave_ar_bits_addr,
  output        io_slave_r_valid,
  output [31:0] io_slave_r_bits_data,
  output        io_tb_slave_ar_ready,
  input  [31:0] io_tb_slave_ar_bits_addr,
  output        io_tb_slave_r_valid,
  output [31:0] io_tb_slave_r_bits_data,
  input         io_tb_en,
  input         io_master_aw_ready,
  output        io_master_aw_valid,
  output [31:0] io_master_aw_bits_addr,
  input         io_master_w_ready,
  output        io_master_w_valid,
  output [31:0] io_master_w_bits_data,
  output [3:0]  io_master_w_bits_strb,
  output        io_master_b_ready,
  input         io_master_b_valid,
  input         io_master_ar_ready,
  output        io_master_ar_valid,
  output [31:0] io_master_ar_bits_addr,
  output        io_master_r_ready,
  input         io_master_r_valid,
  input  [31:0] io_master_r_bits_data,
  output        io_mmio_ENABLE_OUT,
  output [31:0] io_mmio_MATA_MEM_ADDR,
  output [31:0] io_mmio_MATB_MEM_ADDR,
  output [31:0] io_mmio_MATC_MEM_ADDR,
  output [31:0] io_mmio_MAT_MEM_STRIDE,
  output [31:0] io_mmio_ENABLE_LOAD,
  output [31:0] io_mmio_SRC_INFO,
  output [31:0] io_mmio_DST_INFO,
  output [31:0] io_mmio_SIZE_CFG_INFO,
  input         io_mmio_WEN,
  input         io_mmio_ENABLE_IN,
  input         io_mmio_STATUS_IN,
  input  [31:0] io_raddr,
  output [31:0] io_rdata,
  input         io_wen,
  input  [31:0] io_waddr,
  input  [31:0] io_wdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
`endif // RANDOMIZE_REG_INIT
  wire  rf_clock; // @[Memory_Mapped.scala 42:18]
  wire  rf_reset; // @[Memory_Mapped.scala 42:18]
  wire  rf_io_mmio_ENABLE_OUT; // @[Memory_Mapped.scala 42:18]
  wire [31:0] rf_io_mmio_MATA_MEM_ADDR; // @[Memory_Mapped.scala 42:18]
  wire [31:0] rf_io_mmio_MATB_MEM_ADDR; // @[Memory_Mapped.scala 42:18]
  wire [31:0] rf_io_mmio_MATC_MEM_ADDR; // @[Memory_Mapped.scala 42:18]
  wire [31:0] rf_io_mmio_MAT_MEM_STRIDE; // @[Memory_Mapped.scala 42:18]
  wire [31:0] rf_io_mmio_ENABLE_LOAD; // @[Memory_Mapped.scala 42:18]
  wire [31:0] rf_io_mmio_SRC_INFO; // @[Memory_Mapped.scala 42:18]
  wire [31:0] rf_io_mmio_DST_INFO; // @[Memory_Mapped.scala 42:18]
  wire [31:0] rf_io_mmio_SIZE_CFG_INFO; // @[Memory_Mapped.scala 42:18]
  wire  rf_io_mmio_WEN; // @[Memory_Mapped.scala 42:18]
  wire  rf_io_mmio_ENABLE_IN; // @[Memory_Mapped.scala 42:18]
  wire  rf_io_mmio_STATUS_IN; // @[Memory_Mapped.scala 42:18]
  wire [31:0] rf_io_raddr; // @[Memory_Mapped.scala 42:18]
  wire [31:0] rf_io_rdata; // @[Memory_Mapped.scala 42:18]
  wire  rf_io_wen; // @[Memory_Mapped.scala 42:18]
  wire [31:0] rf_io_waddr; // @[Memory_Mapped.scala 42:18]
  wire [31:0] rf_io_wdata; // @[Memory_Mapped.scala 42:18]
  wire  rf_io_complete_write; // @[Memory_Mapped.scala 42:18]
  wire  lm_clock; // @[Memory_Mapped.scala 43:18]
  wire [31:0] lm_io_raddr; // @[Memory_Mapped.scala 43:18]
  wire [31:0] lm_io_rdata; // @[Memory_Mapped.scala 43:18]
  wire  lm_io_wen; // @[Memory_Mapped.scala 43:18]
  wire [31:0] lm_io_waddr; // @[Memory_Mapped.scala 43:18]
  wire [31:0] lm_io_wdata; // @[Memory_Mapped.scala 43:18]
  wire [3:0] lm_io_wstrb; // @[Memory_Mapped.scala 43:18]
  reg [31:0] RAReg; // @[Memory_Mapped.scala 87:27]
  reg  RAReadyReg; // @[Memory_Mapped.scala 88:27]
  reg [31:0] RDReg; // @[Memory_Mapped.scala 89:27]
  reg  RDValidReg; // @[Memory_Mapped.scala 91:27]
  wire  canDoRead = io_slave_ar_valid & ~RAReadyReg; // @[Memory_Mapped.scala 95:49]
  reg  DoRead; // @[Memory_Mapped.scala 97:23]
  reg [31:0] WAReg; // @[Memory_Mapped.scala 101:27]
  reg  WAReadyReg; // @[Memory_Mapped.scala 102:27]
  reg [31:0] WDReg; // @[Memory_Mapped.scala 103:27]
  reg [3:0] WSReg; // @[Memory_Mapped.scala 104:27]
  reg  WDReadyReg; // @[Memory_Mapped.scala 105:27]
  reg  WRValidReg; // @[Memory_Mapped.scala 106:27]
  wire  _canDoWrite_T_3 = io_slave_w_valid & ~WDReadyReg; // @[Memory_Mapped.scala 112:25]
  wire  canDoWrite = io_slave_aw_valid & ~WAReadyReg & _canDoWrite_T_3; // @[Memory_Mapped.scala 111:40]
  wire  _DoWrite_T_1 = io_slave_w_valid & io_slave_w_ready; // @[Memory_Mapped.scala 118:25]
  wire  DoWrite = io_slave_aw_valid & io_slave_aw_ready & _DoWrite_T_1; // @[Memory_Mapped.scala 117:46]
  wire [31:0] _T_2 = RAReg - 32'h100000; // @[Memory_Mapped.scala 136:17]
  wire  _rf_io_raddr_T_1 = RAReg < 32'h200000; // @[Memory_Mapped.scala 138:60]
  wire  _rf_io_raddr_T_2 = 32'h100000 <= RAReg & RAReg < 32'h200000; // @[Memory_Mapped.scala 138:51]
  wire [29:0] _rf_io_raddr_T_6 = _rf_io_raddr_T_2 ? _T_2[31:2] : 30'h0; // @[Memory_Mapped.scala 137:25]
  wire [31:0] _GEN_0 = _T_2 < 32'h100 ? {{2'd0}, _rf_io_raddr_T_6} : _T_2; // @[Memory_Mapped.scala 136:63 137:19 144:19]
  wire [31:0] _lm_io_raddr_T_2 = RAReg - 32'h200000; // @[Memory_Mapped.scala 147:75]
  wire [31:0] _lm_io_raddr_T_3 = 32'h200000 <= RAReg ? _lm_io_raddr_T_2 : 32'h0; // @[Memory_Mapped.scala 147:23]
  wire [63:0] _RDReg_T = {32'h0,rf_io_rdata}; // @[Cat.scala 33:92]
  wire [63:0] _RDReg_T_1 = DoRead ? _RDReg_T : 64'h0; // @[Memory_Mapped.scala 158:19]
  wire [31:0] _RDReg_T_2 = DoRead ? lm_io_rdata : 32'h0; // @[Memory_Mapped.scala 160:19]
  wire [63:0] _GEN_1 = _rf_io_raddr_T_1 ? _RDReg_T_1 : {{32'd0}, _RDReg_T_2}; // @[Memory_Mapped.scala 157:51 158:13 160:13]
  wire  _T_5 = io_slave_aw_bits_addr < 32'h200000; // @[Memory_Mapped.scala 175:34]
  wire [31:0] _T_7 = io_slave_aw_bits_addr - 32'h100000; // @[Memory_Mapped.scala 175:94]
  wire [31:0] _rf_io_waddr_T_1 = WAReg - 32'h100000; // @[Memory_Mapped.scala 176:31]
  wire [31:0] _GEN_2 = io_slave_aw_bits_addr < 32'h200000 & _T_7 < 32'h100 ? {{2'd0}, _rf_io_waddr_T_1[31:2]} :
    _rf_io_waddr_T_1; // @[Memory_Mapped.scala 175:140 176:21 179:21]
  wire [31:0] _lm_io_waddr_T_1 = WAReg - 32'h200000; // @[Memory_Mapped.scala 181:28]
  wire  _lm_io_wen_T_1 = _T_5 ? 1'h0 : 1'h1; // @[Memory_Mapped.scala 189:23]
  wire [31:0] _GEN_3 = DoWrite ? _GEN_2 : 32'h0; // @[Memory_Mapped.scala 174:19 71:15]
  wire [31:0] _GEN_4 = DoWrite ? _lm_io_waddr_T_1 : 32'h0; // @[Memory_Mapped.scala 174:19 181:19 78:15]
  wire [31:0] _GEN_5 = DoWrite ? WDReg : 32'h0; // @[Memory_Mapped.scala 174:19 183:19 72:15]
  wire [3:0] _GEN_7 = DoWrite ? WSReg : 4'h0; // @[Memory_Mapped.scala 174:19 186:19 80:15]
  wire  _GEN_8 = DoWrite & _T_5; // @[Memory_Mapped.scala 174:19 188:17 73:15]
  wire  _GEN_9 = DoWrite & _lm_io_wen_T_1; // @[Memory_Mapped.scala 174:19 189:17 81:15]
  wire  _GEN_10 = ~io_mmio_ENABLE_OUT & canDoRead; // @[Memory_Mapped.scala 129:29 131:29 198:16]
  wire [31:0] _GEN_14 = ~io_mmio_ENABLE_OUT ? _lm_io_raddr_T_3 : io_raddr; // @[Memory_Mapped.scala 129:29 147:17 208:17]
  wire  _GEN_15 = ~io_mmio_ENABLE_OUT & DoRead; // @[Memory_Mapped.scala 129:29 150:16 200:16]
  wire [63:0] _GEN_19 = ~io_mmio_ENABLE_OUT ? _GEN_1 : 64'h0; // @[Memory_Mapped.scala 129:29 199:16]
  wire  _GEN_20 = ~io_mmio_ENABLE_OUT & canDoWrite; // @[Memory_Mapped.scala 129:29 164:16 202:16]
  wire [31:0] _GEN_26 = ~io_mmio_ENABLE_OUT ? _GEN_3 : 32'h0; // @[Memory_Mapped.scala 129:29 71:15]
  wire [31:0] _GEN_28 = ~io_mmio_ENABLE_OUT ? _GEN_5 : 32'h0; // @[Memory_Mapped.scala 129:29 72:15]
  wire  _GEN_31 = ~io_mmio_ENABLE_OUT & _GEN_8; // @[Memory_Mapped.scala 129:29 73:15]
  wire  _GEN_33 = ~io_mmio_ENABLE_OUT & (DoWrite & ~WRValidReg); // @[Memory_Mapped.scala 129:29 192:30 205:16]
  reg [2:0] mState; // @[Memory_Mapped.scala 245:24]
  reg  mWriteAddrSent; // @[Memory_Mapped.scala 246:31]
  reg  mWriteDataSent; // @[Memory_Mapped.scala 247:31]
  reg [31:0] data_buffer; // @[Memory_Mapped.scala 256:28]
  reg [1:0] source_offset; // @[Memory_Mapped.scala 259:30]
  wire [1:0] dest_offset = io_master_aw_bits_addr[1:0]; // @[Memory_Mapped.scala 261:55]
  reg [31:0] request_counter; // @[Memory_Mapped.scala 264:32]
  wire  _io_master_aw_valid_T = mState == 3'h3; // @[Memory_Mapped.scala 266:38]
  wire  _io_master_ar_valid_T = mState == 3'h1; // @[Memory_Mapped.scala 278:38]
  wire  _io_master_r_ready_T = mState == 3'h2; // @[Memory_Mapped.scala 295:31]
  wire  _io_master_b_ready_T = mState == 3'h4; // @[Memory_Mapped.scala 297:31]
  wire [2:0] _GEN_44 = io_master_r_valid ? 3'h3 : mState; // @[Memory_Mapped.scala 310:31 311:16 245:24]
  wire [2:0] _GEN_45 = mWriteAddrSent & mWriteDataSent ? 3'h4 : mState; // @[Memory_Mapped.scala 315:46 316:16 245:24]
  wire [2:0] _GEN_46 = io_master_b_valid ? 3'h0 : mState; // @[Memory_Mapped.scala 320:31 321:16 245:24]
  wire [2:0] _GEN_47 = 3'h4 == mState ? _GEN_46 : mState; // @[Memory_Mapped.scala 298:18 245:24]
  wire [2:0] _GEN_48 = 3'h3 == mState ? _GEN_45 : _GEN_47; // @[Memory_Mapped.scala 298:18]
  wire  _T_18 = io_master_aw_ready & io_master_aw_valid; // @[Decoupled.scala 52:35]
  wire [31:0] _request_counter_T_1 = request_counter + 32'h1; // @[Memory_Mapped.scala 328:42]
  wire [39:0] _io_master_ar_bits_addr_T_1 = request_counter * io_mmio_SIZE_CFG_INFO[31:24]; // @[Memory_Mapped.scala 333:67]
  wire [39:0] _GEN_82 = {{8'd0}, io_mmio_SRC_INFO}; // @[Memory_Mapped.scala 333:48]
  wire [39:0] _io_master_ar_bits_addr_T_3 = _GEN_82 + _io_master_ar_bits_addr_T_1; // @[Memory_Mapped.scala 333:48]
  wire [39:0] _GEN_54 = _io_master_ar_valid_T ? _io_master_ar_bits_addr_T_3 : 40'h0; // @[Memory_Mapped.scala 279:28 332:30 333:28]
  wire [39:0] _io_master_aw_bits_addr_T_1 = request_counter * io_mmio_SIZE_CFG_INFO[23:16]; // @[Memory_Mapped.scala 338:65]
  wire [39:0] _GEN_83 = {{8'd0}, io_mmio_DST_INFO}; // @[Memory_Mapped.scala 338:46]
  wire [39:0] _io_master_aw_bits_addr_T_3 = _GEN_83 + _io_master_aw_bits_addr_T_1; // @[Memory_Mapped.scala 338:46]
  wire [3:0] _mask_width_T_2 = 8'h1 == io_mmio_SIZE_CFG_INFO[15:8] ? 4'h1 : 4'hf; // @[Mux.scala 81:58]
  wire [3:0] _mask_width_T_4 = 8'h2 == io_mmio_SIZE_CFG_INFO[15:8] ? 4'h3 : _mask_width_T_2; // @[Mux.scala 81:58]
  wire [3:0] _mask_width_T_6 = 8'h3 == io_mmio_SIZE_CFG_INFO[15:8] ? 4'h7 : _mask_width_T_4; // @[Mux.scala 81:58]
  wire [3:0] _mask_width_T_8 = 8'h4 == io_mmio_SIZE_CFG_INFO[15:8] ? 4'hf : _mask_width_T_6; // @[Mux.scala 81:58]
  wire [3:0] _GEN_57 = _io_master_aw_valid_T ? _mask_width_T_8 : 4'h0; // @[Memory_Mapped.scala 337:31 339:16]
  wire [3:0] mask_width = _io_master_r_ready_T & io_master_r_valid ? _mask_width_T_8 : _GEN_57; // @[Memory_Mapped.scala 350:51 351:16]
  wire [6:0] _GEN_6 = {{3'd0}, mask_width}; // @[Memory_Mapped.scala 345:41]
  wire [6:0] _io_master_w_bits_strb_T = _GEN_6 << dest_offset; // @[Memory_Mapped.scala 345:41]
  wire [4:0] _io_master_w_bits_data_T = {dest_offset, 3'h0}; // @[Memory_Mapped.scala 346:58]
  wire [62:0] _GEN_11 = {{31'd0}, data_buffer}; // @[Memory_Mapped.scala 346:42]
  wire [62:0] _io_master_w_bits_data_T_1 = _GEN_11 << _io_master_w_bits_data_T; // @[Memory_Mapped.scala 346:42]
  wire [39:0] _GEN_56 = _io_master_aw_valid_T ? _io_master_aw_bits_addr_T_3 : 40'h0; // @[Memory_Mapped.scala 267:28 337:31 338:28]
  wire [6:0] _GEN_58 = _io_master_aw_valid_T ? _io_master_w_bits_strb_T : 7'hf; // @[Memory_Mapped.scala 292:25 337:31 345:27]
  wire [62:0] _GEN_59 = _io_master_aw_valid_T ? _io_master_w_bits_data_T_1 : {{31'd0}, data_buffer}; // @[Memory_Mapped.scala 291:25 337:31 346:27]
  wire [6:0] _GEN_13 = {{3'd0}, mask_width}; // @[Memory_Mapped.scala 357:30]
  wire [6:0] _rData_mask_T = _GEN_13 << source_offset; // @[Memory_Mapped.scala 357:30]
  wire [6:0] _GEN_65 = _io_master_r_ready_T & io_master_r_valid ? _rData_mask_T : 7'h0; // @[Memory_Mapped.scala 350:51 357:16]
  wire [3:0] rData_mask = _GEN_65[3:0];
  wire [7:0] _GEN_60 = rData_mask[0] ? io_master_r_bits_data[7:0] : 8'h0; // @[Memory_Mapped.scala 359:35 360:18 363:18]
  wire [7:0] _GEN_61 = rData_mask[1] ? io_master_r_bits_data[15:8] : 8'h0; // @[Memory_Mapped.scala 359:35 360:18 363:18]
  wire [7:0] _GEN_62 = rData_mask[2] ? io_master_r_bits_data[23:16] : 8'h0; // @[Memory_Mapped.scala 359:35 360:18 363:18]
  wire [7:0] _GEN_63 = rData_mask[3] ? io_master_r_bits_data[31:24] : 8'h0; // @[Memory_Mapped.scala 359:35 360:18 363:18]
  wire [7:0] rData_1 = _io_master_r_ready_T & io_master_r_valid ? _GEN_61 : 8'h0; // @[Memory_Mapped.scala 350:51]
  wire [7:0] rData_0 = _io_master_r_ready_T & io_master_r_valid ? _GEN_60 : 8'h0; // @[Memory_Mapped.scala 350:51]
  wire [7:0] rData_3 = _io_master_r_ready_T & io_master_r_valid ? _GEN_63 : 8'h0; // @[Memory_Mapped.scala 350:51]
  wire [7:0] rData_2 = _io_master_r_ready_T & io_master_r_valid ? _GEN_62 : 8'h0; // @[Memory_Mapped.scala 350:51]
  wire [31:0] _data_buffer_T = {rData_3,rData_2,rData_1,rData_0}; // @[Memory_Mapped.scala 366:26]
  wire [4:0] _data_buffer_T_1 = {source_offset, 3'h0}; // @[Memory_Mapped.scala 366:51]
  wire [31:0] _data_buffer_T_2 = _data_buffer_T >> _data_buffer_T_1; // @[Memory_Mapped.scala 366:33]
  wire [31:0] _GEN_84 = {{24'd0}, io_mmio_SIZE_CFG_INFO[7:0]}; // @[Memory_Mapped.scala 369:49]
  wire  _GEN_78 = io_master_w_ready | mWriteDataSent; // @[Memory_Mapped.scala 379:29 380:22 247:31]
  wire  _GEN_79 = io_master_aw_ready | mWriteAddrSent; // @[Memory_Mapped.scala 382:30 383:22 246:31]
  wire  _GEN_80 = _io_master_aw_valid_T & _GEN_78; // @[Memory_Mapped.scala 378:31 387:20]
  wire  _GEN_81 = _io_master_aw_valid_T & _GEN_79; // @[Memory_Mapped.scala 378:31 386:20]
  wire [63:0] _GEN_85 = reset ? 64'h0 : _GEN_19; // @[Memory_Mapped.scala 89:{27,27}]
  MMIO_Regfile rf ( // @[Memory_Mapped.scala 42:18]
    .clock(rf_clock),
    .reset(rf_reset),
    .io_mmio_ENABLE_OUT(rf_io_mmio_ENABLE_OUT),
    .io_mmio_MATA_MEM_ADDR(rf_io_mmio_MATA_MEM_ADDR),
    .io_mmio_MATB_MEM_ADDR(rf_io_mmio_MATB_MEM_ADDR),
    .io_mmio_MATC_MEM_ADDR(rf_io_mmio_MATC_MEM_ADDR),
    .io_mmio_MAT_MEM_STRIDE(rf_io_mmio_MAT_MEM_STRIDE),
    .io_mmio_ENABLE_LOAD(rf_io_mmio_ENABLE_LOAD),
    .io_mmio_SRC_INFO(rf_io_mmio_SRC_INFO),
    .io_mmio_DST_INFO(rf_io_mmio_DST_INFO),
    .io_mmio_SIZE_CFG_INFO(rf_io_mmio_SIZE_CFG_INFO),
    .io_mmio_WEN(rf_io_mmio_WEN),
    .io_mmio_ENABLE_IN(rf_io_mmio_ENABLE_IN),
    .io_mmio_STATUS_IN(rf_io_mmio_STATUS_IN),
    .io_raddr(rf_io_raddr),
    .io_rdata(rf_io_rdata),
    .io_wen(rf_io_wen),
    .io_waddr(rf_io_waddr),
    .io_wdata(rf_io_wdata),
    .io_complete_write(rf_io_complete_write)
  );
  LocalMem lm ( // @[Memory_Mapped.scala 43:18]
    .clock(lm_clock),
    .io_raddr(lm_io_raddr),
    .io_rdata(lm_io_rdata),
    .io_wen(lm_io_wen),
    .io_waddr(lm_io_waddr),
    .io_wdata(lm_io_wdata),
    .io_wstrb(lm_io_wstrb)
  );
  assign io_slave_aw_ready = ~io_mmio_ENABLE_OUT & WAReadyReg; // @[Memory_Mapped.scala 129:29 167:23 60:21]
  assign io_slave_w_ready = ~io_mmio_ENABLE_OUT & WDReadyReg; // @[Memory_Mapped.scala 129:29 168:23 62:20]
  assign io_slave_b_valid = ~io_mmio_ENABLE_OUT & WRValidReg; // @[Memory_Mapped.scala 129:29 193:30 64:24]
  assign io_slave_ar_ready = ~io_mmio_ENABLE_OUT & RAReadyReg; // @[Memory_Mapped.scala 129:29 132:29 50:23]
  assign io_slave_r_valid = ~io_mmio_ENABLE_OUT & RDValidReg; // @[Memory_Mapped.scala 129:29 153:26 52:24]
  assign io_slave_r_bits_data = ~io_mmio_ENABLE_OUT ? RDReg : 32'h0; // @[Memory_Mapped.scala 129:29 154:26 54:24]
  assign io_tb_slave_ar_ready = io_tb_en; // @[Memory_Mapped.scala 236:17 224:24 237:26]
  assign io_tb_slave_r_valid = io_tb_en; // @[Memory_Mapped.scala 225:23]
  assign io_tb_slave_r_bits_data = io_tb_en ? lm_io_rdata : 32'h0; // @[Memory_Mapped.scala 236:17 229:27 239:29]
  assign io_master_aw_valid = mState == 3'h3 & ~mWriteAddrSent; // @[Memory_Mapped.scala 266:53]
  assign io_master_aw_bits_addr = _GEN_56[31:0];
  assign io_master_w_valid = _io_master_aw_valid_T & ~mWriteDataSent; // @[Memory_Mapped.scala 290:50]
  assign io_master_w_bits_data = _GEN_59[31:0];
  assign io_master_w_bits_strb = _GEN_58[3:0];
  assign io_master_b_ready = mState == 3'h4; // @[Memory_Mapped.scala 297:31]
  assign io_master_ar_valid = mState == 3'h1; // @[Memory_Mapped.scala 278:38]
  assign io_master_ar_bits_addr = _GEN_54[31:0];
  assign io_master_r_ready = mState == 3'h2; // @[Memory_Mapped.scala 295:31]
  assign io_mmio_ENABLE_OUT = rf_io_mmio_ENABLE_OUT; // @[Memory_Mapped.scala 69:14]
  assign io_mmio_MATA_MEM_ADDR = rf_io_mmio_MATA_MEM_ADDR; // @[Memory_Mapped.scala 69:14]
  assign io_mmio_MATB_MEM_ADDR = rf_io_mmio_MATB_MEM_ADDR; // @[Memory_Mapped.scala 69:14]
  assign io_mmio_MATC_MEM_ADDR = rf_io_mmio_MATC_MEM_ADDR; // @[Memory_Mapped.scala 69:14]
  assign io_mmio_MAT_MEM_STRIDE = rf_io_mmio_MAT_MEM_STRIDE; // @[Memory_Mapped.scala 69:14]
  assign io_mmio_ENABLE_LOAD = _io_master_b_ready_T & request_counter == _GEN_84 ? 32'h0 : rf_io_mmio_ENABLE_LOAD; // @[Memory_Mapped.scala 369:73 371:17 69:14]
  assign io_mmio_SRC_INFO = rf_io_mmio_SRC_INFO; // @[Memory_Mapped.scala 69:14]
  assign io_mmio_DST_INFO = rf_io_mmio_DST_INFO; // @[Memory_Mapped.scala 69:14]
  assign io_mmio_SIZE_CFG_INFO = rf_io_mmio_SIZE_CFG_INFO; // @[Memory_Mapped.scala 69:14]
  assign io_rdata = ~io_mmio_ENABLE_OUT ? 32'h0 : lm_io_rdata; // @[Memory_Mapped.scala 129:29 84:12 209:17]
  assign rf_clock = clock;
  assign rf_reset = reset;
  assign rf_io_mmio_WEN = io_mmio_WEN; // @[Memory_Mapped.scala 129:29 69:14 218:26]
  assign rf_io_mmio_ENABLE_IN = io_mmio_ENABLE_IN; // @[Memory_Mapped.scala 129:29 69:14 219:26]
  assign rf_io_mmio_STATUS_IN = io_mmio_STATUS_IN; // @[Memory_Mapped.scala 129:29 69:14 220:26]
  assign rf_io_raddr = ~io_mmio_ENABLE_OUT ? _GEN_0 : 32'h0; // @[Memory_Mapped.scala 129:29 70:15]
  assign rf_io_wen = _io_master_b_ready_T & request_counter == _GEN_84 | _GEN_31; // @[Memory_Mapped.scala 369:73 374:15]
  assign rf_io_waddr = _io_master_b_ready_T & request_counter == _GEN_84 ? 32'h114 : _GEN_26; // @[Memory_Mapped.scala 369:73 375:17]
  assign rf_io_wdata = _io_master_b_ready_T & request_counter == _GEN_84 ? 32'h1 : _GEN_28; // @[Memory_Mapped.scala 369:73 376:17]
  assign rf_io_complete_write = _io_master_b_ready_T & request_counter == _GEN_84; // @[Memory_Mapped.scala 369:30]
  assign lm_clock = clock;
  assign lm_io_raddr = io_tb_en ? io_tb_slave_ar_bits_addr : _GEN_14; // @[Memory_Mapped.scala 236:17 238:17]
  assign lm_io_wen = ~io_mmio_ENABLE_OUT ? _GEN_9 : io_wen; // @[Memory_Mapped.scala 129:29 215:17]
  assign lm_io_waddr = ~io_mmio_ENABLE_OUT ? _GEN_4 : io_waddr; // @[Memory_Mapped.scala 129:29 212:17]
  assign lm_io_wdata = ~io_mmio_ENABLE_OUT ? _GEN_5 : io_wdata; // @[Memory_Mapped.scala 129:29 213:17]
  assign lm_io_wstrb = ~io_mmio_ENABLE_OUT ? _GEN_7 : 4'hf; // @[Memory_Mapped.scala 129:29 214:17]
  always @(posedge clock) begin
    if (reset) begin // @[Memory_Mapped.scala 87:27]
      RAReg <= 32'h0; // @[Memory_Mapped.scala 87:27]
    end else if (~io_mmio_ENABLE_OUT) begin // @[Memory_Mapped.scala 129:29]
      if (canDoRead) begin // @[Memory_Mapped.scala 133:35]
        RAReg <= io_slave_ar_bits_addr;
      end
    end else begin
      RAReg <= 32'h0; // @[Memory_Mapped.scala 197:16]
    end
    if (reset) begin // @[Memory_Mapped.scala 88:27]
      RAReadyReg <= 1'h0; // @[Memory_Mapped.scala 88:27]
    end else begin
      RAReadyReg <= _GEN_10;
    end
    RDReg <= _GEN_85[31:0]; // @[Memory_Mapped.scala 89:{27,27}]
    if (reset) begin // @[Memory_Mapped.scala 91:27]
      RDValidReg <= 1'h0; // @[Memory_Mapped.scala 91:27]
    end else begin
      RDValidReg <= _GEN_15;
    end
    DoRead <= io_slave_ar_valid & io_slave_ar_ready & ~RDValidReg; // @[Memory_Mapped.scala 97:63]
    if (reset) begin // @[Memory_Mapped.scala 101:27]
      WAReg <= 32'h0; // @[Memory_Mapped.scala 101:27]
    end else if (~io_mmio_ENABLE_OUT) begin // @[Memory_Mapped.scala 129:29]
      if (canDoWrite) begin // @[Memory_Mapped.scala 170:17]
        WAReg <= io_slave_aw_bits_addr;
      end else begin
        WAReg <= 32'h0;
      end
    end else begin
      WAReg <= 32'h0; // @[Memory_Mapped.scala 201:16]
    end
    if (reset) begin // @[Memory_Mapped.scala 102:27]
      WAReadyReg <= 1'h0; // @[Memory_Mapped.scala 102:27]
    end else begin
      WAReadyReg <= _GEN_20;
    end
    if (reset) begin // @[Memory_Mapped.scala 103:27]
      WDReg <= 32'h0; // @[Memory_Mapped.scala 103:27]
    end else if (~io_mmio_ENABLE_OUT) begin // @[Memory_Mapped.scala 129:29]
      if (canDoWrite) begin // @[Memory_Mapped.scala 171:17]
        WDReg <= io_slave_w_bits_data;
      end else begin
        WDReg <= 32'h0;
      end
    end else begin
      WDReg <= 32'h0; // @[Memory_Mapped.scala 203:16]
    end
    if (reset) begin // @[Memory_Mapped.scala 104:27]
      WSReg <= 4'h0; // @[Memory_Mapped.scala 104:27]
    end else if (~io_mmio_ENABLE_OUT) begin // @[Memory_Mapped.scala 129:29]
      if (canDoWrite) begin // @[Memory_Mapped.scala 172:17]
        WSReg <= io_slave_w_bits_strb;
      end else begin
        WSReg <= 4'h0;
      end
    end
    if (reset) begin // @[Memory_Mapped.scala 105:27]
      WDReadyReg <= 1'h0; // @[Memory_Mapped.scala 105:27]
    end else begin
      WDReadyReg <= _GEN_20;
    end
    if (reset) begin // @[Memory_Mapped.scala 106:27]
      WRValidReg <= 1'h0; // @[Memory_Mapped.scala 106:27]
    end else begin
      WRValidReg <= _GEN_33;
    end
    if (reset) begin // @[Memory_Mapped.scala 245:24]
      mState <= 3'h0; // @[Memory_Mapped.scala 245:24]
    end else if (3'h0 == mState) begin // @[Memory_Mapped.scala 298:18]
      if (io_mmio_ENABLE_LOAD == 32'h1) begin // @[Memory_Mapped.scala 300:33]
        mState <= 3'h1; // @[Memory_Mapped.scala 301:16]
      end
    end else if (3'h1 == mState) begin // @[Memory_Mapped.scala 298:18]
      if (io_master_ar_ready) begin // @[Memory_Mapped.scala 305:32]
        mState <= 3'h2; // @[Memory_Mapped.scala 306:16]
      end
    end else if (3'h2 == mState) begin // @[Memory_Mapped.scala 298:18]
      mState <= _GEN_44;
    end else begin
      mState <= _GEN_48;
    end
    if (reset) begin // @[Memory_Mapped.scala 246:31]
      mWriteAddrSent <= 1'h0; // @[Memory_Mapped.scala 246:31]
    end else begin
      mWriteAddrSent <= _GEN_81;
    end
    if (reset) begin // @[Memory_Mapped.scala 247:31]
      mWriteDataSent <= 1'h0; // @[Memory_Mapped.scala 247:31]
    end else begin
      mWriteDataSent <= _GEN_80;
    end
    if (reset) begin // @[Memory_Mapped.scala 256:28]
      data_buffer <= 32'h0; // @[Memory_Mapped.scala 256:28]
    end else if (_io_master_r_ready_T & io_master_r_valid) begin // @[Memory_Mapped.scala 350:51]
      data_buffer <= _data_buffer_T_2; // @[Memory_Mapped.scala 366:17]
    end
    if (reset) begin // @[Memory_Mapped.scala 259:30]
      source_offset <= 2'h0; // @[Memory_Mapped.scala 259:30]
    end else if (_io_master_ar_valid_T) begin // @[Memory_Mapped.scala 332:30]
      source_offset <= io_master_ar_bits_addr[1:0]; // @[Memory_Mapped.scala 334:19]
    end
    if (reset) begin // @[Memory_Mapped.scala 264:32]
      request_counter <= 32'h0; // @[Memory_Mapped.scala 264:32]
    end else if (_io_master_b_ready_T & request_counter == _GEN_84) begin // @[Memory_Mapped.scala 369:73]
      request_counter <= 32'h0; // @[Memory_Mapped.scala 370:21]
    end else if (_io_master_aw_valid_T) begin // @[Memory_Mapped.scala 326:31]
      if (_T_18) begin // @[Memory_Mapped.scala 327:29]
        request_counter <= _request_counter_T_1; // @[Memory_Mapped.scala 328:23]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  RAReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  RAReadyReg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  RDReg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  RDValidReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  DoRead = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  WAReg = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  WAReadyReg = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  WDReg = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  WSReg = _RAND_8[3:0];
  _RAND_9 = {1{`RANDOM}};
  WDReadyReg = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  WRValidReg = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  mState = _RAND_11[2:0];
  _RAND_12 = {1{`RANDOM}};
  mWriteAddrSent = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  mWriteDataSent = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  data_buffer = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  source_offset = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  request_counter = _RAND_16[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module topSA(
  input         clock,
  input         reset,
  output        io_slave_aw_ready,
  input         io_slave_aw_valid,
  input  [31:0] io_slave_aw_bits_addr,
  output        io_slave_w_ready,
  input         io_slave_w_valid,
  input  [31:0] io_slave_w_bits_data,
  input  [3:0]  io_slave_w_bits_strb,
  output        io_slave_b_valid,
  output        io_slave_ar_ready,
  input         io_slave_ar_valid,
  input  [31:0] io_slave_ar_bits_addr,
  output        io_slave_r_valid,
  output [31:0] io_slave_r_bits_data,
  output        io_tb_slave_ar_ready,
  input  [31:0] io_tb_slave_ar_bits_addr,
  output        io_tb_slave_r_valid,
  output [31:0] io_tb_slave_r_bits_data,
  input         io_tb_en,
  input         io_master_aw_ready,
  output        io_master_aw_valid,
  output [31:0] io_master_aw_bits_addr,
  input         io_master_w_ready,
  output        io_master_w_valid,
  output [31:0] io_master_w_bits_data,
  output [3:0]  io_master_w_bits_strb,
  output        io_master_b_ready,
  input         io_master_b_valid,
  input         io_master_ar_ready,
  output        io_master_ar_valid,
  output [31:0] io_master_ar_bits_addr,
  output        io_master_r_ready,
  input         io_master_r_valid,
  input  [31:0] io_master_r_bits_data
);
  wire  sa_clock; // @[topSA.scala 25:18]
  wire  sa_reset; // @[topSA.scala 25:18]
  wire  sa_io_mmio_ENABLE_OUT; // @[topSA.scala 25:18]
  wire [31:0] sa_io_mmio_MATA_MEM_ADDR; // @[topSA.scala 25:18]
  wire [31:0] sa_io_mmio_MATB_MEM_ADDR; // @[topSA.scala 25:18]
  wire [31:0] sa_io_mmio_MATC_MEM_ADDR; // @[topSA.scala 25:18]
  wire [31:0] sa_io_mmio_MAT_MEM_STRIDE; // @[topSA.scala 25:18]
  wire  sa_io_mmio_WEN; // @[topSA.scala 25:18]
  wire  sa_io_mmio_ENABLE_IN; // @[topSA.scala 25:18]
  wire  sa_io_mmio_STATUS_IN; // @[topSA.scala 25:18]
  wire [31:0] sa_io_raddr; // @[topSA.scala 25:18]
  wire [31:0] sa_io_rdata; // @[topSA.scala 25:18]
  wire  sa_io_wen; // @[topSA.scala 25:18]
  wire [31:0] sa_io_waddr; // @[topSA.scala 25:18]
  wire [31:0] sa_io_wdata; // @[topSA.scala 25:18]
  wire  mm_clock; // @[topSA.scala 26:18]
  wire  mm_reset; // @[topSA.scala 26:18]
  wire  mm_io_slave_aw_ready; // @[topSA.scala 26:18]
  wire  mm_io_slave_aw_valid; // @[topSA.scala 26:18]
  wire [31:0] mm_io_slave_aw_bits_addr; // @[topSA.scala 26:18]
  wire  mm_io_slave_w_ready; // @[topSA.scala 26:18]
  wire  mm_io_slave_w_valid; // @[topSA.scala 26:18]
  wire [31:0] mm_io_slave_w_bits_data; // @[topSA.scala 26:18]
  wire [3:0] mm_io_slave_w_bits_strb; // @[topSA.scala 26:18]
  wire  mm_io_slave_b_valid; // @[topSA.scala 26:18]
  wire  mm_io_slave_ar_ready; // @[topSA.scala 26:18]
  wire  mm_io_slave_ar_valid; // @[topSA.scala 26:18]
  wire [31:0] mm_io_slave_ar_bits_addr; // @[topSA.scala 26:18]
  wire  mm_io_slave_r_valid; // @[topSA.scala 26:18]
  wire [31:0] mm_io_slave_r_bits_data; // @[topSA.scala 26:18]
  wire  mm_io_tb_slave_ar_ready; // @[topSA.scala 26:18]
  wire [31:0] mm_io_tb_slave_ar_bits_addr; // @[topSA.scala 26:18]
  wire  mm_io_tb_slave_r_valid; // @[topSA.scala 26:18]
  wire [31:0] mm_io_tb_slave_r_bits_data; // @[topSA.scala 26:18]
  wire  mm_io_tb_en; // @[topSA.scala 26:18]
  wire  mm_io_master_aw_ready; // @[topSA.scala 26:18]
  wire  mm_io_master_aw_valid; // @[topSA.scala 26:18]
  wire [31:0] mm_io_master_aw_bits_addr; // @[topSA.scala 26:18]
  wire  mm_io_master_w_ready; // @[topSA.scala 26:18]
  wire  mm_io_master_w_valid; // @[topSA.scala 26:18]
  wire [31:0] mm_io_master_w_bits_data; // @[topSA.scala 26:18]
  wire [3:0] mm_io_master_w_bits_strb; // @[topSA.scala 26:18]
  wire  mm_io_master_b_ready; // @[topSA.scala 26:18]
  wire  mm_io_master_b_valid; // @[topSA.scala 26:18]
  wire  mm_io_master_ar_ready; // @[topSA.scala 26:18]
  wire  mm_io_master_ar_valid; // @[topSA.scala 26:18]
  wire [31:0] mm_io_master_ar_bits_addr; // @[topSA.scala 26:18]
  wire  mm_io_master_r_ready; // @[topSA.scala 26:18]
  wire  mm_io_master_r_valid; // @[topSA.scala 26:18]
  wire [31:0] mm_io_master_r_bits_data; // @[topSA.scala 26:18]
  wire  mm_io_mmio_ENABLE_OUT; // @[topSA.scala 26:18]
  wire [31:0] mm_io_mmio_MATA_MEM_ADDR; // @[topSA.scala 26:18]
  wire [31:0] mm_io_mmio_MATB_MEM_ADDR; // @[topSA.scala 26:18]
  wire [31:0] mm_io_mmio_MATC_MEM_ADDR; // @[topSA.scala 26:18]
  wire [31:0] mm_io_mmio_MAT_MEM_STRIDE; // @[topSA.scala 26:18]
  wire [31:0] mm_io_mmio_ENABLE_LOAD; // @[topSA.scala 26:18]
  wire [31:0] mm_io_mmio_SRC_INFO; // @[topSA.scala 26:18]
  wire [31:0] mm_io_mmio_DST_INFO; // @[topSA.scala 26:18]
  wire [31:0] mm_io_mmio_SIZE_CFG_INFO; // @[topSA.scala 26:18]
  wire  mm_io_mmio_WEN; // @[topSA.scala 26:18]
  wire  mm_io_mmio_ENABLE_IN; // @[topSA.scala 26:18]
  wire  mm_io_mmio_STATUS_IN; // @[topSA.scala 26:18]
  wire [31:0] mm_io_raddr; // @[topSA.scala 26:18]
  wire [31:0] mm_io_rdata; // @[topSA.scala 26:18]
  wire  mm_io_wen; // @[topSA.scala 26:18]
  wire [31:0] mm_io_waddr; // @[topSA.scala 26:18]
  wire [31:0] mm_io_wdata; // @[topSA.scala 26:18]
  SA sa ( // @[topSA.scala 25:18]
    .clock(sa_clock),
    .reset(sa_reset),
    .io_mmio_ENABLE_OUT(sa_io_mmio_ENABLE_OUT),
    .io_mmio_MATA_MEM_ADDR(sa_io_mmio_MATA_MEM_ADDR),
    .io_mmio_MATB_MEM_ADDR(sa_io_mmio_MATB_MEM_ADDR),
    .io_mmio_MATC_MEM_ADDR(sa_io_mmio_MATC_MEM_ADDR),
    .io_mmio_MAT_MEM_STRIDE(sa_io_mmio_MAT_MEM_STRIDE),
    .io_mmio_WEN(sa_io_mmio_WEN),
    .io_mmio_ENABLE_IN(sa_io_mmio_ENABLE_IN),
    .io_mmio_STATUS_IN(sa_io_mmio_STATUS_IN),
    .io_raddr(sa_io_raddr),
    .io_rdata(sa_io_rdata),
    .io_wen(sa_io_wen),
    .io_waddr(sa_io_waddr),
    .io_wdata(sa_io_wdata)
  );
  Memory_Mapped mm ( // @[topSA.scala 26:18]
    .clock(mm_clock),
    .reset(mm_reset),
    .io_slave_aw_ready(mm_io_slave_aw_ready),
    .io_slave_aw_valid(mm_io_slave_aw_valid),
    .io_slave_aw_bits_addr(mm_io_slave_aw_bits_addr),
    .io_slave_w_ready(mm_io_slave_w_ready),
    .io_slave_w_valid(mm_io_slave_w_valid),
    .io_slave_w_bits_data(mm_io_slave_w_bits_data),
    .io_slave_w_bits_strb(mm_io_slave_w_bits_strb),
    .io_slave_b_valid(mm_io_slave_b_valid),
    .io_slave_ar_ready(mm_io_slave_ar_ready),
    .io_slave_ar_valid(mm_io_slave_ar_valid),
    .io_slave_ar_bits_addr(mm_io_slave_ar_bits_addr),
    .io_slave_r_valid(mm_io_slave_r_valid),
    .io_slave_r_bits_data(mm_io_slave_r_bits_data),
    .io_tb_slave_ar_ready(mm_io_tb_slave_ar_ready),
    .io_tb_slave_ar_bits_addr(mm_io_tb_slave_ar_bits_addr),
    .io_tb_slave_r_valid(mm_io_tb_slave_r_valid),
    .io_tb_slave_r_bits_data(mm_io_tb_slave_r_bits_data),
    .io_tb_en(mm_io_tb_en),
    .io_master_aw_ready(mm_io_master_aw_ready),
    .io_master_aw_valid(mm_io_master_aw_valid),
    .io_master_aw_bits_addr(mm_io_master_aw_bits_addr),
    .io_master_w_ready(mm_io_master_w_ready),
    .io_master_w_valid(mm_io_master_w_valid),
    .io_master_w_bits_data(mm_io_master_w_bits_data),
    .io_master_w_bits_strb(mm_io_master_w_bits_strb),
    .io_master_b_ready(mm_io_master_b_ready),
    .io_master_b_valid(mm_io_master_b_valid),
    .io_master_ar_ready(mm_io_master_ar_ready),
    .io_master_ar_valid(mm_io_master_ar_valid),
    .io_master_ar_bits_addr(mm_io_master_ar_bits_addr),
    .io_master_r_ready(mm_io_master_r_ready),
    .io_master_r_valid(mm_io_master_r_valid),
    .io_master_r_bits_data(mm_io_master_r_bits_data),
    .io_mmio_ENABLE_OUT(mm_io_mmio_ENABLE_OUT),
    .io_mmio_MATA_MEM_ADDR(mm_io_mmio_MATA_MEM_ADDR),
    .io_mmio_MATB_MEM_ADDR(mm_io_mmio_MATB_MEM_ADDR),
    .io_mmio_MATC_MEM_ADDR(mm_io_mmio_MATC_MEM_ADDR),
    .io_mmio_MAT_MEM_STRIDE(mm_io_mmio_MAT_MEM_STRIDE),
    .io_mmio_ENABLE_LOAD(mm_io_mmio_ENABLE_LOAD),
    .io_mmio_SRC_INFO(mm_io_mmio_SRC_INFO),
    .io_mmio_DST_INFO(mm_io_mmio_DST_INFO),
    .io_mmio_SIZE_CFG_INFO(mm_io_mmio_SIZE_CFG_INFO),
    .io_mmio_WEN(mm_io_mmio_WEN),
    .io_mmio_ENABLE_IN(mm_io_mmio_ENABLE_IN),
    .io_mmio_STATUS_IN(mm_io_mmio_STATUS_IN),
    .io_raddr(mm_io_raddr),
    .io_rdata(mm_io_rdata),
    .io_wen(mm_io_wen),
    .io_waddr(mm_io_waddr),
    .io_wdata(mm_io_wdata)
  );
  assign io_slave_aw_ready = mm_io_slave_aw_ready; // @[topSA.scala 29:12]
  assign io_slave_w_ready = mm_io_slave_w_ready; // @[topSA.scala 29:12]
  assign io_slave_b_valid = mm_io_slave_b_valid; // @[topSA.scala 29:12]
  assign io_slave_ar_ready = mm_io_slave_ar_ready; // @[topSA.scala 29:12]
  assign io_slave_r_valid = mm_io_slave_r_valid; // @[topSA.scala 29:12]
  assign io_slave_r_bits_data = mm_io_slave_r_bits_data; // @[topSA.scala 29:12]
  assign io_tb_slave_ar_ready = mm_io_tb_slave_ar_ready; // @[topSA.scala 42:15]
  assign io_tb_slave_r_valid = mm_io_tb_slave_r_valid; // @[topSA.scala 42:15]
  assign io_tb_slave_r_bits_data = mm_io_tb_slave_r_bits_data; // @[topSA.scala 42:15]
  assign io_master_aw_valid = mm_io_master_aw_valid; // @[topSA.scala 30:13]
  assign io_master_aw_bits_addr = mm_io_master_aw_bits_addr; // @[topSA.scala 30:13]
  assign io_master_w_valid = mm_io_master_w_valid; // @[topSA.scala 30:13]
  assign io_master_w_bits_data = mm_io_master_w_bits_data; // @[topSA.scala 30:13]
  assign io_master_w_bits_strb = mm_io_master_w_bits_strb; // @[topSA.scala 30:13]
  assign io_master_b_ready = mm_io_master_b_ready; // @[topSA.scala 30:13]
  assign io_master_ar_valid = mm_io_master_ar_valid; // @[topSA.scala 30:13]
  assign io_master_ar_bits_addr = mm_io_master_ar_bits_addr; // @[topSA.scala 30:13]
  assign io_master_r_ready = mm_io_master_r_ready; // @[topSA.scala 30:13]
  assign sa_clock = clock;
  assign sa_reset = reset;
  assign sa_io_mmio_ENABLE_OUT = mm_io_mmio_ENABLE_OUT; // @[topSA.scala 31:14]
  assign sa_io_mmio_MATA_MEM_ADDR = mm_io_mmio_MATA_MEM_ADDR; // @[topSA.scala 31:14]
  assign sa_io_mmio_MATB_MEM_ADDR = mm_io_mmio_MATB_MEM_ADDR; // @[topSA.scala 31:14]
  assign sa_io_mmio_MATC_MEM_ADDR = mm_io_mmio_MATC_MEM_ADDR; // @[topSA.scala 31:14]
  assign sa_io_mmio_MAT_MEM_STRIDE = mm_io_mmio_MAT_MEM_STRIDE; // @[topSA.scala 31:14]
  assign sa_io_rdata = mm_io_rdata; // @[topSA.scala 35:15]
  assign mm_clock = clock;
  assign mm_reset = reset;
  assign mm_io_slave_aw_valid = io_slave_aw_valid; // @[topSA.scala 29:12]
  assign mm_io_slave_aw_bits_addr = io_slave_aw_bits_addr; // @[topSA.scala 29:12]
  assign mm_io_slave_w_valid = io_slave_w_valid; // @[topSA.scala 29:12]
  assign mm_io_slave_w_bits_data = io_slave_w_bits_data; // @[topSA.scala 29:12]
  assign mm_io_slave_w_bits_strb = io_slave_w_bits_strb; // @[topSA.scala 29:12]
  assign mm_io_slave_ar_valid = io_slave_ar_valid; // @[topSA.scala 29:12]
  assign mm_io_slave_ar_bits_addr = io_slave_ar_bits_addr; // @[topSA.scala 29:12]
  assign mm_io_tb_slave_ar_bits_addr = io_tb_slave_ar_bits_addr; // @[topSA.scala 42:15]
  assign mm_io_tb_en = io_tb_en; // @[topSA.scala 43:15]
  assign mm_io_master_aw_ready = io_master_aw_ready; // @[topSA.scala 30:13]
  assign mm_io_master_w_ready = io_master_w_ready; // @[topSA.scala 30:13]
  assign mm_io_master_b_valid = io_master_b_valid; // @[topSA.scala 30:13]
  assign mm_io_master_ar_ready = io_master_ar_ready; // @[topSA.scala 30:13]
  assign mm_io_master_r_valid = io_master_r_valid; // @[topSA.scala 30:13]
  assign mm_io_master_r_bits_data = io_master_r_bits_data; // @[topSA.scala 30:13]
  assign mm_io_mmio_WEN = sa_io_mmio_WEN; // @[topSA.scala 31:14]
  assign mm_io_mmio_ENABLE_IN = sa_io_mmio_ENABLE_IN; // @[topSA.scala 31:14]
  assign mm_io_mmio_STATUS_IN = sa_io_mmio_STATUS_IN; // @[topSA.scala 31:14]
  assign mm_io_raddr = sa_io_raddr; // @[topSA.scala 34:15]
  assign mm_io_wen = sa_io_wen; // @[topSA.scala 39:13]
  assign mm_io_waddr = sa_io_waddr; // @[topSA.scala 36:15]
  assign mm_io_wdata = sa_io_wdata; // @[topSA.scala 37:15]
endmodule
module DMA(
  input         clock,
  input         reset,
  output        io_slave_aw_ready,
  input         io_slave_aw_valid,
  input  [16:0] io_slave_aw_bits_id,
  input  [31:0] io_slave_aw_bits_addr,
  input  [3:0]  io_slave_aw_bits_region,
  input  [7:0]  io_slave_aw_bits_len,
  input  [1:0]  io_slave_aw_bits_size,
  input  [1:0]  io_slave_aw_bits_burst,
  input         io_slave_aw_bits_lock,
  input  [3:0]  io_slave_aw_bits_cache,
  input  [2:0]  io_slave_aw_bits_prot,
  input  [3:0]  io_slave_aw_bits_qos,
  output        io_slave_w_ready,
  input         io_slave_w_valid,
  input  [31:0] io_slave_w_bits_data,
  input  [3:0]  io_slave_w_bits_strb,
  input         io_slave_w_bits_last,
  input         io_slave_b_ready,
  output        io_slave_b_valid,
  output [16:0] io_slave_b_bits_id,
  output [1:0]  io_slave_b_bits_resp,
  output        io_slave_ar_ready,
  input         io_slave_ar_valid,
  input  [16:0] io_slave_ar_bits_id,
  input  [31:0] io_slave_ar_bits_addr,
  input  [3:0]  io_slave_ar_bits_region,
  input  [7:0]  io_slave_ar_bits_len,
  input  [1:0]  io_slave_ar_bits_size,
  input  [1:0]  io_slave_ar_bits_burst,
  input         io_slave_ar_bits_lock,
  input  [3:0]  io_slave_ar_bits_cache,
  input  [2:0]  io_slave_ar_bits_prot,
  input  [3:0]  io_slave_ar_bits_qos,
  input         io_slave_r_ready,
  output        io_slave_r_valid,
  output [16:0] io_slave_r_bits_id,
  output [31:0] io_slave_r_bits_data,
  output [1:0]  io_slave_r_bits_resp,
  output        io_slave_r_bits_last,
  input         io_master_aw_ready,
  output        io_master_aw_valid,
  output [16:0] io_master_aw_bits_id,
  output [31:0] io_master_aw_bits_addr,
  output [3:0]  io_master_aw_bits_region,
  output [7:0]  io_master_aw_bits_len,
  output [1:0]  io_master_aw_bits_size,
  output [1:0]  io_master_aw_bits_burst,
  output        io_master_aw_bits_lock,
  output [3:0]  io_master_aw_bits_cache,
  output [2:0]  io_master_aw_bits_prot,
  output [3:0]  io_master_aw_bits_qos,
  input         io_master_w_ready,
  output        io_master_w_valid,
  output [31:0] io_master_w_bits_data,
  output [3:0]  io_master_w_bits_strb,
  output        io_master_w_bits_last,
  output        io_master_b_ready,
  input         io_master_b_valid,
  input  [16:0] io_master_b_bits_id,
  input  [1:0]  io_master_b_bits_resp,
  input         io_master_ar_ready,
  output        io_master_ar_valid,
  output [16:0] io_master_ar_bits_id,
  output [31:0] io_master_ar_bits_addr,
  output [3:0]  io_master_ar_bits_region,
  output [7:0]  io_master_ar_bits_len,
  output [1:0]  io_master_ar_bits_size,
  output [1:0]  io_master_ar_bits_burst,
  output        io_master_ar_bits_lock,
  output [3:0]  io_master_ar_bits_cache,
  output [2:0]  io_master_ar_bits_prot,
  output [3:0]  io_master_ar_bits_qos,
  output        io_master_r_ready,
  input         io_master_r_valid,
  input  [16:0] io_master_r_bits_id,
  input  [31:0] io_master_r_bits_data,
  input  [1:0]  io_master_r_bits_resp,
  input         io_master_r_bits_last,
  output        io_Hcf
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] mState; // @[DMA.scala 19:24]
  reg  sReadState; // @[DMA.scala 25:28]
  reg [1:0] sWriteState; // @[DMA.scala 26:28]
  reg [31:0] sReadAddrReg; // @[DMA.scala 28:33]
  reg [16:0] sReadIDReg; // @[DMA.scala 29:33]
  reg [16:0] sWriteIDReg; // @[DMA.scala 30:33]
  reg  sWriteDataRecv; // @[DMA.scala 31:33]
  reg  sWriteAddrRecv; // @[DMA.scala 32:33]
  reg [31:0] sWriteDataReg; // @[DMA.scala 33:33]
  reg [31:0] sWriteAddrReg; // @[DMA.scala 34:33]
  wire [31:0] sWriteAddrOffset = sWriteAddrReg - 32'h300000; // @[DMA.scala 35:52]
  wire [31:0] sReadAddrOffset = sReadAddrReg - 32'h300000; // @[DMA.scala 36:51]
  reg  mWriteAddrSent; // @[DMA.scala 38:31]
  reg  mWriteDataSent; // @[DMA.scala 39:31]
  reg [31:0] mmio_regs_0; // @[DMA.scala 42:34]
  reg [31:0] mmio_regs_1; // @[DMA.scala 42:34]
  reg [31:0] mmio_regs_2; // @[DMA.scala 42:34]
  reg [31:0] mmio_regs_3; // @[DMA.scala 42:34]
  reg [31:0] mmio_regs_4; // @[DMA.scala 42:34]
  reg [31:0] mmio_regs_5; // @[DMA.scala 42:34]
  reg [31:0] data_buffer; // @[DMA.scala 51:28]
  reg [1:0] source_offset; // @[DMA.scala 54:30]
  wire [1:0] dest_offset = io_master_aw_bits_addr[1:0]; // @[DMA.scala 57:55]
  reg [31:0] request_counter; // @[DMA.scala 60:32]
  wire [31:0] _sReadData_T_1 = 32'h0 == sReadAddrOffset ? mmio_regs_0 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _sReadData_T_3 = 32'h4 == sReadAddrOffset ? mmio_regs_1 : _sReadData_T_1; // @[Mux.scala 81:58]
  wire [31:0] _sReadData_T_5 = 32'h8 == sReadAddrOffset ? mmio_regs_2 : _sReadData_T_3; // @[Mux.scala 81:58]
  wire [31:0] _sReadData_T_7 = 32'hc == sReadAddrOffset ? mmio_regs_3 : _sReadData_T_5; // @[Mux.scala 81:58]
  wire [31:0] _sReadData_T_9 = 32'h10 == sReadAddrOffset ? mmio_regs_4 : _sReadData_T_7; // @[Mux.scala 81:58]
  wire  _io_master_aw_valid_T = mState == 3'h3; // @[DMA.scala 80:38]
  wire  _io_master_ar_valid_T = mState == 3'h1; // @[DMA.scala 92:38]
  wire  _io_master_r_ready_T = mState == 3'h2; // @[DMA.scala 109:31]
  wire  _io_master_b_ready_T = mState == 3'h4; // @[DMA.scala 111:31]
  wire  _io_slave_aw_ready_T_2 = sWriteState == 2'h0 | sWriteState == 2'h1; // @[DMA.scala 114:52]
  wire  _io_slave_ar_ready_T = ~sReadState; // @[DMA.scala 117:35]
  wire  _io_slave_b_valid_T = sWriteState == 2'h2; // @[DMA.scala 125:39]
  wire [2:0] _GEN_2 = io_master_r_valid ? 3'h3 : mState; // @[DMA.scala 143:31 144:16 19:24]
  wire [2:0] _GEN_3 = mWriteAddrSent & mWriteDataSent ? 3'h4 : mState; // @[DMA.scala 148:46 149:16 19:24]
  wire [2:0] _GEN_4 = io_master_b_valid ? 3'h0 : mState; // @[DMA.scala 153:31 154:16 19:24]
  wire [2:0] _GEN_5 = 3'h4 == mState ? _GEN_4 : mState; // @[DMA.scala 131:18 19:24]
  wire [2:0] _GEN_6 = 3'h3 == mState ? _GEN_3 : _GEN_5; // @[DMA.scala 131:18]
  wire  _GEN_10 = io_slave_ar_valid | sReadState; // @[DMA.scala 163:31 164:20 25:28]
  wire [1:0] _GEN_16 = io_slave_b_ready ? 2'h0 : sWriteState; // @[DMA.scala 186:30 187:21 26:28]
  wire  _T_15 = io_master_aw_ready & io_master_aw_valid; // @[Decoupled.scala 52:35]
  wire [31:0] _request_counter_T_1 = request_counter + 32'h1; // @[DMA.scala 195:42]
  wire [39:0] _io_master_ar_bits_addr_T_1 = request_counter * mmio_regs_3[31:24]; // @[DMA.scala 200:67]
  wire [39:0] _GEN_87 = {{8'd0}, mmio_regs_1}; // @[DMA.scala 200:48]
  wire [39:0] _io_master_ar_bits_addr_T_3 = _GEN_87 + _io_master_ar_bits_addr_T_1; // @[DMA.scala 200:48]
  wire [39:0] _GEN_22 = _io_master_ar_valid_T ? _io_master_ar_bits_addr_T_3 : 40'h0; // @[DMA.scala 199:30 200:28 93:28]
  wire [39:0] _io_master_aw_bits_addr_T_1 = request_counter * mmio_regs_3[23:16]; // @[DMA.scala 205:65]
  wire [39:0] _GEN_88 = {{8'd0}, mmio_regs_2}; // @[DMA.scala 205:46]
  wire [39:0] _io_master_aw_bits_addr_T_3 = _GEN_88 + _io_master_aw_bits_addr_T_1; // @[DMA.scala 205:46]
  wire [3:0] _mask_width_T_2 = 8'h1 == mmio_regs_3[15:8] ? 4'h1 : 4'hf; // @[Mux.scala 81:58]
  wire [3:0] _mask_width_T_4 = 8'h2 == mmio_regs_3[15:8] ? 4'h3 : _mask_width_T_2; // @[Mux.scala 81:58]
  wire [3:0] _mask_width_T_6 = 8'h3 == mmio_regs_3[15:8] ? 4'h7 : _mask_width_T_4; // @[Mux.scala 81:58]
  wire [3:0] _mask_width_T_8 = 8'h4 == mmio_regs_3[15:8] ? 4'hf : _mask_width_T_6; // @[Mux.scala 81:58]
  wire [3:0] _GEN_25 = _io_master_aw_valid_T ? _mask_width_T_8 : 4'h0; // @[DMA.scala 204:31 206:16]
  wire [3:0] mask_width = _io_master_r_ready_T & io_master_r_valid ? _mask_width_T_8 : _GEN_25; // @[DMA.scala 217:51 218:16]
  wire [6:0] _GEN_32 = {{3'd0}, mask_width}; // @[DMA.scala 212:41]
  wire [6:0] _io_master_w_bits_strb_T = _GEN_32 << dest_offset; // @[DMA.scala 212:41]
  wire [4:0] _io_master_w_bits_data_T = {dest_offset, 3'h0}; // @[DMA.scala 213:58]
  wire [62:0] _GEN_34 = {{31'd0}, data_buffer}; // @[DMA.scala 213:42]
  wire [62:0] _io_master_w_bits_data_T_1 = _GEN_34 << _io_master_w_bits_data_T; // @[DMA.scala 213:42]
  wire [39:0] _GEN_24 = _io_master_aw_valid_T ? _io_master_aw_bits_addr_T_3 : 40'h0; // @[DMA.scala 204:31 205:28 81:28]
  wire [6:0] _GEN_26 = _io_master_aw_valid_T ? _io_master_w_bits_strb_T : 7'hf; // @[DMA.scala 106:25 204:31 212:27]
  wire [62:0] _GEN_27 = _io_master_aw_valid_T ? _io_master_w_bits_data_T_1 : {{31'd0}, data_buffer}; // @[DMA.scala 105:25 204:31 213:27]
  wire [6:0] _GEN_35 = {{3'd0}, mask_width}; // @[DMA.scala 224:30]
  wire [6:0] _rData_mask_T = _GEN_35 << source_offset; // @[DMA.scala 224:30]
  wire [6:0] _GEN_33 = _io_master_r_ready_T & io_master_r_valid ? _rData_mask_T : 7'h0; // @[DMA.scala 217:51 224:16]
  wire [3:0] rData_mask = _GEN_33[3:0];
  wire [7:0] _GEN_28 = rData_mask[0] ? io_master_r_bits_data[7:0] : 8'h0; // @[DMA.scala 226:35 227:18 230:18]
  wire [7:0] _GEN_29 = rData_mask[1] ? io_master_r_bits_data[15:8] : 8'h0; // @[DMA.scala 226:35 227:18 230:18]
  wire [7:0] _GEN_30 = rData_mask[2] ? io_master_r_bits_data[23:16] : 8'h0; // @[DMA.scala 226:35 227:18 230:18]
  wire [7:0] _GEN_31 = rData_mask[3] ? io_master_r_bits_data[31:24] : 8'h0; // @[DMA.scala 226:35 227:18 230:18]
  wire [7:0] rData_1 = _io_master_r_ready_T & io_master_r_valid ? _GEN_29 : 8'h0; // @[DMA.scala 217:51]
  wire [7:0] rData_0 = _io_master_r_ready_T & io_master_r_valid ? _GEN_28 : 8'h0; // @[DMA.scala 217:51]
  wire [7:0] rData_3 = _io_master_r_ready_T & io_master_r_valid ? _GEN_31 : 8'h0; // @[DMA.scala 217:51]
  wire [7:0] rData_2 = _io_master_r_ready_T & io_master_r_valid ? _GEN_30 : 8'h0; // @[DMA.scala 217:51]
  wire [31:0] _data_buffer_T = {rData_3,rData_2,rData_1,rData_0}; // @[DMA.scala 233:26]
  wire [4:0] _data_buffer_T_1 = {source_offset, 3'h0}; // @[DMA.scala 233:51]
  wire [31:0] _data_buffer_T_2 = _data_buffer_T >> _data_buffer_T_1; // @[DMA.scala 233:33]
  wire [31:0] _GEN_89 = {{24'd0}, mmio_regs_3[7:0]}; // @[DMA.scala 236:49]
  wire [31:0] _GEN_40 = _io_master_b_ready_T & request_counter == _GEN_89 ? 32'h0 : mmio_regs_0; // @[DMA.scala 236:73 238:17 42:34]
  wire [31:0] _GEN_41 = _io_master_b_ready_T & request_counter == _GEN_89 ? 32'h1 : mmio_regs_5; // @[DMA.scala 236:73 239:17 42:34]
  wire  _GEN_42 = io_master_w_ready | mWriteDataSent; // @[DMA.scala 242:29 243:22 39:31]
  wire  _GEN_43 = io_master_aw_ready | mWriteAddrSent; // @[DMA.scala 245:30 246:22 38:31]
  wire  _GEN_44 = _io_master_aw_valid_T & _GEN_42; // @[DMA.scala 241:31 250:20]
  wire  _GEN_45 = _io_master_aw_valid_T & _GEN_43; // @[DMA.scala 241:31 249:20]
  wire  _GEN_46 = io_slave_aw_valid | sWriteAddrRecv; // @[DMA.scala 257:29 258:22 32:33]
  wire  _GEN_49 = io_slave_w_valid | sWriteDataRecv; // @[DMA.scala 270:28 271:21 31:33]
  wire [31:0] _GEN_58 = 32'h14 == sWriteAddrOffset ? sWriteDataReg : _GEN_41; // @[DMA.scala 280:30 297:22]
  wire [31:0] _GEN_59 = 32'h10 == sWriteAddrOffset ? sWriteDataReg : mmio_regs_4; // @[DMA.scala 280:30 294:22 42:34]
  wire [31:0] _GEN_60 = 32'h10 == sWriteAddrOffset ? _GEN_41 : _GEN_58; // @[DMA.scala 280:30]
  wire [31:0] _GEN_61 = 32'hc == sWriteAddrOffset ? sWriteDataReg : mmio_regs_3; // @[DMA.scala 280:30 291:22 42:34]
  wire [31:0] _GEN_62 = 32'hc == sWriteAddrOffset ? mmio_regs_4 : _GEN_59; // @[DMA.scala 280:30 42:34]
  wire [31:0] _GEN_63 = 32'hc == sWriteAddrOffset ? _GEN_41 : _GEN_60; // @[DMA.scala 280:30]
  wire [31:0] _GEN_64 = 32'h8 == sWriteAddrOffset ? sWriteDataReg : mmio_regs_2; // @[DMA.scala 280:30 288:22 42:34]
  wire [31:0] _GEN_65 = 32'h8 == sWriteAddrOffset ? mmio_regs_3 : _GEN_61; // @[DMA.scala 280:30 42:34]
  wire [31:0] _GEN_66 = 32'h8 == sWriteAddrOffset ? mmio_regs_4 : _GEN_62; // @[DMA.scala 280:30 42:34]
  wire [31:0] _GEN_67 = 32'h8 == sWriteAddrOffset ? _GEN_41 : _GEN_63; // @[DMA.scala 280:30]
  assign io_slave_aw_ready = (sWriteState == 2'h0 | sWriteState == 2'h1) & ~sWriteAddrRecv; // @[DMA.scala 114:83]
  assign io_slave_w_ready = _io_slave_aw_ready_T_2 & ~sWriteDataRecv; // @[DMA.scala 115:82]
  assign io_slave_b_valid = sWriteState == 2'h2; // @[DMA.scala 125:39]
  assign io_slave_b_bits_id = sWriteIDReg; // @[DMA.scala 126:24]
  assign io_slave_b_bits_resp = 2'h0; // @[DMA.scala 127:24]
  assign io_slave_ar_ready = ~sReadState; // @[DMA.scala 117:35]
  assign io_slave_r_valid = sReadState; // @[DMA.scala 119:38]
  assign io_slave_r_bits_id = sReadIDReg; // @[DMA.scala 121:24]
  assign io_slave_r_bits_data = 32'h14 == sReadAddrOffset ? mmio_regs_5 : _sReadData_T_9; // @[Mux.scala 81:58]
  assign io_slave_r_bits_resp = 2'h0; // @[DMA.scala 123:24]
  assign io_slave_r_bits_last = 1'h1; // @[DMA.scala 122:24]
  assign io_master_aw_valid = mState == 3'h3 & ~mWriteAddrSent; // @[DMA.scala 80:53]
  assign io_master_aw_bits_id = 17'h0; // @[DMA.scala 86:28]
  assign io_master_aw_bits_addr = _GEN_24[31:0];
  assign io_master_aw_bits_region = 4'h0; // @[DMA.scala 90:28]
  assign io_master_aw_bits_len = 8'h0; // @[DMA.scala 83:28]
  assign io_master_aw_bits_size = 2'h2; // @[DMA.scala 84:28]
  assign io_master_aw_bits_burst = 2'h0; // @[DMA.scala 82:28]
  assign io_master_aw_bits_lock = 1'h0; // @[DMA.scala 88:28]
  assign io_master_aw_bits_cache = 4'h0; // @[DMA.scala 85:28]
  assign io_master_aw_bits_prot = 3'h0; // @[DMA.scala 87:28]
  assign io_master_aw_bits_qos = 4'h0; // @[DMA.scala 89:28]
  assign io_master_w_valid = _io_master_aw_valid_T & ~mWriteDataSent; // @[DMA.scala 104:50]
  assign io_master_w_bits_data = _GEN_27[31:0];
  assign io_master_w_bits_strb = _GEN_26[3:0];
  assign io_master_w_bits_last = 1'h1; // @[DMA.scala 107:25]
  assign io_master_b_ready = mState == 3'h4; // @[DMA.scala 111:31]
  assign io_master_ar_valid = mState == 3'h1; // @[DMA.scala 92:38]
  assign io_master_ar_bits_id = 17'h0; // @[DMA.scala 98:28]
  assign io_master_ar_bits_addr = _GEN_22[31:0];
  assign io_master_ar_bits_region = 4'h0; // @[DMA.scala 102:28]
  assign io_master_ar_bits_len = 8'h0; // @[DMA.scala 95:28]
  assign io_master_ar_bits_size = 2'h2; // @[DMA.scala 96:28]
  assign io_master_ar_bits_burst = 2'h0; // @[DMA.scala 94:28]
  assign io_master_ar_bits_lock = 1'h0; // @[DMA.scala 100:28]
  assign io_master_ar_bits_cache = 4'h0; // @[DMA.scala 97:28]
  assign io_master_ar_bits_prot = 3'h0; // @[DMA.scala 99:28]
  assign io_master_ar_bits_qos = 4'h0; // @[DMA.scala 101:28]
  assign io_master_r_ready = mState == 3'h2; // @[DMA.scala 109:31]
  assign io_Hcf = mmio_regs_5[0]; // @[DMA.scala 77:10]
  always @(posedge clock) begin
    if (reset) begin // @[DMA.scala 19:24]
      mState <= 3'h0; // @[DMA.scala 19:24]
    end else if (3'h0 == mState) begin // @[DMA.scala 131:18]
      if (mmio_regs_0 == 32'h1) begin // @[DMA.scala 133:33]
        mState <= 3'h1; // @[DMA.scala 134:16]
      end
    end else if (3'h1 == mState) begin // @[DMA.scala 131:18]
      if (io_master_ar_ready) begin // @[DMA.scala 138:32]
        mState <= 3'h2; // @[DMA.scala 139:16]
      end
    end else if (3'h2 == mState) begin // @[DMA.scala 131:18]
      mState <= _GEN_2;
    end else begin
      mState <= _GEN_6;
    end
    if (reset) begin // @[DMA.scala 25:28]
      sReadState <= 1'h0; // @[DMA.scala 25:28]
    end else if (_io_slave_ar_ready_T) begin // @[DMA.scala 161:22]
      sReadState <= _GEN_10;
    end else if (sReadState) begin // @[DMA.scala 161:22]
      if (io_slave_r_ready) begin // @[DMA.scala 168:30]
        sReadState <= 1'h0; // @[DMA.scala 169:20]
      end
    end
    if (reset) begin // @[DMA.scala 26:28]
      sWriteState <= 2'h0; // @[DMA.scala 26:28]
    end else if (2'h0 == sWriteState) begin // @[DMA.scala 174:23]
      if (io_slave_aw_valid | io_slave_w_valid) begin // @[DMA.scala 176:51]
        sWriteState <= 2'h1; // @[DMA.scala 177:21]
      end
    end else if (2'h1 == sWriteState) begin // @[DMA.scala 174:23]
      if (sWriteDataRecv & sWriteAddrRecv) begin // @[DMA.scala 181:45]
        sWriteState <= 2'h2; // @[DMA.scala 182:21]
      end
    end else if (2'h2 == sWriteState) begin // @[DMA.scala 174:23]
      sWriteState <= _GEN_16;
    end
    if (reset) begin // @[DMA.scala 28:33]
      sReadAddrReg <= 32'h0; // @[DMA.scala 28:33]
    end else if (_io_slave_ar_ready_T & io_slave_ar_valid) begin // @[DMA.scala 301:55]
      sReadAddrReg <= io_slave_ar_bits_addr; // @[DMA.scala 302:18]
    end
    if (reset) begin // @[DMA.scala 29:33]
      sReadIDReg <= 17'h0; // @[DMA.scala 29:33]
    end else if (_io_slave_ar_ready_T & io_slave_ar_valid) begin // @[DMA.scala 301:55]
      sReadIDReg <= io_slave_ar_bits_id; // @[DMA.scala 303:18]
    end
    if (reset) begin // @[DMA.scala 30:33]
      sWriteIDReg <= 17'h0; // @[DMA.scala 30:33]
    end else if (_io_slave_aw_ready_T_2) begin // @[DMA.scala 256:66]
      if (io_slave_aw_valid) begin // @[DMA.scala 257:29]
        if (!(sWriteAddrRecv)) begin // @[DMA.scala 264:29]
          sWriteIDReg <= io_slave_aw_bits_id;
        end
      end
    end
    if (reset) begin // @[DMA.scala 31:33]
      sWriteDataRecv <= 1'h0; // @[DMA.scala 31:33]
    end else if (_io_slave_aw_ready_T_2) begin // @[DMA.scala 256:66]
      sWriteDataRecv <= _GEN_49;
    end else if (_io_slave_b_valid_T) begin // @[DMA.scala 274:42]
      sWriteDataRecv <= 1'h0; // @[DMA.scala 276:19]
    end
    if (reset) begin // @[DMA.scala 32:33]
      sWriteAddrRecv <= 1'h0; // @[DMA.scala 32:33]
    end else if (_io_slave_aw_ready_T_2) begin // @[DMA.scala 256:66]
      sWriteAddrRecv <= _GEN_46;
    end else if (_io_slave_b_valid_T) begin // @[DMA.scala 274:42]
      sWriteAddrRecv <= 1'h0; // @[DMA.scala 275:20]
    end
    if (reset) begin // @[DMA.scala 33:33]
      sWriteDataReg <= 32'h0; // @[DMA.scala 33:33]
    end else if (_io_slave_aw_ready_T_2) begin // @[DMA.scala 256:66]
      if (io_slave_w_valid) begin // @[DMA.scala 270:28]
        if (!(sWriteDataRecv)) begin // @[DMA.scala 272:27]
          sWriteDataReg <= io_slave_w_bits_data;
        end
      end
    end
    if (reset) begin // @[DMA.scala 34:33]
      sWriteAddrReg <= 32'h0; // @[DMA.scala 34:33]
    end else if (_io_slave_aw_ready_T_2) begin // @[DMA.scala 256:66]
      if (io_slave_aw_valid) begin // @[DMA.scala 257:29]
        if (!(sWriteAddrRecv)) begin // @[DMA.scala 259:29]
          sWriteAddrReg <= io_slave_aw_bits_addr;
        end
      end
    end
    if (reset) begin // @[DMA.scala 38:31]
      mWriteAddrSent <= 1'h0; // @[DMA.scala 38:31]
    end else begin
      mWriteAddrSent <= _GEN_45;
    end
    if (reset) begin // @[DMA.scala 39:31]
      mWriteDataSent <= 1'h0; // @[DMA.scala 39:31]
    end else begin
      mWriteDataSent <= _GEN_44;
    end
    if (reset) begin // @[DMA.scala 42:34]
      mmio_regs_0 <= 32'h0; // @[DMA.scala 42:34]
    end else if (_io_slave_b_valid_T & io_slave_b_ready) begin // @[DMA.scala 279:56]
      if (32'h0 == sWriteAddrOffset) begin // @[DMA.scala 280:30]
        mmio_regs_0 <= sWriteDataReg; // @[DMA.scala 282:22]
      end else begin
        mmio_regs_0 <= _GEN_40;
      end
    end else begin
      mmio_regs_0 <= _GEN_40;
    end
    if (reset) begin // @[DMA.scala 42:34]
      mmio_regs_1 <= 32'h0; // @[DMA.scala 42:34]
    end else if (_io_slave_b_valid_T & io_slave_b_ready) begin // @[DMA.scala 279:56]
      if (!(32'h0 == sWriteAddrOffset)) begin // @[DMA.scala 280:30]
        if (32'h4 == sWriteAddrOffset) begin // @[DMA.scala 280:30]
          mmio_regs_1 <= sWriteDataReg; // @[DMA.scala 285:22]
        end
      end
    end
    if (reset) begin // @[DMA.scala 42:34]
      mmio_regs_2 <= 32'h0; // @[DMA.scala 42:34]
    end else if (_io_slave_b_valid_T & io_slave_b_ready) begin // @[DMA.scala 279:56]
      if (!(32'h0 == sWriteAddrOffset)) begin // @[DMA.scala 280:30]
        if (!(32'h4 == sWriteAddrOffset)) begin // @[DMA.scala 280:30]
          mmio_regs_2 <= _GEN_64;
        end
      end
    end
    if (reset) begin // @[DMA.scala 42:34]
      mmio_regs_3 <= 32'h0; // @[DMA.scala 42:34]
    end else if (_io_slave_b_valid_T & io_slave_b_ready) begin // @[DMA.scala 279:56]
      if (!(32'h0 == sWriteAddrOffset)) begin // @[DMA.scala 280:30]
        if (!(32'h4 == sWriteAddrOffset)) begin // @[DMA.scala 280:30]
          mmio_regs_3 <= _GEN_65;
        end
      end
    end
    if (reset) begin // @[DMA.scala 42:34]
      mmio_regs_4 <= 32'h0; // @[DMA.scala 42:34]
    end else if (_io_slave_b_valid_T & io_slave_b_ready) begin // @[DMA.scala 279:56]
      if (!(32'h0 == sWriteAddrOffset)) begin // @[DMA.scala 280:30]
        if (!(32'h4 == sWriteAddrOffset)) begin // @[DMA.scala 280:30]
          mmio_regs_4 <= _GEN_66;
        end
      end
    end
    if (reset) begin // @[DMA.scala 42:34]
      mmio_regs_5 <= 32'h0; // @[DMA.scala 42:34]
    end else if (_io_slave_b_valid_T & io_slave_b_ready) begin // @[DMA.scala 279:56]
      if (32'h0 == sWriteAddrOffset) begin // @[DMA.scala 280:30]
        mmio_regs_5 <= _GEN_41;
      end else if (32'h4 == sWriteAddrOffset) begin // @[DMA.scala 280:30]
        mmio_regs_5 <= _GEN_41;
      end else begin
        mmio_regs_5 <= _GEN_67;
      end
    end else begin
      mmio_regs_5 <= _GEN_41;
    end
    if (reset) begin // @[DMA.scala 51:28]
      data_buffer <= 32'h0; // @[DMA.scala 51:28]
    end else if (_io_master_r_ready_T & io_master_r_valid) begin // @[DMA.scala 217:51]
      data_buffer <= _data_buffer_T_2; // @[DMA.scala 233:17]
    end
    if (reset) begin // @[DMA.scala 54:30]
      source_offset <= 2'h0; // @[DMA.scala 54:30]
    end else if (_io_master_ar_valid_T) begin // @[DMA.scala 199:30]
      source_offset <= io_master_ar_bits_addr[1:0]; // @[DMA.scala 201:19]
    end
    if (reset) begin // @[DMA.scala 60:32]
      request_counter <= 32'h0; // @[DMA.scala 60:32]
    end else if (_io_master_b_ready_T & request_counter == _GEN_89) begin // @[DMA.scala 236:73]
      request_counter <= 32'h0; // @[DMA.scala 237:21]
    end else if (_io_master_aw_valid_T) begin // @[DMA.scala 193:31]
      if (_T_15) begin // @[DMA.scala 194:29]
        request_counter <= _request_counter_T_1; // @[DMA.scala 195:23]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  mState = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  sReadState = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  sWriteState = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  sReadAddrReg = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  sReadIDReg = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  sWriteIDReg = _RAND_5[16:0];
  _RAND_6 = {1{`RANDOM}};
  sWriteDataRecv = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  sWriteAddrRecv = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  sWriteDataReg = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  sWriteAddrReg = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  mWriteAddrSent = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  mWriteDataSent = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  mmio_regs_0 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  mmio_regs_1 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  mmio_regs_2 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  mmio_regs_3 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  mmio_regs_4 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  mmio_regs_5 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  data_buffer = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  source_offset = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  request_counter = _RAND_20[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AXIReadBus(
  input         clock,
  input         reset,
  output        io_master_readAddr_ready,
  input         io_master_readAddr_valid,
  input  [16:0] io_master_readAddr_bits_id,
  input  [31:0] io_master_readAddr_bits_addr,
  input  [1:0]  io_master_readAddr_bits_size,
  input         io_master_readData_ready,
  output        io_master_readData_valid,
  output [16:0] io_master_readData_bits_id,
  output [31:0] io_master_readData_bits_data,
  output [1:0]  io_master_readData_bits_resp,
  output        io_master_readData_bits_last,
  input         io_slave_0_readAddr_ready,
  output        io_slave_0_readAddr_valid,
  output [16:0] io_slave_0_readAddr_bits_id,
  output [31:0] io_slave_0_readAddr_bits_addr,
  output [1:0]  io_slave_0_readAddr_bits_size,
  output        io_slave_0_readData_ready,
  input         io_slave_0_readData_valid,
  input  [16:0] io_slave_0_readData_bits_id,
  input  [31:0] io_slave_0_readData_bits_data,
  input  [1:0]  io_slave_0_readData_bits_resp,
  input         io_slave_0_readData_bits_last,
  input         io_slave_1_readAddr_ready,
  output        io_slave_1_readAddr_valid,
  output [16:0] io_slave_1_readAddr_bits_id,
  output [31:0] io_slave_1_readAddr_bits_addr,
  output [1:0]  io_slave_1_readAddr_bits_size,
  output        io_slave_1_readData_ready,
  input         io_slave_1_readData_valid,
  input  [16:0] io_slave_1_readData_bits_id,
  input  [31:0] io_slave_1_readData_bits_data,
  input  [1:0]  io_slave_1_readData_bits_resp,
  input         io_slave_1_readData_bits_last,
  input         io_slave_2_readAddr_ready,
  output        io_slave_2_readAddr_valid,
  output [16:0] io_slave_2_readAddr_bits_id,
  output [31:0] io_slave_2_readAddr_bits_addr,
  output [1:0]  io_slave_2_readAddr_bits_size,
  output        io_slave_2_readData_ready,
  input         io_slave_2_readData_valid,
  input  [16:0] io_slave_2_readData_bits_id,
  input  [31:0] io_slave_2_readData_bits_data,
  input  [1:0]  io_slave_2_readData_bits_resp,
  input         io_slave_2_readData_bits_last
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  _read_port_T_2 = io_master_readAddr_bits_addr >= 32'h8000 & io_master_readAddr_bits_addr < 32'h10000; // @[AXIReadBus.scala 24:53]
  wire  _read_port_T_5 = io_master_readAddr_bits_addr >= 32'h100000 & io_master_readAddr_bits_addr < 32'h300000; // @[AXIReadBus.scala 24:53]
  wire  _read_port_T_8 = io_master_readAddr_bits_addr >= 32'h300000 & io_master_readAddr_bits_addr < 32'h400000; // @[AXIReadBus.scala 24:53]
  wire [1:0] _read_port_T_9 = _read_port_T_8 ? 2'h2 : 2'h0; // @[Mux.scala 101:16]
  wire [1:0] _read_port_T_10 = _read_port_T_5 ? 2'h1 : _read_port_T_9; // @[Mux.scala 101:16]
  wire [1:0] read_port = _read_port_T_2 ? 2'h0 : _read_port_T_10; // @[Mux.scala 101:16]
  reg [2:0] read_port_reg; // @[AXIReadBus.scala 26:30]
  reg [31:0] read_addr_reg; // @[AXIReadBus.scala 27:30]
  reg [16:0] read_addr_reg_id; // @[AXIReadBus.scala 28:33]
  reg [2:0] read_addr_reg_size; // @[AXIReadBus.scala 29:35]
  reg  read_addr_reg_valid; // @[AXIReadBus.scala 30:36]
  reg  outstanding; // @[AXIReadBus.scala 31:28]
  wire  _T = io_master_readAddr_ready & io_master_readAddr_valid; // @[Decoupled.scala 52:35]
  wire  _GEN_0 = _T | outstanding; // @[AXIReadBus.scala 57:33 58:17 31:28]
  wire  _GEN_5 = _T | read_addr_reg_valid; // @[AXIReadBus.scala 57:33 63:25 30:36]
  wire  _GEN_7 = 2'h1 == read_port_reg[1:0] ? io_slave_1_readAddr_ready : io_slave_0_readAddr_ready; // @[AXIReadBus.scala 67:{50,50}]
  wire  _GEN_8 = 2'h2 == read_port_reg[1:0] ? io_slave_2_readAddr_ready : _GEN_7; // @[AXIReadBus.scala 67:{50,50}]
  wire  _GEN_12 = 2'h1 == read_port_reg[1:0] ? io_slave_1_readData_valid : io_slave_0_readData_valid; // @[AXIReadBus.scala 73:{30,30}]
  wire  _GEN_13 = 2'h2 == read_port_reg[1:0] ? io_slave_2_readData_valid : _GEN_12; // @[AXIReadBus.scala 73:{30,30}]
  wire [31:0] _GEN_15 = 2'h1 == read_port_reg[1:0] ? io_slave_1_readData_bits_data : io_slave_0_readData_bits_data; // @[AXIReadBus.scala 74:{34,34}]
  wire [31:0] _GEN_16 = 2'h2 == read_port_reg[1:0] ? io_slave_2_readData_bits_data : _GEN_15; // @[AXIReadBus.scala 74:{34,34}]
  wire [1:0] _GEN_18 = 2'h1 == read_port_reg[1:0] ? io_slave_1_readData_bits_resp : io_slave_0_readData_bits_resp; // @[AXIReadBus.scala 75:{34,34}]
  wire [1:0] _GEN_19 = 2'h2 == read_port_reg[1:0] ? io_slave_2_readData_bits_resp : _GEN_18; // @[AXIReadBus.scala 75:{34,34}]
  wire  _GEN_21 = 2'h1 == read_port_reg[1:0] ? io_slave_1_readData_bits_last : io_slave_0_readData_bits_last; // @[AXIReadBus.scala 76:{34,34}]
  wire  _GEN_22 = 2'h2 == read_port_reg[1:0] ? io_slave_2_readData_bits_last : _GEN_21; // @[AXIReadBus.scala 76:{34,34}]
  wire [16:0] _GEN_24 = 2'h1 == read_port_reg[1:0] ? io_slave_1_readData_bits_id : io_slave_0_readData_bits_id; // @[AXIReadBus.scala 77:{32,32}]
  wire [31:0] _GEN_26 = 2'h0 == read_port_reg[1:0] ? read_addr_reg : 32'h0; // @[AXIReadBus.scala 37:36 78:{48,48}]
  wire [31:0] _GEN_27 = 2'h1 == read_port_reg[1:0] ? read_addr_reg : 32'h0; // @[AXIReadBus.scala 37:36 78:{48,48}]
  wire [31:0] _GEN_28 = 2'h2 == read_port_reg[1:0] ? read_addr_reg : 32'h0; // @[AXIReadBus.scala 37:36 78:{48,48}]
  wire  _GEN_63 = 2'h0 == read_port_reg[1:0]; // @[AXIReadBus.scala 36:32 79:{44,44}]
  wire  _GEN_29 = 2'h0 == read_port_reg[1:0] & read_addr_reg_valid; // @[AXIReadBus.scala 36:32 79:{44,44}]
  wire  _GEN_64 = 2'h1 == read_port_reg[1:0]; // @[AXIReadBus.scala 36:32 79:{44,44}]
  wire  _GEN_30 = 2'h1 == read_port_reg[1:0] & read_addr_reg_valid; // @[AXIReadBus.scala 36:32 79:{44,44}]
  wire  _GEN_65 = 2'h2 == read_port_reg[1:0]; // @[AXIReadBus.scala 36:32 79:{44,44}]
  wire  _GEN_31 = 2'h2 == read_port_reg[1:0] & read_addr_reg_valid; // @[AXIReadBus.scala 36:32 79:{44,44}]
  wire  _GEN_32 = _GEN_63 & io_master_readData_ready; // @[AXIReadBus.scala 47:32 80:{44,44}]
  wire  _GEN_33 = _GEN_64 & io_master_readData_ready; // @[AXIReadBus.scala 47:32 80:{44,44}]
  wire  _GEN_34 = _GEN_65 & io_master_readData_ready; // @[AXIReadBus.scala 47:32 80:{44,44}]
  wire [1:0] _GEN_35 = 2'h0 == read_port_reg[1:0] ? read_addr_reg_size[1:0] : 2'h0; // @[AXIReadBus.scala 41:36 81:{48,48}]
  wire [1:0] _GEN_36 = 2'h1 == read_port_reg[1:0] ? read_addr_reg_size[1:0] : 2'h0; // @[AXIReadBus.scala 41:36 81:{48,48}]
  wire [1:0] _GEN_37 = 2'h2 == read_port_reg[1:0] ? read_addr_reg_size[1:0] : 2'h0; // @[AXIReadBus.scala 41:36 81:{48,48}]
  wire [16:0] _GEN_38 = 2'h0 == read_port_reg[1:0] ? read_addr_reg_id : 17'h0; // @[AXIReadBus.scala 38:34 82:{46,46}]
  wire [16:0] _GEN_39 = 2'h1 == read_port_reg[1:0] ? read_addr_reg_id : 17'h0; // @[AXIReadBus.scala 38:34 82:{46,46}]
  wire [16:0] _GEN_40 = 2'h2 == read_port_reg[1:0] ? read_addr_reg_id : 17'h0; // @[AXIReadBus.scala 38:34 82:{46,46}]
  wire  _T_7 = io_master_readData_ready & io_master_readData_valid; // @[Decoupled.scala 52:35]
  assign io_master_readAddr_ready = ~outstanding; // @[AXIReadBus.scala 55:31]
  assign io_master_readData_valid = outstanding & _GEN_13; // @[AXIReadBus.scala 72:21 50:28 73:30]
  assign io_master_readData_bits_id = 2'h2 == read_port_reg[1:0] ? io_slave_2_readData_bits_id : _GEN_24; // @[AXIReadBus.scala 77:{32,32}]
  assign io_master_readData_bits_data = outstanding ? _GEN_16 : 32'h0; // @[AXIReadBus.scala 72:21 51:32 74:34]
  assign io_master_readData_bits_resp = outstanding ? _GEN_19 : 2'h0; // @[AXIReadBus.scala 72:21 52:32 75:34]
  assign io_master_readData_bits_last = outstanding & _GEN_22; // @[AXIReadBus.scala 72:21 54:32 76:34]
  assign io_slave_0_readAddr_valid = outstanding & _GEN_29; // @[AXIReadBus.scala 72:21 36:32]
  assign io_slave_0_readAddr_bits_id = outstanding ? _GEN_38 : 17'h0; // @[AXIReadBus.scala 72:21 38:34]
  assign io_slave_0_readAddr_bits_addr = outstanding ? _GEN_26 : 32'h0; // @[AXIReadBus.scala 72:21 37:36]
  assign io_slave_0_readAddr_bits_size = outstanding ? _GEN_35 : 2'h0; // @[AXIReadBus.scala 72:21 41:36]
  assign io_slave_0_readData_ready = outstanding & _GEN_32; // @[AXIReadBus.scala 72:21 47:32]
  assign io_slave_1_readAddr_valid = outstanding & _GEN_30; // @[AXIReadBus.scala 72:21 36:32]
  assign io_slave_1_readAddr_bits_id = outstanding ? _GEN_39 : 17'h0; // @[AXIReadBus.scala 72:21 38:34]
  assign io_slave_1_readAddr_bits_addr = outstanding ? _GEN_27 : 32'h0; // @[AXIReadBus.scala 72:21 37:36]
  assign io_slave_1_readAddr_bits_size = outstanding ? _GEN_36 : 2'h0; // @[AXIReadBus.scala 72:21 41:36]
  assign io_slave_1_readData_ready = outstanding & _GEN_33; // @[AXIReadBus.scala 72:21 47:32]
  assign io_slave_2_readAddr_valid = outstanding & _GEN_31; // @[AXIReadBus.scala 72:21 36:32]
  assign io_slave_2_readAddr_bits_id = outstanding ? _GEN_40 : 17'h0; // @[AXIReadBus.scala 72:21 38:34]
  assign io_slave_2_readAddr_bits_addr = outstanding ? _GEN_28 : 32'h0; // @[AXIReadBus.scala 72:21 37:36]
  assign io_slave_2_readAddr_bits_size = outstanding ? _GEN_37 : 2'h0; // @[AXIReadBus.scala 72:21 41:36]
  assign io_slave_2_readData_ready = outstanding & _GEN_34; // @[AXIReadBus.scala 72:21 47:32]
  always @(posedge clock) begin
    if (reset) begin // @[AXIReadBus.scala 26:30]
      read_port_reg <= 3'h0; // @[AXIReadBus.scala 26:30]
    end else if (_T) begin // @[AXIReadBus.scala 57:33]
      read_port_reg <= {{1'd0}, read_port}; // @[AXIReadBus.scala 59:19]
    end
    if (reset) begin // @[AXIReadBus.scala 27:30]
      read_addr_reg <= 32'h0; // @[AXIReadBus.scala 27:30]
    end else if (_T) begin // @[AXIReadBus.scala 57:33]
      read_addr_reg <= io_master_readAddr_bits_addr; // @[AXIReadBus.scala 60:19]
    end
    if (reset) begin // @[AXIReadBus.scala 28:33]
      read_addr_reg_id <= 17'h0; // @[AXIReadBus.scala 28:33]
    end else if (_T) begin // @[AXIReadBus.scala 57:33]
      read_addr_reg_id <= io_master_readAddr_bits_id; // @[AXIReadBus.scala 61:22]
    end
    if (reset) begin // @[AXIReadBus.scala 29:35]
      read_addr_reg_size <= 3'h0; // @[AXIReadBus.scala 29:35]
    end else if (_T) begin // @[AXIReadBus.scala 57:33]
      read_addr_reg_size <= {{1'd0}, io_master_readAddr_bits_size}; // @[AXIReadBus.scala 62:24]
    end
    if (reset) begin // @[AXIReadBus.scala 30:36]
      read_addr_reg_valid <= 1'h0; // @[AXIReadBus.scala 30:36]
    end else if (read_addr_reg_valid) begin // @[AXIReadBus.scala 66:29]
      if (_GEN_8) begin // @[AXIReadBus.scala 67:50]
        read_addr_reg_valid <= 1'h0; // @[AXIReadBus.scala 68:27]
      end else begin
        read_addr_reg_valid <= _GEN_5;
      end
    end else begin
      read_addr_reg_valid <= _GEN_5;
    end
    if (reset) begin // @[AXIReadBus.scala 31:28]
      outstanding <= 1'h0; // @[AXIReadBus.scala 31:28]
    end else if (outstanding) begin // @[AXIReadBus.scala 72:21]
      if (_T_7) begin // @[AXIReadBus.scala 83:35]
        outstanding <= 1'h0; // @[AXIReadBus.scala 84:19]
      end else begin
        outstanding <= _GEN_0;
      end
    end else begin
      outstanding <= _GEN_0;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  read_port_reg = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  read_addr_reg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  read_addr_reg_id = _RAND_2[16:0];
  _RAND_3 = {1{`RANDOM}};
  read_addr_reg_size = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  read_addr_reg_valid = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  outstanding = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RRArbiter(
  input        clock,
  output       io_in_0_ready,
  input        io_in_0_valid,
  output       io_in_1_ready,
  input        io_in_1_valid,
  output       io_in_2_ready,
  input        io_in_2_valid,
  output       io_out_valid,
  output [1:0] io_chosen
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  _GEN_1 = 2'h1 == io_chosen ? io_in_1_valid : io_in_0_valid; // @[Arbiter.scala 55:{16,16}]
  reg [1:0] lastGrant; // @[Reg.scala 19:16]
  wire  grantMask_1 = 2'h1 > lastGrant; // @[Arbiter.scala 81:49]
  wire  grantMask_2 = 2'h2 > lastGrant; // @[Arbiter.scala 81:49]
  wire  validMask_1 = io_in_1_valid & grantMask_1; // @[Arbiter.scala 82:76]
  wire  validMask_2 = io_in_2_valid & grantMask_2; // @[Arbiter.scala 82:76]
  wire  ctrl_2 = ~validMask_1; // @[Arbiter.scala 45:78]
  wire  ctrl_4 = ~(validMask_1 | validMask_2 | io_in_0_valid); // @[Arbiter.scala 45:78]
  wire  ctrl_5 = ~(validMask_1 | validMask_2 | io_in_0_valid | io_in_1_valid); // @[Arbiter.scala 45:78]
  wire [1:0] _GEN_7 = io_in_1_valid ? 2'h1 : 2'h2; // @[Arbiter.scala 91:{26,35}]
  wire [1:0] _GEN_8 = io_in_0_valid ? 2'h0 : _GEN_7; // @[Arbiter.scala 91:{26,35}]
  wire [1:0] _GEN_9 = validMask_2 ? 2'h2 : _GEN_8; // @[Arbiter.scala 93:{24,33}]
  assign io_in_0_ready = ~(validMask_1 | validMask_2); // @[Arbiter.scala 45:78]
  assign io_in_1_ready = grantMask_1 | ctrl_4; // @[Arbiter.scala 86:50]
  assign io_in_2_ready = ctrl_2 & grantMask_2 | ctrl_5; // @[Arbiter.scala 86:50]
  assign io_out_valid = 2'h2 == io_chosen ? io_in_2_valid : _GEN_1; // @[Arbiter.scala 55:{16,16}]
  assign io_chosen = validMask_1 ? 2'h1 : _GEN_9; // @[Arbiter.scala 93:{24,33}]
  always @(posedge clock) begin
    if (io_out_valid) begin // @[Reg.scala 20:18]
      lastGrant <= io_chosen; // @[Reg.scala 20:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  lastGrant = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AXISlaveReadMux(
  input         clock,
  input         reset,
  input         io_out_readAddr_ready,
  output        io_out_readAddr_valid,
  output [16:0] io_out_readAddr_bits_id,
  output [31:0] io_out_readAddr_bits_addr,
  output [1:0]  io_out_readAddr_bits_size,
  output        io_out_readData_ready,
  input         io_out_readData_valid,
  input  [16:0] io_out_readData_bits_id,
  input  [31:0] io_out_readData_bits_data,
  input  [1:0]  io_out_readData_bits_resp,
  input         io_out_readData_bits_last,
  output        io_in_0_readAddr_ready,
  input         io_in_0_readAddr_valid,
  input  [16:0] io_in_0_readAddr_bits_id,
  input  [31:0] io_in_0_readAddr_bits_addr,
  input  [1:0]  io_in_0_readAddr_bits_size,
  input         io_in_0_readData_ready,
  output        io_in_0_readData_valid,
  output [16:0] io_in_0_readData_bits_id,
  output [31:0] io_in_0_readData_bits_data,
  output [1:0]  io_in_0_readData_bits_resp,
  output        io_in_0_readData_bits_last,
  output        io_in_1_readAddr_ready,
  input         io_in_1_readAddr_valid,
  input  [16:0] io_in_1_readAddr_bits_id,
  input  [31:0] io_in_1_readAddr_bits_addr,
  input  [1:0]  io_in_1_readAddr_bits_size,
  input         io_in_1_readData_ready,
  output        io_in_1_readData_valid,
  output [16:0] io_in_1_readData_bits_id,
  output [31:0] io_in_1_readData_bits_data,
  output [1:0]  io_in_1_readData_bits_resp,
  output        io_in_1_readData_bits_last,
  output        io_in_2_readAddr_ready,
  input         io_in_2_readAddr_valid,
  input  [16:0] io_in_2_readAddr_bits_id,
  input  [31:0] io_in_2_readAddr_bits_addr,
  input  [1:0]  io_in_2_readAddr_bits_size,
  input         io_in_2_readData_ready,
  output        io_in_2_readData_valid,
  output [16:0] io_in_2_readData_bits_id,
  output [31:0] io_in_2_readData_bits_data,
  output [1:0]  io_in_2_readData_bits_resp,
  output        io_in_2_readData_bits_last
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  wire  arbiter_clock; // @[AXISlaveReadMux.scala 31:23]
  wire  arbiter_io_in_0_ready; // @[AXISlaveReadMux.scala 31:23]
  wire  arbiter_io_in_0_valid; // @[AXISlaveReadMux.scala 31:23]
  wire  arbiter_io_in_1_ready; // @[AXISlaveReadMux.scala 31:23]
  wire  arbiter_io_in_1_valid; // @[AXISlaveReadMux.scala 31:23]
  wire  arbiter_io_in_2_ready; // @[AXISlaveReadMux.scala 31:23]
  wire  arbiter_io_in_2_valid; // @[AXISlaveReadMux.scala 31:23]
  wire  arbiter_io_out_valid; // @[AXISlaveReadMux.scala 31:23]
  wire [1:0] arbiter_io_chosen; // @[AXISlaveReadMux.scala 31:23]
  reg [1:0] state; // @[AXISlaveReadMux.scala 27:22]
  wire  outstanding = io_in_0_readAddr_valid | io_in_1_readAddr_valid | io_in_2_readAddr_valid; // @[AXISlaveReadMux.scala 29:95]
  reg [1:0] chosen_reg; // @[AXISlaveReadMux.scala 32:27]
  reg  ar_determined; // @[AXISlaveReadMux.scala 33:30]
  reg [16:0] address_reg_id; // @[AXISlaveReadMux.scala 34:28]
  reg [31:0] address_reg_addr; // @[AXISlaveReadMux.scala 34:28]
  reg [1:0] address_reg_size; // @[AXISlaveReadMux.scala 34:28]
  reg [16:0] data_reg_id; // @[AXISlaveReadMux.scala 39:25]
  reg [31:0] data_reg_data; // @[AXISlaveReadMux.scala 39:25]
  reg [1:0] data_reg_resp; // @[AXISlaveReadMux.scala 39:25]
  reg  data_reg_last; // @[AXISlaveReadMux.scala 39:25]
  wire  _T_8 = state == 2'h1; // @[AXISlaveReadMux.scala 101:19]
  wire  _GEN_62 = state == 2'h2 ? 1'h0 : 1'h1; // @[AXISlaveReadMux.scala 111:31 112:20]
  wire  _GEN_68 = state == 2'h1 ? 1'h0 : _GEN_62; // @[AXISlaveReadMux.scala 101:33 102:22]
  wire  mask_0 = state == 2'h0 | _GEN_68; // @[AXISlaveReadMux.scala 92:24 93:20]
  wire  _T_2 = io_out_readData_ready & io_out_readData_valid; // @[Decoupled.scala 52:35]
  wire  _GEN_3 = 2'h1 == chosen_reg ? io_in_1_readData_ready : io_in_0_readData_ready; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_4 = 2'h2 == chosen_reg ? io_in_2_readData_ready : _GEN_3; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_6 = 2'h1 == chosen_reg ? io_in_1_readData_valid : io_in_0_readData_valid; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_7 = 2'h2 == chosen_reg ? io_in_2_readData_valid : _GEN_6; // @[Decoupled.scala 52:{35,35}]
  wire  _T_6 = _GEN_4 & _GEN_7; // @[Decoupled.scala 52:35]
  wire [1:0] _GEN_8 = _T_6 ? 2'h0 : state; // @[AXISlaveReadMux.scala 86:44 87:15 27:22]
  wire [16:0] _GEN_13 = 2'h1 == arbiter_io_chosen ? io_in_1_readAddr_bits_id : io_in_0_readAddr_bits_id; // @[AXISlaveReadMux.scala 96:{19,19}]
  wire [31:0] _GEN_16 = 2'h1 == arbiter_io_chosen ? io_in_1_readAddr_bits_addr : io_in_0_readAddr_bits_addr; // @[AXISlaveReadMux.scala 96:{19,19}]
  wire [1:0] _GEN_25 = 2'h1 == arbiter_io_chosen ? io_in_1_readAddr_bits_size : io_in_0_readAddr_bits_size; // @[AXISlaveReadMux.scala 96:{19,19}]
  wire  _GEN_53 = arbiter_io_out_valid | ar_determined; // @[AXISlaveReadMux.scala 94:31 97:21 33:30]
  wire  _T_9 = io_out_readAddr_ready & io_out_readAddr_valid; // @[Decoupled.scala 52:35]
  wire  _GEN_59 = 2'h0 == chosen_reg; // @[AXISlaveReadMux.scala 113:{38,38} 60:29]
  wire  _GEN_60 = 2'h1 == chosen_reg; // @[AXISlaveReadMux.scala 113:{38,38} 60:29]
  wire  _GEN_61 = 2'h2 == chosen_reg; // @[AXISlaveReadMux.scala 113:{38,38} 60:29]
  wire  _GEN_65 = state == 2'h2 & _GEN_59; // @[AXISlaveReadMux.scala 111:31 60:29]
  wire  _GEN_66 = state == 2'h2 & _GEN_60; // @[AXISlaveReadMux.scala 111:31 60:29]
  wire  _GEN_67 = state == 2'h2 & _GEN_61; // @[AXISlaveReadMux.scala 111:31 60:29]
  wire  _GEN_77 = state == 2'h1 ? 1'h0 : _GEN_65; // @[AXISlaveReadMux.scala 101:33 60:29]
  wire  _GEN_78 = state == 2'h1 ? 1'h0 : _GEN_66; // @[AXISlaveReadMux.scala 101:33 60:29]
  wire  _GEN_79 = state == 2'h1 ? 1'h0 : _GEN_67; // @[AXISlaveReadMux.scala 101:33 60:29]
  RRArbiter arbiter ( // @[AXISlaveReadMux.scala 31:23]
    .clock(arbiter_clock),
    .io_in_0_ready(arbiter_io_in_0_ready),
    .io_in_0_valid(arbiter_io_in_0_valid),
    .io_in_1_ready(arbiter_io_in_1_ready),
    .io_in_1_valid(arbiter_io_in_1_valid),
    .io_in_2_ready(arbiter_io_in_2_ready),
    .io_in_2_valid(arbiter_io_in_2_valid),
    .io_out_valid(arbiter_io_out_valid),
    .io_chosen(arbiter_io_chosen)
  );
  assign io_out_readAddr_valid = ar_determined; // @[AXISlaveReadMux.scala 72:25]
  assign io_out_readAddr_bits_id = address_reg_id; // @[AXISlaveReadMux.scala 116:24]
  assign io_out_readAddr_bits_addr = address_reg_addr; // @[AXISlaveReadMux.scala 116:24]
  assign io_out_readAddr_bits_size = address_reg_size; // @[AXISlaveReadMux.scala 116:24]
  assign io_out_readData_ready = state == 2'h0 ? 1'h0 : _T_8; // @[AXISlaveReadMux.scala 92:24 99:27]
  assign io_in_0_readAddr_ready = arbiter_io_in_0_ready & mask_0; // @[AXISlaveReadMux.scala 67:55]
  assign io_in_0_readData_valid = state == 2'h0 ? 1'h0 : _GEN_77; // @[AXISlaveReadMux.scala 92:24 60:29]
  assign io_in_0_readData_bits_id = 2'h0 == chosen_reg ? data_reg_id : 17'h0; // @[AXISlaveReadMux.scala 117:{35,35} 62:31]
  assign io_in_0_readData_bits_data = 2'h0 == chosen_reg ? data_reg_data : 32'h0; // @[AXISlaveReadMux.scala 117:{35,35} 59:33]
  assign io_in_0_readData_bits_resp = 2'h0 == chosen_reg ? data_reg_resp : 2'h0; // @[AXISlaveReadMux.scala 117:{35,35} 61:33]
  assign io_in_0_readData_bits_last = 2'h0 == chosen_reg ? data_reg_last : 1'h1; // @[AXISlaveReadMux.scala 117:{35,35} 63:33]
  assign io_in_1_readAddr_ready = arbiter_io_in_1_ready & mask_0; // @[AXISlaveReadMux.scala 67:55]
  assign io_in_1_readData_valid = state == 2'h0 ? 1'h0 : _GEN_78; // @[AXISlaveReadMux.scala 92:24 60:29]
  assign io_in_1_readData_bits_id = 2'h1 == chosen_reg ? data_reg_id : 17'h0; // @[AXISlaveReadMux.scala 117:{35,35} 62:31]
  assign io_in_1_readData_bits_data = 2'h1 == chosen_reg ? data_reg_data : 32'h0; // @[AXISlaveReadMux.scala 117:{35,35} 59:33]
  assign io_in_1_readData_bits_resp = 2'h1 == chosen_reg ? data_reg_resp : 2'h0; // @[AXISlaveReadMux.scala 117:{35,35} 61:33]
  assign io_in_1_readData_bits_last = 2'h1 == chosen_reg ? data_reg_last : 1'h1; // @[AXISlaveReadMux.scala 117:{35,35} 63:33]
  assign io_in_2_readAddr_ready = arbiter_io_in_2_ready & mask_0; // @[AXISlaveReadMux.scala 67:55]
  assign io_in_2_readData_valid = state == 2'h0 ? 1'h0 : _GEN_79; // @[AXISlaveReadMux.scala 92:24 60:29]
  assign io_in_2_readData_bits_id = 2'h2 == chosen_reg ? data_reg_id : 17'h0; // @[AXISlaveReadMux.scala 117:{35,35} 62:31]
  assign io_in_2_readData_bits_data = 2'h2 == chosen_reg ? data_reg_data : 32'h0; // @[AXISlaveReadMux.scala 117:{35,35} 59:33]
  assign io_in_2_readData_bits_resp = 2'h2 == chosen_reg ? data_reg_resp : 2'h0; // @[AXISlaveReadMux.scala 117:{35,35} 61:33]
  assign io_in_2_readData_bits_last = 2'h2 == chosen_reg ? data_reg_last : 1'h1; // @[AXISlaveReadMux.scala 117:{35,35} 63:33]
  assign arbiter_clock = clock;
  assign arbiter_io_in_0_valid = io_in_0_readAddr_valid & mask_0; // @[AXISlaveReadMux.scala 68:55]
  assign arbiter_io_in_1_valid = io_in_1_readAddr_valid & mask_0; // @[AXISlaveReadMux.scala 68:55]
  assign arbiter_io_in_2_valid = io_in_2_readAddr_valid & mask_0; // @[AXISlaveReadMux.scala 68:55]
  always @(posedge clock) begin
    if (reset) begin // @[AXISlaveReadMux.scala 27:22]
      state <= 2'h0; // @[AXISlaveReadMux.scala 27:22]
    end else if (2'h0 == state) begin // @[AXISlaveReadMux.scala 74:16]
      if (outstanding) begin // @[AXISlaveReadMux.scala 76:24]
        state <= 2'h1; // @[AXISlaveReadMux.scala 77:15]
      end
    end else if (2'h1 == state) begin // @[AXISlaveReadMux.scala 74:16]
      if (_T_2) begin // @[AXISlaveReadMux.scala 81:33]
        state <= 2'h2; // @[AXISlaveReadMux.scala 82:15]
      end
    end else if (2'h2 == state) begin // @[AXISlaveReadMux.scala 74:16]
      state <= _GEN_8;
    end
    if (reset) begin // @[AXISlaveReadMux.scala 32:27]
      chosen_reg <= 2'h0; // @[AXISlaveReadMux.scala 32:27]
    end else if (state == 2'h0) begin // @[AXISlaveReadMux.scala 92:24]
      if (arbiter_io_out_valid) begin // @[AXISlaveReadMux.scala 94:31]
        chosen_reg <= arbiter_io_chosen; // @[AXISlaveReadMux.scala 95:18]
      end
    end
    if (reset) begin // @[AXISlaveReadMux.scala 33:30]
      ar_determined <= 1'h0; // @[AXISlaveReadMux.scala 33:30]
    end else if (state == 2'h0) begin // @[AXISlaveReadMux.scala 92:24]
      ar_determined <= _GEN_53;
    end else if (state == 2'h1) begin // @[AXISlaveReadMux.scala 101:33]
      if (_T_9) begin // @[AXISlaveReadMux.scala 103:33]
        ar_determined <= 1'h0; // @[AXISlaveReadMux.scala 104:23]
      end
    end
    if (reset) begin // @[AXISlaveReadMux.scala 34:28]
      address_reg_id <= 17'h0; // @[AXISlaveReadMux.scala 34:28]
    end else if (state == 2'h0) begin // @[AXISlaveReadMux.scala 92:24]
      if (arbiter_io_out_valid) begin // @[AXISlaveReadMux.scala 94:31]
        if (2'h2 == arbiter_io_chosen) begin // @[AXISlaveReadMux.scala 96:19]
          address_reg_id <= io_in_2_readAddr_bits_id; // @[AXISlaveReadMux.scala 96:19]
        end else begin
          address_reg_id <= _GEN_13;
        end
      end
    end
    if (reset) begin // @[AXISlaveReadMux.scala 34:28]
      address_reg_addr <= 32'h0; // @[AXISlaveReadMux.scala 34:28]
    end else if (state == 2'h0) begin // @[AXISlaveReadMux.scala 92:24]
      if (arbiter_io_out_valid) begin // @[AXISlaveReadMux.scala 94:31]
        if (2'h2 == arbiter_io_chosen) begin // @[AXISlaveReadMux.scala 96:19]
          address_reg_addr <= io_in_2_readAddr_bits_addr; // @[AXISlaveReadMux.scala 96:19]
        end else begin
          address_reg_addr <= _GEN_16;
        end
      end
    end
    if (reset) begin // @[AXISlaveReadMux.scala 34:28]
      address_reg_size <= 2'h0; // @[AXISlaveReadMux.scala 34:28]
    end else if (state == 2'h0) begin // @[AXISlaveReadMux.scala 92:24]
      if (arbiter_io_out_valid) begin // @[AXISlaveReadMux.scala 94:31]
        if (2'h2 == arbiter_io_chosen) begin // @[AXISlaveReadMux.scala 96:19]
          address_reg_size <= io_in_2_readAddr_bits_size; // @[AXISlaveReadMux.scala 96:19]
        end else begin
          address_reg_size <= _GEN_25;
        end
      end
    end
    if (reset) begin // @[AXISlaveReadMux.scala 39:25]
      data_reg_id <= 17'h0; // @[AXISlaveReadMux.scala 39:25]
    end else if (!(state == 2'h0)) begin // @[AXISlaveReadMux.scala 92:24]
      if (state == 2'h1) begin // @[AXISlaveReadMux.scala 101:33]
        if (_T_2) begin // @[AXISlaveReadMux.scala 106:33]
          data_reg_id <= io_out_readData_bits_id; // @[AXISlaveReadMux.scala 107:18]
        end
      end
    end
    if (reset) begin // @[AXISlaveReadMux.scala 39:25]
      data_reg_data <= 32'h0; // @[AXISlaveReadMux.scala 39:25]
    end else if (!(state == 2'h0)) begin // @[AXISlaveReadMux.scala 92:24]
      if (state == 2'h1) begin // @[AXISlaveReadMux.scala 101:33]
        if (_T_2) begin // @[AXISlaveReadMux.scala 106:33]
          data_reg_data <= io_out_readData_bits_data; // @[AXISlaveReadMux.scala 107:18]
        end
      end
    end
    if (reset) begin // @[AXISlaveReadMux.scala 39:25]
      data_reg_resp <= 2'h0; // @[AXISlaveReadMux.scala 39:25]
    end else if (!(state == 2'h0)) begin // @[AXISlaveReadMux.scala 92:24]
      if (state == 2'h1) begin // @[AXISlaveReadMux.scala 101:33]
        if (_T_2) begin // @[AXISlaveReadMux.scala 106:33]
          data_reg_resp <= io_out_readData_bits_resp; // @[AXISlaveReadMux.scala 107:18]
        end
      end
    end
    if (reset) begin // @[AXISlaveReadMux.scala 39:25]
      data_reg_last <= 1'h0; // @[AXISlaveReadMux.scala 39:25]
    end else if (!(state == 2'h0)) begin // @[AXISlaveReadMux.scala 92:24]
      if (state == 2'h1) begin // @[AXISlaveReadMux.scala 101:33]
        if (_T_2) begin // @[AXISlaveReadMux.scala 106:33]
          data_reg_last <= io_out_readData_bits_last; // @[AXISlaveReadMux.scala 107:18]
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  chosen_reg = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  ar_determined = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  address_reg_id = _RAND_3[16:0];
  _RAND_4 = {1{`RANDOM}};
  address_reg_addr = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  address_reg_size = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  data_reg_id = _RAND_6[16:0];
  _RAND_7 = {1{`RANDOM}};
  data_reg_data = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  data_reg_resp = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  data_reg_last = _RAND_9[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AXIWriteBus(
  input         clock,
  input         reset,
  output        io_master_writeAddr_ready,
  input         io_master_writeAddr_valid,
  input  [16:0] io_master_writeAddr_bits_id,
  input  [31:0] io_master_writeAddr_bits_addr,
  input  [1:0]  io_master_writeAddr_bits_size,
  output        io_master_writeData_ready,
  input         io_master_writeData_valid,
  input  [31:0] io_master_writeData_bits_data,
  input  [3:0]  io_master_writeData_bits_strb,
  input         io_master_writeData_bits_last,
  input         io_master_writeResp_ready,
  output        io_master_writeResp_valid,
  output [16:0] io_master_writeResp_bits_id,
  output [1:0]  io_master_writeResp_bits_resp,
  input         io_slave_0_writeAddr_ready,
  output        io_slave_0_writeAddr_valid,
  output [16:0] io_slave_0_writeAddr_bits_id,
  output [31:0] io_slave_0_writeAddr_bits_addr,
  output [1:0]  io_slave_0_writeAddr_bits_size,
  input         io_slave_0_writeData_ready,
  output        io_slave_0_writeData_valid,
  output [31:0] io_slave_0_writeData_bits_data,
  output [3:0]  io_slave_0_writeData_bits_strb,
  output        io_slave_0_writeData_bits_last,
  output        io_slave_0_writeResp_ready,
  input         io_slave_0_writeResp_valid,
  input  [16:0] io_slave_0_writeResp_bits_id,
  input  [1:0]  io_slave_0_writeResp_bits_resp,
  input         io_slave_1_writeAddr_ready,
  output        io_slave_1_writeAddr_valid,
  output [16:0] io_slave_1_writeAddr_bits_id,
  output [31:0] io_slave_1_writeAddr_bits_addr,
  output [1:0]  io_slave_1_writeAddr_bits_size,
  input         io_slave_1_writeData_ready,
  output        io_slave_1_writeData_valid,
  output [31:0] io_slave_1_writeData_bits_data,
  output [3:0]  io_slave_1_writeData_bits_strb,
  output        io_slave_1_writeData_bits_last,
  output        io_slave_1_writeResp_ready,
  input         io_slave_1_writeResp_valid,
  input  [16:0] io_slave_1_writeResp_bits_id,
  input  [1:0]  io_slave_1_writeResp_bits_resp,
  input         io_slave_2_writeAddr_ready,
  output        io_slave_2_writeAddr_valid,
  output [16:0] io_slave_2_writeAddr_bits_id,
  output [31:0] io_slave_2_writeAddr_bits_addr,
  output [1:0]  io_slave_2_writeAddr_bits_size,
  input         io_slave_2_writeData_ready,
  output        io_slave_2_writeData_valid,
  output [31:0] io_slave_2_writeData_bits_data,
  output [3:0]  io_slave_2_writeData_bits_strb,
  output        io_slave_2_writeData_bits_last,
  output        io_slave_2_writeResp_ready,
  input         io_slave_2_writeResp_valid,
  input  [16:0] io_slave_2_writeResp_bits_id,
  input  [1:0]  io_slave_2_writeResp_bits_resp
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  wire  _write_port_T_2 = io_master_writeAddr_bits_addr >= 32'h8000 & io_master_writeAddr_bits_addr < 32'h10000; // @[AXIWriteBus.scala 25:54]
  wire  _write_port_T_5 = io_master_writeAddr_bits_addr >= 32'h100000 & io_master_writeAddr_bits_addr < 32'h300000; // @[AXIWriteBus.scala 25:54]
  wire  _write_port_T_8 = io_master_writeAddr_bits_addr >= 32'h300000 & io_master_writeAddr_bits_addr < 32'h400000; // @[AXIWriteBus.scala 25:54]
  wire [1:0] _write_port_T_9 = _write_port_T_8 ? 2'h2 : 2'h0; // @[Mux.scala 101:16]
  wire [1:0] _write_port_T_10 = _write_port_T_5 ? 2'h1 : _write_port_T_9; // @[Mux.scala 101:16]
  wire [1:0] write_port = _write_port_T_2 ? 2'h0 : _write_port_T_10; // @[Mux.scala 101:16]
  reg [2:0] write_port_reg; // @[AXIWriteBus.scala 28:31]
  reg [31:0] write_addr_reg; // @[AXIWriteBus.scala 30:31]
  reg  write_addr_reg_valid; // @[AXIWriteBus.scala 31:37]
  reg [16:0] write_addr_reg_id; // @[AXIWriteBus.scala 32:34]
  reg [2:0] write_addr_reg_size; // @[AXIWriteBus.scala 33:36]
  reg [31:0] write_data_reg; // @[AXIWriteBus.scala 35:31]
  reg  write_data_reg_valid; // @[AXIWriteBus.scala 36:37]
  reg [3:0] write_data_reg_strb; // @[AXIWriteBus.scala 37:36]
  reg  write_data_reg_last; // @[AXIWriteBus.scala 38:36]
  reg [16:0] write_resp_reg; // @[AXIWriteBus.scala 40:31]
  reg  write_resp_reg_valid; // @[AXIWriteBus.scala 41:37]
  reg [16:0] write_resp_reg_id; // @[AXIWriteBus.scala 42:34]
  reg  w_outstanding; // @[AXIWriteBus.scala 45:30]
  reg  aw_outstanding; // @[AXIWriteBus.scala 46:31]
  reg  b_outstanding; // @[AXIWriteBus.scala 47:30]
  wire  _T = io_master_writeAddr_ready & io_master_writeAddr_valid; // @[Decoupled.scala 52:35]
  wire  _GEN_0 = _T | aw_outstanding; // @[AXIWriteBus.scala 75:34 76:20 46:31]
  wire  _GEN_3 = _T | write_addr_reg_valid; // @[AXIWriteBus.scala 75:34 79:26 31:37]
  wire  _T_1 = io_master_writeData_ready & io_master_writeData_valid; // @[Decoupled.scala 52:35]
  wire  _GEN_6 = _T_1 | w_outstanding; // @[AXIWriteBus.scala 83:34 84:19 45:30]
  wire  _GEN_9 = _T_1 | write_data_reg_valid; // @[AXIWriteBus.scala 83:34 87:26 36:37]
  wire  _GEN_12 = 2'h1 == write_port_reg[1:0] ? io_slave_1_writeAddr_ready : io_slave_0_writeAddr_ready; // @[AXIWriteBus.scala 91:{29,29}]
  wire  _GEN_13 = 2'h2 == write_port_reg[1:0] ? io_slave_2_writeAddr_ready : _GEN_12; // @[AXIWriteBus.scala 91:{29,29}]
  wire  _GEN_16 = 2'h1 == write_port_reg[1:0] ? io_slave_1_writeData_ready : io_slave_0_writeData_ready; // @[AXIWriteBus.scala 94:{29,29}]
  wire  _GEN_17 = 2'h2 == write_port_reg[1:0] ? io_slave_2_writeData_ready : _GEN_16; // @[AXIWriteBus.scala 94:{29,29}]
  wire  _GEN_19 = aw_outstanding & w_outstanding & write_resp_reg_valid & io_master_writeResp_ready ? 1'h0 :
    write_resp_reg_valid; // @[AXIWriteBus.scala 97:94 98:28 41:37]
  wire  _GEN_22 = aw_outstanding & w_outstanding & write_resp_reg_valid & io_master_writeResp_ready ? 1'h0 :
    b_outstanding; // @[AXIWriteBus.scala 101:21 47:30 97:94]
  wire  _GEN_24 = 2'h1 == write_port_reg[1:0] ? io_slave_1_writeResp_ready : io_slave_0_writeResp_ready; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_25 = 2'h2 == write_port_reg[1:0] ? io_slave_2_writeResp_ready : _GEN_24; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_27 = 2'h1 == write_port_reg[1:0] ? io_slave_1_writeResp_valid : io_slave_0_writeResp_valid; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_28 = 2'h2 == write_port_reg[1:0] ? io_slave_2_writeResp_valid : _GEN_27; // @[Decoupled.scala 52:{35,35}]
  wire  _T_10 = _GEN_25 & _GEN_28; // @[Decoupled.scala 52:35]
  wire [1:0] _GEN_30 = 2'h1 == write_port_reg[1:0] ? io_slave_1_writeResp_bits_resp : io_slave_0_writeResp_bits_resp; // @[AXIWriteBus.scala 108:{22,22}]
  wire [1:0] _GEN_31 = 2'h2 == write_port_reg[1:0] ? io_slave_2_writeResp_bits_resp : _GEN_30; // @[AXIWriteBus.scala 108:{22,22}]
  wire [16:0] _GEN_33 = 2'h1 == write_port_reg[1:0] ? io_slave_1_writeResp_bits_id : io_slave_0_writeResp_bits_id; // @[AXIWriteBus.scala 109:{25,25}]
  wire  _GEN_35 = _T_10 | _GEN_22; // @[AXIWriteBus.scala 105:50 106:21]
  wire  _GEN_36 = _T_10 | _GEN_19; // @[AXIWriteBus.scala 105:50 107:28]
  wire [31:0] _GEN_39 = 2'h0 == write_port_reg[1:0] ? write_addr_reg : 32'h0; // @[AXIWriteBus.scala 111:{50,50} 56:37]
  wire [31:0] _GEN_40 = 2'h1 == write_port_reg[1:0] ? write_addr_reg : 32'h0; // @[AXIWriteBus.scala 111:{50,50} 56:37]
  wire [31:0] _GEN_41 = 2'h2 == write_port_reg[1:0] ? write_addr_reg : 32'h0; // @[AXIWriteBus.scala 111:{50,50} 56:37]
  wire  _GEN_97 = 2'h0 == write_port_reg[1:0]; // @[AXIWriteBus.scala 112:{46,46} 55:33]
  wire  _GEN_42 = 2'h0 == write_port_reg[1:0] & write_addr_reg_valid; // @[AXIWriteBus.scala 112:{46,46} 55:33]
  wire  _GEN_98 = 2'h1 == write_port_reg[1:0]; // @[AXIWriteBus.scala 112:{46,46} 55:33]
  wire  _GEN_43 = 2'h1 == write_port_reg[1:0] & write_addr_reg_valid; // @[AXIWriteBus.scala 112:{46,46} 55:33]
  wire  _GEN_99 = 2'h2 == write_port_reg[1:0]; // @[AXIWriteBus.scala 112:{46,46} 55:33]
  wire  _GEN_44 = 2'h2 == write_port_reg[1:0] & write_addr_reg_valid; // @[AXIWriteBus.scala 112:{46,46} 55:33]
  wire [16:0] _GEN_45 = 2'h0 == write_port_reg[1:0] ? write_addr_reg_id : 17'h0; // @[AXIWriteBus.scala 113:{48,48} 57:35]
  wire [16:0] _GEN_46 = 2'h1 == write_port_reg[1:0] ? write_addr_reg_id : 17'h0; // @[AXIWriteBus.scala 113:{48,48} 57:35]
  wire [16:0] _GEN_47 = 2'h2 == write_port_reg[1:0] ? write_addr_reg_id : 17'h0; // @[AXIWriteBus.scala 113:{48,48} 57:35]
  wire [1:0] _GEN_48 = 2'h0 == write_port_reg[1:0] ? write_addr_reg_size[1:0] : 2'h0; // @[AXIWriteBus.scala 114:{50,50} 60:37]
  wire [1:0] _GEN_49 = 2'h1 == write_port_reg[1:0] ? write_addr_reg_size[1:0] : 2'h0; // @[AXIWriteBus.scala 114:{50,50} 60:37]
  wire [1:0] _GEN_50 = 2'h2 == write_port_reg[1:0] ? write_addr_reg_size[1:0] : 2'h0; // @[AXIWriteBus.scala 114:{50,50} 60:37]
  wire [31:0] _GEN_51 = 2'h0 == write_port_reg[1:0] ? write_data_reg : 32'h0; // @[AXIWriteBus.scala 115:{50,50} 52:37]
  wire [31:0] _GEN_52 = 2'h1 == write_port_reg[1:0] ? write_data_reg : 32'h0; // @[AXIWriteBus.scala 115:{50,50} 52:37]
  wire [31:0] _GEN_53 = 2'h2 == write_port_reg[1:0] ? write_data_reg : 32'h0; // @[AXIWriteBus.scala 115:{50,50} 52:37]
  wire [3:0] _GEN_54 = 2'h0 == write_port_reg[1:0] ? write_data_reg_strb : 4'h0; // @[AXIWriteBus.scala 116:{50,50} 53:37]
  wire [3:0] _GEN_55 = 2'h1 == write_port_reg[1:0] ? write_data_reg_strb : 4'h0; // @[AXIWriteBus.scala 116:{50,50} 53:37]
  wire [3:0] _GEN_56 = 2'h2 == write_port_reg[1:0] ? write_data_reg_strb : 4'h0; // @[AXIWriteBus.scala 116:{50,50} 53:37]
  wire  _GEN_57 = _GEN_97 & write_data_reg_valid; // @[AXIWriteBus.scala 117:{46,46} 51:33]
  wire  _GEN_58 = _GEN_98 & write_data_reg_valid; // @[AXIWriteBus.scala 117:{46,46} 51:33]
  wire  _GEN_59 = _GEN_99 & write_data_reg_valid; // @[AXIWriteBus.scala 117:{46,46} 51:33]
  wire  _GEN_60 = _GEN_97 & write_data_reg_last; // @[AXIWriteBus.scala 118:{50,50} 54:37]
  wire  _GEN_61 = _GEN_98 & write_data_reg_last; // @[AXIWriteBus.scala 118:{50,50} 54:37]
  wire  _GEN_62 = _GEN_99 & write_data_reg_last; // @[AXIWriteBus.scala 118:{50,50} 54:37]
  wire  _GEN_63 = _GEN_97 & ~b_outstanding; // @[AXIWriteBus.scala 119:{46,46} 66:33]
  wire  _GEN_64 = _GEN_98 & ~b_outstanding; // @[AXIWriteBus.scala 119:{46,46} 66:33]
  wire  _GEN_65 = _GEN_99 & ~b_outstanding; // @[AXIWriteBus.scala 119:{46,46} 66:33]
  assign io_master_writeAddr_ready = ~aw_outstanding; // @[AXIWriteBus.scala 69:32]
  assign io_master_writeData_ready = ~w_outstanding; // @[AXIWriteBus.scala 68:32]
  assign io_master_writeResp_valid = write_resp_reg_valid; // @[AXIWriteBus.scala 70:29]
  assign io_master_writeResp_bits_id = write_resp_reg_id; // @[AXIWriteBus.scala 72:31]
  assign io_master_writeResp_bits_resp = write_resp_reg[1:0]; // @[AXIWriteBus.scala 71:33]
  assign io_slave_0_writeAddr_valid = aw_outstanding & _GEN_42; // @[AXIWriteBus.scala 104:24 55:33]
  assign io_slave_0_writeAddr_bits_id = aw_outstanding ? _GEN_45 : 17'h0; // @[AXIWriteBus.scala 104:24 57:35]
  assign io_slave_0_writeAddr_bits_addr = aw_outstanding ? _GEN_39 : 32'h0; // @[AXIWriteBus.scala 104:24 56:37]
  assign io_slave_0_writeAddr_bits_size = aw_outstanding ? _GEN_48 : 2'h0; // @[AXIWriteBus.scala 104:24 60:37]
  assign io_slave_0_writeData_valid = aw_outstanding & _GEN_57; // @[AXIWriteBus.scala 104:24 51:33]
  assign io_slave_0_writeData_bits_data = aw_outstanding ? _GEN_51 : 32'h0; // @[AXIWriteBus.scala 104:24 52:37]
  assign io_slave_0_writeData_bits_strb = aw_outstanding ? _GEN_54 : 4'h0; // @[AXIWriteBus.scala 104:24 53:37]
  assign io_slave_0_writeData_bits_last = aw_outstanding & _GEN_60; // @[AXIWriteBus.scala 104:24 54:37]
  assign io_slave_0_writeResp_ready = aw_outstanding & _GEN_63; // @[AXIWriteBus.scala 104:24 66:33]
  assign io_slave_1_writeAddr_valid = aw_outstanding & _GEN_43; // @[AXIWriteBus.scala 104:24 55:33]
  assign io_slave_1_writeAddr_bits_id = aw_outstanding ? _GEN_46 : 17'h0; // @[AXIWriteBus.scala 104:24 57:35]
  assign io_slave_1_writeAddr_bits_addr = aw_outstanding ? _GEN_40 : 32'h0; // @[AXIWriteBus.scala 104:24 56:37]
  assign io_slave_1_writeAddr_bits_size = aw_outstanding ? _GEN_49 : 2'h0; // @[AXIWriteBus.scala 104:24 60:37]
  assign io_slave_1_writeData_valid = aw_outstanding & _GEN_58; // @[AXIWriteBus.scala 104:24 51:33]
  assign io_slave_1_writeData_bits_data = aw_outstanding ? _GEN_52 : 32'h0; // @[AXIWriteBus.scala 104:24 52:37]
  assign io_slave_1_writeData_bits_strb = aw_outstanding ? _GEN_55 : 4'h0; // @[AXIWriteBus.scala 104:24 53:37]
  assign io_slave_1_writeData_bits_last = aw_outstanding & _GEN_61; // @[AXIWriteBus.scala 104:24 54:37]
  assign io_slave_1_writeResp_ready = aw_outstanding & _GEN_64; // @[AXIWriteBus.scala 104:24 66:33]
  assign io_slave_2_writeAddr_valid = aw_outstanding & _GEN_44; // @[AXIWriteBus.scala 104:24 55:33]
  assign io_slave_2_writeAddr_bits_id = aw_outstanding ? _GEN_47 : 17'h0; // @[AXIWriteBus.scala 104:24 57:35]
  assign io_slave_2_writeAddr_bits_addr = aw_outstanding ? _GEN_41 : 32'h0; // @[AXIWriteBus.scala 104:24 56:37]
  assign io_slave_2_writeAddr_bits_size = aw_outstanding ? _GEN_50 : 2'h0; // @[AXIWriteBus.scala 104:24 60:37]
  assign io_slave_2_writeData_valid = aw_outstanding & _GEN_59; // @[AXIWriteBus.scala 104:24 51:33]
  assign io_slave_2_writeData_bits_data = aw_outstanding ? _GEN_53 : 32'h0; // @[AXIWriteBus.scala 104:24 52:37]
  assign io_slave_2_writeData_bits_strb = aw_outstanding ? _GEN_56 : 4'h0; // @[AXIWriteBus.scala 104:24 53:37]
  assign io_slave_2_writeData_bits_last = aw_outstanding & _GEN_62; // @[AXIWriteBus.scala 104:24 54:37]
  assign io_slave_2_writeResp_ready = aw_outstanding & _GEN_65; // @[AXIWriteBus.scala 104:24 66:33]
  always @(posedge clock) begin
    if (reset) begin // @[AXIWriteBus.scala 28:31]
      write_port_reg <= 3'h0; // @[AXIWriteBus.scala 28:31]
    end else if (_T) begin // @[AXIWriteBus.scala 75:34]
      write_port_reg <= {{1'd0}, write_port}; // @[AXIWriteBus.scala 77:20]
    end
    if (reset) begin // @[AXIWriteBus.scala 30:31]
      write_addr_reg <= 32'h0; // @[AXIWriteBus.scala 30:31]
    end else if (_T) begin // @[AXIWriteBus.scala 75:34]
      write_addr_reg <= io_master_writeAddr_bits_addr; // @[AXIWriteBus.scala 78:20]
    end
    if (reset) begin // @[AXIWriteBus.scala 31:37]
      write_addr_reg_valid <= 1'h0; // @[AXIWriteBus.scala 31:37]
    end else if (write_addr_reg_valid & _GEN_13) begin // @[AXIWriteBus.scala 91:74]
      write_addr_reg_valid <= 1'h0; // @[AXIWriteBus.scala 92:28]
    end else begin
      write_addr_reg_valid <= _GEN_3;
    end
    if (reset) begin // @[AXIWriteBus.scala 32:34]
      write_addr_reg_id <= 17'h0; // @[AXIWriteBus.scala 32:34]
    end else if (_T) begin // @[AXIWriteBus.scala 75:34]
      write_addr_reg_id <= io_master_writeAddr_bits_id; // @[AXIWriteBus.scala 80:23]
    end
    if (reset) begin // @[AXIWriteBus.scala 33:36]
      write_addr_reg_size <= 3'h0; // @[AXIWriteBus.scala 33:36]
    end else if (_T) begin // @[AXIWriteBus.scala 75:34]
      write_addr_reg_size <= {{1'd0}, io_master_writeAddr_bits_size}; // @[AXIWriteBus.scala 81:25]
    end
    if (reset) begin // @[AXIWriteBus.scala 35:31]
      write_data_reg <= 32'h0; // @[AXIWriteBus.scala 35:31]
    end else if (_T_1) begin // @[AXIWriteBus.scala 83:34]
      write_data_reg <= io_master_writeData_bits_data; // @[AXIWriteBus.scala 86:20]
    end
    if (reset) begin // @[AXIWriteBus.scala 36:37]
      write_data_reg_valid <= 1'h0; // @[AXIWriteBus.scala 36:37]
    end else if (write_data_reg_valid & _GEN_17) begin // @[AXIWriteBus.scala 94:74]
      write_data_reg_valid <= 1'h0; // @[AXIWriteBus.scala 95:28]
    end else begin
      write_data_reg_valid <= _GEN_9;
    end
    if (reset) begin // @[AXIWriteBus.scala 37:36]
      write_data_reg_strb <= 4'h0; // @[AXIWriteBus.scala 37:36]
    end else if (_T_1) begin // @[AXIWriteBus.scala 83:34]
      write_data_reg_strb <= io_master_writeData_bits_strb; // @[AXIWriteBus.scala 85:25]
    end
    if (reset) begin // @[AXIWriteBus.scala 38:36]
      write_data_reg_last <= 1'h0; // @[AXIWriteBus.scala 38:36]
    end else if (_T_1) begin // @[AXIWriteBus.scala 83:34]
      write_data_reg_last <= io_master_writeData_bits_last; // @[AXIWriteBus.scala 88:25]
    end
    if (reset) begin // @[AXIWriteBus.scala 40:31]
      write_resp_reg <= 17'h0; // @[AXIWriteBus.scala 40:31]
    end else if (aw_outstanding) begin // @[AXIWriteBus.scala 104:24]
      if (_T_10) begin // @[AXIWriteBus.scala 105:50]
        write_resp_reg <= {{15'd0}, _GEN_31}; // @[AXIWriteBus.scala 108:22]
      end
    end
    if (reset) begin // @[AXIWriteBus.scala 41:37]
      write_resp_reg_valid <= 1'h0; // @[AXIWriteBus.scala 41:37]
    end else if (aw_outstanding) begin // @[AXIWriteBus.scala 104:24]
      write_resp_reg_valid <= _GEN_36;
    end else if (aw_outstanding & w_outstanding & write_resp_reg_valid & io_master_writeResp_ready) begin // @[AXIWriteBus.scala 97:94]
      write_resp_reg_valid <= 1'h0; // @[AXIWriteBus.scala 98:28]
    end
    if (reset) begin // @[AXIWriteBus.scala 42:34]
      write_resp_reg_id <= 17'h0; // @[AXIWriteBus.scala 42:34]
    end else if (aw_outstanding) begin // @[AXIWriteBus.scala 104:24]
      if (_T_10) begin // @[AXIWriteBus.scala 105:50]
        if (2'h2 == write_port_reg[1:0]) begin // @[AXIWriteBus.scala 109:25]
          write_resp_reg_id <= io_slave_2_writeResp_bits_id; // @[AXIWriteBus.scala 109:25]
        end else begin
          write_resp_reg_id <= _GEN_33;
        end
      end
    end
    if (reset) begin // @[AXIWriteBus.scala 45:30]
      w_outstanding <= 1'h0; // @[AXIWriteBus.scala 45:30]
    end else if (aw_outstanding & w_outstanding & write_resp_reg_valid & io_master_writeResp_ready) begin // @[AXIWriteBus.scala 97:94]
      w_outstanding <= 1'h0; // @[AXIWriteBus.scala 100:21]
    end else begin
      w_outstanding <= _GEN_6;
    end
    if (reset) begin // @[AXIWriteBus.scala 46:31]
      aw_outstanding <= 1'h0; // @[AXIWriteBus.scala 46:31]
    end else if (aw_outstanding & w_outstanding & write_resp_reg_valid & io_master_writeResp_ready) begin // @[AXIWriteBus.scala 97:94]
      aw_outstanding <= 1'h0; // @[AXIWriteBus.scala 99:22]
    end else begin
      aw_outstanding <= _GEN_0;
    end
    if (reset) begin // @[AXIWriteBus.scala 47:30]
      b_outstanding <= 1'h0; // @[AXIWriteBus.scala 47:30]
    end else if (aw_outstanding) begin // @[AXIWriteBus.scala 104:24]
      b_outstanding <= _GEN_35;
    end else if (aw_outstanding & w_outstanding & write_resp_reg_valid & io_master_writeResp_ready) begin // @[AXIWriteBus.scala 97:94]
      b_outstanding <= 1'h0; // @[AXIWriteBus.scala 101:21]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  write_port_reg = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  write_addr_reg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  write_addr_reg_valid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  write_addr_reg_id = _RAND_3[16:0];
  _RAND_4 = {1{`RANDOM}};
  write_addr_reg_size = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  write_data_reg = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  write_data_reg_valid = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  write_data_reg_strb = _RAND_7[3:0];
  _RAND_8 = {1{`RANDOM}};
  write_data_reg_last = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  write_resp_reg = _RAND_9[16:0];
  _RAND_10 = {1{`RANDOM}};
  write_resp_reg_valid = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  write_resp_reg_id = _RAND_11[16:0];
  _RAND_12 = {1{`RANDOM}};
  w_outstanding = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  aw_outstanding = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  b_outstanding = _RAND_14[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AXISlaveWriteMux(
  input         clock,
  input         reset,
  input         io_out_writeAddr_ready,
  output        io_out_writeAddr_valid,
  output [16:0] io_out_writeAddr_bits_id,
  output [31:0] io_out_writeAddr_bits_addr,
  output [1:0]  io_out_writeAddr_bits_size,
  input         io_out_writeData_ready,
  output        io_out_writeData_valid,
  output [31:0] io_out_writeData_bits_data,
  output [3:0]  io_out_writeData_bits_strb,
  output        io_out_writeData_bits_last,
  output        io_out_writeResp_ready,
  input         io_out_writeResp_valid,
  input  [16:0] io_out_writeResp_bits_id,
  input  [1:0]  io_out_writeResp_bits_resp,
  output        io_in_0_writeAddr_ready,
  input         io_in_0_writeAddr_valid,
  input  [16:0] io_in_0_writeAddr_bits_id,
  input  [31:0] io_in_0_writeAddr_bits_addr,
  input  [1:0]  io_in_0_writeAddr_bits_size,
  output        io_in_0_writeData_ready,
  input         io_in_0_writeData_valid,
  input  [31:0] io_in_0_writeData_bits_data,
  input  [3:0]  io_in_0_writeData_bits_strb,
  input         io_in_0_writeData_bits_last,
  input         io_in_0_writeResp_ready,
  output        io_in_0_writeResp_valid,
  output [16:0] io_in_0_writeResp_bits_id,
  output [1:0]  io_in_0_writeResp_bits_resp,
  output        io_in_1_writeAddr_ready,
  input         io_in_1_writeAddr_valid,
  input  [16:0] io_in_1_writeAddr_bits_id,
  input  [31:0] io_in_1_writeAddr_bits_addr,
  input  [1:0]  io_in_1_writeAddr_bits_size,
  output        io_in_1_writeData_ready,
  input         io_in_1_writeData_valid,
  input  [31:0] io_in_1_writeData_bits_data,
  input  [3:0]  io_in_1_writeData_bits_strb,
  input         io_in_1_writeData_bits_last,
  input         io_in_1_writeResp_ready,
  output        io_in_1_writeResp_valid,
  output [16:0] io_in_1_writeResp_bits_id,
  output [1:0]  io_in_1_writeResp_bits_resp,
  output        io_in_2_writeAddr_ready,
  input         io_in_2_writeAddr_valid,
  input  [16:0] io_in_2_writeAddr_bits_id,
  input  [31:0] io_in_2_writeAddr_bits_addr,
  input  [1:0]  io_in_2_writeAddr_bits_size,
  output        io_in_2_writeData_ready,
  input         io_in_2_writeData_valid,
  input  [31:0] io_in_2_writeData_bits_data,
  input  [3:0]  io_in_2_writeData_bits_strb,
  input         io_in_2_writeData_bits_last,
  input         io_in_2_writeResp_ready,
  output        io_in_2_writeResp_valid,
  output [16:0] io_in_2_writeResp_bits_id,
  output [1:0]  io_in_2_writeResp_bits_resp
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  wire  arbiter_clock; // @[AXISlaveWriteMux.scala 34:23]
  wire  arbiter_io_in_0_ready; // @[AXISlaveWriteMux.scala 34:23]
  wire  arbiter_io_in_0_valid; // @[AXISlaveWriteMux.scala 34:23]
  wire  arbiter_io_in_1_ready; // @[AXISlaveWriteMux.scala 34:23]
  wire  arbiter_io_in_1_valid; // @[AXISlaveWriteMux.scala 34:23]
  wire  arbiter_io_in_2_ready; // @[AXISlaveWriteMux.scala 34:23]
  wire  arbiter_io_in_2_valid; // @[AXISlaveWriteMux.scala 34:23]
  wire  arbiter_io_out_valid; // @[AXISlaveWriteMux.scala 34:23]
  wire [1:0] arbiter_io_chosen; // @[AXISlaveWriteMux.scala 34:23]
  reg [1:0] state; // @[AXISlaveWriteMux.scala 29:22]
  wire  outstanding = io_in_0_writeAddr_valid | io_in_1_writeAddr_valid | io_in_2_writeAddr_valid; // @[AXISlaveWriteMux.scala 31:96]
  reg [1:0] chosen_reg; // @[AXISlaveWriteMux.scala 35:27]
  reg  w_determined; // @[AXISlaveWriteMux.scala 36:29]
  reg  aw_determined; // @[AXISlaveWriteMux.scala 37:30]
  reg [16:0] address_reg_id; // @[AXISlaveWriteMux.scala 39:28]
  reg [31:0] address_reg_addr; // @[AXISlaveWriteMux.scala 39:28]
  reg [1:0] address_reg_size; // @[AXISlaveWriteMux.scala 39:28]
  reg [31:0] data_reg_data; // @[AXISlaveWriteMux.scala 44:25]
  reg [3:0] data_reg_strb; // @[AXISlaveWriteMux.scala 44:25]
  reg  data_reg_last; // @[AXISlaveWriteMux.scala 44:25]
  reg [16:0] resp_reg_id; // @[AXISlaveWriteMux.scala 49:25]
  reg [1:0] resp_reg_resp; // @[AXISlaveWriteMux.scala 49:25]
  wire  _T_21 = state == 2'h2; // @[AXISlaveWriteMux.scala 134:19]
  wire  _GEN_121 = state == 2'h3 ? 1'h0 : 1'h1; // @[AXISlaveWriteMux.scala 147:31 148:20]
  wire  _GEN_127 = state == 2'h2 ? 1'h0 : _GEN_121; // @[AXISlaveWriteMux.scala 134:33 135:22]
  wire  _GEN_138 = state == 2'h1 ? 1'h0 : _GEN_127; // @[AXISlaveWriteMux.scala 123:33 124:20]
  wire  mask_0 = state == 2'h0 | _GEN_138; // @[AXISlaveWriteMux.scala 109:24 110:20]
  wire  _GEN_1 = 2'h1 == arbiter_io_chosen ? io_in_1_writeData_ready : io_in_0_writeData_ready; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_2 = 2'h2 == arbiter_io_chosen ? io_in_2_writeData_ready : _GEN_1; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_4 = 2'h1 == arbiter_io_chosen ? io_in_1_writeData_valid : io_in_0_writeData_valid; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_5 = 2'h2 == arbiter_io_chosen ? io_in_2_writeData_valid : _GEN_4; // @[Decoupled.scala 52:{35,35}]
  wire  _T_1 = _GEN_2 & _GEN_5; // @[Decoupled.scala 52:35]
  wire  _GEN_9 = 2'h1 == chosen_reg ? io_in_1_writeData_ready : io_in_0_writeData_ready; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_10 = 2'h2 == chosen_reg ? io_in_2_writeData_ready : _GEN_9; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_12 = 2'h1 == chosen_reg ? io_in_1_writeData_valid : io_in_0_writeData_valid; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_13 = 2'h2 == chosen_reg ? io_in_2_writeData_valid : _GEN_12; // @[Decoupled.scala 52:{35,35}]
  wire  _T_5 = _GEN_10 & _GEN_13; // @[Decoupled.scala 52:35]
  wire  _T_7 = io_out_writeResp_ready & io_out_writeResp_valid; // @[Decoupled.scala 52:35]
  wire [1:0] _GEN_15 = _T_7 ? 2'h3 : state; // @[AXISlaveWriteMux.scala 98:34 99:15 29:22]
  wire  _GEN_17 = 2'h1 == chosen_reg ? io_in_1_writeResp_ready : io_in_0_writeResp_ready; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_18 = 2'h2 == chosen_reg ? io_in_2_writeResp_ready : _GEN_17; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_20 = 2'h1 == chosen_reg ? io_in_1_writeResp_valid : io_in_0_writeResp_valid; // @[Decoupled.scala 52:{35,35}]
  wire  _GEN_21 = 2'h2 == chosen_reg ? io_in_2_writeResp_valid : _GEN_20; // @[Decoupled.scala 52:{35,35}]
  wire  _T_11 = _GEN_18 & _GEN_21; // @[Decoupled.scala 52:35]
  wire [1:0] _GEN_22 = _T_11 ? 2'h0 : state; // @[AXISlaveWriteMux.scala 103:45 104:15 29:22]
  wire [1:0] _GEN_23 = 2'h3 == state ? _GEN_22 : state; // @[AXISlaveWriteMux.scala 81:16 29:22]
  wire  _GEN_27 = 2'h0 == arbiter_io_chosen; // @[AXISlaveWriteMux.scala 112:{46,46} 67:30]
  wire  _GEN_28 = 2'h1 == arbiter_io_chosen; // @[AXISlaveWriteMux.scala 112:{46,46} 67:30]
  wire  _GEN_29 = 2'h2 == arbiter_io_chosen; // @[AXISlaveWriteMux.scala 112:{46,46} 67:30]
  wire [16:0] _GEN_31 = 2'h1 == arbiter_io_chosen ? io_in_1_writeAddr_bits_id : io_in_0_writeAddr_bits_id; // @[AXISlaveWriteMux.scala 114:{19,19}]
  wire [31:0] _GEN_34 = 2'h1 == arbiter_io_chosen ? io_in_1_writeAddr_bits_addr : io_in_0_writeAddr_bits_addr; // @[AXISlaveWriteMux.scala 114:{19,19}]
  wire [1:0] _GEN_43 = 2'h1 == arbiter_io_chosen ? io_in_1_writeAddr_bits_size : io_in_0_writeAddr_bits_size; // @[AXISlaveWriteMux.scala 114:{19,19}]
  wire [31:0] _GEN_61 = 2'h1 == arbiter_io_chosen ? io_in_1_writeData_bits_data : io_in_0_writeData_bits_data; // @[AXISlaveWriteMux.scala 117:{18,18}]
  wire [31:0] _GEN_62 = 2'h2 == arbiter_io_chosen ? io_in_2_writeData_bits_data : _GEN_61; // @[AXISlaveWriteMux.scala 117:{18,18}]
  wire [3:0] _GEN_64 = 2'h1 == arbiter_io_chosen ? io_in_1_writeData_bits_strb : io_in_0_writeData_bits_strb; // @[AXISlaveWriteMux.scala 117:{18,18}]
  wire [3:0] _GEN_65 = 2'h2 == arbiter_io_chosen ? io_in_2_writeData_bits_strb : _GEN_64; // @[AXISlaveWriteMux.scala 117:{18,18}]
  wire  _GEN_67 = 2'h1 == arbiter_io_chosen ? io_in_1_writeData_bits_last : io_in_0_writeData_bits_last; // @[AXISlaveWriteMux.scala 117:{18,18}]
  wire  _GEN_68 = 2'h2 == arbiter_io_chosen ? io_in_2_writeData_bits_last : _GEN_67; // @[AXISlaveWriteMux.scala 117:{18,18}]
  wire  _GEN_72 = _T_1 | w_determined; // @[AXISlaveWriteMux.scala 116:59 118:22 36:29]
  wire  _GEN_73 = arbiter_io_out_valid & _GEN_27; // @[AXISlaveWriteMux.scala 111:31 67:30]
  wire  _GEN_74 = arbiter_io_out_valid & _GEN_28; // @[AXISlaveWriteMux.scala 111:31 67:30]
  wire  _GEN_75 = arbiter_io_out_valid & _GEN_29; // @[AXISlaveWriteMux.scala 111:31 67:30]
  wire  _GEN_87 = arbiter_io_out_valid | aw_determined; // @[AXISlaveWriteMux.scala 111:31 115:21 37:30]
  wire [31:0] _GEN_99 = 2'h1 == chosen_reg ? io_in_1_writeData_bits_data : io_in_0_writeData_bits_data; // @[AXISlaveWriteMux.scala 126:{16,16}]
  wire [31:0] _GEN_100 = 2'h2 == chosen_reg ? io_in_2_writeData_bits_data : _GEN_99; // @[AXISlaveWriteMux.scala 126:{16,16}]
  wire [3:0] _GEN_102 = 2'h1 == chosen_reg ? io_in_1_writeData_bits_strb : io_in_0_writeData_bits_strb; // @[AXISlaveWriteMux.scala 126:{16,16}]
  wire [3:0] _GEN_103 = 2'h2 == chosen_reg ? io_in_2_writeData_bits_strb : _GEN_102; // @[AXISlaveWriteMux.scala 126:{16,16}]
  wire  _GEN_105 = 2'h1 == chosen_reg ? io_in_1_writeData_bits_last : io_in_0_writeData_bits_last; // @[AXISlaveWriteMux.scala 126:{16,16}]
  wire  _GEN_106 = 2'h2 == chosen_reg ? io_in_2_writeData_bits_last : _GEN_105; // @[AXISlaveWriteMux.scala 126:{16,16}]
  wire  _T_18 = io_out_writeAddr_ready & io_out_writeAddr_valid; // @[Decoupled.scala 52:35]
  wire  _GEN_110 = _T_18 ? 1'h0 : aw_determined; // @[AXISlaveWriteMux.scala 128:32 129:21 37:30]
  wire  _GEN_111 = 2'h0 == chosen_reg; // @[AXISlaveWriteMux.scala 131:{39,39} 67:30]
  wire  _GEN_112 = 2'h1 == chosen_reg; // @[AXISlaveWriteMux.scala 131:{39,39} 67:30]
  wire  _GEN_113 = 2'h2 == chosen_reg; // @[AXISlaveWriteMux.scala 131:{39,39} 67:30]
  wire  _T_23 = io_out_writeData_ready & io_out_writeData_valid; // @[Decoupled.scala 52:35]
  wire  _GEN_115 = _T_23 ? 1'h0 : w_determined; // @[AXISlaveWriteMux.scala 139:34 140:22 36:29]
  wire [16:0] _GEN_116 = _T_7 ? io_out_writeResp_bits_id : resp_reg_id; // @[AXISlaveWriteMux.scala 142:34 143:18 49:25]
  wire [1:0] _GEN_117 = _T_7 ? io_out_writeResp_bits_resp : resp_reg_resp; // @[AXISlaveWriteMux.scala 142:34 143:18 49:25]
  wire  _GEN_124 = state == 2'h3 & _GEN_111; // @[AXISlaveWriteMux.scala 147:31 68:30]
  wire  _GEN_125 = state == 2'h3 & _GEN_112; // @[AXISlaveWriteMux.scala 147:31 68:30]
  wire  _GEN_126 = state == 2'h3 & _GEN_113; // @[AXISlaveWriteMux.scala 147:31 68:30]
  wire  _GEN_135 = state == 2'h2 ? 1'h0 : _GEN_124; // @[AXISlaveWriteMux.scala 134:33 68:30]
  wire  _GEN_136 = state == 2'h2 ? 1'h0 : _GEN_125; // @[AXISlaveWriteMux.scala 134:33 68:30]
  wire  _GEN_137 = state == 2'h2 ? 1'h0 : _GEN_126; // @[AXISlaveWriteMux.scala 134:33 68:30]
  wire  _GEN_145 = state == 2'h1 & _GEN_111; // @[AXISlaveWriteMux.scala 123:33 67:30]
  wire  _GEN_146 = state == 2'h1 & _GEN_112; // @[AXISlaveWriteMux.scala 123:33 67:30]
  wire  _GEN_147 = state == 2'h1 & _GEN_113; // @[AXISlaveWriteMux.scala 123:33 67:30]
  wire  _GEN_148 = state == 2'h1 ? 1'h0 : _T_21; // @[AXISlaveWriteMux.scala 123:33 132:28]
  wire  _GEN_152 = state == 2'h1 ? 1'h0 : _GEN_135; // @[AXISlaveWriteMux.scala 123:33 68:30]
  wire  _GEN_153 = state == 2'h1 ? 1'h0 : _GEN_136; // @[AXISlaveWriteMux.scala 123:33 68:30]
  wire  _GEN_154 = state == 2'h1 ? 1'h0 : _GEN_137; // @[AXISlaveWriteMux.scala 123:33 68:30]
  RRArbiter arbiter ( // @[AXISlaveWriteMux.scala 34:23]
    .clock(arbiter_clock),
    .io_in_0_ready(arbiter_io_in_0_ready),
    .io_in_0_valid(arbiter_io_in_0_valid),
    .io_in_1_ready(arbiter_io_in_1_ready),
    .io_in_1_valid(arbiter_io_in_1_valid),
    .io_in_2_ready(arbiter_io_in_2_ready),
    .io_in_2_valid(arbiter_io_in_2_valid),
    .io_out_valid(arbiter_io_out_valid),
    .io_chosen(arbiter_io_chosen)
  );
  assign io_out_writeAddr_valid = aw_determined; // @[AXISlaveWriteMux.scala 78:26]
  assign io_out_writeAddr_bits_id = address_reg_id; // @[AXISlaveWriteMux.scala 153:25]
  assign io_out_writeAddr_bits_addr = address_reg_addr; // @[AXISlaveWriteMux.scala 153:25]
  assign io_out_writeAddr_bits_size = address_reg_size; // @[AXISlaveWriteMux.scala 153:25]
  assign io_out_writeData_valid = w_determined; // @[AXISlaveWriteMux.scala 79:26]
  assign io_out_writeData_bits_data = data_reg_data; // @[AXISlaveWriteMux.scala 152:25]
  assign io_out_writeData_bits_strb = data_reg_strb; // @[AXISlaveWriteMux.scala 152:25]
  assign io_out_writeData_bits_last = data_reg_last; // @[AXISlaveWriteMux.scala 152:25]
  assign io_out_writeResp_ready = state == 2'h0 ? 1'h0 : _GEN_148; // @[AXISlaveWriteMux.scala 109:24 121:28]
  assign io_in_0_writeAddr_ready = arbiter_io_in_0_ready & mask_0; // @[AXISlaveWriteMux.scala 74:56]
  assign io_in_0_writeData_ready = state == 2'h0 ? _GEN_73 : _GEN_145; // @[AXISlaveWriteMux.scala 109:24]
  assign io_in_0_writeResp_valid = state == 2'h0 ? 1'h0 : _GEN_152; // @[AXISlaveWriteMux.scala 109:24 68:30]
  assign io_in_0_writeResp_bits_id = 2'h0 == chosen_reg ? resp_reg_id : 17'h0; // @[AXISlaveWriteMux.scala 154:{36,36} 69:32]
  assign io_in_0_writeResp_bits_resp = 2'h0 == chosen_reg ? resp_reg_resp : 2'h0; // @[AXISlaveWriteMux.scala 154:{36,36} 70:34]
  assign io_in_1_writeAddr_ready = arbiter_io_in_1_ready & mask_0; // @[AXISlaveWriteMux.scala 74:56]
  assign io_in_1_writeData_ready = state == 2'h0 ? _GEN_74 : _GEN_146; // @[AXISlaveWriteMux.scala 109:24]
  assign io_in_1_writeResp_valid = state == 2'h0 ? 1'h0 : _GEN_153; // @[AXISlaveWriteMux.scala 109:24 68:30]
  assign io_in_1_writeResp_bits_id = 2'h1 == chosen_reg ? resp_reg_id : 17'h0; // @[AXISlaveWriteMux.scala 154:{36,36} 69:32]
  assign io_in_1_writeResp_bits_resp = 2'h1 == chosen_reg ? resp_reg_resp : 2'h0; // @[AXISlaveWriteMux.scala 154:{36,36} 70:34]
  assign io_in_2_writeAddr_ready = arbiter_io_in_2_ready & mask_0; // @[AXISlaveWriteMux.scala 74:56]
  assign io_in_2_writeData_ready = state == 2'h0 ? _GEN_75 : _GEN_147; // @[AXISlaveWriteMux.scala 109:24]
  assign io_in_2_writeResp_valid = state == 2'h0 ? 1'h0 : _GEN_154; // @[AXISlaveWriteMux.scala 109:24 68:30]
  assign io_in_2_writeResp_bits_id = 2'h2 == chosen_reg ? resp_reg_id : 17'h0; // @[AXISlaveWriteMux.scala 154:{36,36} 69:32]
  assign io_in_2_writeResp_bits_resp = 2'h2 == chosen_reg ? resp_reg_resp : 2'h0; // @[AXISlaveWriteMux.scala 154:{36,36} 70:34]
  assign arbiter_clock = clock;
  assign arbiter_io_in_0_valid = io_in_0_writeAddr_valid & mask_0; // @[AXISlaveWriteMux.scala 75:56]
  assign arbiter_io_in_1_valid = io_in_1_writeAddr_valid & mask_0; // @[AXISlaveWriteMux.scala 75:56]
  assign arbiter_io_in_2_valid = io_in_2_writeAddr_valid & mask_0; // @[AXISlaveWriteMux.scala 75:56]
  always @(posedge clock) begin
    if (reset) begin // @[AXISlaveWriteMux.scala 29:22]
      state <= 2'h0; // @[AXISlaveWriteMux.scala 29:22]
    end else if (2'h0 == state) begin // @[AXISlaveWriteMux.scala 81:16]
      if (outstanding) begin // @[AXISlaveWriteMux.scala 83:24]
        if (_T_1) begin // @[AXISlaveWriteMux.scala 84:61]
          state <= 2'h2; // @[AXISlaveWriteMux.scala 85:17]
        end else begin
          state <= 2'h1; // @[AXISlaveWriteMux.scala 88:17]
        end
      end
    end else if (2'h1 == state) begin // @[AXISlaveWriteMux.scala 81:16]
      if (_T_5) begin // @[AXISlaveWriteMux.scala 93:45]
        state <= 2'h2; // @[AXISlaveWriteMux.scala 94:15]
      end
    end else if (2'h2 == state) begin // @[AXISlaveWriteMux.scala 81:16]
      state <= _GEN_15;
    end else begin
      state <= _GEN_23;
    end
    if (reset) begin // @[AXISlaveWriteMux.scala 35:27]
      chosen_reg <= 2'h0; // @[AXISlaveWriteMux.scala 35:27]
    end else if (state == 2'h0) begin // @[AXISlaveWriteMux.scala 109:24]
      if (arbiter_io_out_valid) begin // @[AXISlaveWriteMux.scala 111:31]
        chosen_reg <= arbiter_io_chosen; // @[AXISlaveWriteMux.scala 113:18]
      end
    end
    if (reset) begin // @[AXISlaveWriteMux.scala 36:29]
      w_determined <= 1'h0; // @[AXISlaveWriteMux.scala 36:29]
    end else if (state == 2'h0) begin // @[AXISlaveWriteMux.scala 109:24]
      if (arbiter_io_out_valid) begin // @[AXISlaveWriteMux.scala 111:31]
        w_determined <= _GEN_72;
      end
    end else if (!(state == 2'h1)) begin // @[AXISlaveWriteMux.scala 123:33]
      if (state == 2'h2) begin // @[AXISlaveWriteMux.scala 134:33]
        w_determined <= _GEN_115;
      end
    end
    if (reset) begin // @[AXISlaveWriteMux.scala 37:30]
      aw_determined <= 1'h0; // @[AXISlaveWriteMux.scala 37:30]
    end else if (state == 2'h0) begin // @[AXISlaveWriteMux.scala 109:24]
      aw_determined <= _GEN_87;
    end else if (state == 2'h1) begin // @[AXISlaveWriteMux.scala 123:33]
      aw_determined <= _GEN_110;
    end else if (state == 2'h2) begin // @[AXISlaveWriteMux.scala 134:33]
      aw_determined <= _GEN_110;
    end
    if (reset) begin // @[AXISlaveWriteMux.scala 39:28]
      address_reg_id <= 17'h0; // @[AXISlaveWriteMux.scala 39:28]
    end else if (state == 2'h0) begin // @[AXISlaveWriteMux.scala 109:24]
      if (arbiter_io_out_valid) begin // @[AXISlaveWriteMux.scala 111:31]
        if (2'h2 == arbiter_io_chosen) begin // @[AXISlaveWriteMux.scala 114:19]
          address_reg_id <= io_in_2_writeAddr_bits_id; // @[AXISlaveWriteMux.scala 114:19]
        end else begin
          address_reg_id <= _GEN_31;
        end
      end
    end
    if (reset) begin // @[AXISlaveWriteMux.scala 39:28]
      address_reg_addr <= 32'h0; // @[AXISlaveWriteMux.scala 39:28]
    end else if (state == 2'h0) begin // @[AXISlaveWriteMux.scala 109:24]
      if (arbiter_io_out_valid) begin // @[AXISlaveWriteMux.scala 111:31]
        if (2'h2 == arbiter_io_chosen) begin // @[AXISlaveWriteMux.scala 114:19]
          address_reg_addr <= io_in_2_writeAddr_bits_addr; // @[AXISlaveWriteMux.scala 114:19]
        end else begin
          address_reg_addr <= _GEN_34;
        end
      end
    end
    if (reset) begin // @[AXISlaveWriteMux.scala 39:28]
      address_reg_size <= 2'h0; // @[AXISlaveWriteMux.scala 39:28]
    end else if (state == 2'h0) begin // @[AXISlaveWriteMux.scala 109:24]
      if (arbiter_io_out_valid) begin // @[AXISlaveWriteMux.scala 111:31]
        if (2'h2 == arbiter_io_chosen) begin // @[AXISlaveWriteMux.scala 114:19]
          address_reg_size <= io_in_2_writeAddr_bits_size; // @[AXISlaveWriteMux.scala 114:19]
        end else begin
          address_reg_size <= _GEN_43;
        end
      end
    end
    if (reset) begin // @[AXISlaveWriteMux.scala 44:25]
      data_reg_data <= 32'h0; // @[AXISlaveWriteMux.scala 44:25]
    end else if (state == 2'h0) begin // @[AXISlaveWriteMux.scala 109:24]
      if (arbiter_io_out_valid) begin // @[AXISlaveWriteMux.scala 111:31]
        if (_T_1) begin // @[AXISlaveWriteMux.scala 116:59]
          data_reg_data <= _GEN_62; // @[AXISlaveWriteMux.scala 117:18]
        end
      end
    end else if (state == 2'h1) begin // @[AXISlaveWriteMux.scala 123:33]
      if (_T_5) begin // @[AXISlaveWriteMux.scala 125:43]
        data_reg_data <= _GEN_100; // @[AXISlaveWriteMux.scala 126:16]
      end
    end
    if (reset) begin // @[AXISlaveWriteMux.scala 44:25]
      data_reg_strb <= 4'h0; // @[AXISlaveWriteMux.scala 44:25]
    end else if (state == 2'h0) begin // @[AXISlaveWriteMux.scala 109:24]
      if (arbiter_io_out_valid) begin // @[AXISlaveWriteMux.scala 111:31]
        if (_T_1) begin // @[AXISlaveWriteMux.scala 116:59]
          data_reg_strb <= _GEN_65; // @[AXISlaveWriteMux.scala 117:18]
        end
      end
    end else if (state == 2'h1) begin // @[AXISlaveWriteMux.scala 123:33]
      if (_T_5) begin // @[AXISlaveWriteMux.scala 125:43]
        data_reg_strb <= _GEN_103; // @[AXISlaveWriteMux.scala 126:16]
      end
    end
    if (reset) begin // @[AXISlaveWriteMux.scala 44:25]
      data_reg_last <= 1'h0; // @[AXISlaveWriteMux.scala 44:25]
    end else if (state == 2'h0) begin // @[AXISlaveWriteMux.scala 109:24]
      if (arbiter_io_out_valid) begin // @[AXISlaveWriteMux.scala 111:31]
        if (_T_1) begin // @[AXISlaveWriteMux.scala 116:59]
          data_reg_last <= _GEN_68; // @[AXISlaveWriteMux.scala 117:18]
        end
      end
    end else if (state == 2'h1) begin // @[AXISlaveWriteMux.scala 123:33]
      if (_T_5) begin // @[AXISlaveWriteMux.scala 125:43]
        data_reg_last <= _GEN_106; // @[AXISlaveWriteMux.scala 126:16]
      end
    end
    if (reset) begin // @[AXISlaveWriteMux.scala 49:25]
      resp_reg_id <= 17'h0; // @[AXISlaveWriteMux.scala 49:25]
    end else if (!(state == 2'h0)) begin // @[AXISlaveWriteMux.scala 109:24]
      if (!(state == 2'h1)) begin // @[AXISlaveWriteMux.scala 123:33]
        if (state == 2'h2) begin // @[AXISlaveWriteMux.scala 134:33]
          resp_reg_id <= _GEN_116;
        end
      end
    end
    if (reset) begin // @[AXISlaveWriteMux.scala 49:25]
      resp_reg_resp <= 2'h0; // @[AXISlaveWriteMux.scala 49:25]
    end else if (!(state == 2'h0)) begin // @[AXISlaveWriteMux.scala 109:24]
      if (!(state == 2'h1)) begin // @[AXISlaveWriteMux.scala 123:33]
        if (state == 2'h2) begin // @[AXISlaveWriteMux.scala 134:33]
          resp_reg_resp <= _GEN_117;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  chosen_reg = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  w_determined = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  aw_determined = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  address_reg_id = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  address_reg_addr = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  address_reg_size = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  data_reg_data = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  data_reg_strb = _RAND_8[3:0];
  _RAND_9 = {1{`RANDOM}};
  data_reg_last = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  resp_reg_id = _RAND_10[16:0];
  _RAND_11 = {1{`RANDOM}};
  resp_reg_resp = _RAND_11[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AXILiteXBar(
  input         clock,
  input         reset,
  output        io_masters_0_aw_ready,
  input         io_masters_0_aw_valid,
  input  [31:0] io_masters_0_aw_bits_addr,
  output        io_masters_0_w_ready,
  input         io_masters_0_w_valid,
  input  [31:0] io_masters_0_w_bits_data,
  input  [3:0]  io_masters_0_w_bits_strb,
  input         io_masters_0_b_ready,
  output        io_masters_0_b_valid,
  output        io_masters_0_ar_ready,
  input         io_masters_0_ar_valid,
  input  [31:0] io_masters_0_ar_bits_addr,
  input         io_masters_0_r_ready,
  output        io_masters_0_r_valid,
  output [31:0] io_masters_0_r_bits_data,
  output        io_masters_1_aw_ready,
  input         io_masters_1_aw_valid,
  input  [31:0] io_masters_1_aw_bits_addr,
  output        io_masters_1_w_ready,
  input         io_masters_1_w_valid,
  input  [31:0] io_masters_1_w_bits_data,
  input  [3:0]  io_masters_1_w_bits_strb,
  input         io_masters_1_b_ready,
  output        io_masters_1_b_valid,
  output        io_masters_1_ar_ready,
  input         io_masters_1_ar_valid,
  input  [31:0] io_masters_1_ar_bits_addr,
  input         io_masters_1_r_ready,
  output        io_masters_1_r_valid,
  output [31:0] io_masters_1_r_bits_data,
  output        io_masters_2_aw_ready,
  input         io_masters_2_aw_valid,
  input  [16:0] io_masters_2_aw_bits_id,
  input  [31:0] io_masters_2_aw_bits_addr,
  input  [1:0]  io_masters_2_aw_bits_size,
  output        io_masters_2_w_ready,
  input         io_masters_2_w_valid,
  input  [31:0] io_masters_2_w_bits_data,
  input  [3:0]  io_masters_2_w_bits_strb,
  input         io_masters_2_w_bits_last,
  input         io_masters_2_b_ready,
  output        io_masters_2_b_valid,
  output [16:0] io_masters_2_b_bits_id,
  output [1:0]  io_masters_2_b_bits_resp,
  output        io_masters_2_ar_ready,
  input         io_masters_2_ar_valid,
  input  [16:0] io_masters_2_ar_bits_id,
  input  [31:0] io_masters_2_ar_bits_addr,
  input  [1:0]  io_masters_2_ar_bits_size,
  input         io_masters_2_r_ready,
  output        io_masters_2_r_valid,
  output [16:0] io_masters_2_r_bits_id,
  output [31:0] io_masters_2_r_bits_data,
  output [1:0]  io_masters_2_r_bits_resp,
  output        io_masters_2_r_bits_last,
  input         io_slaves_0_aw_ready,
  output        io_slaves_0_aw_valid,
  output [31:0] io_slaves_0_aw_bits_addr,
  input         io_slaves_0_w_ready,
  output        io_slaves_0_w_valid,
  output [31:0] io_slaves_0_w_bits_data,
  output [3:0]  io_slaves_0_w_bits_strb,
  output        io_slaves_0_b_ready,
  input         io_slaves_0_b_valid,
  input         io_slaves_0_ar_ready,
  output        io_slaves_0_ar_valid,
  output [31:0] io_slaves_0_ar_bits_addr,
  output        io_slaves_0_r_ready,
  input         io_slaves_0_r_valid,
  input  [31:0] io_slaves_0_r_bits_data,
  input         io_slaves_1_aw_ready,
  output        io_slaves_1_aw_valid,
  output [31:0] io_slaves_1_aw_bits_addr,
  input         io_slaves_1_w_ready,
  output        io_slaves_1_w_valid,
  output [31:0] io_slaves_1_w_bits_data,
  output [3:0]  io_slaves_1_w_bits_strb,
  input         io_slaves_1_b_valid,
  input         io_slaves_1_ar_ready,
  output        io_slaves_1_ar_valid,
  output [31:0] io_slaves_1_ar_bits_addr,
  input         io_slaves_1_r_valid,
  input  [31:0] io_slaves_1_r_bits_data,
  input         io_slaves_2_aw_ready,
  output        io_slaves_2_aw_valid,
  output [16:0] io_slaves_2_aw_bits_id,
  output [31:0] io_slaves_2_aw_bits_addr,
  output [1:0]  io_slaves_2_aw_bits_size,
  input         io_slaves_2_w_ready,
  output        io_slaves_2_w_valid,
  output [31:0] io_slaves_2_w_bits_data,
  output [3:0]  io_slaves_2_w_bits_strb,
  output        io_slaves_2_w_bits_last,
  output        io_slaves_2_b_ready,
  input         io_slaves_2_b_valid,
  input  [16:0] io_slaves_2_b_bits_id,
  input  [1:0]  io_slaves_2_b_bits_resp,
  input         io_slaves_2_ar_ready,
  output        io_slaves_2_ar_valid,
  output [16:0] io_slaves_2_ar_bits_id,
  output [31:0] io_slaves_2_ar_bits_addr,
  output [1:0]  io_slaves_2_ar_bits_size,
  output        io_slaves_2_r_ready,
  input         io_slaves_2_r_valid,
  input  [16:0] io_slaves_2_r_bits_id,
  input  [31:0] io_slaves_2_r_bits_data,
  input  [1:0]  io_slaves_2_r_bits_resp,
  input         io_slaves_2_r_bits_last
);
  wire  readBuses_0_clock; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_reset; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_master_readAddr_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_master_readAddr_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_0_io_master_readAddr_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_0_io_master_readAddr_bits_addr; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_0_io_master_readAddr_bits_size; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_master_readData_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_master_readData_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_0_io_master_readData_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_0_io_master_readData_bits_data; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_0_io_master_readData_bits_resp; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_master_readData_bits_last; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_0_readAddr_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_0_readAddr_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_0_io_slave_0_readAddr_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_0_io_slave_0_readAddr_bits_addr; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_0_io_slave_0_readAddr_bits_size; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_0_readData_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_0_readData_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_0_io_slave_0_readData_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_0_io_slave_0_readData_bits_data; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_0_io_slave_0_readData_bits_resp; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_0_readData_bits_last; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_1_readAddr_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_1_readAddr_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_0_io_slave_1_readAddr_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_0_io_slave_1_readAddr_bits_addr; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_0_io_slave_1_readAddr_bits_size; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_1_readData_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_1_readData_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_0_io_slave_1_readData_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_0_io_slave_1_readData_bits_data; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_0_io_slave_1_readData_bits_resp; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_1_readData_bits_last; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_2_readAddr_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_2_readAddr_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_0_io_slave_2_readAddr_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_0_io_slave_2_readAddr_bits_addr; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_0_io_slave_2_readAddr_bits_size; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_2_readData_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_2_readData_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_0_io_slave_2_readData_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_0_io_slave_2_readData_bits_data; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_0_io_slave_2_readData_bits_resp; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_0_io_slave_2_readData_bits_last; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_clock; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_reset; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_master_readAddr_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_master_readAddr_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_1_io_master_readAddr_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_1_io_master_readAddr_bits_addr; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_1_io_master_readAddr_bits_size; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_master_readData_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_master_readData_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_1_io_master_readData_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_1_io_master_readData_bits_data; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_1_io_master_readData_bits_resp; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_master_readData_bits_last; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_0_readAddr_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_0_readAddr_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_1_io_slave_0_readAddr_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_1_io_slave_0_readAddr_bits_addr; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_1_io_slave_0_readAddr_bits_size; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_0_readData_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_0_readData_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_1_io_slave_0_readData_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_1_io_slave_0_readData_bits_data; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_1_io_slave_0_readData_bits_resp; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_0_readData_bits_last; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_1_readAddr_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_1_readAddr_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_1_io_slave_1_readAddr_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_1_io_slave_1_readAddr_bits_addr; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_1_io_slave_1_readAddr_bits_size; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_1_readData_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_1_readData_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_1_io_slave_1_readData_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_1_io_slave_1_readData_bits_data; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_1_io_slave_1_readData_bits_resp; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_1_readData_bits_last; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_2_readAddr_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_2_readAddr_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_1_io_slave_2_readAddr_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_1_io_slave_2_readAddr_bits_addr; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_1_io_slave_2_readAddr_bits_size; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_2_readData_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_2_readData_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_1_io_slave_2_readData_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_1_io_slave_2_readData_bits_data; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_1_io_slave_2_readData_bits_resp; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_1_io_slave_2_readData_bits_last; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_clock; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_reset; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_master_readAddr_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_master_readAddr_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_2_io_master_readAddr_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_2_io_master_readAddr_bits_addr; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_2_io_master_readAddr_bits_size; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_master_readData_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_master_readData_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_2_io_master_readData_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_2_io_master_readData_bits_data; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_2_io_master_readData_bits_resp; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_master_readData_bits_last; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_0_readAddr_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_0_readAddr_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_2_io_slave_0_readAddr_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_2_io_slave_0_readAddr_bits_addr; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_2_io_slave_0_readAddr_bits_size; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_0_readData_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_0_readData_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_2_io_slave_0_readData_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_2_io_slave_0_readData_bits_data; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_2_io_slave_0_readData_bits_resp; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_0_readData_bits_last; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_1_readAddr_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_1_readAddr_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_2_io_slave_1_readAddr_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_2_io_slave_1_readAddr_bits_addr; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_2_io_slave_1_readAddr_bits_size; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_1_readData_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_1_readData_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_2_io_slave_1_readData_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_2_io_slave_1_readData_bits_data; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_2_io_slave_1_readData_bits_resp; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_1_readData_bits_last; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_2_readAddr_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_2_readAddr_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_2_io_slave_2_readAddr_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_2_io_slave_2_readAddr_bits_addr; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_2_io_slave_2_readAddr_bits_size; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_2_readData_ready; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_2_readData_valid; // @[AXILiteXBar.scala 15:11]
  wire [16:0] readBuses_2_io_slave_2_readData_bits_id; // @[AXILiteXBar.scala 15:11]
  wire [31:0] readBuses_2_io_slave_2_readData_bits_data; // @[AXILiteXBar.scala 15:11]
  wire [1:0] readBuses_2_io_slave_2_readData_bits_resp; // @[AXILiteXBar.scala 15:11]
  wire  readBuses_2_io_slave_2_readData_bits_last; // @[AXILiteXBar.scala 15:11]
  wire  readMuxes_0_clock; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_reset; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_out_readAddr_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_out_readAddr_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_0_io_out_readAddr_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_0_io_out_readAddr_bits_addr; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_0_io_out_readAddr_bits_size; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_out_readData_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_out_readData_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_0_io_out_readData_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_0_io_out_readData_bits_data; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_0_io_out_readData_bits_resp; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_out_readData_bits_last; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_0_readAddr_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_0_readAddr_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_0_io_in_0_readAddr_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_0_io_in_0_readAddr_bits_addr; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_0_io_in_0_readAddr_bits_size; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_0_readData_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_0_readData_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_0_io_in_0_readData_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_0_io_in_0_readData_bits_data; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_0_io_in_0_readData_bits_resp; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_0_readData_bits_last; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_1_readAddr_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_1_readAddr_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_0_io_in_1_readAddr_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_0_io_in_1_readAddr_bits_addr; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_0_io_in_1_readAddr_bits_size; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_1_readData_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_1_readData_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_0_io_in_1_readData_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_0_io_in_1_readData_bits_data; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_0_io_in_1_readData_bits_resp; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_1_readData_bits_last; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_2_readAddr_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_2_readAddr_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_0_io_in_2_readAddr_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_0_io_in_2_readAddr_bits_addr; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_0_io_in_2_readAddr_bits_size; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_2_readData_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_2_readData_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_0_io_in_2_readData_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_0_io_in_2_readData_bits_data; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_0_io_in_2_readData_bits_resp; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_0_io_in_2_readData_bits_last; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_clock; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_reset; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_out_readAddr_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_out_readAddr_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_1_io_out_readAddr_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_1_io_out_readAddr_bits_addr; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_1_io_out_readAddr_bits_size; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_out_readData_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_out_readData_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_1_io_out_readData_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_1_io_out_readData_bits_data; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_1_io_out_readData_bits_resp; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_out_readData_bits_last; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_0_readAddr_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_0_readAddr_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_1_io_in_0_readAddr_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_1_io_in_0_readAddr_bits_addr; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_1_io_in_0_readAddr_bits_size; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_0_readData_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_0_readData_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_1_io_in_0_readData_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_1_io_in_0_readData_bits_data; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_1_io_in_0_readData_bits_resp; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_0_readData_bits_last; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_1_readAddr_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_1_readAddr_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_1_io_in_1_readAddr_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_1_io_in_1_readAddr_bits_addr; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_1_io_in_1_readAddr_bits_size; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_1_readData_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_1_readData_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_1_io_in_1_readData_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_1_io_in_1_readData_bits_data; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_1_io_in_1_readData_bits_resp; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_1_readData_bits_last; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_2_readAddr_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_2_readAddr_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_1_io_in_2_readAddr_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_1_io_in_2_readAddr_bits_addr; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_1_io_in_2_readAddr_bits_size; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_2_readData_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_2_readData_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_1_io_in_2_readData_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_1_io_in_2_readData_bits_data; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_1_io_in_2_readData_bits_resp; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_1_io_in_2_readData_bits_last; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_clock; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_reset; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_out_readAddr_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_out_readAddr_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_2_io_out_readAddr_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_2_io_out_readAddr_bits_addr; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_2_io_out_readAddr_bits_size; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_out_readData_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_out_readData_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_2_io_out_readData_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_2_io_out_readData_bits_data; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_2_io_out_readData_bits_resp; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_out_readData_bits_last; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_0_readAddr_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_0_readAddr_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_2_io_in_0_readAddr_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_2_io_in_0_readAddr_bits_addr; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_2_io_in_0_readAddr_bits_size; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_0_readData_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_0_readData_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_2_io_in_0_readData_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_2_io_in_0_readData_bits_data; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_2_io_in_0_readData_bits_resp; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_0_readData_bits_last; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_1_readAddr_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_1_readAddr_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_2_io_in_1_readAddr_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_2_io_in_1_readAddr_bits_addr; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_2_io_in_1_readAddr_bits_size; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_1_readData_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_1_readData_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_2_io_in_1_readData_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_2_io_in_1_readData_bits_data; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_2_io_in_1_readData_bits_resp; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_1_readData_bits_last; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_2_readAddr_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_2_readAddr_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_2_io_in_2_readAddr_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_2_io_in_2_readAddr_bits_addr; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_2_io_in_2_readAddr_bits_size; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_2_readData_ready; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_2_readData_valid; // @[AXILiteXBar.scala 18:11]
  wire [16:0] readMuxes_2_io_in_2_readData_bits_id; // @[AXILiteXBar.scala 18:11]
  wire [31:0] readMuxes_2_io_in_2_readData_bits_data; // @[AXILiteXBar.scala 18:11]
  wire [1:0] readMuxes_2_io_in_2_readData_bits_resp; // @[AXILiteXBar.scala 18:11]
  wire  readMuxes_2_io_in_2_readData_bits_last; // @[AXILiteXBar.scala 18:11]
  wire  writeBuses_0_clock; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_reset; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_master_writeAddr_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_master_writeAddr_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_0_io_master_writeAddr_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_0_io_master_writeAddr_bits_addr; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_0_io_master_writeAddr_bits_size; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_master_writeData_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_master_writeData_valid; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_0_io_master_writeData_bits_data; // @[AXILiteXBar.scala 23:11]
  wire [3:0] writeBuses_0_io_master_writeData_bits_strb; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_master_writeData_bits_last; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_master_writeResp_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_master_writeResp_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_0_io_master_writeResp_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_0_io_master_writeResp_bits_resp; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_0_writeAddr_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_0_writeAddr_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_0_io_slave_0_writeAddr_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_0_io_slave_0_writeAddr_bits_addr; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_0_io_slave_0_writeAddr_bits_size; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_0_writeData_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_0_writeData_valid; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_0_io_slave_0_writeData_bits_data; // @[AXILiteXBar.scala 23:11]
  wire [3:0] writeBuses_0_io_slave_0_writeData_bits_strb; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_0_writeData_bits_last; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_0_writeResp_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_0_writeResp_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_0_io_slave_0_writeResp_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_0_io_slave_0_writeResp_bits_resp; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_1_writeAddr_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_1_writeAddr_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_0_io_slave_1_writeAddr_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_0_io_slave_1_writeAddr_bits_addr; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_0_io_slave_1_writeAddr_bits_size; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_1_writeData_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_1_writeData_valid; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_0_io_slave_1_writeData_bits_data; // @[AXILiteXBar.scala 23:11]
  wire [3:0] writeBuses_0_io_slave_1_writeData_bits_strb; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_1_writeData_bits_last; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_1_writeResp_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_1_writeResp_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_0_io_slave_1_writeResp_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_0_io_slave_1_writeResp_bits_resp; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_2_writeAddr_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_2_writeAddr_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_0_io_slave_2_writeAddr_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_0_io_slave_2_writeAddr_bits_addr; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_0_io_slave_2_writeAddr_bits_size; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_2_writeData_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_2_writeData_valid; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_0_io_slave_2_writeData_bits_data; // @[AXILiteXBar.scala 23:11]
  wire [3:0] writeBuses_0_io_slave_2_writeData_bits_strb; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_2_writeData_bits_last; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_2_writeResp_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_0_io_slave_2_writeResp_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_0_io_slave_2_writeResp_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_0_io_slave_2_writeResp_bits_resp; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_clock; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_reset; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_master_writeAddr_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_master_writeAddr_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_1_io_master_writeAddr_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_1_io_master_writeAddr_bits_addr; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_1_io_master_writeAddr_bits_size; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_master_writeData_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_master_writeData_valid; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_1_io_master_writeData_bits_data; // @[AXILiteXBar.scala 23:11]
  wire [3:0] writeBuses_1_io_master_writeData_bits_strb; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_master_writeData_bits_last; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_master_writeResp_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_master_writeResp_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_1_io_master_writeResp_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_1_io_master_writeResp_bits_resp; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_0_writeAddr_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_0_writeAddr_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_1_io_slave_0_writeAddr_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_1_io_slave_0_writeAddr_bits_addr; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_1_io_slave_0_writeAddr_bits_size; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_0_writeData_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_0_writeData_valid; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_1_io_slave_0_writeData_bits_data; // @[AXILiteXBar.scala 23:11]
  wire [3:0] writeBuses_1_io_slave_0_writeData_bits_strb; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_0_writeData_bits_last; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_0_writeResp_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_0_writeResp_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_1_io_slave_0_writeResp_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_1_io_slave_0_writeResp_bits_resp; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_1_writeAddr_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_1_writeAddr_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_1_io_slave_1_writeAddr_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_1_io_slave_1_writeAddr_bits_addr; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_1_io_slave_1_writeAddr_bits_size; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_1_writeData_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_1_writeData_valid; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_1_io_slave_1_writeData_bits_data; // @[AXILiteXBar.scala 23:11]
  wire [3:0] writeBuses_1_io_slave_1_writeData_bits_strb; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_1_writeData_bits_last; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_1_writeResp_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_1_writeResp_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_1_io_slave_1_writeResp_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_1_io_slave_1_writeResp_bits_resp; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_2_writeAddr_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_2_writeAddr_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_1_io_slave_2_writeAddr_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_1_io_slave_2_writeAddr_bits_addr; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_1_io_slave_2_writeAddr_bits_size; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_2_writeData_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_2_writeData_valid; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_1_io_slave_2_writeData_bits_data; // @[AXILiteXBar.scala 23:11]
  wire [3:0] writeBuses_1_io_slave_2_writeData_bits_strb; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_2_writeData_bits_last; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_2_writeResp_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_1_io_slave_2_writeResp_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_1_io_slave_2_writeResp_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_1_io_slave_2_writeResp_bits_resp; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_clock; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_reset; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_master_writeAddr_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_master_writeAddr_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_2_io_master_writeAddr_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_2_io_master_writeAddr_bits_addr; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_2_io_master_writeAddr_bits_size; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_master_writeData_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_master_writeData_valid; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_2_io_master_writeData_bits_data; // @[AXILiteXBar.scala 23:11]
  wire [3:0] writeBuses_2_io_master_writeData_bits_strb; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_master_writeData_bits_last; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_master_writeResp_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_master_writeResp_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_2_io_master_writeResp_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_2_io_master_writeResp_bits_resp; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_0_writeAddr_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_0_writeAddr_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_2_io_slave_0_writeAddr_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_2_io_slave_0_writeAddr_bits_addr; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_2_io_slave_0_writeAddr_bits_size; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_0_writeData_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_0_writeData_valid; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_2_io_slave_0_writeData_bits_data; // @[AXILiteXBar.scala 23:11]
  wire [3:0] writeBuses_2_io_slave_0_writeData_bits_strb; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_0_writeData_bits_last; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_0_writeResp_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_0_writeResp_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_2_io_slave_0_writeResp_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_2_io_slave_0_writeResp_bits_resp; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_1_writeAddr_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_1_writeAddr_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_2_io_slave_1_writeAddr_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_2_io_slave_1_writeAddr_bits_addr; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_2_io_slave_1_writeAddr_bits_size; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_1_writeData_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_1_writeData_valid; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_2_io_slave_1_writeData_bits_data; // @[AXILiteXBar.scala 23:11]
  wire [3:0] writeBuses_2_io_slave_1_writeData_bits_strb; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_1_writeData_bits_last; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_1_writeResp_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_1_writeResp_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_2_io_slave_1_writeResp_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_2_io_slave_1_writeResp_bits_resp; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_2_writeAddr_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_2_writeAddr_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_2_io_slave_2_writeAddr_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_2_io_slave_2_writeAddr_bits_addr; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_2_io_slave_2_writeAddr_bits_size; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_2_writeData_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_2_writeData_valid; // @[AXILiteXBar.scala 23:11]
  wire [31:0] writeBuses_2_io_slave_2_writeData_bits_data; // @[AXILiteXBar.scala 23:11]
  wire [3:0] writeBuses_2_io_slave_2_writeData_bits_strb; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_2_writeData_bits_last; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_2_writeResp_ready; // @[AXILiteXBar.scala 23:11]
  wire  writeBuses_2_io_slave_2_writeResp_valid; // @[AXILiteXBar.scala 23:11]
  wire [16:0] writeBuses_2_io_slave_2_writeResp_bits_id; // @[AXILiteXBar.scala 23:11]
  wire [1:0] writeBuses_2_io_slave_2_writeResp_bits_resp; // @[AXILiteXBar.scala 23:11]
  wire  writeMuxes_0_clock; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_reset; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_out_writeAddr_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_out_writeAddr_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_0_io_out_writeAddr_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_0_io_out_writeAddr_bits_addr; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_0_io_out_writeAddr_bits_size; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_out_writeData_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_out_writeData_valid; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_0_io_out_writeData_bits_data; // @[AXILiteXBar.scala 27:11]
  wire [3:0] writeMuxes_0_io_out_writeData_bits_strb; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_out_writeData_bits_last; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_out_writeResp_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_out_writeResp_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_0_io_out_writeResp_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_0_io_out_writeResp_bits_resp; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_0_writeAddr_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_0_writeAddr_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_0_io_in_0_writeAddr_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_0_io_in_0_writeAddr_bits_addr; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_0_io_in_0_writeAddr_bits_size; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_0_writeData_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_0_writeData_valid; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_0_io_in_0_writeData_bits_data; // @[AXILiteXBar.scala 27:11]
  wire [3:0] writeMuxes_0_io_in_0_writeData_bits_strb; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_0_writeData_bits_last; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_0_writeResp_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_0_writeResp_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_0_io_in_0_writeResp_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_0_io_in_0_writeResp_bits_resp; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_1_writeAddr_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_1_writeAddr_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_0_io_in_1_writeAddr_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_0_io_in_1_writeAddr_bits_addr; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_0_io_in_1_writeAddr_bits_size; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_1_writeData_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_1_writeData_valid; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_0_io_in_1_writeData_bits_data; // @[AXILiteXBar.scala 27:11]
  wire [3:0] writeMuxes_0_io_in_1_writeData_bits_strb; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_1_writeData_bits_last; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_1_writeResp_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_1_writeResp_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_0_io_in_1_writeResp_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_0_io_in_1_writeResp_bits_resp; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_2_writeAddr_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_2_writeAddr_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_0_io_in_2_writeAddr_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_0_io_in_2_writeAddr_bits_addr; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_0_io_in_2_writeAddr_bits_size; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_2_writeData_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_2_writeData_valid; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_0_io_in_2_writeData_bits_data; // @[AXILiteXBar.scala 27:11]
  wire [3:0] writeMuxes_0_io_in_2_writeData_bits_strb; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_2_writeData_bits_last; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_2_writeResp_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_0_io_in_2_writeResp_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_0_io_in_2_writeResp_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_0_io_in_2_writeResp_bits_resp; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_clock; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_reset; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_out_writeAddr_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_out_writeAddr_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_1_io_out_writeAddr_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_1_io_out_writeAddr_bits_addr; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_1_io_out_writeAddr_bits_size; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_out_writeData_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_out_writeData_valid; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_1_io_out_writeData_bits_data; // @[AXILiteXBar.scala 27:11]
  wire [3:0] writeMuxes_1_io_out_writeData_bits_strb; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_out_writeData_bits_last; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_out_writeResp_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_out_writeResp_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_1_io_out_writeResp_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_1_io_out_writeResp_bits_resp; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_0_writeAddr_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_0_writeAddr_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_1_io_in_0_writeAddr_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_1_io_in_0_writeAddr_bits_addr; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_1_io_in_0_writeAddr_bits_size; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_0_writeData_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_0_writeData_valid; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_1_io_in_0_writeData_bits_data; // @[AXILiteXBar.scala 27:11]
  wire [3:0] writeMuxes_1_io_in_0_writeData_bits_strb; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_0_writeData_bits_last; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_0_writeResp_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_0_writeResp_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_1_io_in_0_writeResp_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_1_io_in_0_writeResp_bits_resp; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_1_writeAddr_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_1_writeAddr_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_1_io_in_1_writeAddr_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_1_io_in_1_writeAddr_bits_addr; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_1_io_in_1_writeAddr_bits_size; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_1_writeData_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_1_writeData_valid; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_1_io_in_1_writeData_bits_data; // @[AXILiteXBar.scala 27:11]
  wire [3:0] writeMuxes_1_io_in_1_writeData_bits_strb; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_1_writeData_bits_last; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_1_writeResp_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_1_writeResp_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_1_io_in_1_writeResp_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_1_io_in_1_writeResp_bits_resp; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_2_writeAddr_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_2_writeAddr_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_1_io_in_2_writeAddr_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_1_io_in_2_writeAddr_bits_addr; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_1_io_in_2_writeAddr_bits_size; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_2_writeData_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_2_writeData_valid; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_1_io_in_2_writeData_bits_data; // @[AXILiteXBar.scala 27:11]
  wire [3:0] writeMuxes_1_io_in_2_writeData_bits_strb; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_2_writeData_bits_last; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_2_writeResp_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_1_io_in_2_writeResp_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_1_io_in_2_writeResp_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_1_io_in_2_writeResp_bits_resp; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_clock; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_reset; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_out_writeAddr_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_out_writeAddr_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_2_io_out_writeAddr_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_2_io_out_writeAddr_bits_addr; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_2_io_out_writeAddr_bits_size; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_out_writeData_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_out_writeData_valid; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_2_io_out_writeData_bits_data; // @[AXILiteXBar.scala 27:11]
  wire [3:0] writeMuxes_2_io_out_writeData_bits_strb; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_out_writeData_bits_last; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_out_writeResp_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_out_writeResp_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_2_io_out_writeResp_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_2_io_out_writeResp_bits_resp; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_0_writeAddr_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_0_writeAddr_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_2_io_in_0_writeAddr_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_2_io_in_0_writeAddr_bits_addr; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_2_io_in_0_writeAddr_bits_size; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_0_writeData_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_0_writeData_valid; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_2_io_in_0_writeData_bits_data; // @[AXILiteXBar.scala 27:11]
  wire [3:0] writeMuxes_2_io_in_0_writeData_bits_strb; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_0_writeData_bits_last; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_0_writeResp_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_0_writeResp_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_2_io_in_0_writeResp_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_2_io_in_0_writeResp_bits_resp; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_1_writeAddr_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_1_writeAddr_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_2_io_in_1_writeAddr_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_2_io_in_1_writeAddr_bits_addr; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_2_io_in_1_writeAddr_bits_size; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_1_writeData_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_1_writeData_valid; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_2_io_in_1_writeData_bits_data; // @[AXILiteXBar.scala 27:11]
  wire [3:0] writeMuxes_2_io_in_1_writeData_bits_strb; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_1_writeData_bits_last; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_1_writeResp_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_1_writeResp_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_2_io_in_1_writeResp_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_2_io_in_1_writeResp_bits_resp; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_2_writeAddr_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_2_writeAddr_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_2_io_in_2_writeAddr_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_2_io_in_2_writeAddr_bits_addr; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_2_io_in_2_writeAddr_bits_size; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_2_writeData_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_2_writeData_valid; // @[AXILiteXBar.scala 27:11]
  wire [31:0] writeMuxes_2_io_in_2_writeData_bits_data; // @[AXILiteXBar.scala 27:11]
  wire [3:0] writeMuxes_2_io_in_2_writeData_bits_strb; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_2_writeData_bits_last; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_2_writeResp_ready; // @[AXILiteXBar.scala 27:11]
  wire  writeMuxes_2_io_in_2_writeResp_valid; // @[AXILiteXBar.scala 27:11]
  wire [16:0] writeMuxes_2_io_in_2_writeResp_bits_id; // @[AXILiteXBar.scala 27:11]
  wire [1:0] writeMuxes_2_io_in_2_writeResp_bits_resp; // @[AXILiteXBar.scala 27:11]
  AXIReadBus readBuses_0 ( // @[AXILiteXBar.scala 15:11]
    .clock(readBuses_0_clock),
    .reset(readBuses_0_reset),
    .io_master_readAddr_ready(readBuses_0_io_master_readAddr_ready),
    .io_master_readAddr_valid(readBuses_0_io_master_readAddr_valid),
    .io_master_readAddr_bits_id(readBuses_0_io_master_readAddr_bits_id),
    .io_master_readAddr_bits_addr(readBuses_0_io_master_readAddr_bits_addr),
    .io_master_readAddr_bits_size(readBuses_0_io_master_readAddr_bits_size),
    .io_master_readData_ready(readBuses_0_io_master_readData_ready),
    .io_master_readData_valid(readBuses_0_io_master_readData_valid),
    .io_master_readData_bits_id(readBuses_0_io_master_readData_bits_id),
    .io_master_readData_bits_data(readBuses_0_io_master_readData_bits_data),
    .io_master_readData_bits_resp(readBuses_0_io_master_readData_bits_resp),
    .io_master_readData_bits_last(readBuses_0_io_master_readData_bits_last),
    .io_slave_0_readAddr_ready(readBuses_0_io_slave_0_readAddr_ready),
    .io_slave_0_readAddr_valid(readBuses_0_io_slave_0_readAddr_valid),
    .io_slave_0_readAddr_bits_id(readBuses_0_io_slave_0_readAddr_bits_id),
    .io_slave_0_readAddr_bits_addr(readBuses_0_io_slave_0_readAddr_bits_addr),
    .io_slave_0_readAddr_bits_size(readBuses_0_io_slave_0_readAddr_bits_size),
    .io_slave_0_readData_ready(readBuses_0_io_slave_0_readData_ready),
    .io_slave_0_readData_valid(readBuses_0_io_slave_0_readData_valid),
    .io_slave_0_readData_bits_id(readBuses_0_io_slave_0_readData_bits_id),
    .io_slave_0_readData_bits_data(readBuses_0_io_slave_0_readData_bits_data),
    .io_slave_0_readData_bits_resp(readBuses_0_io_slave_0_readData_bits_resp),
    .io_slave_0_readData_bits_last(readBuses_0_io_slave_0_readData_bits_last),
    .io_slave_1_readAddr_ready(readBuses_0_io_slave_1_readAddr_ready),
    .io_slave_1_readAddr_valid(readBuses_0_io_slave_1_readAddr_valid),
    .io_slave_1_readAddr_bits_id(readBuses_0_io_slave_1_readAddr_bits_id),
    .io_slave_1_readAddr_bits_addr(readBuses_0_io_slave_1_readAddr_bits_addr),
    .io_slave_1_readAddr_bits_size(readBuses_0_io_slave_1_readAddr_bits_size),
    .io_slave_1_readData_ready(readBuses_0_io_slave_1_readData_ready),
    .io_slave_1_readData_valid(readBuses_0_io_slave_1_readData_valid),
    .io_slave_1_readData_bits_id(readBuses_0_io_slave_1_readData_bits_id),
    .io_slave_1_readData_bits_data(readBuses_0_io_slave_1_readData_bits_data),
    .io_slave_1_readData_bits_resp(readBuses_0_io_slave_1_readData_bits_resp),
    .io_slave_1_readData_bits_last(readBuses_0_io_slave_1_readData_bits_last),
    .io_slave_2_readAddr_ready(readBuses_0_io_slave_2_readAddr_ready),
    .io_slave_2_readAddr_valid(readBuses_0_io_slave_2_readAddr_valid),
    .io_slave_2_readAddr_bits_id(readBuses_0_io_slave_2_readAddr_bits_id),
    .io_slave_2_readAddr_bits_addr(readBuses_0_io_slave_2_readAddr_bits_addr),
    .io_slave_2_readAddr_bits_size(readBuses_0_io_slave_2_readAddr_bits_size),
    .io_slave_2_readData_ready(readBuses_0_io_slave_2_readData_ready),
    .io_slave_2_readData_valid(readBuses_0_io_slave_2_readData_valid),
    .io_slave_2_readData_bits_id(readBuses_0_io_slave_2_readData_bits_id),
    .io_slave_2_readData_bits_data(readBuses_0_io_slave_2_readData_bits_data),
    .io_slave_2_readData_bits_resp(readBuses_0_io_slave_2_readData_bits_resp),
    .io_slave_2_readData_bits_last(readBuses_0_io_slave_2_readData_bits_last)
  );
  AXIReadBus readBuses_1 ( // @[AXILiteXBar.scala 15:11]
    .clock(readBuses_1_clock),
    .reset(readBuses_1_reset),
    .io_master_readAddr_ready(readBuses_1_io_master_readAddr_ready),
    .io_master_readAddr_valid(readBuses_1_io_master_readAddr_valid),
    .io_master_readAddr_bits_id(readBuses_1_io_master_readAddr_bits_id),
    .io_master_readAddr_bits_addr(readBuses_1_io_master_readAddr_bits_addr),
    .io_master_readAddr_bits_size(readBuses_1_io_master_readAddr_bits_size),
    .io_master_readData_ready(readBuses_1_io_master_readData_ready),
    .io_master_readData_valid(readBuses_1_io_master_readData_valid),
    .io_master_readData_bits_id(readBuses_1_io_master_readData_bits_id),
    .io_master_readData_bits_data(readBuses_1_io_master_readData_bits_data),
    .io_master_readData_bits_resp(readBuses_1_io_master_readData_bits_resp),
    .io_master_readData_bits_last(readBuses_1_io_master_readData_bits_last),
    .io_slave_0_readAddr_ready(readBuses_1_io_slave_0_readAddr_ready),
    .io_slave_0_readAddr_valid(readBuses_1_io_slave_0_readAddr_valid),
    .io_slave_0_readAddr_bits_id(readBuses_1_io_slave_0_readAddr_bits_id),
    .io_slave_0_readAddr_bits_addr(readBuses_1_io_slave_0_readAddr_bits_addr),
    .io_slave_0_readAddr_bits_size(readBuses_1_io_slave_0_readAddr_bits_size),
    .io_slave_0_readData_ready(readBuses_1_io_slave_0_readData_ready),
    .io_slave_0_readData_valid(readBuses_1_io_slave_0_readData_valid),
    .io_slave_0_readData_bits_id(readBuses_1_io_slave_0_readData_bits_id),
    .io_slave_0_readData_bits_data(readBuses_1_io_slave_0_readData_bits_data),
    .io_slave_0_readData_bits_resp(readBuses_1_io_slave_0_readData_bits_resp),
    .io_slave_0_readData_bits_last(readBuses_1_io_slave_0_readData_bits_last),
    .io_slave_1_readAddr_ready(readBuses_1_io_slave_1_readAddr_ready),
    .io_slave_1_readAddr_valid(readBuses_1_io_slave_1_readAddr_valid),
    .io_slave_1_readAddr_bits_id(readBuses_1_io_slave_1_readAddr_bits_id),
    .io_slave_1_readAddr_bits_addr(readBuses_1_io_slave_1_readAddr_bits_addr),
    .io_slave_1_readAddr_bits_size(readBuses_1_io_slave_1_readAddr_bits_size),
    .io_slave_1_readData_ready(readBuses_1_io_slave_1_readData_ready),
    .io_slave_1_readData_valid(readBuses_1_io_slave_1_readData_valid),
    .io_slave_1_readData_bits_id(readBuses_1_io_slave_1_readData_bits_id),
    .io_slave_1_readData_bits_data(readBuses_1_io_slave_1_readData_bits_data),
    .io_slave_1_readData_bits_resp(readBuses_1_io_slave_1_readData_bits_resp),
    .io_slave_1_readData_bits_last(readBuses_1_io_slave_1_readData_bits_last),
    .io_slave_2_readAddr_ready(readBuses_1_io_slave_2_readAddr_ready),
    .io_slave_2_readAddr_valid(readBuses_1_io_slave_2_readAddr_valid),
    .io_slave_2_readAddr_bits_id(readBuses_1_io_slave_2_readAddr_bits_id),
    .io_slave_2_readAddr_bits_addr(readBuses_1_io_slave_2_readAddr_bits_addr),
    .io_slave_2_readAddr_bits_size(readBuses_1_io_slave_2_readAddr_bits_size),
    .io_slave_2_readData_ready(readBuses_1_io_slave_2_readData_ready),
    .io_slave_2_readData_valid(readBuses_1_io_slave_2_readData_valid),
    .io_slave_2_readData_bits_id(readBuses_1_io_slave_2_readData_bits_id),
    .io_slave_2_readData_bits_data(readBuses_1_io_slave_2_readData_bits_data),
    .io_slave_2_readData_bits_resp(readBuses_1_io_slave_2_readData_bits_resp),
    .io_slave_2_readData_bits_last(readBuses_1_io_slave_2_readData_bits_last)
  );
  AXIReadBus readBuses_2 ( // @[AXILiteXBar.scala 15:11]
    .clock(readBuses_2_clock),
    .reset(readBuses_2_reset),
    .io_master_readAddr_ready(readBuses_2_io_master_readAddr_ready),
    .io_master_readAddr_valid(readBuses_2_io_master_readAddr_valid),
    .io_master_readAddr_bits_id(readBuses_2_io_master_readAddr_bits_id),
    .io_master_readAddr_bits_addr(readBuses_2_io_master_readAddr_bits_addr),
    .io_master_readAddr_bits_size(readBuses_2_io_master_readAddr_bits_size),
    .io_master_readData_ready(readBuses_2_io_master_readData_ready),
    .io_master_readData_valid(readBuses_2_io_master_readData_valid),
    .io_master_readData_bits_id(readBuses_2_io_master_readData_bits_id),
    .io_master_readData_bits_data(readBuses_2_io_master_readData_bits_data),
    .io_master_readData_bits_resp(readBuses_2_io_master_readData_bits_resp),
    .io_master_readData_bits_last(readBuses_2_io_master_readData_bits_last),
    .io_slave_0_readAddr_ready(readBuses_2_io_slave_0_readAddr_ready),
    .io_slave_0_readAddr_valid(readBuses_2_io_slave_0_readAddr_valid),
    .io_slave_0_readAddr_bits_id(readBuses_2_io_slave_0_readAddr_bits_id),
    .io_slave_0_readAddr_bits_addr(readBuses_2_io_slave_0_readAddr_bits_addr),
    .io_slave_0_readAddr_bits_size(readBuses_2_io_slave_0_readAddr_bits_size),
    .io_slave_0_readData_ready(readBuses_2_io_slave_0_readData_ready),
    .io_slave_0_readData_valid(readBuses_2_io_slave_0_readData_valid),
    .io_slave_0_readData_bits_id(readBuses_2_io_slave_0_readData_bits_id),
    .io_slave_0_readData_bits_data(readBuses_2_io_slave_0_readData_bits_data),
    .io_slave_0_readData_bits_resp(readBuses_2_io_slave_0_readData_bits_resp),
    .io_slave_0_readData_bits_last(readBuses_2_io_slave_0_readData_bits_last),
    .io_slave_1_readAddr_ready(readBuses_2_io_slave_1_readAddr_ready),
    .io_slave_1_readAddr_valid(readBuses_2_io_slave_1_readAddr_valid),
    .io_slave_1_readAddr_bits_id(readBuses_2_io_slave_1_readAddr_bits_id),
    .io_slave_1_readAddr_bits_addr(readBuses_2_io_slave_1_readAddr_bits_addr),
    .io_slave_1_readAddr_bits_size(readBuses_2_io_slave_1_readAddr_bits_size),
    .io_slave_1_readData_ready(readBuses_2_io_slave_1_readData_ready),
    .io_slave_1_readData_valid(readBuses_2_io_slave_1_readData_valid),
    .io_slave_1_readData_bits_id(readBuses_2_io_slave_1_readData_bits_id),
    .io_slave_1_readData_bits_data(readBuses_2_io_slave_1_readData_bits_data),
    .io_slave_1_readData_bits_resp(readBuses_2_io_slave_1_readData_bits_resp),
    .io_slave_1_readData_bits_last(readBuses_2_io_slave_1_readData_bits_last),
    .io_slave_2_readAddr_ready(readBuses_2_io_slave_2_readAddr_ready),
    .io_slave_2_readAddr_valid(readBuses_2_io_slave_2_readAddr_valid),
    .io_slave_2_readAddr_bits_id(readBuses_2_io_slave_2_readAddr_bits_id),
    .io_slave_2_readAddr_bits_addr(readBuses_2_io_slave_2_readAddr_bits_addr),
    .io_slave_2_readAddr_bits_size(readBuses_2_io_slave_2_readAddr_bits_size),
    .io_slave_2_readData_ready(readBuses_2_io_slave_2_readData_ready),
    .io_slave_2_readData_valid(readBuses_2_io_slave_2_readData_valid),
    .io_slave_2_readData_bits_id(readBuses_2_io_slave_2_readData_bits_id),
    .io_slave_2_readData_bits_data(readBuses_2_io_slave_2_readData_bits_data),
    .io_slave_2_readData_bits_resp(readBuses_2_io_slave_2_readData_bits_resp),
    .io_slave_2_readData_bits_last(readBuses_2_io_slave_2_readData_bits_last)
  );
  AXISlaveReadMux readMuxes_0 ( // @[AXILiteXBar.scala 18:11]
    .clock(readMuxes_0_clock),
    .reset(readMuxes_0_reset),
    .io_out_readAddr_ready(readMuxes_0_io_out_readAddr_ready),
    .io_out_readAddr_valid(readMuxes_0_io_out_readAddr_valid),
    .io_out_readAddr_bits_id(readMuxes_0_io_out_readAddr_bits_id),
    .io_out_readAddr_bits_addr(readMuxes_0_io_out_readAddr_bits_addr),
    .io_out_readAddr_bits_size(readMuxes_0_io_out_readAddr_bits_size),
    .io_out_readData_ready(readMuxes_0_io_out_readData_ready),
    .io_out_readData_valid(readMuxes_0_io_out_readData_valid),
    .io_out_readData_bits_id(readMuxes_0_io_out_readData_bits_id),
    .io_out_readData_bits_data(readMuxes_0_io_out_readData_bits_data),
    .io_out_readData_bits_resp(readMuxes_0_io_out_readData_bits_resp),
    .io_out_readData_bits_last(readMuxes_0_io_out_readData_bits_last),
    .io_in_0_readAddr_ready(readMuxes_0_io_in_0_readAddr_ready),
    .io_in_0_readAddr_valid(readMuxes_0_io_in_0_readAddr_valid),
    .io_in_0_readAddr_bits_id(readMuxes_0_io_in_0_readAddr_bits_id),
    .io_in_0_readAddr_bits_addr(readMuxes_0_io_in_0_readAddr_bits_addr),
    .io_in_0_readAddr_bits_size(readMuxes_0_io_in_0_readAddr_bits_size),
    .io_in_0_readData_ready(readMuxes_0_io_in_0_readData_ready),
    .io_in_0_readData_valid(readMuxes_0_io_in_0_readData_valid),
    .io_in_0_readData_bits_id(readMuxes_0_io_in_0_readData_bits_id),
    .io_in_0_readData_bits_data(readMuxes_0_io_in_0_readData_bits_data),
    .io_in_0_readData_bits_resp(readMuxes_0_io_in_0_readData_bits_resp),
    .io_in_0_readData_bits_last(readMuxes_0_io_in_0_readData_bits_last),
    .io_in_1_readAddr_ready(readMuxes_0_io_in_1_readAddr_ready),
    .io_in_1_readAddr_valid(readMuxes_0_io_in_1_readAddr_valid),
    .io_in_1_readAddr_bits_id(readMuxes_0_io_in_1_readAddr_bits_id),
    .io_in_1_readAddr_bits_addr(readMuxes_0_io_in_1_readAddr_bits_addr),
    .io_in_1_readAddr_bits_size(readMuxes_0_io_in_1_readAddr_bits_size),
    .io_in_1_readData_ready(readMuxes_0_io_in_1_readData_ready),
    .io_in_1_readData_valid(readMuxes_0_io_in_1_readData_valid),
    .io_in_1_readData_bits_id(readMuxes_0_io_in_1_readData_bits_id),
    .io_in_1_readData_bits_data(readMuxes_0_io_in_1_readData_bits_data),
    .io_in_1_readData_bits_resp(readMuxes_0_io_in_1_readData_bits_resp),
    .io_in_1_readData_bits_last(readMuxes_0_io_in_1_readData_bits_last),
    .io_in_2_readAddr_ready(readMuxes_0_io_in_2_readAddr_ready),
    .io_in_2_readAddr_valid(readMuxes_0_io_in_2_readAddr_valid),
    .io_in_2_readAddr_bits_id(readMuxes_0_io_in_2_readAddr_bits_id),
    .io_in_2_readAddr_bits_addr(readMuxes_0_io_in_2_readAddr_bits_addr),
    .io_in_2_readAddr_bits_size(readMuxes_0_io_in_2_readAddr_bits_size),
    .io_in_2_readData_ready(readMuxes_0_io_in_2_readData_ready),
    .io_in_2_readData_valid(readMuxes_0_io_in_2_readData_valid),
    .io_in_2_readData_bits_id(readMuxes_0_io_in_2_readData_bits_id),
    .io_in_2_readData_bits_data(readMuxes_0_io_in_2_readData_bits_data),
    .io_in_2_readData_bits_resp(readMuxes_0_io_in_2_readData_bits_resp),
    .io_in_2_readData_bits_last(readMuxes_0_io_in_2_readData_bits_last)
  );
  AXISlaveReadMux readMuxes_1 ( // @[AXILiteXBar.scala 18:11]
    .clock(readMuxes_1_clock),
    .reset(readMuxes_1_reset),
    .io_out_readAddr_ready(readMuxes_1_io_out_readAddr_ready),
    .io_out_readAddr_valid(readMuxes_1_io_out_readAddr_valid),
    .io_out_readAddr_bits_id(readMuxes_1_io_out_readAddr_bits_id),
    .io_out_readAddr_bits_addr(readMuxes_1_io_out_readAddr_bits_addr),
    .io_out_readAddr_bits_size(readMuxes_1_io_out_readAddr_bits_size),
    .io_out_readData_ready(readMuxes_1_io_out_readData_ready),
    .io_out_readData_valid(readMuxes_1_io_out_readData_valid),
    .io_out_readData_bits_id(readMuxes_1_io_out_readData_bits_id),
    .io_out_readData_bits_data(readMuxes_1_io_out_readData_bits_data),
    .io_out_readData_bits_resp(readMuxes_1_io_out_readData_bits_resp),
    .io_out_readData_bits_last(readMuxes_1_io_out_readData_bits_last),
    .io_in_0_readAddr_ready(readMuxes_1_io_in_0_readAddr_ready),
    .io_in_0_readAddr_valid(readMuxes_1_io_in_0_readAddr_valid),
    .io_in_0_readAddr_bits_id(readMuxes_1_io_in_0_readAddr_bits_id),
    .io_in_0_readAddr_bits_addr(readMuxes_1_io_in_0_readAddr_bits_addr),
    .io_in_0_readAddr_bits_size(readMuxes_1_io_in_0_readAddr_bits_size),
    .io_in_0_readData_ready(readMuxes_1_io_in_0_readData_ready),
    .io_in_0_readData_valid(readMuxes_1_io_in_0_readData_valid),
    .io_in_0_readData_bits_id(readMuxes_1_io_in_0_readData_bits_id),
    .io_in_0_readData_bits_data(readMuxes_1_io_in_0_readData_bits_data),
    .io_in_0_readData_bits_resp(readMuxes_1_io_in_0_readData_bits_resp),
    .io_in_0_readData_bits_last(readMuxes_1_io_in_0_readData_bits_last),
    .io_in_1_readAddr_ready(readMuxes_1_io_in_1_readAddr_ready),
    .io_in_1_readAddr_valid(readMuxes_1_io_in_1_readAddr_valid),
    .io_in_1_readAddr_bits_id(readMuxes_1_io_in_1_readAddr_bits_id),
    .io_in_1_readAddr_bits_addr(readMuxes_1_io_in_1_readAddr_bits_addr),
    .io_in_1_readAddr_bits_size(readMuxes_1_io_in_1_readAddr_bits_size),
    .io_in_1_readData_ready(readMuxes_1_io_in_1_readData_ready),
    .io_in_1_readData_valid(readMuxes_1_io_in_1_readData_valid),
    .io_in_1_readData_bits_id(readMuxes_1_io_in_1_readData_bits_id),
    .io_in_1_readData_bits_data(readMuxes_1_io_in_1_readData_bits_data),
    .io_in_1_readData_bits_resp(readMuxes_1_io_in_1_readData_bits_resp),
    .io_in_1_readData_bits_last(readMuxes_1_io_in_1_readData_bits_last),
    .io_in_2_readAddr_ready(readMuxes_1_io_in_2_readAddr_ready),
    .io_in_2_readAddr_valid(readMuxes_1_io_in_2_readAddr_valid),
    .io_in_2_readAddr_bits_id(readMuxes_1_io_in_2_readAddr_bits_id),
    .io_in_2_readAddr_bits_addr(readMuxes_1_io_in_2_readAddr_bits_addr),
    .io_in_2_readAddr_bits_size(readMuxes_1_io_in_2_readAddr_bits_size),
    .io_in_2_readData_ready(readMuxes_1_io_in_2_readData_ready),
    .io_in_2_readData_valid(readMuxes_1_io_in_2_readData_valid),
    .io_in_2_readData_bits_id(readMuxes_1_io_in_2_readData_bits_id),
    .io_in_2_readData_bits_data(readMuxes_1_io_in_2_readData_bits_data),
    .io_in_2_readData_bits_resp(readMuxes_1_io_in_2_readData_bits_resp),
    .io_in_2_readData_bits_last(readMuxes_1_io_in_2_readData_bits_last)
  );
  AXISlaveReadMux readMuxes_2 ( // @[AXILiteXBar.scala 18:11]
    .clock(readMuxes_2_clock),
    .reset(readMuxes_2_reset),
    .io_out_readAddr_ready(readMuxes_2_io_out_readAddr_ready),
    .io_out_readAddr_valid(readMuxes_2_io_out_readAddr_valid),
    .io_out_readAddr_bits_id(readMuxes_2_io_out_readAddr_bits_id),
    .io_out_readAddr_bits_addr(readMuxes_2_io_out_readAddr_bits_addr),
    .io_out_readAddr_bits_size(readMuxes_2_io_out_readAddr_bits_size),
    .io_out_readData_ready(readMuxes_2_io_out_readData_ready),
    .io_out_readData_valid(readMuxes_2_io_out_readData_valid),
    .io_out_readData_bits_id(readMuxes_2_io_out_readData_bits_id),
    .io_out_readData_bits_data(readMuxes_2_io_out_readData_bits_data),
    .io_out_readData_bits_resp(readMuxes_2_io_out_readData_bits_resp),
    .io_out_readData_bits_last(readMuxes_2_io_out_readData_bits_last),
    .io_in_0_readAddr_ready(readMuxes_2_io_in_0_readAddr_ready),
    .io_in_0_readAddr_valid(readMuxes_2_io_in_0_readAddr_valid),
    .io_in_0_readAddr_bits_id(readMuxes_2_io_in_0_readAddr_bits_id),
    .io_in_0_readAddr_bits_addr(readMuxes_2_io_in_0_readAddr_bits_addr),
    .io_in_0_readAddr_bits_size(readMuxes_2_io_in_0_readAddr_bits_size),
    .io_in_0_readData_ready(readMuxes_2_io_in_0_readData_ready),
    .io_in_0_readData_valid(readMuxes_2_io_in_0_readData_valid),
    .io_in_0_readData_bits_id(readMuxes_2_io_in_0_readData_bits_id),
    .io_in_0_readData_bits_data(readMuxes_2_io_in_0_readData_bits_data),
    .io_in_0_readData_bits_resp(readMuxes_2_io_in_0_readData_bits_resp),
    .io_in_0_readData_bits_last(readMuxes_2_io_in_0_readData_bits_last),
    .io_in_1_readAddr_ready(readMuxes_2_io_in_1_readAddr_ready),
    .io_in_1_readAddr_valid(readMuxes_2_io_in_1_readAddr_valid),
    .io_in_1_readAddr_bits_id(readMuxes_2_io_in_1_readAddr_bits_id),
    .io_in_1_readAddr_bits_addr(readMuxes_2_io_in_1_readAddr_bits_addr),
    .io_in_1_readAddr_bits_size(readMuxes_2_io_in_1_readAddr_bits_size),
    .io_in_1_readData_ready(readMuxes_2_io_in_1_readData_ready),
    .io_in_1_readData_valid(readMuxes_2_io_in_1_readData_valid),
    .io_in_1_readData_bits_id(readMuxes_2_io_in_1_readData_bits_id),
    .io_in_1_readData_bits_data(readMuxes_2_io_in_1_readData_bits_data),
    .io_in_1_readData_bits_resp(readMuxes_2_io_in_1_readData_bits_resp),
    .io_in_1_readData_bits_last(readMuxes_2_io_in_1_readData_bits_last),
    .io_in_2_readAddr_ready(readMuxes_2_io_in_2_readAddr_ready),
    .io_in_2_readAddr_valid(readMuxes_2_io_in_2_readAddr_valid),
    .io_in_2_readAddr_bits_id(readMuxes_2_io_in_2_readAddr_bits_id),
    .io_in_2_readAddr_bits_addr(readMuxes_2_io_in_2_readAddr_bits_addr),
    .io_in_2_readAddr_bits_size(readMuxes_2_io_in_2_readAddr_bits_size),
    .io_in_2_readData_ready(readMuxes_2_io_in_2_readData_ready),
    .io_in_2_readData_valid(readMuxes_2_io_in_2_readData_valid),
    .io_in_2_readData_bits_id(readMuxes_2_io_in_2_readData_bits_id),
    .io_in_2_readData_bits_data(readMuxes_2_io_in_2_readData_bits_data),
    .io_in_2_readData_bits_resp(readMuxes_2_io_in_2_readData_bits_resp),
    .io_in_2_readData_bits_last(readMuxes_2_io_in_2_readData_bits_last)
  );
  AXIWriteBus writeBuses_0 ( // @[AXILiteXBar.scala 23:11]
    .clock(writeBuses_0_clock),
    .reset(writeBuses_0_reset),
    .io_master_writeAddr_ready(writeBuses_0_io_master_writeAddr_ready),
    .io_master_writeAddr_valid(writeBuses_0_io_master_writeAddr_valid),
    .io_master_writeAddr_bits_id(writeBuses_0_io_master_writeAddr_bits_id),
    .io_master_writeAddr_bits_addr(writeBuses_0_io_master_writeAddr_bits_addr),
    .io_master_writeAddr_bits_size(writeBuses_0_io_master_writeAddr_bits_size),
    .io_master_writeData_ready(writeBuses_0_io_master_writeData_ready),
    .io_master_writeData_valid(writeBuses_0_io_master_writeData_valid),
    .io_master_writeData_bits_data(writeBuses_0_io_master_writeData_bits_data),
    .io_master_writeData_bits_strb(writeBuses_0_io_master_writeData_bits_strb),
    .io_master_writeData_bits_last(writeBuses_0_io_master_writeData_bits_last),
    .io_master_writeResp_ready(writeBuses_0_io_master_writeResp_ready),
    .io_master_writeResp_valid(writeBuses_0_io_master_writeResp_valid),
    .io_master_writeResp_bits_id(writeBuses_0_io_master_writeResp_bits_id),
    .io_master_writeResp_bits_resp(writeBuses_0_io_master_writeResp_bits_resp),
    .io_slave_0_writeAddr_ready(writeBuses_0_io_slave_0_writeAddr_ready),
    .io_slave_0_writeAddr_valid(writeBuses_0_io_slave_0_writeAddr_valid),
    .io_slave_0_writeAddr_bits_id(writeBuses_0_io_slave_0_writeAddr_bits_id),
    .io_slave_0_writeAddr_bits_addr(writeBuses_0_io_slave_0_writeAddr_bits_addr),
    .io_slave_0_writeAddr_bits_size(writeBuses_0_io_slave_0_writeAddr_bits_size),
    .io_slave_0_writeData_ready(writeBuses_0_io_slave_0_writeData_ready),
    .io_slave_0_writeData_valid(writeBuses_0_io_slave_0_writeData_valid),
    .io_slave_0_writeData_bits_data(writeBuses_0_io_slave_0_writeData_bits_data),
    .io_slave_0_writeData_bits_strb(writeBuses_0_io_slave_0_writeData_bits_strb),
    .io_slave_0_writeData_bits_last(writeBuses_0_io_slave_0_writeData_bits_last),
    .io_slave_0_writeResp_ready(writeBuses_0_io_slave_0_writeResp_ready),
    .io_slave_0_writeResp_valid(writeBuses_0_io_slave_0_writeResp_valid),
    .io_slave_0_writeResp_bits_id(writeBuses_0_io_slave_0_writeResp_bits_id),
    .io_slave_0_writeResp_bits_resp(writeBuses_0_io_slave_0_writeResp_bits_resp),
    .io_slave_1_writeAddr_ready(writeBuses_0_io_slave_1_writeAddr_ready),
    .io_slave_1_writeAddr_valid(writeBuses_0_io_slave_1_writeAddr_valid),
    .io_slave_1_writeAddr_bits_id(writeBuses_0_io_slave_1_writeAddr_bits_id),
    .io_slave_1_writeAddr_bits_addr(writeBuses_0_io_slave_1_writeAddr_bits_addr),
    .io_slave_1_writeAddr_bits_size(writeBuses_0_io_slave_1_writeAddr_bits_size),
    .io_slave_1_writeData_ready(writeBuses_0_io_slave_1_writeData_ready),
    .io_slave_1_writeData_valid(writeBuses_0_io_slave_1_writeData_valid),
    .io_slave_1_writeData_bits_data(writeBuses_0_io_slave_1_writeData_bits_data),
    .io_slave_1_writeData_bits_strb(writeBuses_0_io_slave_1_writeData_bits_strb),
    .io_slave_1_writeData_bits_last(writeBuses_0_io_slave_1_writeData_bits_last),
    .io_slave_1_writeResp_ready(writeBuses_0_io_slave_1_writeResp_ready),
    .io_slave_1_writeResp_valid(writeBuses_0_io_slave_1_writeResp_valid),
    .io_slave_1_writeResp_bits_id(writeBuses_0_io_slave_1_writeResp_bits_id),
    .io_slave_1_writeResp_bits_resp(writeBuses_0_io_slave_1_writeResp_bits_resp),
    .io_slave_2_writeAddr_ready(writeBuses_0_io_slave_2_writeAddr_ready),
    .io_slave_2_writeAddr_valid(writeBuses_0_io_slave_2_writeAddr_valid),
    .io_slave_2_writeAddr_bits_id(writeBuses_0_io_slave_2_writeAddr_bits_id),
    .io_slave_2_writeAddr_bits_addr(writeBuses_0_io_slave_2_writeAddr_bits_addr),
    .io_slave_2_writeAddr_bits_size(writeBuses_0_io_slave_2_writeAddr_bits_size),
    .io_slave_2_writeData_ready(writeBuses_0_io_slave_2_writeData_ready),
    .io_slave_2_writeData_valid(writeBuses_0_io_slave_2_writeData_valid),
    .io_slave_2_writeData_bits_data(writeBuses_0_io_slave_2_writeData_bits_data),
    .io_slave_2_writeData_bits_strb(writeBuses_0_io_slave_2_writeData_bits_strb),
    .io_slave_2_writeData_bits_last(writeBuses_0_io_slave_2_writeData_bits_last),
    .io_slave_2_writeResp_ready(writeBuses_0_io_slave_2_writeResp_ready),
    .io_slave_2_writeResp_valid(writeBuses_0_io_slave_2_writeResp_valid),
    .io_slave_2_writeResp_bits_id(writeBuses_0_io_slave_2_writeResp_bits_id),
    .io_slave_2_writeResp_bits_resp(writeBuses_0_io_slave_2_writeResp_bits_resp)
  );
  AXIWriteBus writeBuses_1 ( // @[AXILiteXBar.scala 23:11]
    .clock(writeBuses_1_clock),
    .reset(writeBuses_1_reset),
    .io_master_writeAddr_ready(writeBuses_1_io_master_writeAddr_ready),
    .io_master_writeAddr_valid(writeBuses_1_io_master_writeAddr_valid),
    .io_master_writeAddr_bits_id(writeBuses_1_io_master_writeAddr_bits_id),
    .io_master_writeAddr_bits_addr(writeBuses_1_io_master_writeAddr_bits_addr),
    .io_master_writeAddr_bits_size(writeBuses_1_io_master_writeAddr_bits_size),
    .io_master_writeData_ready(writeBuses_1_io_master_writeData_ready),
    .io_master_writeData_valid(writeBuses_1_io_master_writeData_valid),
    .io_master_writeData_bits_data(writeBuses_1_io_master_writeData_bits_data),
    .io_master_writeData_bits_strb(writeBuses_1_io_master_writeData_bits_strb),
    .io_master_writeData_bits_last(writeBuses_1_io_master_writeData_bits_last),
    .io_master_writeResp_ready(writeBuses_1_io_master_writeResp_ready),
    .io_master_writeResp_valid(writeBuses_1_io_master_writeResp_valid),
    .io_master_writeResp_bits_id(writeBuses_1_io_master_writeResp_bits_id),
    .io_master_writeResp_bits_resp(writeBuses_1_io_master_writeResp_bits_resp),
    .io_slave_0_writeAddr_ready(writeBuses_1_io_slave_0_writeAddr_ready),
    .io_slave_0_writeAddr_valid(writeBuses_1_io_slave_0_writeAddr_valid),
    .io_slave_0_writeAddr_bits_id(writeBuses_1_io_slave_0_writeAddr_bits_id),
    .io_slave_0_writeAddr_bits_addr(writeBuses_1_io_slave_0_writeAddr_bits_addr),
    .io_slave_0_writeAddr_bits_size(writeBuses_1_io_slave_0_writeAddr_bits_size),
    .io_slave_0_writeData_ready(writeBuses_1_io_slave_0_writeData_ready),
    .io_slave_0_writeData_valid(writeBuses_1_io_slave_0_writeData_valid),
    .io_slave_0_writeData_bits_data(writeBuses_1_io_slave_0_writeData_bits_data),
    .io_slave_0_writeData_bits_strb(writeBuses_1_io_slave_0_writeData_bits_strb),
    .io_slave_0_writeData_bits_last(writeBuses_1_io_slave_0_writeData_bits_last),
    .io_slave_0_writeResp_ready(writeBuses_1_io_slave_0_writeResp_ready),
    .io_slave_0_writeResp_valid(writeBuses_1_io_slave_0_writeResp_valid),
    .io_slave_0_writeResp_bits_id(writeBuses_1_io_slave_0_writeResp_bits_id),
    .io_slave_0_writeResp_bits_resp(writeBuses_1_io_slave_0_writeResp_bits_resp),
    .io_slave_1_writeAddr_ready(writeBuses_1_io_slave_1_writeAddr_ready),
    .io_slave_1_writeAddr_valid(writeBuses_1_io_slave_1_writeAddr_valid),
    .io_slave_1_writeAddr_bits_id(writeBuses_1_io_slave_1_writeAddr_bits_id),
    .io_slave_1_writeAddr_bits_addr(writeBuses_1_io_slave_1_writeAddr_bits_addr),
    .io_slave_1_writeAddr_bits_size(writeBuses_1_io_slave_1_writeAddr_bits_size),
    .io_slave_1_writeData_ready(writeBuses_1_io_slave_1_writeData_ready),
    .io_slave_1_writeData_valid(writeBuses_1_io_slave_1_writeData_valid),
    .io_slave_1_writeData_bits_data(writeBuses_1_io_slave_1_writeData_bits_data),
    .io_slave_1_writeData_bits_strb(writeBuses_1_io_slave_1_writeData_bits_strb),
    .io_slave_1_writeData_bits_last(writeBuses_1_io_slave_1_writeData_bits_last),
    .io_slave_1_writeResp_ready(writeBuses_1_io_slave_1_writeResp_ready),
    .io_slave_1_writeResp_valid(writeBuses_1_io_slave_1_writeResp_valid),
    .io_slave_1_writeResp_bits_id(writeBuses_1_io_slave_1_writeResp_bits_id),
    .io_slave_1_writeResp_bits_resp(writeBuses_1_io_slave_1_writeResp_bits_resp),
    .io_slave_2_writeAddr_ready(writeBuses_1_io_slave_2_writeAddr_ready),
    .io_slave_2_writeAddr_valid(writeBuses_1_io_slave_2_writeAddr_valid),
    .io_slave_2_writeAddr_bits_id(writeBuses_1_io_slave_2_writeAddr_bits_id),
    .io_slave_2_writeAddr_bits_addr(writeBuses_1_io_slave_2_writeAddr_bits_addr),
    .io_slave_2_writeAddr_bits_size(writeBuses_1_io_slave_2_writeAddr_bits_size),
    .io_slave_2_writeData_ready(writeBuses_1_io_slave_2_writeData_ready),
    .io_slave_2_writeData_valid(writeBuses_1_io_slave_2_writeData_valid),
    .io_slave_2_writeData_bits_data(writeBuses_1_io_slave_2_writeData_bits_data),
    .io_slave_2_writeData_bits_strb(writeBuses_1_io_slave_2_writeData_bits_strb),
    .io_slave_2_writeData_bits_last(writeBuses_1_io_slave_2_writeData_bits_last),
    .io_slave_2_writeResp_ready(writeBuses_1_io_slave_2_writeResp_ready),
    .io_slave_2_writeResp_valid(writeBuses_1_io_slave_2_writeResp_valid),
    .io_slave_2_writeResp_bits_id(writeBuses_1_io_slave_2_writeResp_bits_id),
    .io_slave_2_writeResp_bits_resp(writeBuses_1_io_slave_2_writeResp_bits_resp)
  );
  AXIWriteBus writeBuses_2 ( // @[AXILiteXBar.scala 23:11]
    .clock(writeBuses_2_clock),
    .reset(writeBuses_2_reset),
    .io_master_writeAddr_ready(writeBuses_2_io_master_writeAddr_ready),
    .io_master_writeAddr_valid(writeBuses_2_io_master_writeAddr_valid),
    .io_master_writeAddr_bits_id(writeBuses_2_io_master_writeAddr_bits_id),
    .io_master_writeAddr_bits_addr(writeBuses_2_io_master_writeAddr_bits_addr),
    .io_master_writeAddr_bits_size(writeBuses_2_io_master_writeAddr_bits_size),
    .io_master_writeData_ready(writeBuses_2_io_master_writeData_ready),
    .io_master_writeData_valid(writeBuses_2_io_master_writeData_valid),
    .io_master_writeData_bits_data(writeBuses_2_io_master_writeData_bits_data),
    .io_master_writeData_bits_strb(writeBuses_2_io_master_writeData_bits_strb),
    .io_master_writeData_bits_last(writeBuses_2_io_master_writeData_bits_last),
    .io_master_writeResp_ready(writeBuses_2_io_master_writeResp_ready),
    .io_master_writeResp_valid(writeBuses_2_io_master_writeResp_valid),
    .io_master_writeResp_bits_id(writeBuses_2_io_master_writeResp_bits_id),
    .io_master_writeResp_bits_resp(writeBuses_2_io_master_writeResp_bits_resp),
    .io_slave_0_writeAddr_ready(writeBuses_2_io_slave_0_writeAddr_ready),
    .io_slave_0_writeAddr_valid(writeBuses_2_io_slave_0_writeAddr_valid),
    .io_slave_0_writeAddr_bits_id(writeBuses_2_io_slave_0_writeAddr_bits_id),
    .io_slave_0_writeAddr_bits_addr(writeBuses_2_io_slave_0_writeAddr_bits_addr),
    .io_slave_0_writeAddr_bits_size(writeBuses_2_io_slave_0_writeAddr_bits_size),
    .io_slave_0_writeData_ready(writeBuses_2_io_slave_0_writeData_ready),
    .io_slave_0_writeData_valid(writeBuses_2_io_slave_0_writeData_valid),
    .io_slave_0_writeData_bits_data(writeBuses_2_io_slave_0_writeData_bits_data),
    .io_slave_0_writeData_bits_strb(writeBuses_2_io_slave_0_writeData_bits_strb),
    .io_slave_0_writeData_bits_last(writeBuses_2_io_slave_0_writeData_bits_last),
    .io_slave_0_writeResp_ready(writeBuses_2_io_slave_0_writeResp_ready),
    .io_slave_0_writeResp_valid(writeBuses_2_io_slave_0_writeResp_valid),
    .io_slave_0_writeResp_bits_id(writeBuses_2_io_slave_0_writeResp_bits_id),
    .io_slave_0_writeResp_bits_resp(writeBuses_2_io_slave_0_writeResp_bits_resp),
    .io_slave_1_writeAddr_ready(writeBuses_2_io_slave_1_writeAddr_ready),
    .io_slave_1_writeAddr_valid(writeBuses_2_io_slave_1_writeAddr_valid),
    .io_slave_1_writeAddr_bits_id(writeBuses_2_io_slave_1_writeAddr_bits_id),
    .io_slave_1_writeAddr_bits_addr(writeBuses_2_io_slave_1_writeAddr_bits_addr),
    .io_slave_1_writeAddr_bits_size(writeBuses_2_io_slave_1_writeAddr_bits_size),
    .io_slave_1_writeData_ready(writeBuses_2_io_slave_1_writeData_ready),
    .io_slave_1_writeData_valid(writeBuses_2_io_slave_1_writeData_valid),
    .io_slave_1_writeData_bits_data(writeBuses_2_io_slave_1_writeData_bits_data),
    .io_slave_1_writeData_bits_strb(writeBuses_2_io_slave_1_writeData_bits_strb),
    .io_slave_1_writeData_bits_last(writeBuses_2_io_slave_1_writeData_bits_last),
    .io_slave_1_writeResp_ready(writeBuses_2_io_slave_1_writeResp_ready),
    .io_slave_1_writeResp_valid(writeBuses_2_io_slave_1_writeResp_valid),
    .io_slave_1_writeResp_bits_id(writeBuses_2_io_slave_1_writeResp_bits_id),
    .io_slave_1_writeResp_bits_resp(writeBuses_2_io_slave_1_writeResp_bits_resp),
    .io_slave_2_writeAddr_ready(writeBuses_2_io_slave_2_writeAddr_ready),
    .io_slave_2_writeAddr_valid(writeBuses_2_io_slave_2_writeAddr_valid),
    .io_slave_2_writeAddr_bits_id(writeBuses_2_io_slave_2_writeAddr_bits_id),
    .io_slave_2_writeAddr_bits_addr(writeBuses_2_io_slave_2_writeAddr_bits_addr),
    .io_slave_2_writeAddr_bits_size(writeBuses_2_io_slave_2_writeAddr_bits_size),
    .io_slave_2_writeData_ready(writeBuses_2_io_slave_2_writeData_ready),
    .io_slave_2_writeData_valid(writeBuses_2_io_slave_2_writeData_valid),
    .io_slave_2_writeData_bits_data(writeBuses_2_io_slave_2_writeData_bits_data),
    .io_slave_2_writeData_bits_strb(writeBuses_2_io_slave_2_writeData_bits_strb),
    .io_slave_2_writeData_bits_last(writeBuses_2_io_slave_2_writeData_bits_last),
    .io_slave_2_writeResp_ready(writeBuses_2_io_slave_2_writeResp_ready),
    .io_slave_2_writeResp_valid(writeBuses_2_io_slave_2_writeResp_valid),
    .io_slave_2_writeResp_bits_id(writeBuses_2_io_slave_2_writeResp_bits_id),
    .io_slave_2_writeResp_bits_resp(writeBuses_2_io_slave_2_writeResp_bits_resp)
  );
  AXISlaveWriteMux writeMuxes_0 ( // @[AXILiteXBar.scala 27:11]
    .clock(writeMuxes_0_clock),
    .reset(writeMuxes_0_reset),
    .io_out_writeAddr_ready(writeMuxes_0_io_out_writeAddr_ready),
    .io_out_writeAddr_valid(writeMuxes_0_io_out_writeAddr_valid),
    .io_out_writeAddr_bits_id(writeMuxes_0_io_out_writeAddr_bits_id),
    .io_out_writeAddr_bits_addr(writeMuxes_0_io_out_writeAddr_bits_addr),
    .io_out_writeAddr_bits_size(writeMuxes_0_io_out_writeAddr_bits_size),
    .io_out_writeData_ready(writeMuxes_0_io_out_writeData_ready),
    .io_out_writeData_valid(writeMuxes_0_io_out_writeData_valid),
    .io_out_writeData_bits_data(writeMuxes_0_io_out_writeData_bits_data),
    .io_out_writeData_bits_strb(writeMuxes_0_io_out_writeData_bits_strb),
    .io_out_writeData_bits_last(writeMuxes_0_io_out_writeData_bits_last),
    .io_out_writeResp_ready(writeMuxes_0_io_out_writeResp_ready),
    .io_out_writeResp_valid(writeMuxes_0_io_out_writeResp_valid),
    .io_out_writeResp_bits_id(writeMuxes_0_io_out_writeResp_bits_id),
    .io_out_writeResp_bits_resp(writeMuxes_0_io_out_writeResp_bits_resp),
    .io_in_0_writeAddr_ready(writeMuxes_0_io_in_0_writeAddr_ready),
    .io_in_0_writeAddr_valid(writeMuxes_0_io_in_0_writeAddr_valid),
    .io_in_0_writeAddr_bits_id(writeMuxes_0_io_in_0_writeAddr_bits_id),
    .io_in_0_writeAddr_bits_addr(writeMuxes_0_io_in_0_writeAddr_bits_addr),
    .io_in_0_writeAddr_bits_size(writeMuxes_0_io_in_0_writeAddr_bits_size),
    .io_in_0_writeData_ready(writeMuxes_0_io_in_0_writeData_ready),
    .io_in_0_writeData_valid(writeMuxes_0_io_in_0_writeData_valid),
    .io_in_0_writeData_bits_data(writeMuxes_0_io_in_0_writeData_bits_data),
    .io_in_0_writeData_bits_strb(writeMuxes_0_io_in_0_writeData_bits_strb),
    .io_in_0_writeData_bits_last(writeMuxes_0_io_in_0_writeData_bits_last),
    .io_in_0_writeResp_ready(writeMuxes_0_io_in_0_writeResp_ready),
    .io_in_0_writeResp_valid(writeMuxes_0_io_in_0_writeResp_valid),
    .io_in_0_writeResp_bits_id(writeMuxes_0_io_in_0_writeResp_bits_id),
    .io_in_0_writeResp_bits_resp(writeMuxes_0_io_in_0_writeResp_bits_resp),
    .io_in_1_writeAddr_ready(writeMuxes_0_io_in_1_writeAddr_ready),
    .io_in_1_writeAddr_valid(writeMuxes_0_io_in_1_writeAddr_valid),
    .io_in_1_writeAddr_bits_id(writeMuxes_0_io_in_1_writeAddr_bits_id),
    .io_in_1_writeAddr_bits_addr(writeMuxes_0_io_in_1_writeAddr_bits_addr),
    .io_in_1_writeAddr_bits_size(writeMuxes_0_io_in_1_writeAddr_bits_size),
    .io_in_1_writeData_ready(writeMuxes_0_io_in_1_writeData_ready),
    .io_in_1_writeData_valid(writeMuxes_0_io_in_1_writeData_valid),
    .io_in_1_writeData_bits_data(writeMuxes_0_io_in_1_writeData_bits_data),
    .io_in_1_writeData_bits_strb(writeMuxes_0_io_in_1_writeData_bits_strb),
    .io_in_1_writeData_bits_last(writeMuxes_0_io_in_1_writeData_bits_last),
    .io_in_1_writeResp_ready(writeMuxes_0_io_in_1_writeResp_ready),
    .io_in_1_writeResp_valid(writeMuxes_0_io_in_1_writeResp_valid),
    .io_in_1_writeResp_bits_id(writeMuxes_0_io_in_1_writeResp_bits_id),
    .io_in_1_writeResp_bits_resp(writeMuxes_0_io_in_1_writeResp_bits_resp),
    .io_in_2_writeAddr_ready(writeMuxes_0_io_in_2_writeAddr_ready),
    .io_in_2_writeAddr_valid(writeMuxes_0_io_in_2_writeAddr_valid),
    .io_in_2_writeAddr_bits_id(writeMuxes_0_io_in_2_writeAddr_bits_id),
    .io_in_2_writeAddr_bits_addr(writeMuxes_0_io_in_2_writeAddr_bits_addr),
    .io_in_2_writeAddr_bits_size(writeMuxes_0_io_in_2_writeAddr_bits_size),
    .io_in_2_writeData_ready(writeMuxes_0_io_in_2_writeData_ready),
    .io_in_2_writeData_valid(writeMuxes_0_io_in_2_writeData_valid),
    .io_in_2_writeData_bits_data(writeMuxes_0_io_in_2_writeData_bits_data),
    .io_in_2_writeData_bits_strb(writeMuxes_0_io_in_2_writeData_bits_strb),
    .io_in_2_writeData_bits_last(writeMuxes_0_io_in_2_writeData_bits_last),
    .io_in_2_writeResp_ready(writeMuxes_0_io_in_2_writeResp_ready),
    .io_in_2_writeResp_valid(writeMuxes_0_io_in_2_writeResp_valid),
    .io_in_2_writeResp_bits_id(writeMuxes_0_io_in_2_writeResp_bits_id),
    .io_in_2_writeResp_bits_resp(writeMuxes_0_io_in_2_writeResp_bits_resp)
  );
  AXISlaveWriteMux writeMuxes_1 ( // @[AXILiteXBar.scala 27:11]
    .clock(writeMuxes_1_clock),
    .reset(writeMuxes_1_reset),
    .io_out_writeAddr_ready(writeMuxes_1_io_out_writeAddr_ready),
    .io_out_writeAddr_valid(writeMuxes_1_io_out_writeAddr_valid),
    .io_out_writeAddr_bits_id(writeMuxes_1_io_out_writeAddr_bits_id),
    .io_out_writeAddr_bits_addr(writeMuxes_1_io_out_writeAddr_bits_addr),
    .io_out_writeAddr_bits_size(writeMuxes_1_io_out_writeAddr_bits_size),
    .io_out_writeData_ready(writeMuxes_1_io_out_writeData_ready),
    .io_out_writeData_valid(writeMuxes_1_io_out_writeData_valid),
    .io_out_writeData_bits_data(writeMuxes_1_io_out_writeData_bits_data),
    .io_out_writeData_bits_strb(writeMuxes_1_io_out_writeData_bits_strb),
    .io_out_writeData_bits_last(writeMuxes_1_io_out_writeData_bits_last),
    .io_out_writeResp_ready(writeMuxes_1_io_out_writeResp_ready),
    .io_out_writeResp_valid(writeMuxes_1_io_out_writeResp_valid),
    .io_out_writeResp_bits_id(writeMuxes_1_io_out_writeResp_bits_id),
    .io_out_writeResp_bits_resp(writeMuxes_1_io_out_writeResp_bits_resp),
    .io_in_0_writeAddr_ready(writeMuxes_1_io_in_0_writeAddr_ready),
    .io_in_0_writeAddr_valid(writeMuxes_1_io_in_0_writeAddr_valid),
    .io_in_0_writeAddr_bits_id(writeMuxes_1_io_in_0_writeAddr_bits_id),
    .io_in_0_writeAddr_bits_addr(writeMuxes_1_io_in_0_writeAddr_bits_addr),
    .io_in_0_writeAddr_bits_size(writeMuxes_1_io_in_0_writeAddr_bits_size),
    .io_in_0_writeData_ready(writeMuxes_1_io_in_0_writeData_ready),
    .io_in_0_writeData_valid(writeMuxes_1_io_in_0_writeData_valid),
    .io_in_0_writeData_bits_data(writeMuxes_1_io_in_0_writeData_bits_data),
    .io_in_0_writeData_bits_strb(writeMuxes_1_io_in_0_writeData_bits_strb),
    .io_in_0_writeData_bits_last(writeMuxes_1_io_in_0_writeData_bits_last),
    .io_in_0_writeResp_ready(writeMuxes_1_io_in_0_writeResp_ready),
    .io_in_0_writeResp_valid(writeMuxes_1_io_in_0_writeResp_valid),
    .io_in_0_writeResp_bits_id(writeMuxes_1_io_in_0_writeResp_bits_id),
    .io_in_0_writeResp_bits_resp(writeMuxes_1_io_in_0_writeResp_bits_resp),
    .io_in_1_writeAddr_ready(writeMuxes_1_io_in_1_writeAddr_ready),
    .io_in_1_writeAddr_valid(writeMuxes_1_io_in_1_writeAddr_valid),
    .io_in_1_writeAddr_bits_id(writeMuxes_1_io_in_1_writeAddr_bits_id),
    .io_in_1_writeAddr_bits_addr(writeMuxes_1_io_in_1_writeAddr_bits_addr),
    .io_in_1_writeAddr_bits_size(writeMuxes_1_io_in_1_writeAddr_bits_size),
    .io_in_1_writeData_ready(writeMuxes_1_io_in_1_writeData_ready),
    .io_in_1_writeData_valid(writeMuxes_1_io_in_1_writeData_valid),
    .io_in_1_writeData_bits_data(writeMuxes_1_io_in_1_writeData_bits_data),
    .io_in_1_writeData_bits_strb(writeMuxes_1_io_in_1_writeData_bits_strb),
    .io_in_1_writeData_bits_last(writeMuxes_1_io_in_1_writeData_bits_last),
    .io_in_1_writeResp_ready(writeMuxes_1_io_in_1_writeResp_ready),
    .io_in_1_writeResp_valid(writeMuxes_1_io_in_1_writeResp_valid),
    .io_in_1_writeResp_bits_id(writeMuxes_1_io_in_1_writeResp_bits_id),
    .io_in_1_writeResp_bits_resp(writeMuxes_1_io_in_1_writeResp_bits_resp),
    .io_in_2_writeAddr_ready(writeMuxes_1_io_in_2_writeAddr_ready),
    .io_in_2_writeAddr_valid(writeMuxes_1_io_in_2_writeAddr_valid),
    .io_in_2_writeAddr_bits_id(writeMuxes_1_io_in_2_writeAddr_bits_id),
    .io_in_2_writeAddr_bits_addr(writeMuxes_1_io_in_2_writeAddr_bits_addr),
    .io_in_2_writeAddr_bits_size(writeMuxes_1_io_in_2_writeAddr_bits_size),
    .io_in_2_writeData_ready(writeMuxes_1_io_in_2_writeData_ready),
    .io_in_2_writeData_valid(writeMuxes_1_io_in_2_writeData_valid),
    .io_in_2_writeData_bits_data(writeMuxes_1_io_in_2_writeData_bits_data),
    .io_in_2_writeData_bits_strb(writeMuxes_1_io_in_2_writeData_bits_strb),
    .io_in_2_writeData_bits_last(writeMuxes_1_io_in_2_writeData_bits_last),
    .io_in_2_writeResp_ready(writeMuxes_1_io_in_2_writeResp_ready),
    .io_in_2_writeResp_valid(writeMuxes_1_io_in_2_writeResp_valid),
    .io_in_2_writeResp_bits_id(writeMuxes_1_io_in_2_writeResp_bits_id),
    .io_in_2_writeResp_bits_resp(writeMuxes_1_io_in_2_writeResp_bits_resp)
  );
  AXISlaveWriteMux writeMuxes_2 ( // @[AXILiteXBar.scala 27:11]
    .clock(writeMuxes_2_clock),
    .reset(writeMuxes_2_reset),
    .io_out_writeAddr_ready(writeMuxes_2_io_out_writeAddr_ready),
    .io_out_writeAddr_valid(writeMuxes_2_io_out_writeAddr_valid),
    .io_out_writeAddr_bits_id(writeMuxes_2_io_out_writeAddr_bits_id),
    .io_out_writeAddr_bits_addr(writeMuxes_2_io_out_writeAddr_bits_addr),
    .io_out_writeAddr_bits_size(writeMuxes_2_io_out_writeAddr_bits_size),
    .io_out_writeData_ready(writeMuxes_2_io_out_writeData_ready),
    .io_out_writeData_valid(writeMuxes_2_io_out_writeData_valid),
    .io_out_writeData_bits_data(writeMuxes_2_io_out_writeData_bits_data),
    .io_out_writeData_bits_strb(writeMuxes_2_io_out_writeData_bits_strb),
    .io_out_writeData_bits_last(writeMuxes_2_io_out_writeData_bits_last),
    .io_out_writeResp_ready(writeMuxes_2_io_out_writeResp_ready),
    .io_out_writeResp_valid(writeMuxes_2_io_out_writeResp_valid),
    .io_out_writeResp_bits_id(writeMuxes_2_io_out_writeResp_bits_id),
    .io_out_writeResp_bits_resp(writeMuxes_2_io_out_writeResp_bits_resp),
    .io_in_0_writeAddr_ready(writeMuxes_2_io_in_0_writeAddr_ready),
    .io_in_0_writeAddr_valid(writeMuxes_2_io_in_0_writeAddr_valid),
    .io_in_0_writeAddr_bits_id(writeMuxes_2_io_in_0_writeAddr_bits_id),
    .io_in_0_writeAddr_bits_addr(writeMuxes_2_io_in_0_writeAddr_bits_addr),
    .io_in_0_writeAddr_bits_size(writeMuxes_2_io_in_0_writeAddr_bits_size),
    .io_in_0_writeData_ready(writeMuxes_2_io_in_0_writeData_ready),
    .io_in_0_writeData_valid(writeMuxes_2_io_in_0_writeData_valid),
    .io_in_0_writeData_bits_data(writeMuxes_2_io_in_0_writeData_bits_data),
    .io_in_0_writeData_bits_strb(writeMuxes_2_io_in_0_writeData_bits_strb),
    .io_in_0_writeData_bits_last(writeMuxes_2_io_in_0_writeData_bits_last),
    .io_in_0_writeResp_ready(writeMuxes_2_io_in_0_writeResp_ready),
    .io_in_0_writeResp_valid(writeMuxes_2_io_in_0_writeResp_valid),
    .io_in_0_writeResp_bits_id(writeMuxes_2_io_in_0_writeResp_bits_id),
    .io_in_0_writeResp_bits_resp(writeMuxes_2_io_in_0_writeResp_bits_resp),
    .io_in_1_writeAddr_ready(writeMuxes_2_io_in_1_writeAddr_ready),
    .io_in_1_writeAddr_valid(writeMuxes_2_io_in_1_writeAddr_valid),
    .io_in_1_writeAddr_bits_id(writeMuxes_2_io_in_1_writeAddr_bits_id),
    .io_in_1_writeAddr_bits_addr(writeMuxes_2_io_in_1_writeAddr_bits_addr),
    .io_in_1_writeAddr_bits_size(writeMuxes_2_io_in_1_writeAddr_bits_size),
    .io_in_1_writeData_ready(writeMuxes_2_io_in_1_writeData_ready),
    .io_in_1_writeData_valid(writeMuxes_2_io_in_1_writeData_valid),
    .io_in_1_writeData_bits_data(writeMuxes_2_io_in_1_writeData_bits_data),
    .io_in_1_writeData_bits_strb(writeMuxes_2_io_in_1_writeData_bits_strb),
    .io_in_1_writeData_bits_last(writeMuxes_2_io_in_1_writeData_bits_last),
    .io_in_1_writeResp_ready(writeMuxes_2_io_in_1_writeResp_ready),
    .io_in_1_writeResp_valid(writeMuxes_2_io_in_1_writeResp_valid),
    .io_in_1_writeResp_bits_id(writeMuxes_2_io_in_1_writeResp_bits_id),
    .io_in_1_writeResp_bits_resp(writeMuxes_2_io_in_1_writeResp_bits_resp),
    .io_in_2_writeAddr_ready(writeMuxes_2_io_in_2_writeAddr_ready),
    .io_in_2_writeAddr_valid(writeMuxes_2_io_in_2_writeAddr_valid),
    .io_in_2_writeAddr_bits_id(writeMuxes_2_io_in_2_writeAddr_bits_id),
    .io_in_2_writeAddr_bits_addr(writeMuxes_2_io_in_2_writeAddr_bits_addr),
    .io_in_2_writeAddr_bits_size(writeMuxes_2_io_in_2_writeAddr_bits_size),
    .io_in_2_writeData_ready(writeMuxes_2_io_in_2_writeData_ready),
    .io_in_2_writeData_valid(writeMuxes_2_io_in_2_writeData_valid),
    .io_in_2_writeData_bits_data(writeMuxes_2_io_in_2_writeData_bits_data),
    .io_in_2_writeData_bits_strb(writeMuxes_2_io_in_2_writeData_bits_strb),
    .io_in_2_writeData_bits_last(writeMuxes_2_io_in_2_writeData_bits_last),
    .io_in_2_writeResp_ready(writeMuxes_2_io_in_2_writeResp_ready),
    .io_in_2_writeResp_valid(writeMuxes_2_io_in_2_writeResp_valid),
    .io_in_2_writeResp_bits_id(writeMuxes_2_io_in_2_writeResp_bits_id),
    .io_in_2_writeResp_bits_resp(writeMuxes_2_io_in_2_writeResp_bits_resp)
  );
  assign io_masters_0_aw_ready = writeBuses_0_io_master_writeAddr_ready; // @[AXILiteXBar.scala 36:15]
  assign io_masters_0_w_ready = writeBuses_0_io_master_writeData_ready; // @[AXILiteXBar.scala 37:14]
  assign io_masters_0_b_valid = writeBuses_0_io_master_writeResp_valid; // @[AXILiteXBar.scala 38:14]
  assign io_masters_0_ar_ready = readBuses_0_io_master_readAddr_ready; // @[AXILiteXBar.scala 31:15]
  assign io_masters_0_r_valid = readBuses_0_io_master_readData_valid; // @[AXILiteXBar.scala 32:14]
  assign io_masters_0_r_bits_data = readBuses_0_io_master_readData_bits_data; // @[AXILiteXBar.scala 32:14]
  assign io_masters_1_aw_ready = writeBuses_1_io_master_writeAddr_ready; // @[AXILiteXBar.scala 36:15]
  assign io_masters_1_w_ready = writeBuses_1_io_master_writeData_ready; // @[AXILiteXBar.scala 37:14]
  assign io_masters_1_b_valid = writeBuses_1_io_master_writeResp_valid; // @[AXILiteXBar.scala 38:14]
  assign io_masters_1_ar_ready = readBuses_1_io_master_readAddr_ready; // @[AXILiteXBar.scala 31:15]
  assign io_masters_1_r_valid = readBuses_1_io_master_readData_valid; // @[AXILiteXBar.scala 32:14]
  assign io_masters_1_r_bits_data = readBuses_1_io_master_readData_bits_data; // @[AXILiteXBar.scala 32:14]
  assign io_masters_2_aw_ready = writeBuses_2_io_master_writeAddr_ready; // @[AXILiteXBar.scala 36:15]
  assign io_masters_2_w_ready = writeBuses_2_io_master_writeData_ready; // @[AXILiteXBar.scala 37:14]
  assign io_masters_2_b_valid = writeBuses_2_io_master_writeResp_valid; // @[AXILiteXBar.scala 38:14]
  assign io_masters_2_b_bits_id = writeBuses_2_io_master_writeResp_bits_id; // @[AXILiteXBar.scala 38:14]
  assign io_masters_2_b_bits_resp = writeBuses_2_io_master_writeResp_bits_resp; // @[AXILiteXBar.scala 38:14]
  assign io_masters_2_ar_ready = readBuses_2_io_master_readAddr_ready; // @[AXILiteXBar.scala 31:15]
  assign io_masters_2_r_valid = readBuses_2_io_master_readData_valid; // @[AXILiteXBar.scala 32:14]
  assign io_masters_2_r_bits_id = readBuses_2_io_master_readData_bits_id; // @[AXILiteXBar.scala 32:14]
  assign io_masters_2_r_bits_data = readBuses_2_io_master_readData_bits_data; // @[AXILiteXBar.scala 32:14]
  assign io_masters_2_r_bits_resp = readBuses_2_io_master_readData_bits_resp; // @[AXILiteXBar.scala 32:14]
  assign io_masters_2_r_bits_last = readBuses_2_io_master_readData_bits_last; // @[AXILiteXBar.scala 32:14]
  assign io_slaves_0_aw_valid = writeMuxes_0_io_out_writeAddr_valid; // @[AXILiteXBar.scala 48:16]
  assign io_slaves_0_aw_bits_addr = writeMuxes_0_io_out_writeAddr_bits_addr; // @[AXILiteXBar.scala 48:16]
  assign io_slaves_0_w_valid = writeMuxes_0_io_out_writeData_valid; // @[AXILiteXBar.scala 49:15]
  assign io_slaves_0_w_bits_data = writeMuxes_0_io_out_writeData_bits_data; // @[AXILiteXBar.scala 49:15]
  assign io_slaves_0_w_bits_strb = writeMuxes_0_io_out_writeData_bits_strb; // @[AXILiteXBar.scala 49:15]
  assign io_slaves_0_b_ready = writeMuxes_0_io_out_writeResp_ready; // @[AXILiteXBar.scala 50:15]
  assign io_slaves_0_ar_valid = readMuxes_0_io_out_readAddr_valid; // @[AXILiteXBar.scala 42:16]
  assign io_slaves_0_ar_bits_addr = readMuxes_0_io_out_readAddr_bits_addr; // @[AXILiteXBar.scala 42:16]
  assign io_slaves_0_r_ready = readMuxes_0_io_out_readData_ready; // @[AXILiteXBar.scala 43:15]
  assign io_slaves_1_aw_valid = writeMuxes_1_io_out_writeAddr_valid; // @[AXILiteXBar.scala 48:16]
  assign io_slaves_1_aw_bits_addr = writeMuxes_1_io_out_writeAddr_bits_addr; // @[AXILiteXBar.scala 48:16]
  assign io_slaves_1_w_valid = writeMuxes_1_io_out_writeData_valid; // @[AXILiteXBar.scala 49:15]
  assign io_slaves_1_w_bits_data = writeMuxes_1_io_out_writeData_bits_data; // @[AXILiteXBar.scala 49:15]
  assign io_slaves_1_w_bits_strb = writeMuxes_1_io_out_writeData_bits_strb; // @[AXILiteXBar.scala 49:15]
  assign io_slaves_1_ar_valid = readMuxes_1_io_out_readAddr_valid; // @[AXILiteXBar.scala 42:16]
  assign io_slaves_1_ar_bits_addr = readMuxes_1_io_out_readAddr_bits_addr; // @[AXILiteXBar.scala 42:16]
  assign io_slaves_2_aw_valid = writeMuxes_2_io_out_writeAddr_valid; // @[AXILiteXBar.scala 48:16]
  assign io_slaves_2_aw_bits_id = writeMuxes_2_io_out_writeAddr_bits_id; // @[AXILiteXBar.scala 48:16]
  assign io_slaves_2_aw_bits_addr = writeMuxes_2_io_out_writeAddr_bits_addr; // @[AXILiteXBar.scala 48:16]
  assign io_slaves_2_aw_bits_size = writeMuxes_2_io_out_writeAddr_bits_size; // @[AXILiteXBar.scala 48:16]
  assign io_slaves_2_w_valid = writeMuxes_2_io_out_writeData_valid; // @[AXILiteXBar.scala 49:15]
  assign io_slaves_2_w_bits_data = writeMuxes_2_io_out_writeData_bits_data; // @[AXILiteXBar.scala 49:15]
  assign io_slaves_2_w_bits_strb = writeMuxes_2_io_out_writeData_bits_strb; // @[AXILiteXBar.scala 49:15]
  assign io_slaves_2_w_bits_last = writeMuxes_2_io_out_writeData_bits_last; // @[AXILiteXBar.scala 49:15]
  assign io_slaves_2_b_ready = writeMuxes_2_io_out_writeResp_ready; // @[AXILiteXBar.scala 50:15]
  assign io_slaves_2_ar_valid = readMuxes_2_io_out_readAddr_valid; // @[AXILiteXBar.scala 42:16]
  assign io_slaves_2_ar_bits_id = readMuxes_2_io_out_readAddr_bits_id; // @[AXILiteXBar.scala 42:16]
  assign io_slaves_2_ar_bits_addr = readMuxes_2_io_out_readAddr_bits_addr; // @[AXILiteXBar.scala 42:16]
  assign io_slaves_2_ar_bits_size = readMuxes_2_io_out_readAddr_bits_size; // @[AXILiteXBar.scala 42:16]
  assign io_slaves_2_r_ready = readMuxes_2_io_out_readData_ready; // @[AXILiteXBar.scala 43:15]
  assign readBuses_0_clock = clock;
  assign readBuses_0_reset = reset;
  assign readBuses_0_io_master_readAddr_valid = io_masters_0_ar_valid; // @[AXILiteXBar.scala 31:15]
  assign readBuses_0_io_master_readAddr_bits_id = 17'h0; // @[AXILiteXBar.scala 31:15]
  assign readBuses_0_io_master_readAddr_bits_addr = io_masters_0_ar_bits_addr; // @[AXILiteXBar.scala 31:15]
  assign readBuses_0_io_master_readAddr_bits_size = 2'h2; // @[AXILiteXBar.scala 31:15]
  assign readBuses_0_io_master_readData_ready = io_masters_0_r_ready; // @[AXILiteXBar.scala 32:14]
  assign readBuses_0_io_slave_0_readAddr_ready = readMuxes_0_io_in_0_readAddr_ready; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_0_readData_valid = readMuxes_0_io_in_0_readData_valid; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_0_readData_bits_id = readMuxes_0_io_in_0_readData_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_0_readData_bits_data = readMuxes_0_io_in_0_readData_bits_data; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_0_readData_bits_resp = readMuxes_0_io_in_0_readData_bits_resp; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_0_readData_bits_last = readMuxes_0_io_in_0_readData_bits_last; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_1_readAddr_ready = readMuxes_1_io_in_0_readAddr_ready; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_1_readData_valid = readMuxes_1_io_in_0_readData_valid; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_1_readData_bits_id = readMuxes_1_io_in_0_readData_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_1_readData_bits_data = readMuxes_1_io_in_0_readData_bits_data; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_1_readData_bits_resp = readMuxes_1_io_in_0_readData_bits_resp; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_1_readData_bits_last = readMuxes_1_io_in_0_readData_bits_last; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_2_readAddr_ready = readMuxes_2_io_in_0_readAddr_ready; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_2_readData_valid = readMuxes_2_io_in_0_readData_valid; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_2_readData_bits_id = readMuxes_2_io_in_0_readData_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_2_readData_bits_data = readMuxes_2_io_in_0_readData_bits_data; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_2_readData_bits_resp = readMuxes_2_io_in_0_readData_bits_resp; // @[AXILiteXBar.scala 54:30]
  assign readBuses_0_io_slave_2_readData_bits_last = readMuxes_2_io_in_0_readData_bits_last; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_clock = clock;
  assign readBuses_1_reset = reset;
  assign readBuses_1_io_master_readAddr_valid = io_masters_1_ar_valid; // @[AXILiteXBar.scala 31:15]
  assign readBuses_1_io_master_readAddr_bits_id = 17'h0; // @[AXILiteXBar.scala 31:15]
  assign readBuses_1_io_master_readAddr_bits_addr = io_masters_1_ar_bits_addr; // @[AXILiteXBar.scala 31:15]
  assign readBuses_1_io_master_readAddr_bits_size = 2'h2; // @[AXILiteXBar.scala 31:15]
  assign readBuses_1_io_master_readData_ready = io_masters_1_r_ready; // @[AXILiteXBar.scala 32:14]
  assign readBuses_1_io_slave_0_readAddr_ready = readMuxes_0_io_in_1_readAddr_ready; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_0_readData_valid = readMuxes_0_io_in_1_readData_valid; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_0_readData_bits_id = readMuxes_0_io_in_1_readData_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_0_readData_bits_data = readMuxes_0_io_in_1_readData_bits_data; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_0_readData_bits_resp = readMuxes_0_io_in_1_readData_bits_resp; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_0_readData_bits_last = readMuxes_0_io_in_1_readData_bits_last; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_1_readAddr_ready = readMuxes_1_io_in_1_readAddr_ready; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_1_readData_valid = readMuxes_1_io_in_1_readData_valid; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_1_readData_bits_id = readMuxes_1_io_in_1_readData_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_1_readData_bits_data = readMuxes_1_io_in_1_readData_bits_data; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_1_readData_bits_resp = readMuxes_1_io_in_1_readData_bits_resp; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_1_readData_bits_last = readMuxes_1_io_in_1_readData_bits_last; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_2_readAddr_ready = readMuxes_2_io_in_1_readAddr_ready; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_2_readData_valid = readMuxes_2_io_in_1_readData_valid; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_2_readData_bits_id = readMuxes_2_io_in_1_readData_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_2_readData_bits_data = readMuxes_2_io_in_1_readData_bits_data; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_2_readData_bits_resp = readMuxes_2_io_in_1_readData_bits_resp; // @[AXILiteXBar.scala 54:30]
  assign readBuses_1_io_slave_2_readData_bits_last = readMuxes_2_io_in_1_readData_bits_last; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_clock = clock;
  assign readBuses_2_reset = reset;
  assign readBuses_2_io_master_readAddr_valid = io_masters_2_ar_valid; // @[AXILiteXBar.scala 31:15]
  assign readBuses_2_io_master_readAddr_bits_id = io_masters_2_ar_bits_id; // @[AXILiteXBar.scala 31:15]
  assign readBuses_2_io_master_readAddr_bits_addr = io_masters_2_ar_bits_addr; // @[AXILiteXBar.scala 31:15]
  assign readBuses_2_io_master_readAddr_bits_size = io_masters_2_ar_bits_size; // @[AXILiteXBar.scala 31:15]
  assign readBuses_2_io_master_readData_ready = io_masters_2_r_ready; // @[AXILiteXBar.scala 32:14]
  assign readBuses_2_io_slave_0_readAddr_ready = readMuxes_0_io_in_2_readAddr_ready; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_0_readData_valid = readMuxes_0_io_in_2_readData_valid; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_0_readData_bits_id = readMuxes_0_io_in_2_readData_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_0_readData_bits_data = readMuxes_0_io_in_2_readData_bits_data; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_0_readData_bits_resp = readMuxes_0_io_in_2_readData_bits_resp; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_0_readData_bits_last = readMuxes_0_io_in_2_readData_bits_last; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_1_readAddr_ready = readMuxes_1_io_in_2_readAddr_ready; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_1_readData_valid = readMuxes_1_io_in_2_readData_valid; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_1_readData_bits_id = readMuxes_1_io_in_2_readData_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_1_readData_bits_data = readMuxes_1_io_in_2_readData_bits_data; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_1_readData_bits_resp = readMuxes_1_io_in_2_readData_bits_resp; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_1_readData_bits_last = readMuxes_1_io_in_2_readData_bits_last; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_2_readAddr_ready = readMuxes_2_io_in_2_readAddr_ready; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_2_readData_valid = readMuxes_2_io_in_2_readData_valid; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_2_readData_bits_id = readMuxes_2_io_in_2_readData_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_2_readData_bits_data = readMuxes_2_io_in_2_readData_bits_data; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_2_readData_bits_resp = readMuxes_2_io_in_2_readData_bits_resp; // @[AXILiteXBar.scala 54:30]
  assign readBuses_2_io_slave_2_readData_bits_last = readMuxes_2_io_in_2_readData_bits_last; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_clock = clock;
  assign readMuxes_0_reset = reset;
  assign readMuxes_0_io_out_readAddr_ready = io_slaves_0_ar_ready; // @[AXILiteXBar.scala 42:16]
  assign readMuxes_0_io_out_readData_valid = io_slaves_0_r_valid; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_0_io_out_readData_bits_id = 17'h0; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_0_io_out_readData_bits_data = io_slaves_0_r_bits_data; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_0_io_out_readData_bits_resp = 2'h0; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_0_io_out_readData_bits_last = 1'h1; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_0_io_in_0_readAddr_valid = readBuses_0_io_slave_0_readAddr_valid; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_0_readAddr_bits_id = readBuses_0_io_slave_0_readAddr_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_0_readAddr_bits_addr = readBuses_0_io_slave_0_readAddr_bits_addr; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_0_readAddr_bits_size = readBuses_0_io_slave_0_readAddr_bits_size; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_0_readData_ready = readBuses_0_io_slave_0_readData_ready; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_1_readAddr_valid = readBuses_1_io_slave_0_readAddr_valid; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_1_readAddr_bits_id = readBuses_1_io_slave_0_readAddr_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_1_readAddr_bits_addr = readBuses_1_io_slave_0_readAddr_bits_addr; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_1_readAddr_bits_size = readBuses_1_io_slave_0_readAddr_bits_size; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_1_readData_ready = readBuses_1_io_slave_0_readData_ready; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_2_readAddr_valid = readBuses_2_io_slave_0_readAddr_valid; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_2_readAddr_bits_id = readBuses_2_io_slave_0_readAddr_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_2_readAddr_bits_addr = readBuses_2_io_slave_0_readAddr_bits_addr; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_2_readAddr_bits_size = readBuses_2_io_slave_0_readAddr_bits_size; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_0_io_in_2_readData_ready = readBuses_2_io_slave_0_readData_ready; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_clock = clock;
  assign readMuxes_1_reset = reset;
  assign readMuxes_1_io_out_readAddr_ready = io_slaves_1_ar_ready; // @[AXILiteXBar.scala 42:16]
  assign readMuxes_1_io_out_readData_valid = io_slaves_1_r_valid; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_1_io_out_readData_bits_id = 17'h0; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_1_io_out_readData_bits_data = io_slaves_1_r_bits_data; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_1_io_out_readData_bits_resp = 2'h0; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_1_io_out_readData_bits_last = 1'h1; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_1_io_in_0_readAddr_valid = readBuses_0_io_slave_1_readAddr_valid; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_0_readAddr_bits_id = readBuses_0_io_slave_1_readAddr_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_0_readAddr_bits_addr = readBuses_0_io_slave_1_readAddr_bits_addr; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_0_readAddr_bits_size = readBuses_0_io_slave_1_readAddr_bits_size; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_0_readData_ready = readBuses_0_io_slave_1_readData_ready; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_1_readAddr_valid = readBuses_1_io_slave_1_readAddr_valid; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_1_readAddr_bits_id = readBuses_1_io_slave_1_readAddr_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_1_readAddr_bits_addr = readBuses_1_io_slave_1_readAddr_bits_addr; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_1_readAddr_bits_size = readBuses_1_io_slave_1_readAddr_bits_size; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_1_readData_ready = readBuses_1_io_slave_1_readData_ready; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_2_readAddr_valid = readBuses_2_io_slave_1_readAddr_valid; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_2_readAddr_bits_id = readBuses_2_io_slave_1_readAddr_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_2_readAddr_bits_addr = readBuses_2_io_slave_1_readAddr_bits_addr; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_2_readAddr_bits_size = readBuses_2_io_slave_1_readAddr_bits_size; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_1_io_in_2_readData_ready = readBuses_2_io_slave_1_readData_ready; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_clock = clock;
  assign readMuxes_2_reset = reset;
  assign readMuxes_2_io_out_readAddr_ready = io_slaves_2_ar_ready; // @[AXILiteXBar.scala 42:16]
  assign readMuxes_2_io_out_readData_valid = io_slaves_2_r_valid; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_2_io_out_readData_bits_id = io_slaves_2_r_bits_id; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_2_io_out_readData_bits_data = io_slaves_2_r_bits_data; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_2_io_out_readData_bits_resp = io_slaves_2_r_bits_resp; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_2_io_out_readData_bits_last = io_slaves_2_r_bits_last; // @[AXILiteXBar.scala 43:15]
  assign readMuxes_2_io_in_0_readAddr_valid = readBuses_0_io_slave_2_readAddr_valid; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_0_readAddr_bits_id = readBuses_0_io_slave_2_readAddr_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_0_readAddr_bits_addr = readBuses_0_io_slave_2_readAddr_bits_addr; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_0_readAddr_bits_size = readBuses_0_io_slave_2_readAddr_bits_size; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_0_readData_ready = readBuses_0_io_slave_2_readData_ready; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_1_readAddr_valid = readBuses_1_io_slave_2_readAddr_valid; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_1_readAddr_bits_id = readBuses_1_io_slave_2_readAddr_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_1_readAddr_bits_addr = readBuses_1_io_slave_2_readAddr_bits_addr; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_1_readAddr_bits_size = readBuses_1_io_slave_2_readAddr_bits_size; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_1_readData_ready = readBuses_1_io_slave_2_readData_ready; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_2_readAddr_valid = readBuses_2_io_slave_2_readAddr_valid; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_2_readAddr_bits_id = readBuses_2_io_slave_2_readAddr_bits_id; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_2_readAddr_bits_addr = readBuses_2_io_slave_2_readAddr_bits_addr; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_2_readAddr_bits_size = readBuses_2_io_slave_2_readAddr_bits_size; // @[AXILiteXBar.scala 54:30]
  assign readMuxes_2_io_in_2_readData_ready = readBuses_2_io_slave_2_readData_ready; // @[AXILiteXBar.scala 54:30]
  assign writeBuses_0_clock = clock;
  assign writeBuses_0_reset = reset;
  assign writeBuses_0_io_master_writeAddr_valid = io_masters_0_aw_valid; // @[AXILiteXBar.scala 36:15]
  assign writeBuses_0_io_master_writeAddr_bits_id = 17'h0; // @[AXILiteXBar.scala 36:15]
  assign writeBuses_0_io_master_writeAddr_bits_addr = io_masters_0_aw_bits_addr; // @[AXILiteXBar.scala 36:15]
  assign writeBuses_0_io_master_writeAddr_bits_size = 2'h2; // @[AXILiteXBar.scala 36:15]
  assign writeBuses_0_io_master_writeData_valid = io_masters_0_w_valid; // @[AXILiteXBar.scala 37:14]
  assign writeBuses_0_io_master_writeData_bits_data = io_masters_0_w_bits_data; // @[AXILiteXBar.scala 37:14]
  assign writeBuses_0_io_master_writeData_bits_strb = io_masters_0_w_bits_strb; // @[AXILiteXBar.scala 37:14]
  assign writeBuses_0_io_master_writeData_bits_last = 1'h0; // @[AXILiteXBar.scala 37:14]
  assign writeBuses_0_io_master_writeResp_ready = io_masters_0_b_ready; // @[AXILiteXBar.scala 38:14]
  assign writeBuses_0_io_slave_0_writeAddr_ready = writeMuxes_0_io_in_0_writeAddr_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_0_writeData_ready = writeMuxes_0_io_in_0_writeData_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_0_writeResp_valid = writeMuxes_0_io_in_0_writeResp_valid; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_0_writeResp_bits_id = writeMuxes_0_io_in_0_writeResp_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_0_writeResp_bits_resp = writeMuxes_0_io_in_0_writeResp_bits_resp; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_1_writeAddr_ready = writeMuxes_1_io_in_0_writeAddr_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_1_writeData_ready = writeMuxes_1_io_in_0_writeData_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_1_writeResp_valid = writeMuxes_1_io_in_0_writeResp_valid; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_1_writeResp_bits_id = writeMuxes_1_io_in_0_writeResp_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_1_writeResp_bits_resp = writeMuxes_1_io_in_0_writeResp_bits_resp; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_2_writeAddr_ready = writeMuxes_2_io_in_0_writeAddr_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_2_writeData_ready = writeMuxes_2_io_in_0_writeData_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_2_writeResp_valid = writeMuxes_2_io_in_0_writeResp_valid; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_2_writeResp_bits_id = writeMuxes_2_io_in_0_writeResp_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_0_io_slave_2_writeResp_bits_resp = writeMuxes_2_io_in_0_writeResp_bits_resp; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_clock = clock;
  assign writeBuses_1_reset = reset;
  assign writeBuses_1_io_master_writeAddr_valid = io_masters_1_aw_valid; // @[AXILiteXBar.scala 36:15]
  assign writeBuses_1_io_master_writeAddr_bits_id = 17'h0; // @[AXILiteXBar.scala 36:15]
  assign writeBuses_1_io_master_writeAddr_bits_addr = io_masters_1_aw_bits_addr; // @[AXILiteXBar.scala 36:15]
  assign writeBuses_1_io_master_writeAddr_bits_size = 2'h2; // @[AXILiteXBar.scala 36:15]
  assign writeBuses_1_io_master_writeData_valid = io_masters_1_w_valid; // @[AXILiteXBar.scala 37:14]
  assign writeBuses_1_io_master_writeData_bits_data = io_masters_1_w_bits_data; // @[AXILiteXBar.scala 37:14]
  assign writeBuses_1_io_master_writeData_bits_strb = io_masters_1_w_bits_strb; // @[AXILiteXBar.scala 37:14]
  assign writeBuses_1_io_master_writeData_bits_last = 1'h1; // @[AXILiteXBar.scala 37:14]
  assign writeBuses_1_io_master_writeResp_ready = io_masters_1_b_ready; // @[AXILiteXBar.scala 38:14]
  assign writeBuses_1_io_slave_0_writeAddr_ready = writeMuxes_0_io_in_1_writeAddr_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_0_writeData_ready = writeMuxes_0_io_in_1_writeData_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_0_writeResp_valid = writeMuxes_0_io_in_1_writeResp_valid; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_0_writeResp_bits_id = writeMuxes_0_io_in_1_writeResp_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_0_writeResp_bits_resp = writeMuxes_0_io_in_1_writeResp_bits_resp; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_1_writeAddr_ready = writeMuxes_1_io_in_1_writeAddr_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_1_writeData_ready = writeMuxes_1_io_in_1_writeData_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_1_writeResp_valid = writeMuxes_1_io_in_1_writeResp_valid; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_1_writeResp_bits_id = writeMuxes_1_io_in_1_writeResp_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_1_writeResp_bits_resp = writeMuxes_1_io_in_1_writeResp_bits_resp; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_2_writeAddr_ready = writeMuxes_2_io_in_1_writeAddr_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_2_writeData_ready = writeMuxes_2_io_in_1_writeData_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_2_writeResp_valid = writeMuxes_2_io_in_1_writeResp_valid; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_2_writeResp_bits_id = writeMuxes_2_io_in_1_writeResp_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_1_io_slave_2_writeResp_bits_resp = writeMuxes_2_io_in_1_writeResp_bits_resp; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_clock = clock;
  assign writeBuses_2_reset = reset;
  assign writeBuses_2_io_master_writeAddr_valid = io_masters_2_aw_valid; // @[AXILiteXBar.scala 36:15]
  assign writeBuses_2_io_master_writeAddr_bits_id = io_masters_2_aw_bits_id; // @[AXILiteXBar.scala 36:15]
  assign writeBuses_2_io_master_writeAddr_bits_addr = io_masters_2_aw_bits_addr; // @[AXILiteXBar.scala 36:15]
  assign writeBuses_2_io_master_writeAddr_bits_size = io_masters_2_aw_bits_size; // @[AXILiteXBar.scala 36:15]
  assign writeBuses_2_io_master_writeData_valid = io_masters_2_w_valid; // @[AXILiteXBar.scala 37:14]
  assign writeBuses_2_io_master_writeData_bits_data = io_masters_2_w_bits_data; // @[AXILiteXBar.scala 37:14]
  assign writeBuses_2_io_master_writeData_bits_strb = io_masters_2_w_bits_strb; // @[AXILiteXBar.scala 37:14]
  assign writeBuses_2_io_master_writeData_bits_last = io_masters_2_w_bits_last; // @[AXILiteXBar.scala 37:14]
  assign writeBuses_2_io_master_writeResp_ready = io_masters_2_b_ready; // @[AXILiteXBar.scala 38:14]
  assign writeBuses_2_io_slave_0_writeAddr_ready = writeMuxes_0_io_in_2_writeAddr_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_0_writeData_ready = writeMuxes_0_io_in_2_writeData_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_0_writeResp_valid = writeMuxes_0_io_in_2_writeResp_valid; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_0_writeResp_bits_id = writeMuxes_0_io_in_2_writeResp_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_0_writeResp_bits_resp = writeMuxes_0_io_in_2_writeResp_bits_resp; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_1_writeAddr_ready = writeMuxes_1_io_in_2_writeAddr_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_1_writeData_ready = writeMuxes_1_io_in_2_writeData_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_1_writeResp_valid = writeMuxes_1_io_in_2_writeResp_valid; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_1_writeResp_bits_id = writeMuxes_1_io_in_2_writeResp_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_1_writeResp_bits_resp = writeMuxes_1_io_in_2_writeResp_bits_resp; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_2_writeAddr_ready = writeMuxes_2_io_in_2_writeAddr_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_2_writeData_ready = writeMuxes_2_io_in_2_writeData_ready; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_2_writeResp_valid = writeMuxes_2_io_in_2_writeResp_valid; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_2_writeResp_bits_id = writeMuxes_2_io_in_2_writeResp_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeBuses_2_io_slave_2_writeResp_bits_resp = writeMuxes_2_io_in_2_writeResp_bits_resp; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_clock = clock;
  assign writeMuxes_0_reset = reset;
  assign writeMuxes_0_io_out_writeAddr_ready = io_slaves_0_aw_ready; // @[AXILiteXBar.scala 48:16]
  assign writeMuxes_0_io_out_writeData_ready = io_slaves_0_w_ready; // @[AXILiteXBar.scala 49:15]
  assign writeMuxes_0_io_out_writeResp_valid = io_slaves_0_b_valid; // @[AXILiteXBar.scala 50:15]
  assign writeMuxes_0_io_out_writeResp_bits_id = 17'h0; // @[AXILiteXBar.scala 50:15]
  assign writeMuxes_0_io_out_writeResp_bits_resp = 2'h0; // @[AXILiteXBar.scala 50:15]
  assign writeMuxes_0_io_in_0_writeAddr_valid = writeBuses_0_io_slave_0_writeAddr_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_0_writeAddr_bits_id = writeBuses_0_io_slave_0_writeAddr_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_0_writeAddr_bits_addr = writeBuses_0_io_slave_0_writeAddr_bits_addr; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_0_writeAddr_bits_size = writeBuses_0_io_slave_0_writeAddr_bits_size; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_0_writeData_valid = writeBuses_0_io_slave_0_writeData_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_0_writeData_bits_data = writeBuses_0_io_slave_0_writeData_bits_data; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_0_writeData_bits_strb = writeBuses_0_io_slave_0_writeData_bits_strb; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_0_writeData_bits_last = writeBuses_0_io_slave_0_writeData_bits_last; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_0_writeResp_ready = writeBuses_0_io_slave_0_writeResp_ready; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_1_writeAddr_valid = writeBuses_1_io_slave_0_writeAddr_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_1_writeAddr_bits_id = writeBuses_1_io_slave_0_writeAddr_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_1_writeAddr_bits_addr = writeBuses_1_io_slave_0_writeAddr_bits_addr; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_1_writeAddr_bits_size = writeBuses_1_io_slave_0_writeAddr_bits_size; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_1_writeData_valid = writeBuses_1_io_slave_0_writeData_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_1_writeData_bits_data = writeBuses_1_io_slave_0_writeData_bits_data; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_1_writeData_bits_strb = writeBuses_1_io_slave_0_writeData_bits_strb; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_1_writeData_bits_last = writeBuses_1_io_slave_0_writeData_bits_last; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_1_writeResp_ready = writeBuses_1_io_slave_0_writeResp_ready; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_2_writeAddr_valid = writeBuses_2_io_slave_0_writeAddr_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_2_writeAddr_bits_id = writeBuses_2_io_slave_0_writeAddr_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_2_writeAddr_bits_addr = writeBuses_2_io_slave_0_writeAddr_bits_addr; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_2_writeAddr_bits_size = writeBuses_2_io_slave_0_writeAddr_bits_size; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_2_writeData_valid = writeBuses_2_io_slave_0_writeData_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_2_writeData_bits_data = writeBuses_2_io_slave_0_writeData_bits_data; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_2_writeData_bits_strb = writeBuses_2_io_slave_0_writeData_bits_strb; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_2_writeData_bits_last = writeBuses_2_io_slave_0_writeData_bits_last; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_0_io_in_2_writeResp_ready = writeBuses_2_io_slave_0_writeResp_ready; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_clock = clock;
  assign writeMuxes_1_reset = reset;
  assign writeMuxes_1_io_out_writeAddr_ready = io_slaves_1_aw_ready; // @[AXILiteXBar.scala 48:16]
  assign writeMuxes_1_io_out_writeData_ready = io_slaves_1_w_ready; // @[AXILiteXBar.scala 49:15]
  assign writeMuxes_1_io_out_writeResp_valid = io_slaves_1_b_valid; // @[AXILiteXBar.scala 50:15]
  assign writeMuxes_1_io_out_writeResp_bits_id = 17'h0; // @[AXILiteXBar.scala 50:15]
  assign writeMuxes_1_io_out_writeResp_bits_resp = 2'h0; // @[AXILiteXBar.scala 50:15]
  assign writeMuxes_1_io_in_0_writeAddr_valid = writeBuses_0_io_slave_1_writeAddr_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_0_writeAddr_bits_id = writeBuses_0_io_slave_1_writeAddr_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_0_writeAddr_bits_addr = writeBuses_0_io_slave_1_writeAddr_bits_addr; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_0_writeAddr_bits_size = writeBuses_0_io_slave_1_writeAddr_bits_size; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_0_writeData_valid = writeBuses_0_io_slave_1_writeData_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_0_writeData_bits_data = writeBuses_0_io_slave_1_writeData_bits_data; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_0_writeData_bits_strb = writeBuses_0_io_slave_1_writeData_bits_strb; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_0_writeData_bits_last = writeBuses_0_io_slave_1_writeData_bits_last; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_0_writeResp_ready = writeBuses_0_io_slave_1_writeResp_ready; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_1_writeAddr_valid = writeBuses_1_io_slave_1_writeAddr_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_1_writeAddr_bits_id = writeBuses_1_io_slave_1_writeAddr_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_1_writeAddr_bits_addr = writeBuses_1_io_slave_1_writeAddr_bits_addr; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_1_writeAddr_bits_size = writeBuses_1_io_slave_1_writeAddr_bits_size; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_1_writeData_valid = writeBuses_1_io_slave_1_writeData_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_1_writeData_bits_data = writeBuses_1_io_slave_1_writeData_bits_data; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_1_writeData_bits_strb = writeBuses_1_io_slave_1_writeData_bits_strb; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_1_writeData_bits_last = writeBuses_1_io_slave_1_writeData_bits_last; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_1_writeResp_ready = writeBuses_1_io_slave_1_writeResp_ready; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_2_writeAddr_valid = writeBuses_2_io_slave_1_writeAddr_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_2_writeAddr_bits_id = writeBuses_2_io_slave_1_writeAddr_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_2_writeAddr_bits_addr = writeBuses_2_io_slave_1_writeAddr_bits_addr; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_2_writeAddr_bits_size = writeBuses_2_io_slave_1_writeAddr_bits_size; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_2_writeData_valid = writeBuses_2_io_slave_1_writeData_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_2_writeData_bits_data = writeBuses_2_io_slave_1_writeData_bits_data; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_2_writeData_bits_strb = writeBuses_2_io_slave_1_writeData_bits_strb; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_2_writeData_bits_last = writeBuses_2_io_slave_1_writeData_bits_last; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_1_io_in_2_writeResp_ready = writeBuses_2_io_slave_1_writeResp_ready; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_clock = clock;
  assign writeMuxes_2_reset = reset;
  assign writeMuxes_2_io_out_writeAddr_ready = io_slaves_2_aw_ready; // @[AXILiteXBar.scala 48:16]
  assign writeMuxes_2_io_out_writeData_ready = io_slaves_2_w_ready; // @[AXILiteXBar.scala 49:15]
  assign writeMuxes_2_io_out_writeResp_valid = io_slaves_2_b_valid; // @[AXILiteXBar.scala 50:15]
  assign writeMuxes_2_io_out_writeResp_bits_id = io_slaves_2_b_bits_id; // @[AXILiteXBar.scala 50:15]
  assign writeMuxes_2_io_out_writeResp_bits_resp = io_slaves_2_b_bits_resp; // @[AXILiteXBar.scala 50:15]
  assign writeMuxes_2_io_in_0_writeAddr_valid = writeBuses_0_io_slave_2_writeAddr_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_0_writeAddr_bits_id = writeBuses_0_io_slave_2_writeAddr_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_0_writeAddr_bits_addr = writeBuses_0_io_slave_2_writeAddr_bits_addr; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_0_writeAddr_bits_size = writeBuses_0_io_slave_2_writeAddr_bits_size; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_0_writeData_valid = writeBuses_0_io_slave_2_writeData_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_0_writeData_bits_data = writeBuses_0_io_slave_2_writeData_bits_data; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_0_writeData_bits_strb = writeBuses_0_io_slave_2_writeData_bits_strb; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_0_writeData_bits_last = writeBuses_0_io_slave_2_writeData_bits_last; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_0_writeResp_ready = writeBuses_0_io_slave_2_writeResp_ready; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_1_writeAddr_valid = writeBuses_1_io_slave_2_writeAddr_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_1_writeAddr_bits_id = writeBuses_1_io_slave_2_writeAddr_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_1_writeAddr_bits_addr = writeBuses_1_io_slave_2_writeAddr_bits_addr; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_1_writeAddr_bits_size = writeBuses_1_io_slave_2_writeAddr_bits_size; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_1_writeData_valid = writeBuses_1_io_slave_2_writeData_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_1_writeData_bits_data = writeBuses_1_io_slave_2_writeData_bits_data; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_1_writeData_bits_strb = writeBuses_1_io_slave_2_writeData_bits_strb; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_1_writeData_bits_last = writeBuses_1_io_slave_2_writeData_bits_last; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_1_writeResp_ready = writeBuses_1_io_slave_2_writeResp_ready; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_2_writeAddr_valid = writeBuses_2_io_slave_2_writeAddr_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_2_writeAddr_bits_id = writeBuses_2_io_slave_2_writeAddr_bits_id; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_2_writeAddr_bits_addr = writeBuses_2_io_slave_2_writeAddr_bits_addr; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_2_writeAddr_bits_size = writeBuses_2_io_slave_2_writeAddr_bits_size; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_2_writeData_valid = writeBuses_2_io_slave_2_writeData_valid; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_2_writeData_bits_data = writeBuses_2_io_slave_2_writeData_bits_data; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_2_writeData_bits_strb = writeBuses_2_io_slave_2_writeData_bits_strb; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_2_writeData_bits_last = writeBuses_2_io_slave_2_writeData_bits_last; // @[AXILiteXBar.scala 58:31]
  assign writeMuxes_2_io_in_2_writeResp_ready = writeBuses_2_io_slave_2_writeResp_ready; // @[AXILiteXBar.scala 58:31]
endmodule
module top_Hw14_1(
  input         clock,
  input         reset,
  output [14:0] io_pc,
  output [31:0] io_regs_0,
  output [31:0] io_regs_1,
  output [31:0] io_regs_2,
  output [31:0] io_regs_3,
  output [31:0] io_regs_4,
  output [31:0] io_regs_5,
  output [31:0] io_regs_6,
  output [31:0] io_regs_7,
  output [31:0] io_regs_8,
  output [31:0] io_regs_9,
  output [31:0] io_regs_10,
  output [31:0] io_regs_11,
  output [31:0] io_regs_12,
  output [31:0] io_regs_13,
  output [31:0] io_regs_14,
  output [31:0] io_regs_15,
  output [31:0] io_regs_16,
  output [31:0] io_regs_17,
  output [31:0] io_regs_18,
  output [31:0] io_regs_19,
  output [31:0] io_regs_20,
  output [31:0] io_regs_21,
  output [31:0] io_regs_22,
  output [31:0] io_regs_23,
  output [31:0] io_regs_24,
  output [31:0] io_regs_25,
  output [31:0] io_regs_26,
  output [31:0] io_regs_27,
  output [31:0] io_regs_28,
  output [31:0] io_regs_29,
  output [31:0] io_regs_30,
  output [31:0] io_regs_31,
  output        io_Hcf,
  output [31:0] io_cycle_count,
  output        io_tb_slave_aw_ready,
  input         io_tb_slave_aw_valid,
  input  [16:0] io_tb_slave_aw_bits_id,
  input  [31:0] io_tb_slave_aw_bits_addr,
  input  [3:0]  io_tb_slave_aw_bits_region,
  input  [7:0]  io_tb_slave_aw_bits_len,
  input  [1:0]  io_tb_slave_aw_bits_size,
  input  [1:0]  io_tb_slave_aw_bits_burst,
  input         io_tb_slave_aw_bits_lock,
  input  [3:0]  io_tb_slave_aw_bits_cache,
  input  [2:0]  io_tb_slave_aw_bits_prot,
  input  [3:0]  io_tb_slave_aw_bits_qos,
  output        io_tb_slave_w_ready,
  input         io_tb_slave_w_valid,
  input  [31:0] io_tb_slave_w_bits_data,
  input  [3:0]  io_tb_slave_w_bits_strb,
  input         io_tb_slave_w_bits_last,
  input         io_tb_slave_b_ready,
  output        io_tb_slave_b_valid,
  output [16:0] io_tb_slave_b_bits_id,
  output [1:0]  io_tb_slave_b_bits_resp,
  output        io_tb_slave_ar_ready,
  input         io_tb_slave_ar_valid,
  input  [16:0] io_tb_slave_ar_bits_id,
  input  [31:0] io_tb_slave_ar_bits_addr,
  input  [3:0]  io_tb_slave_ar_bits_region,
  input  [7:0]  io_tb_slave_ar_bits_len,
  input  [1:0]  io_tb_slave_ar_bits_size,
  input  [1:0]  io_tb_slave_ar_bits_burst,
  input         io_tb_slave_ar_bits_lock,
  input  [3:0]  io_tb_slave_ar_bits_cache,
  input  [2:0]  io_tb_slave_ar_bits_prot,
  input  [3:0]  io_tb_slave_ar_bits_qos,
  input         io_tb_slave_r_ready,
  output        io_tb_slave_r_valid,
  output [16:0] io_tb_slave_r_bits_id,
  output [31:0] io_tb_slave_r_bits_data,
  output [1:0]  io_tb_slave_r_bits_resp,
  output        io_tb_slave_r_bits_last,
  input         io_tb_en
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  cpu_clock; // @[Hw14-1.scala 31:21]
  wire  cpu_reset; // @[Hw14-1.scala 31:21]
  wire  cpu_io_master_aw_ready; // @[Hw14-1.scala 31:21]
  wire  cpu_io_master_aw_valid; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_master_aw_bits_addr; // @[Hw14-1.scala 31:21]
  wire  cpu_io_master_w_ready; // @[Hw14-1.scala 31:21]
  wire  cpu_io_master_w_valid; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_master_w_bits_data; // @[Hw14-1.scala 31:21]
  wire [3:0] cpu_io_master_w_bits_strb; // @[Hw14-1.scala 31:21]
  wire  cpu_io_master_b_ready; // @[Hw14-1.scala 31:21]
  wire  cpu_io_master_b_valid; // @[Hw14-1.scala 31:21]
  wire  cpu_io_master_ar_ready; // @[Hw14-1.scala 31:21]
  wire  cpu_io_master_ar_valid; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_master_ar_bits_addr; // @[Hw14-1.scala 31:21]
  wire  cpu_io_master_r_ready; // @[Hw14-1.scala 31:21]
  wire  cpu_io_master_r_valid; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_master_r_bits_data; // @[Hw14-1.scala 31:21]
  wire [14:0] cpu_io_pc; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_1; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_2; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_3; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_4; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_5; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_6; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_7; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_8; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_9; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_10; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_11; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_12; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_13; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_14; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_15; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_16; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_17; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_18; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_19; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_20; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_21; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_22; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_23; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_24; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_25; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_26; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_27; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_28; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_29; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_30; // @[Hw14-1.scala 31:21]
  wire [31:0] cpu_io_regs_31; // @[Hw14-1.scala 31:21]
  wire  cpu_io_Hcf; // @[Hw14-1.scala 31:21]
  wire  dm_clock; // @[Hw14-1.scala 32:21]
  wire  dm_reset; // @[Hw14-1.scala 32:21]
  wire  dm_io_slave_aw_ready; // @[Hw14-1.scala 32:21]
  wire  dm_io_slave_aw_valid; // @[Hw14-1.scala 32:21]
  wire [31:0] dm_io_slave_aw_bits_addr; // @[Hw14-1.scala 32:21]
  wire  dm_io_slave_w_ready; // @[Hw14-1.scala 32:21]
  wire  dm_io_slave_w_valid; // @[Hw14-1.scala 32:21]
  wire [31:0] dm_io_slave_w_bits_data; // @[Hw14-1.scala 32:21]
  wire [3:0] dm_io_slave_w_bits_strb; // @[Hw14-1.scala 32:21]
  wire  dm_io_slave_b_ready; // @[Hw14-1.scala 32:21]
  wire  dm_io_slave_b_valid; // @[Hw14-1.scala 32:21]
  wire  dm_io_slave_ar_ready; // @[Hw14-1.scala 32:21]
  wire  dm_io_slave_ar_valid; // @[Hw14-1.scala 32:21]
  wire [31:0] dm_io_slave_ar_bits_addr; // @[Hw14-1.scala 32:21]
  wire  dm_io_slave_r_ready; // @[Hw14-1.scala 32:21]
  wire  dm_io_slave_r_valid; // @[Hw14-1.scala 32:21]
  wire [31:0] dm_io_slave_r_bits_data; // @[Hw14-1.scala 32:21]
  wire  sa_clock; // @[Hw14-1.scala 33:21]
  wire  sa_reset; // @[Hw14-1.scala 33:21]
  wire  sa_io_slave_aw_ready; // @[Hw14-1.scala 33:21]
  wire  sa_io_slave_aw_valid; // @[Hw14-1.scala 33:21]
  wire [31:0] sa_io_slave_aw_bits_addr; // @[Hw14-1.scala 33:21]
  wire  sa_io_slave_w_ready; // @[Hw14-1.scala 33:21]
  wire  sa_io_slave_w_valid; // @[Hw14-1.scala 33:21]
  wire [31:0] sa_io_slave_w_bits_data; // @[Hw14-1.scala 33:21]
  wire [3:0] sa_io_slave_w_bits_strb; // @[Hw14-1.scala 33:21]
  wire  sa_io_slave_b_valid; // @[Hw14-1.scala 33:21]
  wire  sa_io_slave_ar_ready; // @[Hw14-1.scala 33:21]
  wire  sa_io_slave_ar_valid; // @[Hw14-1.scala 33:21]
  wire [31:0] sa_io_slave_ar_bits_addr; // @[Hw14-1.scala 33:21]
  wire  sa_io_slave_r_valid; // @[Hw14-1.scala 33:21]
  wire [31:0] sa_io_slave_r_bits_data; // @[Hw14-1.scala 33:21]
  wire  sa_io_tb_slave_ar_ready; // @[Hw14-1.scala 33:21]
  wire [31:0] sa_io_tb_slave_ar_bits_addr; // @[Hw14-1.scala 33:21]
  wire  sa_io_tb_slave_r_valid; // @[Hw14-1.scala 33:21]
  wire [31:0] sa_io_tb_slave_r_bits_data; // @[Hw14-1.scala 33:21]
  wire  sa_io_tb_en; // @[Hw14-1.scala 33:21]
  wire  sa_io_master_aw_ready; // @[Hw14-1.scala 33:21]
  wire  sa_io_master_aw_valid; // @[Hw14-1.scala 33:21]
  wire [31:0] sa_io_master_aw_bits_addr; // @[Hw14-1.scala 33:21]
  wire  sa_io_master_w_ready; // @[Hw14-1.scala 33:21]
  wire  sa_io_master_w_valid; // @[Hw14-1.scala 33:21]
  wire [31:0] sa_io_master_w_bits_data; // @[Hw14-1.scala 33:21]
  wire [3:0] sa_io_master_w_bits_strb; // @[Hw14-1.scala 33:21]
  wire  sa_io_master_b_ready; // @[Hw14-1.scala 33:21]
  wire  sa_io_master_b_valid; // @[Hw14-1.scala 33:21]
  wire  sa_io_master_ar_ready; // @[Hw14-1.scala 33:21]
  wire  sa_io_master_ar_valid; // @[Hw14-1.scala 33:21]
  wire [31:0] sa_io_master_ar_bits_addr; // @[Hw14-1.scala 33:21]
  wire  sa_io_master_r_ready; // @[Hw14-1.scala 33:21]
  wire  sa_io_master_r_valid; // @[Hw14-1.scala 33:21]
  wire [31:0] sa_io_master_r_bits_data; // @[Hw14-1.scala 33:21]
  wire  dma_clock; // @[Hw14-1.scala 34:21]
  wire  dma_reset; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_aw_ready; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_aw_valid; // @[Hw14-1.scala 34:21]
  wire [16:0] dma_io_slave_aw_bits_id; // @[Hw14-1.scala 34:21]
  wire [31:0] dma_io_slave_aw_bits_addr; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_slave_aw_bits_region; // @[Hw14-1.scala 34:21]
  wire [7:0] dma_io_slave_aw_bits_len; // @[Hw14-1.scala 34:21]
  wire [1:0] dma_io_slave_aw_bits_size; // @[Hw14-1.scala 34:21]
  wire [1:0] dma_io_slave_aw_bits_burst; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_aw_bits_lock; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_slave_aw_bits_cache; // @[Hw14-1.scala 34:21]
  wire [2:0] dma_io_slave_aw_bits_prot; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_slave_aw_bits_qos; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_w_ready; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_w_valid; // @[Hw14-1.scala 34:21]
  wire [31:0] dma_io_slave_w_bits_data; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_slave_w_bits_strb; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_w_bits_last; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_b_ready; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_b_valid; // @[Hw14-1.scala 34:21]
  wire [16:0] dma_io_slave_b_bits_id; // @[Hw14-1.scala 34:21]
  wire [1:0] dma_io_slave_b_bits_resp; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_ar_ready; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_ar_valid; // @[Hw14-1.scala 34:21]
  wire [16:0] dma_io_slave_ar_bits_id; // @[Hw14-1.scala 34:21]
  wire [31:0] dma_io_slave_ar_bits_addr; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_slave_ar_bits_region; // @[Hw14-1.scala 34:21]
  wire [7:0] dma_io_slave_ar_bits_len; // @[Hw14-1.scala 34:21]
  wire [1:0] dma_io_slave_ar_bits_size; // @[Hw14-1.scala 34:21]
  wire [1:0] dma_io_slave_ar_bits_burst; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_ar_bits_lock; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_slave_ar_bits_cache; // @[Hw14-1.scala 34:21]
  wire [2:0] dma_io_slave_ar_bits_prot; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_slave_ar_bits_qos; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_r_ready; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_r_valid; // @[Hw14-1.scala 34:21]
  wire [16:0] dma_io_slave_r_bits_id; // @[Hw14-1.scala 34:21]
  wire [31:0] dma_io_slave_r_bits_data; // @[Hw14-1.scala 34:21]
  wire [1:0] dma_io_slave_r_bits_resp; // @[Hw14-1.scala 34:21]
  wire  dma_io_slave_r_bits_last; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_aw_ready; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_aw_valid; // @[Hw14-1.scala 34:21]
  wire [16:0] dma_io_master_aw_bits_id; // @[Hw14-1.scala 34:21]
  wire [31:0] dma_io_master_aw_bits_addr; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_master_aw_bits_region; // @[Hw14-1.scala 34:21]
  wire [7:0] dma_io_master_aw_bits_len; // @[Hw14-1.scala 34:21]
  wire [1:0] dma_io_master_aw_bits_size; // @[Hw14-1.scala 34:21]
  wire [1:0] dma_io_master_aw_bits_burst; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_aw_bits_lock; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_master_aw_bits_cache; // @[Hw14-1.scala 34:21]
  wire [2:0] dma_io_master_aw_bits_prot; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_master_aw_bits_qos; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_w_ready; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_w_valid; // @[Hw14-1.scala 34:21]
  wire [31:0] dma_io_master_w_bits_data; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_master_w_bits_strb; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_w_bits_last; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_b_ready; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_b_valid; // @[Hw14-1.scala 34:21]
  wire [16:0] dma_io_master_b_bits_id; // @[Hw14-1.scala 34:21]
  wire [1:0] dma_io_master_b_bits_resp; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_ar_ready; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_ar_valid; // @[Hw14-1.scala 34:21]
  wire [16:0] dma_io_master_ar_bits_id; // @[Hw14-1.scala 34:21]
  wire [31:0] dma_io_master_ar_bits_addr; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_master_ar_bits_region; // @[Hw14-1.scala 34:21]
  wire [7:0] dma_io_master_ar_bits_len; // @[Hw14-1.scala 34:21]
  wire [1:0] dma_io_master_ar_bits_size; // @[Hw14-1.scala 34:21]
  wire [1:0] dma_io_master_ar_bits_burst; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_ar_bits_lock; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_master_ar_bits_cache; // @[Hw14-1.scala 34:21]
  wire [2:0] dma_io_master_ar_bits_prot; // @[Hw14-1.scala 34:21]
  wire [3:0] dma_io_master_ar_bits_qos; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_r_ready; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_r_valid; // @[Hw14-1.scala 34:21]
  wire [16:0] dma_io_master_r_bits_id; // @[Hw14-1.scala 34:21]
  wire [31:0] dma_io_master_r_bits_data; // @[Hw14-1.scala 34:21]
  wire [1:0] dma_io_master_r_bits_resp; // @[Hw14-1.scala 34:21]
  wire  dma_io_master_r_bits_last; // @[Hw14-1.scala 34:21]
  wire  dma_io_Hcf; // @[Hw14-1.scala 34:21]
  wire  bus_clock; // @[Hw14-1.scala 36:21]
  wire  bus_reset; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_0_aw_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_0_aw_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_masters_0_aw_bits_addr; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_0_w_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_0_w_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_masters_0_w_bits_data; // @[Hw14-1.scala 36:21]
  wire [3:0] bus_io_masters_0_w_bits_strb; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_0_b_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_0_b_valid; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_0_ar_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_0_ar_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_masters_0_ar_bits_addr; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_0_r_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_0_r_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_masters_0_r_bits_data; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_1_aw_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_1_aw_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_masters_1_aw_bits_addr; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_1_w_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_1_w_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_masters_1_w_bits_data; // @[Hw14-1.scala 36:21]
  wire [3:0] bus_io_masters_1_w_bits_strb; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_1_b_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_1_b_valid; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_1_ar_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_1_ar_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_masters_1_ar_bits_addr; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_1_r_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_1_r_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_masters_1_r_bits_data; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_2_aw_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_2_aw_valid; // @[Hw14-1.scala 36:21]
  wire [16:0] bus_io_masters_2_aw_bits_id; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_masters_2_aw_bits_addr; // @[Hw14-1.scala 36:21]
  wire [1:0] bus_io_masters_2_aw_bits_size; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_2_w_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_2_w_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_masters_2_w_bits_data; // @[Hw14-1.scala 36:21]
  wire [3:0] bus_io_masters_2_w_bits_strb; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_2_w_bits_last; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_2_b_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_2_b_valid; // @[Hw14-1.scala 36:21]
  wire [16:0] bus_io_masters_2_b_bits_id; // @[Hw14-1.scala 36:21]
  wire [1:0] bus_io_masters_2_b_bits_resp; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_2_ar_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_2_ar_valid; // @[Hw14-1.scala 36:21]
  wire [16:0] bus_io_masters_2_ar_bits_id; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_masters_2_ar_bits_addr; // @[Hw14-1.scala 36:21]
  wire [1:0] bus_io_masters_2_ar_bits_size; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_2_r_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_2_r_valid; // @[Hw14-1.scala 36:21]
  wire [16:0] bus_io_masters_2_r_bits_id; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_masters_2_r_bits_data; // @[Hw14-1.scala 36:21]
  wire [1:0] bus_io_masters_2_r_bits_resp; // @[Hw14-1.scala 36:21]
  wire  bus_io_masters_2_r_bits_last; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_0_aw_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_0_aw_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_slaves_0_aw_bits_addr; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_0_w_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_0_w_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_slaves_0_w_bits_data; // @[Hw14-1.scala 36:21]
  wire [3:0] bus_io_slaves_0_w_bits_strb; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_0_b_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_0_b_valid; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_0_ar_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_0_ar_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_slaves_0_ar_bits_addr; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_0_r_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_0_r_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_slaves_0_r_bits_data; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_1_aw_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_1_aw_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_slaves_1_aw_bits_addr; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_1_w_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_1_w_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_slaves_1_w_bits_data; // @[Hw14-1.scala 36:21]
  wire [3:0] bus_io_slaves_1_w_bits_strb; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_1_b_valid; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_1_ar_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_1_ar_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_slaves_1_ar_bits_addr; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_1_r_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_slaves_1_r_bits_data; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_2_aw_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_2_aw_valid; // @[Hw14-1.scala 36:21]
  wire [16:0] bus_io_slaves_2_aw_bits_id; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_slaves_2_aw_bits_addr; // @[Hw14-1.scala 36:21]
  wire [1:0] bus_io_slaves_2_aw_bits_size; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_2_w_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_2_w_valid; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_slaves_2_w_bits_data; // @[Hw14-1.scala 36:21]
  wire [3:0] bus_io_slaves_2_w_bits_strb; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_2_w_bits_last; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_2_b_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_2_b_valid; // @[Hw14-1.scala 36:21]
  wire [16:0] bus_io_slaves_2_b_bits_id; // @[Hw14-1.scala 36:21]
  wire [1:0] bus_io_slaves_2_b_bits_resp; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_2_ar_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_2_ar_valid; // @[Hw14-1.scala 36:21]
  wire [16:0] bus_io_slaves_2_ar_bits_id; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_slaves_2_ar_bits_addr; // @[Hw14-1.scala 36:21]
  wire [1:0] bus_io_slaves_2_ar_bits_size; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_2_r_ready; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_2_r_valid; // @[Hw14-1.scala 36:21]
  wire [16:0] bus_io_slaves_2_r_bits_id; // @[Hw14-1.scala 36:21]
  wire [31:0] bus_io_slaves_2_r_bits_data; // @[Hw14-1.scala 36:21]
  wire [1:0] bus_io_slaves_2_r_bits_resp; // @[Hw14-1.scala 36:21]
  wire  bus_io_slaves_2_r_bits_last; // @[Hw14-1.scala 36:21]
  reg [31:0] cycle_counter; // @[Hw14-1.scala 51:32]
  wire [31:0] _cycle_counter_T_1 = cycle_counter + 32'h1; // @[Hw14-1.scala 52:37]
  SingleCycleCPU cpu ( // @[Hw14-1.scala 31:21]
    .clock(cpu_clock),
    .reset(cpu_reset),
    .io_master_aw_ready(cpu_io_master_aw_ready),
    .io_master_aw_valid(cpu_io_master_aw_valid),
    .io_master_aw_bits_addr(cpu_io_master_aw_bits_addr),
    .io_master_w_ready(cpu_io_master_w_ready),
    .io_master_w_valid(cpu_io_master_w_valid),
    .io_master_w_bits_data(cpu_io_master_w_bits_data),
    .io_master_w_bits_strb(cpu_io_master_w_bits_strb),
    .io_master_b_ready(cpu_io_master_b_ready),
    .io_master_b_valid(cpu_io_master_b_valid),
    .io_master_ar_ready(cpu_io_master_ar_ready),
    .io_master_ar_valid(cpu_io_master_ar_valid),
    .io_master_ar_bits_addr(cpu_io_master_ar_bits_addr),
    .io_master_r_ready(cpu_io_master_r_ready),
    .io_master_r_valid(cpu_io_master_r_valid),
    .io_master_r_bits_data(cpu_io_master_r_bits_data),
    .io_pc(cpu_io_pc),
    .io_regs_1(cpu_io_regs_1),
    .io_regs_2(cpu_io_regs_2),
    .io_regs_3(cpu_io_regs_3),
    .io_regs_4(cpu_io_regs_4),
    .io_regs_5(cpu_io_regs_5),
    .io_regs_6(cpu_io_regs_6),
    .io_regs_7(cpu_io_regs_7),
    .io_regs_8(cpu_io_regs_8),
    .io_regs_9(cpu_io_regs_9),
    .io_regs_10(cpu_io_regs_10),
    .io_regs_11(cpu_io_regs_11),
    .io_regs_12(cpu_io_regs_12),
    .io_regs_13(cpu_io_regs_13),
    .io_regs_14(cpu_io_regs_14),
    .io_regs_15(cpu_io_regs_15),
    .io_regs_16(cpu_io_regs_16),
    .io_regs_17(cpu_io_regs_17),
    .io_regs_18(cpu_io_regs_18),
    .io_regs_19(cpu_io_regs_19),
    .io_regs_20(cpu_io_regs_20),
    .io_regs_21(cpu_io_regs_21),
    .io_regs_22(cpu_io_regs_22),
    .io_regs_23(cpu_io_regs_23),
    .io_regs_24(cpu_io_regs_24),
    .io_regs_25(cpu_io_regs_25),
    .io_regs_26(cpu_io_regs_26),
    .io_regs_27(cpu_io_regs_27),
    .io_regs_28(cpu_io_regs_28),
    .io_regs_29(cpu_io_regs_29),
    .io_regs_30(cpu_io_regs_30),
    .io_regs_31(cpu_io_regs_31),
    .io_Hcf(cpu_io_Hcf)
  );
  DataMem dm ( // @[Hw14-1.scala 32:21]
    .clock(dm_clock),
    .reset(dm_reset),
    .io_slave_aw_ready(dm_io_slave_aw_ready),
    .io_slave_aw_valid(dm_io_slave_aw_valid),
    .io_slave_aw_bits_addr(dm_io_slave_aw_bits_addr),
    .io_slave_w_ready(dm_io_slave_w_ready),
    .io_slave_w_valid(dm_io_slave_w_valid),
    .io_slave_w_bits_data(dm_io_slave_w_bits_data),
    .io_slave_w_bits_strb(dm_io_slave_w_bits_strb),
    .io_slave_b_ready(dm_io_slave_b_ready),
    .io_slave_b_valid(dm_io_slave_b_valid),
    .io_slave_ar_ready(dm_io_slave_ar_ready),
    .io_slave_ar_valid(dm_io_slave_ar_valid),
    .io_slave_ar_bits_addr(dm_io_slave_ar_bits_addr),
    .io_slave_r_ready(dm_io_slave_r_ready),
    .io_slave_r_valid(dm_io_slave_r_valid),
    .io_slave_r_bits_data(dm_io_slave_r_bits_data)
  );
  topSA sa ( // @[Hw14-1.scala 33:21]
    .clock(sa_clock),
    .reset(sa_reset),
    .io_slave_aw_ready(sa_io_slave_aw_ready),
    .io_slave_aw_valid(sa_io_slave_aw_valid),
    .io_slave_aw_bits_addr(sa_io_slave_aw_bits_addr),
    .io_slave_w_ready(sa_io_slave_w_ready),
    .io_slave_w_valid(sa_io_slave_w_valid),
    .io_slave_w_bits_data(sa_io_slave_w_bits_data),
    .io_slave_w_bits_strb(sa_io_slave_w_bits_strb),
    .io_slave_b_valid(sa_io_slave_b_valid),
    .io_slave_ar_ready(sa_io_slave_ar_ready),
    .io_slave_ar_valid(sa_io_slave_ar_valid),
    .io_slave_ar_bits_addr(sa_io_slave_ar_bits_addr),
    .io_slave_r_valid(sa_io_slave_r_valid),
    .io_slave_r_bits_data(sa_io_slave_r_bits_data),
    .io_tb_slave_ar_ready(sa_io_tb_slave_ar_ready),
    .io_tb_slave_ar_bits_addr(sa_io_tb_slave_ar_bits_addr),
    .io_tb_slave_r_valid(sa_io_tb_slave_r_valid),
    .io_tb_slave_r_bits_data(sa_io_tb_slave_r_bits_data),
    .io_tb_en(sa_io_tb_en),
    .io_master_aw_ready(sa_io_master_aw_ready),
    .io_master_aw_valid(sa_io_master_aw_valid),
    .io_master_aw_bits_addr(sa_io_master_aw_bits_addr),
    .io_master_w_ready(sa_io_master_w_ready),
    .io_master_w_valid(sa_io_master_w_valid),
    .io_master_w_bits_data(sa_io_master_w_bits_data),
    .io_master_w_bits_strb(sa_io_master_w_bits_strb),
    .io_master_b_ready(sa_io_master_b_ready),
    .io_master_b_valid(sa_io_master_b_valid),
    .io_master_ar_ready(sa_io_master_ar_ready),
    .io_master_ar_valid(sa_io_master_ar_valid),
    .io_master_ar_bits_addr(sa_io_master_ar_bits_addr),
    .io_master_r_ready(sa_io_master_r_ready),
    .io_master_r_valid(sa_io_master_r_valid),
    .io_master_r_bits_data(sa_io_master_r_bits_data)
  );
  DMA dma ( // @[Hw14-1.scala 34:21]
    .clock(dma_clock),
    .reset(dma_reset),
    .io_slave_aw_ready(dma_io_slave_aw_ready),
    .io_slave_aw_valid(dma_io_slave_aw_valid),
    .io_slave_aw_bits_id(dma_io_slave_aw_bits_id),
    .io_slave_aw_bits_addr(dma_io_slave_aw_bits_addr),
    .io_slave_aw_bits_region(dma_io_slave_aw_bits_region),
    .io_slave_aw_bits_len(dma_io_slave_aw_bits_len),
    .io_slave_aw_bits_size(dma_io_slave_aw_bits_size),
    .io_slave_aw_bits_burst(dma_io_slave_aw_bits_burst),
    .io_slave_aw_bits_lock(dma_io_slave_aw_bits_lock),
    .io_slave_aw_bits_cache(dma_io_slave_aw_bits_cache),
    .io_slave_aw_bits_prot(dma_io_slave_aw_bits_prot),
    .io_slave_aw_bits_qos(dma_io_slave_aw_bits_qos),
    .io_slave_w_ready(dma_io_slave_w_ready),
    .io_slave_w_valid(dma_io_slave_w_valid),
    .io_slave_w_bits_data(dma_io_slave_w_bits_data),
    .io_slave_w_bits_strb(dma_io_slave_w_bits_strb),
    .io_slave_w_bits_last(dma_io_slave_w_bits_last),
    .io_slave_b_ready(dma_io_slave_b_ready),
    .io_slave_b_valid(dma_io_slave_b_valid),
    .io_slave_b_bits_id(dma_io_slave_b_bits_id),
    .io_slave_b_bits_resp(dma_io_slave_b_bits_resp),
    .io_slave_ar_ready(dma_io_slave_ar_ready),
    .io_slave_ar_valid(dma_io_slave_ar_valid),
    .io_slave_ar_bits_id(dma_io_slave_ar_bits_id),
    .io_slave_ar_bits_addr(dma_io_slave_ar_bits_addr),
    .io_slave_ar_bits_region(dma_io_slave_ar_bits_region),
    .io_slave_ar_bits_len(dma_io_slave_ar_bits_len),
    .io_slave_ar_bits_size(dma_io_slave_ar_bits_size),
    .io_slave_ar_bits_burst(dma_io_slave_ar_bits_burst),
    .io_slave_ar_bits_lock(dma_io_slave_ar_bits_lock),
    .io_slave_ar_bits_cache(dma_io_slave_ar_bits_cache),
    .io_slave_ar_bits_prot(dma_io_slave_ar_bits_prot),
    .io_slave_ar_bits_qos(dma_io_slave_ar_bits_qos),
    .io_slave_r_ready(dma_io_slave_r_ready),
    .io_slave_r_valid(dma_io_slave_r_valid),
    .io_slave_r_bits_id(dma_io_slave_r_bits_id),
    .io_slave_r_bits_data(dma_io_slave_r_bits_data),
    .io_slave_r_bits_resp(dma_io_slave_r_bits_resp),
    .io_slave_r_bits_last(dma_io_slave_r_bits_last),
    .io_master_aw_ready(dma_io_master_aw_ready),
    .io_master_aw_valid(dma_io_master_aw_valid),
    .io_master_aw_bits_id(dma_io_master_aw_bits_id),
    .io_master_aw_bits_addr(dma_io_master_aw_bits_addr),
    .io_master_aw_bits_region(dma_io_master_aw_bits_region),
    .io_master_aw_bits_len(dma_io_master_aw_bits_len),
    .io_master_aw_bits_size(dma_io_master_aw_bits_size),
    .io_master_aw_bits_burst(dma_io_master_aw_bits_burst),
    .io_master_aw_bits_lock(dma_io_master_aw_bits_lock),
    .io_master_aw_bits_cache(dma_io_master_aw_bits_cache),
    .io_master_aw_bits_prot(dma_io_master_aw_bits_prot),
    .io_master_aw_bits_qos(dma_io_master_aw_bits_qos),
    .io_master_w_ready(dma_io_master_w_ready),
    .io_master_w_valid(dma_io_master_w_valid),
    .io_master_w_bits_data(dma_io_master_w_bits_data),
    .io_master_w_bits_strb(dma_io_master_w_bits_strb),
    .io_master_w_bits_last(dma_io_master_w_bits_last),
    .io_master_b_ready(dma_io_master_b_ready),
    .io_master_b_valid(dma_io_master_b_valid),
    .io_master_b_bits_id(dma_io_master_b_bits_id),
    .io_master_b_bits_resp(dma_io_master_b_bits_resp),
    .io_master_ar_ready(dma_io_master_ar_ready),
    .io_master_ar_valid(dma_io_master_ar_valid),
    .io_master_ar_bits_id(dma_io_master_ar_bits_id),
    .io_master_ar_bits_addr(dma_io_master_ar_bits_addr),
    .io_master_ar_bits_region(dma_io_master_ar_bits_region),
    .io_master_ar_bits_len(dma_io_master_ar_bits_len),
    .io_master_ar_bits_size(dma_io_master_ar_bits_size),
    .io_master_ar_bits_burst(dma_io_master_ar_bits_burst),
    .io_master_ar_bits_lock(dma_io_master_ar_bits_lock),
    .io_master_ar_bits_cache(dma_io_master_ar_bits_cache),
    .io_master_ar_bits_prot(dma_io_master_ar_bits_prot),
    .io_master_ar_bits_qos(dma_io_master_ar_bits_qos),
    .io_master_r_ready(dma_io_master_r_ready),
    .io_master_r_valid(dma_io_master_r_valid),
    .io_master_r_bits_id(dma_io_master_r_bits_id),
    .io_master_r_bits_data(dma_io_master_r_bits_data),
    .io_master_r_bits_resp(dma_io_master_r_bits_resp),
    .io_master_r_bits_last(dma_io_master_r_bits_last),
    .io_Hcf(dma_io_Hcf)
  );
  AXILiteXBar bus ( // @[Hw14-1.scala 36:21]
    .clock(bus_clock),
    .reset(bus_reset),
    .io_masters_0_aw_ready(bus_io_masters_0_aw_ready),
    .io_masters_0_aw_valid(bus_io_masters_0_aw_valid),
    .io_masters_0_aw_bits_addr(bus_io_masters_0_aw_bits_addr),
    .io_masters_0_w_ready(bus_io_masters_0_w_ready),
    .io_masters_0_w_valid(bus_io_masters_0_w_valid),
    .io_masters_0_w_bits_data(bus_io_masters_0_w_bits_data),
    .io_masters_0_w_bits_strb(bus_io_masters_0_w_bits_strb),
    .io_masters_0_b_ready(bus_io_masters_0_b_ready),
    .io_masters_0_b_valid(bus_io_masters_0_b_valid),
    .io_masters_0_ar_ready(bus_io_masters_0_ar_ready),
    .io_masters_0_ar_valid(bus_io_masters_0_ar_valid),
    .io_masters_0_ar_bits_addr(bus_io_masters_0_ar_bits_addr),
    .io_masters_0_r_ready(bus_io_masters_0_r_ready),
    .io_masters_0_r_valid(bus_io_masters_0_r_valid),
    .io_masters_0_r_bits_data(bus_io_masters_0_r_bits_data),
    .io_masters_1_aw_ready(bus_io_masters_1_aw_ready),
    .io_masters_1_aw_valid(bus_io_masters_1_aw_valid),
    .io_masters_1_aw_bits_addr(bus_io_masters_1_aw_bits_addr),
    .io_masters_1_w_ready(bus_io_masters_1_w_ready),
    .io_masters_1_w_valid(bus_io_masters_1_w_valid),
    .io_masters_1_w_bits_data(bus_io_masters_1_w_bits_data),
    .io_masters_1_w_bits_strb(bus_io_masters_1_w_bits_strb),
    .io_masters_1_b_ready(bus_io_masters_1_b_ready),
    .io_masters_1_b_valid(bus_io_masters_1_b_valid),
    .io_masters_1_ar_ready(bus_io_masters_1_ar_ready),
    .io_masters_1_ar_valid(bus_io_masters_1_ar_valid),
    .io_masters_1_ar_bits_addr(bus_io_masters_1_ar_bits_addr),
    .io_masters_1_r_ready(bus_io_masters_1_r_ready),
    .io_masters_1_r_valid(bus_io_masters_1_r_valid),
    .io_masters_1_r_bits_data(bus_io_masters_1_r_bits_data),
    .io_masters_2_aw_ready(bus_io_masters_2_aw_ready),
    .io_masters_2_aw_valid(bus_io_masters_2_aw_valid),
    .io_masters_2_aw_bits_id(bus_io_masters_2_aw_bits_id),
    .io_masters_2_aw_bits_addr(bus_io_masters_2_aw_bits_addr),
    .io_masters_2_aw_bits_size(bus_io_masters_2_aw_bits_size),
    .io_masters_2_w_ready(bus_io_masters_2_w_ready),
    .io_masters_2_w_valid(bus_io_masters_2_w_valid),
    .io_masters_2_w_bits_data(bus_io_masters_2_w_bits_data),
    .io_masters_2_w_bits_strb(bus_io_masters_2_w_bits_strb),
    .io_masters_2_w_bits_last(bus_io_masters_2_w_bits_last),
    .io_masters_2_b_ready(bus_io_masters_2_b_ready),
    .io_masters_2_b_valid(bus_io_masters_2_b_valid),
    .io_masters_2_b_bits_id(bus_io_masters_2_b_bits_id),
    .io_masters_2_b_bits_resp(bus_io_masters_2_b_bits_resp),
    .io_masters_2_ar_ready(bus_io_masters_2_ar_ready),
    .io_masters_2_ar_valid(bus_io_masters_2_ar_valid),
    .io_masters_2_ar_bits_id(bus_io_masters_2_ar_bits_id),
    .io_masters_2_ar_bits_addr(bus_io_masters_2_ar_bits_addr),
    .io_masters_2_ar_bits_size(bus_io_masters_2_ar_bits_size),
    .io_masters_2_r_ready(bus_io_masters_2_r_ready),
    .io_masters_2_r_valid(bus_io_masters_2_r_valid),
    .io_masters_2_r_bits_id(bus_io_masters_2_r_bits_id),
    .io_masters_2_r_bits_data(bus_io_masters_2_r_bits_data),
    .io_masters_2_r_bits_resp(bus_io_masters_2_r_bits_resp),
    .io_masters_2_r_bits_last(bus_io_masters_2_r_bits_last),
    .io_slaves_0_aw_ready(bus_io_slaves_0_aw_ready),
    .io_slaves_0_aw_valid(bus_io_slaves_0_aw_valid),
    .io_slaves_0_aw_bits_addr(bus_io_slaves_0_aw_bits_addr),
    .io_slaves_0_w_ready(bus_io_slaves_0_w_ready),
    .io_slaves_0_w_valid(bus_io_slaves_0_w_valid),
    .io_slaves_0_w_bits_data(bus_io_slaves_0_w_bits_data),
    .io_slaves_0_w_bits_strb(bus_io_slaves_0_w_bits_strb),
    .io_slaves_0_b_ready(bus_io_slaves_0_b_ready),
    .io_slaves_0_b_valid(bus_io_slaves_0_b_valid),
    .io_slaves_0_ar_ready(bus_io_slaves_0_ar_ready),
    .io_slaves_0_ar_valid(bus_io_slaves_0_ar_valid),
    .io_slaves_0_ar_bits_addr(bus_io_slaves_0_ar_bits_addr),
    .io_slaves_0_r_ready(bus_io_slaves_0_r_ready),
    .io_slaves_0_r_valid(bus_io_slaves_0_r_valid),
    .io_slaves_0_r_bits_data(bus_io_slaves_0_r_bits_data),
    .io_slaves_1_aw_ready(bus_io_slaves_1_aw_ready),
    .io_slaves_1_aw_valid(bus_io_slaves_1_aw_valid),
    .io_slaves_1_aw_bits_addr(bus_io_slaves_1_aw_bits_addr),
    .io_slaves_1_w_ready(bus_io_slaves_1_w_ready),
    .io_slaves_1_w_valid(bus_io_slaves_1_w_valid),
    .io_slaves_1_w_bits_data(bus_io_slaves_1_w_bits_data),
    .io_slaves_1_w_bits_strb(bus_io_slaves_1_w_bits_strb),
    .io_slaves_1_b_valid(bus_io_slaves_1_b_valid),
    .io_slaves_1_ar_ready(bus_io_slaves_1_ar_ready),
    .io_slaves_1_ar_valid(bus_io_slaves_1_ar_valid),
    .io_slaves_1_ar_bits_addr(bus_io_slaves_1_ar_bits_addr),
    .io_slaves_1_r_valid(bus_io_slaves_1_r_valid),
    .io_slaves_1_r_bits_data(bus_io_slaves_1_r_bits_data),
    .io_slaves_2_aw_ready(bus_io_slaves_2_aw_ready),
    .io_slaves_2_aw_valid(bus_io_slaves_2_aw_valid),
    .io_slaves_2_aw_bits_id(bus_io_slaves_2_aw_bits_id),
    .io_slaves_2_aw_bits_addr(bus_io_slaves_2_aw_bits_addr),
    .io_slaves_2_aw_bits_size(bus_io_slaves_2_aw_bits_size),
    .io_slaves_2_w_ready(bus_io_slaves_2_w_ready),
    .io_slaves_2_w_valid(bus_io_slaves_2_w_valid),
    .io_slaves_2_w_bits_data(bus_io_slaves_2_w_bits_data),
    .io_slaves_2_w_bits_strb(bus_io_slaves_2_w_bits_strb),
    .io_slaves_2_w_bits_last(bus_io_slaves_2_w_bits_last),
    .io_slaves_2_b_ready(bus_io_slaves_2_b_ready),
    .io_slaves_2_b_valid(bus_io_slaves_2_b_valid),
    .io_slaves_2_b_bits_id(bus_io_slaves_2_b_bits_id),
    .io_slaves_2_b_bits_resp(bus_io_slaves_2_b_bits_resp),
    .io_slaves_2_ar_ready(bus_io_slaves_2_ar_ready),
    .io_slaves_2_ar_valid(bus_io_slaves_2_ar_valid),
    .io_slaves_2_ar_bits_id(bus_io_slaves_2_ar_bits_id),
    .io_slaves_2_ar_bits_addr(bus_io_slaves_2_ar_bits_addr),
    .io_slaves_2_ar_bits_size(bus_io_slaves_2_ar_bits_size),
    .io_slaves_2_r_ready(bus_io_slaves_2_r_ready),
    .io_slaves_2_r_valid(bus_io_slaves_2_r_valid),
    .io_slaves_2_r_bits_id(bus_io_slaves_2_r_bits_id),
    .io_slaves_2_r_bits_data(bus_io_slaves_2_r_bits_data),
    .io_slaves_2_r_bits_resp(bus_io_slaves_2_r_bits_resp),
    .io_slaves_2_r_bits_last(bus_io_slaves_2_r_bits_last)
  );
  assign io_pc = cpu_io_pc; // @[Hw14-1.scala 46:13]
  assign io_regs_0 = 32'h0; // @[Hw14-1.scala 47:13]
  assign io_regs_1 = cpu_io_regs_1; // @[Hw14-1.scala 47:13]
  assign io_regs_2 = cpu_io_regs_2; // @[Hw14-1.scala 47:13]
  assign io_regs_3 = cpu_io_regs_3; // @[Hw14-1.scala 47:13]
  assign io_regs_4 = cpu_io_regs_4; // @[Hw14-1.scala 47:13]
  assign io_regs_5 = cpu_io_regs_5; // @[Hw14-1.scala 47:13]
  assign io_regs_6 = cpu_io_regs_6; // @[Hw14-1.scala 47:13]
  assign io_regs_7 = cpu_io_regs_7; // @[Hw14-1.scala 47:13]
  assign io_regs_8 = cpu_io_regs_8; // @[Hw14-1.scala 47:13]
  assign io_regs_9 = cpu_io_regs_9; // @[Hw14-1.scala 47:13]
  assign io_regs_10 = cpu_io_regs_10; // @[Hw14-1.scala 47:13]
  assign io_regs_11 = cpu_io_regs_11; // @[Hw14-1.scala 47:13]
  assign io_regs_12 = cpu_io_regs_12; // @[Hw14-1.scala 47:13]
  assign io_regs_13 = cpu_io_regs_13; // @[Hw14-1.scala 47:13]
  assign io_regs_14 = cpu_io_regs_14; // @[Hw14-1.scala 47:13]
  assign io_regs_15 = cpu_io_regs_15; // @[Hw14-1.scala 47:13]
  assign io_regs_16 = cpu_io_regs_16; // @[Hw14-1.scala 47:13]
  assign io_regs_17 = cpu_io_regs_17; // @[Hw14-1.scala 47:13]
  assign io_regs_18 = cpu_io_regs_18; // @[Hw14-1.scala 47:13]
  assign io_regs_19 = cpu_io_regs_19; // @[Hw14-1.scala 47:13]
  assign io_regs_20 = cpu_io_regs_20; // @[Hw14-1.scala 47:13]
  assign io_regs_21 = cpu_io_regs_21; // @[Hw14-1.scala 47:13]
  assign io_regs_22 = cpu_io_regs_22; // @[Hw14-1.scala 47:13]
  assign io_regs_23 = cpu_io_regs_23; // @[Hw14-1.scala 47:13]
  assign io_regs_24 = cpu_io_regs_24; // @[Hw14-1.scala 47:13]
  assign io_regs_25 = cpu_io_regs_25; // @[Hw14-1.scala 47:13]
  assign io_regs_26 = cpu_io_regs_26; // @[Hw14-1.scala 47:13]
  assign io_regs_27 = cpu_io_regs_27; // @[Hw14-1.scala 47:13]
  assign io_regs_28 = cpu_io_regs_28; // @[Hw14-1.scala 47:13]
  assign io_regs_29 = cpu_io_regs_29; // @[Hw14-1.scala 47:13]
  assign io_regs_30 = cpu_io_regs_30; // @[Hw14-1.scala 47:13]
  assign io_regs_31 = cpu_io_regs_31; // @[Hw14-1.scala 47:13]
  assign io_Hcf = cpu_io_Hcf; // @[Hw14-1.scala 48:13]
  assign io_cycle_count = cycle_counter; // @[Hw14-1.scala 53:20]
  assign io_tb_slave_aw_ready = 1'h0; // @[Hw14-1.scala 56:17]
  assign io_tb_slave_w_ready = 1'h0; // @[Hw14-1.scala 56:17]
  assign io_tb_slave_b_valid = 1'h0; // @[Hw14-1.scala 56:17]
  assign io_tb_slave_b_bits_id = 17'h0; // @[Hw14-1.scala 56:17]
  assign io_tb_slave_b_bits_resp = 2'h0; // @[Hw14-1.scala 56:17]
  assign io_tb_slave_ar_ready = sa_io_tb_slave_ar_ready; // @[Hw14-1.scala 56:17]
  assign io_tb_slave_r_valid = sa_io_tb_slave_r_valid; // @[Hw14-1.scala 56:17]
  assign io_tb_slave_r_bits_id = 17'h0; // @[Hw14-1.scala 56:17]
  assign io_tb_slave_r_bits_data = sa_io_tb_slave_r_bits_data; // @[Hw14-1.scala 56:17]
  assign io_tb_slave_r_bits_resp = 2'h0; // @[Hw14-1.scala 56:17]
  assign io_tb_slave_r_bits_last = 1'h1; // @[Hw14-1.scala 56:17]
  assign cpu_clock = clock;
  assign cpu_reset = reset;
  assign cpu_io_master_aw_ready = bus_io_masters_0_aw_ready; // @[Hw14-1.scala 38:23]
  assign cpu_io_master_w_ready = bus_io_masters_0_w_ready; // @[Hw14-1.scala 38:23]
  assign cpu_io_master_b_valid = bus_io_masters_0_b_valid; // @[Hw14-1.scala 38:23]
  assign cpu_io_master_ar_ready = bus_io_masters_0_ar_ready; // @[Hw14-1.scala 38:23]
  assign cpu_io_master_r_valid = bus_io_masters_0_r_valid; // @[Hw14-1.scala 38:23]
  assign cpu_io_master_r_bits_data = bus_io_masters_0_r_bits_data; // @[Hw14-1.scala 38:23]
  assign dm_clock = clock;
  assign dm_reset = reset;
  assign dm_io_slave_aw_valid = bus_io_slaves_0_aw_valid; // @[Hw14-1.scala 41:22]
  assign dm_io_slave_aw_bits_addr = bus_io_slaves_0_aw_bits_addr; // @[Hw14-1.scala 41:22]
  assign dm_io_slave_w_valid = bus_io_slaves_0_w_valid; // @[Hw14-1.scala 41:22]
  assign dm_io_slave_w_bits_data = bus_io_slaves_0_w_bits_data; // @[Hw14-1.scala 41:22]
  assign dm_io_slave_w_bits_strb = bus_io_slaves_0_w_bits_strb; // @[Hw14-1.scala 41:22]
  assign dm_io_slave_b_ready = bus_io_slaves_0_b_ready; // @[Hw14-1.scala 41:22]
  assign dm_io_slave_ar_valid = bus_io_slaves_0_ar_valid; // @[Hw14-1.scala 41:22]
  assign dm_io_slave_ar_bits_addr = bus_io_slaves_0_ar_bits_addr; // @[Hw14-1.scala 41:22]
  assign dm_io_slave_r_ready = bus_io_slaves_0_r_ready; // @[Hw14-1.scala 41:22]
  assign sa_clock = clock;
  assign sa_reset = reset;
  assign sa_io_slave_aw_valid = bus_io_slaves_1_aw_valid; // @[Hw14-1.scala 42:22]
  assign sa_io_slave_aw_bits_addr = bus_io_slaves_1_aw_bits_addr; // @[Hw14-1.scala 42:22]
  assign sa_io_slave_w_valid = bus_io_slaves_1_w_valid; // @[Hw14-1.scala 42:22]
  assign sa_io_slave_w_bits_data = bus_io_slaves_1_w_bits_data; // @[Hw14-1.scala 42:22]
  assign sa_io_slave_w_bits_strb = bus_io_slaves_1_w_bits_strb; // @[Hw14-1.scala 42:22]
  assign sa_io_slave_ar_valid = bus_io_slaves_1_ar_valid; // @[Hw14-1.scala 42:22]
  assign sa_io_slave_ar_bits_addr = bus_io_slaves_1_ar_bits_addr; // @[Hw14-1.scala 42:22]
  assign sa_io_tb_slave_ar_bits_addr = io_tb_slave_ar_bits_addr; // @[Hw14-1.scala 56:17]
  assign sa_io_tb_en = io_tb_en; // @[Hw14-1.scala 57:17]
  assign sa_io_master_aw_ready = bus_io_masters_1_aw_ready; // @[Hw14-1.scala 39:23]
  assign sa_io_master_w_ready = bus_io_masters_1_w_ready; // @[Hw14-1.scala 39:23]
  assign sa_io_master_b_valid = bus_io_masters_1_b_valid; // @[Hw14-1.scala 39:23]
  assign sa_io_master_ar_ready = bus_io_masters_1_ar_ready; // @[Hw14-1.scala 39:23]
  assign sa_io_master_r_valid = bus_io_masters_1_r_valid; // @[Hw14-1.scala 39:23]
  assign sa_io_master_r_bits_data = bus_io_masters_1_r_bits_data; // @[Hw14-1.scala 39:23]
  assign dma_clock = clock;
  assign dma_reset = reset;
  assign dma_io_slave_aw_valid = bus_io_slaves_2_aw_valid; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_aw_bits_id = bus_io_slaves_2_aw_bits_id; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_aw_bits_addr = bus_io_slaves_2_aw_bits_addr; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_aw_bits_region = 4'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_aw_bits_len = 8'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_aw_bits_size = bus_io_slaves_2_aw_bits_size; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_aw_bits_burst = 2'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_aw_bits_lock = 1'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_aw_bits_cache = 4'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_aw_bits_prot = 3'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_aw_bits_qos = 4'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_w_valid = bus_io_slaves_2_w_valid; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_w_bits_data = bus_io_slaves_2_w_bits_data; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_w_bits_strb = bus_io_slaves_2_w_bits_strb; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_w_bits_last = bus_io_slaves_2_w_bits_last; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_b_ready = bus_io_slaves_2_b_ready; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_ar_valid = bus_io_slaves_2_ar_valid; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_ar_bits_id = bus_io_slaves_2_ar_bits_id; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_ar_bits_addr = bus_io_slaves_2_ar_bits_addr; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_ar_bits_region = 4'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_ar_bits_len = 8'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_ar_bits_size = bus_io_slaves_2_ar_bits_size; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_ar_bits_burst = 2'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_ar_bits_lock = 1'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_ar_bits_cache = 4'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_ar_bits_prot = 3'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_ar_bits_qos = 4'h0; // @[Hw14-1.scala 43:22]
  assign dma_io_slave_r_ready = bus_io_slaves_2_r_ready; // @[Hw14-1.scala 43:22]
  assign dma_io_master_aw_ready = bus_io_masters_2_aw_ready; // @[Hw14-1.scala 40:23]
  assign dma_io_master_w_ready = bus_io_masters_2_w_ready; // @[Hw14-1.scala 40:23]
  assign dma_io_master_b_valid = bus_io_masters_2_b_valid; // @[Hw14-1.scala 40:23]
  assign dma_io_master_b_bits_id = bus_io_masters_2_b_bits_id; // @[Hw14-1.scala 40:23]
  assign dma_io_master_b_bits_resp = bus_io_masters_2_b_bits_resp; // @[Hw14-1.scala 40:23]
  assign dma_io_master_ar_ready = bus_io_masters_2_ar_ready; // @[Hw14-1.scala 40:23]
  assign dma_io_master_r_valid = bus_io_masters_2_r_valid; // @[Hw14-1.scala 40:23]
  assign dma_io_master_r_bits_id = bus_io_masters_2_r_bits_id; // @[Hw14-1.scala 40:23]
  assign dma_io_master_r_bits_data = bus_io_masters_2_r_bits_data; // @[Hw14-1.scala 40:23]
  assign dma_io_master_r_bits_resp = bus_io_masters_2_r_bits_resp; // @[Hw14-1.scala 40:23]
  assign dma_io_master_r_bits_last = bus_io_masters_2_r_bits_last; // @[Hw14-1.scala 40:23]
  assign bus_clock = clock;
  assign bus_reset = reset;
  assign bus_io_masters_0_aw_valid = cpu_io_master_aw_valid; // @[Hw14-1.scala 38:23]
  assign bus_io_masters_0_aw_bits_addr = cpu_io_master_aw_bits_addr; // @[Hw14-1.scala 38:23]
  assign bus_io_masters_0_w_valid = cpu_io_master_w_valid; // @[Hw14-1.scala 38:23]
  assign bus_io_masters_0_w_bits_data = cpu_io_master_w_bits_data; // @[Hw14-1.scala 38:23]
  assign bus_io_masters_0_w_bits_strb = cpu_io_master_w_bits_strb; // @[Hw14-1.scala 38:23]
  assign bus_io_masters_0_b_ready = cpu_io_master_b_ready; // @[Hw14-1.scala 38:23]
  assign bus_io_masters_0_ar_valid = cpu_io_master_ar_valid; // @[Hw14-1.scala 38:23]
  assign bus_io_masters_0_ar_bits_addr = cpu_io_master_ar_bits_addr; // @[Hw14-1.scala 38:23]
  assign bus_io_masters_0_r_ready = cpu_io_master_r_ready; // @[Hw14-1.scala 38:23]
  assign bus_io_masters_1_aw_valid = sa_io_master_aw_valid; // @[Hw14-1.scala 39:23]
  assign bus_io_masters_1_aw_bits_addr = sa_io_master_aw_bits_addr; // @[Hw14-1.scala 39:23]
  assign bus_io_masters_1_w_valid = sa_io_master_w_valid; // @[Hw14-1.scala 39:23]
  assign bus_io_masters_1_w_bits_data = sa_io_master_w_bits_data; // @[Hw14-1.scala 39:23]
  assign bus_io_masters_1_w_bits_strb = sa_io_master_w_bits_strb; // @[Hw14-1.scala 39:23]
  assign bus_io_masters_1_b_ready = sa_io_master_b_ready; // @[Hw14-1.scala 39:23]
  assign bus_io_masters_1_ar_valid = sa_io_master_ar_valid; // @[Hw14-1.scala 39:23]
  assign bus_io_masters_1_ar_bits_addr = sa_io_master_ar_bits_addr; // @[Hw14-1.scala 39:23]
  assign bus_io_masters_1_r_ready = sa_io_master_r_ready; // @[Hw14-1.scala 39:23]
  assign bus_io_masters_2_aw_valid = dma_io_master_aw_valid; // @[Hw14-1.scala 40:23]
  assign bus_io_masters_2_aw_bits_id = dma_io_master_aw_bits_id; // @[Hw14-1.scala 40:23]
  assign bus_io_masters_2_aw_bits_addr = dma_io_master_aw_bits_addr; // @[Hw14-1.scala 40:23]
  assign bus_io_masters_2_aw_bits_size = dma_io_master_aw_bits_size; // @[Hw14-1.scala 40:23]
  assign bus_io_masters_2_w_valid = dma_io_master_w_valid; // @[Hw14-1.scala 40:23]
  assign bus_io_masters_2_w_bits_data = dma_io_master_w_bits_data; // @[Hw14-1.scala 40:23]
  assign bus_io_masters_2_w_bits_strb = dma_io_master_w_bits_strb; // @[Hw14-1.scala 40:23]
  assign bus_io_masters_2_w_bits_last = dma_io_master_w_bits_last; // @[Hw14-1.scala 40:23]
  assign bus_io_masters_2_b_ready = dma_io_master_b_ready; // @[Hw14-1.scala 40:23]
  assign bus_io_masters_2_ar_valid = dma_io_master_ar_valid; // @[Hw14-1.scala 40:23]
  assign bus_io_masters_2_ar_bits_id = dma_io_master_ar_bits_id; // @[Hw14-1.scala 40:23]
  assign bus_io_masters_2_ar_bits_addr = dma_io_master_ar_bits_addr; // @[Hw14-1.scala 40:23]
  assign bus_io_masters_2_ar_bits_size = dma_io_master_ar_bits_size; // @[Hw14-1.scala 40:23]
  assign bus_io_masters_2_r_ready = dma_io_master_r_ready; // @[Hw14-1.scala 40:23]
  assign bus_io_slaves_0_aw_ready = dm_io_slave_aw_ready; // @[Hw14-1.scala 41:22]
  assign bus_io_slaves_0_w_ready = dm_io_slave_w_ready; // @[Hw14-1.scala 41:22]
  assign bus_io_slaves_0_b_valid = dm_io_slave_b_valid; // @[Hw14-1.scala 41:22]
  assign bus_io_slaves_0_ar_ready = dm_io_slave_ar_ready; // @[Hw14-1.scala 41:22]
  assign bus_io_slaves_0_r_valid = dm_io_slave_r_valid; // @[Hw14-1.scala 41:22]
  assign bus_io_slaves_0_r_bits_data = dm_io_slave_r_bits_data; // @[Hw14-1.scala 41:22]
  assign bus_io_slaves_1_aw_ready = sa_io_slave_aw_ready; // @[Hw14-1.scala 42:22]
  assign bus_io_slaves_1_w_ready = sa_io_slave_w_ready; // @[Hw14-1.scala 42:22]
  assign bus_io_slaves_1_b_valid = sa_io_slave_b_valid; // @[Hw14-1.scala 42:22]
  assign bus_io_slaves_1_ar_ready = sa_io_slave_ar_ready; // @[Hw14-1.scala 42:22]
  assign bus_io_slaves_1_r_valid = sa_io_slave_r_valid; // @[Hw14-1.scala 42:22]
  assign bus_io_slaves_1_r_bits_data = sa_io_slave_r_bits_data; // @[Hw14-1.scala 42:22]
  assign bus_io_slaves_2_aw_ready = dma_io_slave_aw_ready; // @[Hw14-1.scala 43:22]
  assign bus_io_slaves_2_w_ready = dma_io_slave_w_ready; // @[Hw14-1.scala 43:22]
  assign bus_io_slaves_2_b_valid = dma_io_slave_b_valid; // @[Hw14-1.scala 43:22]
  assign bus_io_slaves_2_b_bits_id = dma_io_slave_b_bits_id; // @[Hw14-1.scala 43:22]
  assign bus_io_slaves_2_b_bits_resp = dma_io_slave_b_bits_resp; // @[Hw14-1.scala 43:22]
  assign bus_io_slaves_2_ar_ready = dma_io_slave_ar_ready; // @[Hw14-1.scala 43:22]
  assign bus_io_slaves_2_r_valid = dma_io_slave_r_valid; // @[Hw14-1.scala 43:22]
  assign bus_io_slaves_2_r_bits_id = dma_io_slave_r_bits_id; // @[Hw14-1.scala 43:22]
  assign bus_io_slaves_2_r_bits_data = dma_io_slave_r_bits_data; // @[Hw14-1.scala 43:22]
  assign bus_io_slaves_2_r_bits_resp = dma_io_slave_r_bits_resp; // @[Hw14-1.scala 43:22]
  assign bus_io_slaves_2_r_bits_last = dma_io_slave_r_bits_last; // @[Hw14-1.scala 43:22]
  always @(posedge clock) begin
    if (reset) begin // @[Hw14-1.scala 51:32]
      cycle_counter <= 32'h1; // @[Hw14-1.scala 51:32]
    end else begin
      cycle_counter <= _cycle_counter_T_1; // @[Hw14-1.scala 52:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cycle_counter = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
