
module SYS_TOP # ( parameter DATA_WIDTH = 8 ,  Depth = 16 )
(
 input   wire                          RST_N,
 input   wire                          UART_CLK,
 input   wire                          REF_CLK,
 input   wire                          UART_RX_IN,
 output  wire                          UART_TX_O
// output  wire                          parity_error,
//output  wire                          framing_error
);


wire                                   SYNC_UART_RST,
                                       SYNC_REF_RST;
									   
wire					               UART_TX_CLK;


wire      [DATA_WIDTH-1:0]             Operand_A,
                                       Operand_B,
									   UART_Config,
									   DIV_RATIO;
									   
									   
wire      [DATA_WIDTH-1:0]             UART_RX_OUT;
wire         						   UART_RX_V_OUT;
wire      [DATA_WIDTH-1:0]			   UART_RX_SYNC;
wire                                   UART_RX_V_SYNC;

wire      [DATA_WIDTH-1:0]             UART_TX_IN;
wire        						   UART_TX_VLD;
wire      [DATA_WIDTH-1:0]             UART_TX_SYNC;
wire        						   UART_TX_V_SYNC;

wire                                   UART_TX_Busy;	
wire                                   UART_TX_Busy_SYNC;	
									   
wire                                   RF_WrEn;
wire                                   RF_RdEn;
wire      [$clog2(Depth)-1:0]          RF_Address;
wire      [DATA_WIDTH-1:0]             RF_WrData;
wire      [DATA_WIDTH-1:0]             RF_RdData;
wire                                   RF_RdData_VLD;									   

wire                                   CLKG_EN;
wire                                   ALU_EN;
wire      [3:0]                        ALU_FUN; 
wire      [DATA_WIDTH*2-1:0]           ALU_OUT;
wire                                   ALU_OUT_VLD; 
									   
wire                                   ALU_CLK ;								   
	
wire                                   CLKDIV_EN ;
								   
///********************************************************///
//////////////////// Reset synchronizers /////////////////////
///********************************************************///

Reset_Sync U0_Reset_Sync (
.RST(RST_N),
.CLK(UART_CLK),
.Sync_RST(SYNC_UART_RST)
);

Reset_Sync U1_U0_Reset_Sync (
.RST(RST_N),
.CLK(REF_CLK),
.Sync_RST(SYNC_REF_RST)
);

///********************************************************///
////////////////////// Data Synchronizer /////////////////////
///********************************************************///

Data_Sync # (.Width(DATA_WIDTH)) U0_ref_Data_Sync (
.CLK(REF_CLK),
.RST(SYNC_REF_RST),
.P_Data_in(UART_RX_OUT),
.bus_enable(UART_RX_V_OUT),
.Sync_Data(UART_RX_SYNC),
.enable_pulse_d(UART_RX_V_SYNC)
);

Data_Sync # (.Width(DATA_WIDTH)) U1_uart_Data_Sync (
.CLK(UART_TX_CLK),
.RST(SYNC_UART_RST),
.P_Data_in(UART_TX_IN),
.bus_enable(UART_TX_VLD),
.Sync_Data(UART_TX_SYNC),
.enable_pulse_d(UART_TX_V_SYNC)
);

///********************************************************///
////////////////////// Bit Synchronizer /////////////////////
///********************************************************///

Bit_Sync U0_Bit_Sync (
.CLK(REF_CLK),
.RST(SYNC_REF_RST),
.unsync_bit(UART_TX_Busy),
.sync_bit(UART_TX_Busy_SYNC)
);

///********************************************************///
//////////////////////// Clock Divider ///////////////////////
///********************************************************///

CLK_DIV U0_CLK_DIV (
.Ref_CLK(UART_CLK),             
.RST(SYNC_UART_RST),                 
.CLK_EN(CLKDIV_EN),               
.div_ratio(DIV_RATIO[3:0]),           
.Div_CLK(UART_TX_CLK)             
);

///********************************************************///
/////////////////////////// UART /////////////////////////////
///********************************************************///

UART_TOP # (.DATA_WIDTH (DATA_WIDTH)) U0_UART_TOP (
.RST(SYNC_UART_RST),
.TX_CLK(UART_TX_CLK),
.RX_CLK(UART_CLK),
.PAR_EN(UART_Config[0]),
.PAR_TYP(UART_Config[1]),
.Prescale(UART_Config[6:2]),
.RX_IN_S(UART_RX_IN),
.RX_OUT_P(UART_RX_OUT),                      
.RX_OUT_V(UART_RX_V_OUT),                      
.TX_IN_P(UART_TX_SYNC), 
.TX_IN_V(UART_TX_V_SYNC), 
.TX_OUT_S(UART_TX_O),
.TX_OUT_V(UART_TX_Busy)
//.parity_error(parity_error),
//.framing_error(framing_error)                  
);

///********************************************************///
//////////////////// System Controller ///////////////////////
///********************************************************///

SYS_CTRL # (.Width(DATA_WIDTH) , .Depth(Depth)) U0_SYS_CTRL (
.CLK(REF_CLK),
.RST(SYNC_REF_RST),
.Rd_D(RF_RdData),
.Rd_D_VLD(RF_RdData_VLD),
.WrEn(RF_WrEn),
.RdEn(RF_RdEn),
.Addr(RF_Address),
.Wr_D(RF_WrData),
.ALU_EN(ALU_EN),
.ALU_FUN(ALU_FUN), 
.ALU_OUT(ALU_OUT),
.OUT_VLD(ALU_OUT_VLD),  
.CLK_EN(CLKG_EN), 
.clk_div_en(CLKDIV_EN),
.RX_P_Data(UART_RX_SYNC), 
.RX_D_VLD(UART_RX_V_SYNC),
.busy(UART_TX_Busy_SYNC),
.TX_P_Data(UART_TX_IN), 
.TX_D_VLD(UART_TX_VLD)
);

///********************************************************///
/////////////////////// Register File ////////////////////////
///********************************************************///

Register_File # (.Width(DATA_WIDTH) , .Depth(Depth)) U0_Register_File (
.CLK(REF_CLK),
.RST(SYNC_REF_RST),
.WrEn(RF_WrEn),
.RdEn(RF_RdEn),
.Address(RF_Address),
.WrData(RF_WrData),
.RdData(RF_RdData),
.RdData_VLD(RF_RdData_VLD),
.REG0(Operand_A),
.REG1(Operand_B),
.REG2(UART_Config),
.REG3(DIV_RATIO)
);

///********************************************************///
//////////////////////////// ALU /////////////////////////////
///********************************************************///
 
ALU # (.OP_WIDTH (DATA_WIDTH)) U0_ALU (
.CLK(ALU_CLK),
.RST(SYNC_REF_RST),  
.A(Operand_A), 
.B(Operand_B),
.EN(ALU_EN),
.ALU_FUN(ALU_FUN),
.ALU_OUT_reg(ALU_OUT),
.OUT_VALID(ALU_OUT_VLD)
);

///********************************************************///
///////////////////////// Clock Gating ///////////////////////
///********************************************************///

CLK_GATE U0_CLK_GATE (
.CLK_EN(CLKG_EN),
.CLK(REF_CLK),
.GATED_CLK(ALU_CLK)
);


endmodule
 
