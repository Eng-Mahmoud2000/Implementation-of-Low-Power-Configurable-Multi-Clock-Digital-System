module SYS_CTRL # ( parameter Width = 8 , Depth = 16)
(
input                                  CLK,
input                                  RST,
input           [Width-1:0]            RX_P_Data,
input                                  RX_D_VLD,
input           [Width-1:0]            Rd_D,
input                                  Rd_D_VLD,
input                                  busy,
input           [2*Width-1:0]          ALU_OUT,
input                                  OUT_VLD,
output                                 WrEn,
output                                 RdEn,
output          [$clog2(Depth)-1:0]    Addr,
output          [Width-1:0]            Wr_D,
output          [3:0]                  ALU_FUN,
output                                 ALU_EN,
output                                 CLK_EN,
output          [Width-1:0]            TX_P_Data,
output                                 TX_D_VLD,
output                                 clk_div_en
);


SYS_RX_FSM # ( .Width(Width) , .Depth(Depth) ) U_SYS_RX_FSM (
.RX_P_Data(RX_P_Data),
.RX_D_VLD(RX_D_VLD),
.CLK(CLK),
.RST(RST),
.WrEn(WrEn),
.RdEn(RdEn),
.Addr(Addr),
.Wr_D(Wr_D),
.ALU_FUN(ALU_FUN),
.ALU_EN(ALU_EN),
.CLK_EN(CLK_EN)
);


SYS_TX_FSM # ( .Width(Width) ) U_SYS_TX_FSM (
.Rd_D(Rd_D),
.Rd_D_VLD(Rd_D_VLD),
.CLK(CLK),
.RST(RST),
.busy(busy),
.ALU_OUT(ALU_OUT),
.OUT_VLD(OUT_VLD),
.TX_P_Data(TX_P_Data),
.TX_D_VLD(TX_D_VLD),
.clk_div_en(clk_div_en)
);
    
endmodule