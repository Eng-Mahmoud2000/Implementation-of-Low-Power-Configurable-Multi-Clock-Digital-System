`timescale 1ns/1ps
module UART_TX_TB ();

reg     [7:0]        P_DATA_TB          ;
reg                  Data_VALID_TB      ;
reg                  PAR_EN_TB          ;
reg                  PAR_TYP_TB         ; 
reg                  CLK_TB             ;
reg                  RST_TB             ;
wire                 TX_OUT_TB          ;
wire                 Busy_TB            ;

initial begin
    $dumpfile("UART_TX.vcd");
    $dumpvars;
    
    //Initial Values
    CLK_TB            = 1'b0         ;
    RST_TB            = 1'b1         ;
    P_DATA_TB         = 8'b10101000  ;
    PAR_EN_TB         = 1'b1         ;
    PAR_TYP_TB        = 1'b1         ;
    Data_VALID_TB     = 1'b0         ;

    //Activating and Deactivation Reset signal
    #2.5
    RST_TB = 1'b0 ;
    #2.5
    RST_TB = 1'b1 ;


    //rising the data valid to test the UART
    #5
    Data_VALID_TB = 1'b1 ;
    #5
    Data_VALID_TB = 1'b0 ;

    //change the data
    #10
    P_DATA_TB        = 8'b01010100 ;

    // rising the data valid to test that the Uart does not work during sending
    #25
    Data_VALID_TB  = 1'b1;
    #5
    Data_VALID_TB  = 1'b0;
    #100

    // rising the data valid to send the new data again and chaning the parity
    PAR_TYP_TB     = 1'b0 ;
    Data_VALID_TB  = 1'b1;
    #5
    Data_VALID_TB  = 1'b0 ;
    #100

    // disabling the parity bit and puting new data on the bus
    P_DATA_TB        = 8'b11001010 ;
    PAR_EN_TB        = 1'b0 ;
    #5

    // rising the data valid to send the new data again
    Data_VALID_TB  = 1'b1;
    #5
    Data_VALID_TB  = 1'b0;

    #100
    $stop ;
end

always #2.5 CLK_TB = !CLK_TB ;

UART_TX DUT (
.P_DATA(P_DATA_TB)              ,
.DATA_VALID(Data_VALID_TB)      ,
.PAR_EN(PAR_EN_TB)              ,
.PAR_TYP(PAR_TYP_TB)            ,
.CLK(CLK_TB)                    ,
.RST(RST_TB)                    ,
.TX_OUT(TX_OUT_TB)              ,
.BUSY(Busy_TB)
);

endmodule