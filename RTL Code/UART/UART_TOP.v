module UART_TOP # ( parameter DATA_WIDTH = 8 , PRESCALE_WIDTH = 5 )
(
input                               RX_IN_S,
input   [DATA_WIDTH-1:0]            TX_IN_P,
input                               TX_IN_V,
input                               PAR_EN,
input   [PRESCALE_WIDTH-1:0]        Prescale,
input                               PAR_TYP,
input                               TX_CLK,
input                               RX_CLK,
input                               RST,
output                              TX_OUT_S,
output                              TX_OUT_V,
output                              RX_OUT_V,
output  [DATA_WIDTH-1:0]            RX_OUT_P
);


UART_TX U_UART_TX(
.P_DATA(TX_IN_P),
.DATA_VALID(TX_IN_V),
.PAR_EN(PAR_EN),
.PAR_TYP(PAR_TYP),
.CLK(TX_CLK),
.RST(RST),
.TX_OUT(TX_OUT_S),
.BUSY(TX_OUT_V)
);



UART_RX U_UART_RX(
.RX_IN(RX_IN_S),
.Prescale(Prescale),           
.PAR_EN(PAR_EN),
.PAR_TYP(PAR_TYP),
.CLK(RX_CLK),
.RST(RST),
.data_valid(RX_OUT_V),
.P_DATA(RX_OUT_P)
);
    
endmodule