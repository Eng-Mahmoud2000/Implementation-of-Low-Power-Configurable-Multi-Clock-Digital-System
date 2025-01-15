module strt_check (
//Input and Output Ports 
input               strt_chk_en,sampled_bit,
input               clk,
input               rst,
output reg          strt_glitch
);
///////////////////////////////////////////////////////

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        strt_glitch<=1'b0;
        end
    else if (strt_chk_en) begin
        if (!sampled_bit) begin
            strt_glitch<=1'b0;
        end
        else begin
            strt_glitch<=1'b1;
        end 
    end
end
endmodule