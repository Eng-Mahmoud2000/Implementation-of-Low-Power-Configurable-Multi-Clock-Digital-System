module Reset_Sync (
input                           CLK,
input                           RST,
output wire                     Sync_RST
);
reg                             Meta_flop,Sync_flop ;
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        Meta_flop<=1'b0;
        Sync_flop<=1'b0;
    end
    else begin
        Meta_flop<=1'b1;
        Sync_flop<=Meta_flop;
    end
end
assign Sync_RST = Sync_flop;

endmodule