module Stop_check (
//Input and Output Ports 
input               stp_chk_en,sampled_bit,
input               clk,
input               rst,
output reg          stp_err
);
///////////////////////////////////////////////////////

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        stp_err<=1'b0;
    end
    else if (stp_chk_en) begin
        if (sampled_bit) begin
            stp_err<=1'b0;
        end
        else begin
            stp_err<=1'b1;
        end
    end
end
endmodule