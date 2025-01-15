module parity_check (
//Input and Output Ports 
input               par_chk_en,sampled_bit,PAR_TYP,
input       [7:0]   P_DATA,
input               clk,
input               rst,
output reg          par_err
);
/////////////////////////////////////////////////

//Internal Cnnections
reg                par_bit;
/////////////////////////////////////////////////

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        par_err<=1'b0;
    end
    else if (par_chk_en) begin
        if (sampled_bit==par_bit) begin
            par_err<=1'b0;
        end
        else begin
            par_err<=1'b1;
        end
    end
end
always @(*) begin
    if(!PAR_TYP) begin
        par_bit= ^P_DATA;
    end
    else begin
        par_bit= ~^P_DATA;
    end
end
endmodule