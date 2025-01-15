module data_sampling (
//Input and Output Ports 
input                          RX_IN,
input                          dat_samp_en,
input           [4:0]          Prescale,       // 5-bit to oversampling UP to 16
input                          clk,
input                          rst,
input           [3:0]          edge_cnt,
output reg                     sampled_bit
);
///////////////////////////////////////////////////////

//Internal Cnnections
reg                            samp1,samp2,samp3;
reg             [2:0]          samples;

///////////////////////////////////////////////////////


always @(posedge clk or negedge rst) begin
if (!rst) begin
    sampled_bit<=1'b0;
end
else if (dat_samp_en) begin
    if (edge_cnt==(Prescale>>1)-1) begin
        samp1<=RX_IN;
        end
    else if (edge_cnt==(Prescale>>1)) begin
        samp2<=RX_IN;
        end
    else if (edge_cnt==(Prescale>>1)+1) begin
        samp3<=RX_IN;
        end
    samples={samp1,samp2,samp3};
    case (samples)
        3'b000: sampled_bit<=1'b0;
        3'b001: sampled_bit<=1'b0;
        3'b010: sampled_bit<=1'b0;
        3'b011: sampled_bit<=1'b1;
        3'b100: sampled_bit<=1'b0;
        3'b101: sampled_bit<=1'b1;
        3'b110: sampled_bit<=1'b1;
        3'b111: sampled_bit<=1'b1;
    endcase
end
end
endmodule