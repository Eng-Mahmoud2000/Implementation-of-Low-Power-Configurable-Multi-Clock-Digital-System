module Bit_Sync (
input                           unsync_bit,
input                           CLK,
input                           RST,
output wire                     sync_bit
);
reg                             Meta_flop,Sync_flop ;
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        Meta_flop<=1'b0;
        Sync_flop<=1'b0;
    end
    else begin
        Meta_flop<=unsync_bit;
        Sync_flop<=Meta_flop;
    end
end
assign sync_bit = Sync_flop;

endmodule