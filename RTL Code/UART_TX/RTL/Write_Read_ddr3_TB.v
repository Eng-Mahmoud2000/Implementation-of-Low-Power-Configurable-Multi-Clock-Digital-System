`timescale 1ns/1ps
module Write_Read_ddr3_TB ();
reg                  clk_in ;
reg     [15:0]       ddr3_dq          ;
reg     [1:0]        ddr3_dqs_n          ;
reg     [1:0]        ddr3_dqs_p          ;
wire    [13:0]       ddr3_addr          ;
wire    [2:0]        ddr3_ba          ;
wire                 ddr3_ras_n          ;
wire                 ddr3_cas_n          ;
wire                 ddr3_we_n      ;
wire                 ddr3_reset_n          ;
wire                 ddr3_ck_p         ; 
wire                 ddr3_ck_n             ;
wire                 ddr3_cke             ;
wire                 ddr3_cs_n          ;
wire                 ddr3_dm            ;
wire                 ddr3_odt            ;
wire                 led_calib            ;

initial begin
    //Initial Values
    clk_in            = 1'b0         ;
    
    end

always #5 clk_in = !clk_in ;

Write_Read_ddr3 DUT (
.clk_in(clk_in)              ,
.ddr3_dq(ddr3_dq)      ,
.ddr3_dqs_n(ddr3_dqs_n)              ,
.ddr3_dqs_p(ddr3_dqs_p)            ,
.ddr3_addr(ddr3_addr)                    ,
.ddr3_ba(ddr3_ba)                    ,
.ddr3_ras_n(ddr3_ras_n)              ,
.ddr3_cas_n(ddr3_cas_n)
.ddr3_we_n(ddr3_we_n),
.ddr3_reset_n(ddr3_reset_n),
.ddr3_ck_p(ddr3_ck_p),
.ddr3_ck_n(ddr3_ck_n),
.ddr3_cs_n(ddr3_cs_n),
.ddr3_cke(ddr3_cke),
.ddr3_dm(ddr3_dm),
.ddr3_odt(ddr3_odt),
.led_calib(led_calib)
);

endmodule