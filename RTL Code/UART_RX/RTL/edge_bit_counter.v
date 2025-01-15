module edge_bit_counter (
//Input and Output Ports 
input                       enable,
input                       reset_cnt,
input           [4:0]       Prescale,     // 5-bit to oversampling UP to 16
input                       clk,
input                       rst,
output reg      [3:0]       bit_cnt,edge_cnt
);
///////////////////////////////////////////////////////


always @(posedge clk or negedge rst) begin
    if (!rst) begin
        bit_cnt<=4'b0;
        edge_cnt<=4'b0;
    end
    else if (enable) begin
        if(reset_cnt) begin
            bit_cnt<=4'b0;
            edge_cnt<=4'b0;
            end
        else if (edge_cnt==Prescale) begin
            edge_cnt <= 4'b1;
            bit_cnt <= bit_cnt+1;
        end
        else begin
            edge_cnt <= edge_cnt+1;
        end
    end
end
endmodule