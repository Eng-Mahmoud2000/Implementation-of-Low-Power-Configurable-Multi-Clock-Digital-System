module CLK_GATE (
input               CLK_EN,
input               CLK,
output wire         GATED_CLK
);

reg                 Latched_EN;   

always @(CLK or CLK_EN) begin
    if(!CLK) begin
        Latched_EN <= CLK_EN;
    end
end

assign GATED_CLK= CLK && Latched_EN;

endmodule