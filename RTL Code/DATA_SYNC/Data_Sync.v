module Data_Sync #( parameter Width = 8 )
(
input       [Width-1:0]         P_Data_in,
input                           CLK,
input                           RST,
input                           bus_enable,
output reg  [Width-1:0]         Sync_Data,
output reg                      enable_pulse_d
);
reg                             Meta_flop,Sync_flop,enable_flop;
wire                            enable_pulse;
wire        [Width-1:0]         Sync_Data_out;


//----------------- double flop synchronizer --------------

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        Meta_flop<=1'b0;
        Sync_flop<=1'b0;
    end
    else begin
        Meta_flop<=bus_enable;
        Sync_flop<=Meta_flop;
    end
end
/////////////////////////////////////////////////////////////////

//----------------- pulse generator --------------------

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        enable_flop<=1'b0;
    end
    else begin
        enable_flop<=Sync_flop;
    end
end
////////////////////////////////////////////////////////////////

//----------------- Register Enable pulse --------------------

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        enable_pulse_d<=1'b0;
    end
    else begin
        enable_pulse_d<=enable_pulse;
    end
end
////////////////////////////////////////////////////////////////

//----------------- Register The Data --------------------
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        Sync_Data<='b0;
    end
    else begin
        Sync_Data<=Sync_Data_out;
    end
end
///////////////////////////////////////////////////////////////////

assign enable_pulse =  Sync_flop && !enable_flop ;
assign Sync_Data_out = enable_pulse ? P_Data_in : Sync_Data ;

endmodule