module BindsTo_1_DataMem(
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

initial begin
  $readmemh("src/main/resource/Hw14-1/data.hex", DataMem.memory);
end
                      endmodule

bind DataMem BindsTo_1_DataMem BindsTo_1_DataMem_Inst(.*);