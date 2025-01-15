module UART_TX (
//Input and Output Ports 
input           [7:0]   P_DATA,
input                   DATA_VALID,PAR_EN,PAR_TYP,
input                   CLK,
input                   RST,
output                  TX_OUT,BUSY
);
///////////////////////////////////////////////////////


//Internal Cnnections
wire                    start_bit,stop_bit;
wire                    ser_done,ser_en;
wire            [1:0]   mux_sel;
wire                    ser_data;
wire                    par_bit;
assign start_bit = 0;
assign stop_bit = 1;
////////////////////////////////////////////////////////


//Instantiate The Finite State Machine Unit
TX_FSM U_TX_FSM(
.Data_Valid(DATA_VALID),
.ser_done(ser_done),
.PAR_EN(PAR_EN),
.Clk(CLK),
.RST(RST),
.mux_sel(mux_sel),
.ser_en(ser_en),
.busy(BUSY)
);
/////////////////////////////////////////

//Instantiate The Serializer Unit
serializer U_serializer(
.P_DATA(P_DATA),
.ser_en(ser_en),
.busy(BUSY),
.Clk(CLK),
.RST(RST),
.ser_done(ser_done),
.ser_data(ser_data)
);
///////////////////////////////////////////


//Instantiate The parityCalcution Unit
parityCalc U_parityCalc(
.P_DATA(P_DATA),
.Data_Valid(DATA_VALID),
.PAR_TYP(PAR_TYP),
.PAR_EN(PAR_EN),
.busy(BUSY),
.Clk(CLK),
.RST(RST),
.par_bit(par_bit)
);
/////////////////////////////////////////////

//Instantiate The Multiplexer Unit
MUX_4x1 U_MUX(
.A(start_bit),
.B(stop_bit),
.C(ser_data),
.D(par_bit),
.mux_sel(mux_sel),
.mux_out(TX_OUT)
);

    
endmodule