module BindsTo_0_InstMem(
  input         clock,
  input  [14:0] io_raddr,
  output [31:0] io_inst
);

initial begin
  $readmemh("src/main/resource/Hw14-1/m_code.hex", InstMem.memory);
end
                      endmodule

bind InstMem BindsTo_0_InstMem BindsTo_0_InstMem_Inst(.*);