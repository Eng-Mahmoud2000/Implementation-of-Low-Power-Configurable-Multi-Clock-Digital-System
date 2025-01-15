module deserializer (
//Input and Output Ports 
input                          deser_en,sampled_bit,
input                          clk,
input                          rst,
input           [3:0]          edge_cnt,
output reg      [7:0]          P_DATA
);
///////////////////////////////////////////////////////

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        P_DATA<=8'b0;
    end
    else if (deser_en && edge_cnt == 4'b0110) begin
        P_DATA<= {sampled_bit,P_DATA[7:1]};
    end
end
endmodule