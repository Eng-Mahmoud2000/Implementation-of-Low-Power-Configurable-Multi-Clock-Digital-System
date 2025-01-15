`timescale 1ps/1ps
module UART_RX_TB ();
//Internal Cnnections
reg                         RX_CLK_TB;
reg                         RST_TB;
reg                         RX_IN_TB;
reg         [4:0]           Prescale_TB;
reg                         PAR_EN_TB;
reg                         PAR_TYP_TB;
wire        [7:0]           P_DATA_TB; 
wire                        data_valid_TB;
reg                         TX_CLK_TB;
reg                         Data_En;
reg         [5:0]           count ;
reg         [31:0]          Data = 32'b1010101010_10011011010_10010101010 ;


/* 
These three frames of data
first one to check the functionality of UART_RX Normally
second one to check the data valid if we have parity error
third one to check the functionality of UART_RX if the parity enable equal to zero
*/ 
////////////////////////////////////////////////////

initial
 begin
//initial values
Data_En  = 1'b0   ;
count    = 4'b0   ;
RX_CLK_TB = 1'b1   ;
TX_CLK_TB = 1'b0   ;
RST_TB  = 1'b1   ;
Prescale_TB = 5'b1000 ;
PAR_EN_TB = 1'b1   ;
PAR_TYP_TB = 1'b0   ;
RX_IN_TB = 1'b1   ;

#5
RST_TB = 1'b0;    // reset the design

#5
RST_TB = 1'b1;   

#20 
Data_En = 1'b1 ;

#4000
PAR_EN_TB = 1'b0   ;

#4000

$stop ;

end
///////////////////////////////////////////////////////

always @ (posedge TX_CLK_TB)
 begin
  if(Data_En && count < 6'd32 )
   begin
    RX_IN_TB <= Data[count] ;
	count <= count + 6'b1 ;
   end	
  else
    RX_IN_TB <= 1'b1 ;  
 end
 //////////////////////////////////////////////////////////
 
// Generating the clock
always #10 RX_CLK_TB = ~RX_CLK_TB ;

always #80 TX_CLK_TB = ~TX_CLK_TB ;
//////////////////////////////////////////////////////////////

// Instaniation the Design 
UART_RX DUT (
.RX_IN(RX_IN_TB),
.Prescale(Prescale_TB),
.PAR_EN(PAR_EN_TB),
.PAR_TYP(PAR_TYP_TB),
.CLK(RX_CLK_TB),
.RST(RST_TB),
.data_valid(data_valid_TB),
.P_DATA(P_DATA_TB)
);

endmodule