module CLK_DIV #( parameter Width = 4 )
(
input                       Ref_CLK,
input                       RST,
input                       CLK_EN,
input       [Width-1:0]     div_ratio,
output reg                  Div_CLK
);

wire        [Width-1:0]     toggle_count;
reg         [Width-1:0]     count;
reg                         toggle_flag; 
always @(posedge Ref_CLK or negedge RST) begin
    if (!RST) begin
        Div_CLK <= 0;
        count <= 0;
        toggle_flag <= 0;
    end
    else if (CLK_EN) begin
        if (!div_ratio[0]) begin
            if (count==toggle_count) begin
                Div_CLK <= ~Div_CLK;
                count<=0;
            end
            else begin
                count<= count + 1'b1;
            end 
        end
        else begin
            if (toggle_flag) begin
                if (count==toggle_count) begin
                    Div_CLK <= ~Div_CLK;
                    count <= 0;
                    toggle_flag <= ~toggle_flag;
                end
                else begin
                    count<= count + 1'b1;
                end
            end
            else begin
                if (count==toggle_count+1) begin
                    Div_CLK <= ~Div_CLK;
                    count<=0;
                    toggle_flag <= ~toggle_flag;
                end
                else begin
                    count <= count + 1'b1;
                end                
            end
        end
    end
end

assign toggle_count = (div_ratio>>1)-1;
endmodule