`timescale 1ps/1ps
module SYS_TB ();
    
integer i;    
//-------------------------//
/*  parameters definition  */   
//-------------------------//
parameter Width = 8;
parameter Depth = 16;

//-------------------------//
/*    DUT instantiation    */   
//-------------------------//
reg  REF_CLK_tb;
reg  UART_CLK_tb;
reg  Reset_tb;
reg  Rx_IN_tb;
wire Tx_out_tb;
//wire Parity_error_tb;
//wire Stop_error_tb;

SYS_TOP #(
    .DATA_WIDTH(Width),
    .Depth(Depth)
) DUT (
    .REF_CLK(REF_CLK_tb),
    .UART_CLK(UART_CLK_tb),
    .RST_N(Reset_tb),
    .UART_RX_IN(Rx_IN_tb),
    .UART_TX_O(Tx_out_tb)
    //.Parity_error(Parity_error_tb),
    //.Stop_error(Stop_error_tb)
);

//-------------------------//
/*      initial block      */   
//-------------------------//

initial begin
REF_CLK_tb        = 1'b1;
UART_CLK_tb       = 1'b1;
Reset_tb          = 1'b1;
Rx_IN_tb          = 1'b1;

//  Reset
#100
Reset_tb = 1'b0;   
#100
Reset_tb = 1'b1;  

#30 

send_data_P(8'b01010101); // write
send_data_P(8'b01010000); // Adress = 1010
send_data_P(8'b01010000); // data = 1010

send_data_P(8'b11011101); // Read
send_data_P(8'b01010000); // Adress = 1010

send_data_P(8'b00110011); // ALU_OP
send_data_P(8'b11110000); // A = 00001111
send_data_P(8'b11111111); // B = 11111111
send_data_P(8'b00000000); // ADD = 100001110

send_data_P(8'b10111011); // ALU_with_no_OP
send_data_P(8'b11010000); // compare A > B

send_data_P(8'b00110011); // ALU_OP
send_data_P(8'b11010000); // A = 00001010
send_data_P(8'b11010000); // B = 00001010
send_data_P(8'b10000000); // sub = 00000000

send_data_P(8'b10111011); // ALU_with_no_OP
send_data_P(8'b01010000); // compare A = B

send_data_P(8'b00110011); // ALU_OP
send_data_P(8'b00010000); // A = 8
send_data_P(8'b00000001); // B = 128
send_data_P(8'b01000000); // mul = 100_00000000

send_data_P(8'b10111011); // ALU_with_no_OP
send_data_P(8'b00110000); // compare A < B



#100000

$stop ;

end

task send_data_P (
    input  [Width-1:0] data
);
begin
    Rx_IN_tb = 0;
    #(8*100);
    for (i = Width-1; i>=0; i=i-1) begin
        Rx_IN_tb = data[i];
        #(8*100);
    end
    Rx_IN_tb = ^data;
    #(8*100);
    Rx_IN_tb = 1;
    #(8*100);
end
endtask

always #50 UART_CLK_tb = ~UART_CLK_tb ;
always #1 REF_CLK_tb  = ~REF_CLK_tb ;


endmodule