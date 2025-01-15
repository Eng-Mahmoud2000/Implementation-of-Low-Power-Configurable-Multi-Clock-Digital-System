module UART_RX (
//Input and Output Ports 
input                   RX_IN,
input        [4:0]      Prescale,           // 5-bit to oversampling UP to 16
input                   PAR_EN,PAR_TYP,
input                   CLK,
input                   RST,
output                  data_valid,
output       [7:0]      P_DATA
);
///////////////////////////////////////////////////////


//Internal Cnnections
wire                    par_err,strt_glitch,stp_err;
wire        [3:0]       bit_cnt,edge_cnt;
wire                    enable,par_chk_en,strt_chk_en,stp_chk_en,dat_samp_en,deser_en,reset_cnt;
wire                    sampled_bit;

////////////////////////////////////////////////////////


//Instantiate The Finite State Machine Unit
RX_FSM U_RX_FSM(
.RX_IN(RX_IN),
.PAR_EN(PAR_EN),
.par_err(par_err),
.strt_glitch(strt_glitch),
.stp_err(stp_err),
.bit_cnt(bit_cnt),
.edge_cnt(edge_cnt),
.Clk(CLK),
.RST(RST),
.enable(enable),
.par_chk_en(par_chk_en),
.strt_chk_en(strt_chk_en),
.stp_chk_en(stp_chk_en),
.dat_samp_en(dat_samp_en),
.deser_en(deser_en),
.reset_cnt(reset_cnt),
.data_valid(data_valid)
);
/////////////////////////////////////////

//Instantiate The data sampling Unit
data_sampling U_data_sampling(
.RX_IN(RX_IN),
.dat_samp_en(dat_samp_en),
.Prescale(Prescale),
.clk(CLK),
.rst(RST),
.edge_cnt(edge_cnt),
.sampled_bit(sampled_bit)
);
///////////////////////////////////////////

//Instantiate The edge bit counter Unit
edge_bit_counter U_edge_bit_counter(
.enable(enable),
.reset_cnt(reset_cnt),
.Prescale(Prescale),
.clk(CLK),
.rst(RST),
.bit_cnt(bit_cnt),
.edge_cnt(edge_cnt)
);
///////////////////////////////////////////

//Instantiate The Deserializer Unit
deserializer U_deserializer(
.deser_en(deser_en),
.sampled_bit(sampled_bit),
.clk(CLK),
.rst(RST),
.edge_cnt(edge_cnt),
.P_DATA(P_DATA)
);
///////////////////////////////////////////


//Instantiate The parity_check Unit
parity_check U_parity_check(
.par_chk_en(par_chk_en),
.sampled_bit(sampled_bit),
.PAR_TYP(PAR_TYP),
.P_DATA(P_DATA),
.clk(CLK),
.rst(RST),
.par_err(par_err)
);
/////////////////////////////////////////////

//Instantiate The start check Unit
strt_check U_strt_check(
.strt_chk_en(strt_chk_en),
.sampled_bit(sampled_bit),
.clk(CLK),
.rst(RST),
.strt_glitch(strt_glitch)
);
/////////////////////////////////////////////

//Instantiate The stop check Unit
Stop_check U_Stop_check(
.stp_chk_en(stp_chk_en),
.sampled_bit(sampled_bit),
.clk(CLK),
.rst(RST),
.stp_err(stp_err)
);
    
endmodule