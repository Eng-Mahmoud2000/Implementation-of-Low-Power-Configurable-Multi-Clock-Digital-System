module ALU #( parameter OP_WIDTH = 8 )
(
// input and output ports 
input           [OP_WIDTH-1:0]      A,B,
input           [3:0]               ALU_FUN,
input                               EN,
input                               CLK,RST,
output reg      [2*OP_WIDTH-1:0]    ALU_OUT_reg,
output reg                          OUT_VALID  
);
/////////////////////////////////////////////////////
//internal_signals  
reg             [2*OP_WIDTH-1:0]     ALU_OUT_comb;
reg                                 OUT_VALID_comb;
// register the output of ALU
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        ALU_OUT_reg<='b0;
        OUT_VALID<=1'b0;
    end
    else begin
        ALU_OUT_reg<= ALU_OUT_comb;
        OUT_VALID <= OUT_VALID_comb;
    end
end
///////////////////////////////////////////////////////
always @(*) begin
    ALU_OUT_comb= 'b0;
    OUT_VALID_comb= 1'b0;
    if (EN) begin
        OUT_VALID_comb= 1'b1;
        case (ALU_FUN)
            4'b0000:begin
                ALU_OUT_comb=A+B;
                end
            4'b0001:begin
                ALU_OUT_comb=A-B;
                end
            4'b0010:begin
                ALU_OUT_comb=A*B;
                end
            4'b0011:begin
                ALU_OUT_comb=A/B;
                end
            4'b0100:begin
                ALU_OUT_comb=A&B;
                end
            4'b0101:begin
                ALU_OUT_comb=A|B;
                end
            4'b0110:begin
                ALU_OUT_comb=~(A&B);
                end
            4'b0111:begin
                ALU_OUT_comb=~(A|B);
                end
            4'b1000:begin
                ALU_OUT_comb=A^B;
                end
            4'b1001:begin
                ALU_OUT_comb=(A~^B);
                end
            4'b1010:begin
                if (A==B) begin
                    ALU_OUT_comb='b1; 
                end
                else begin
                    ALU_OUT_comb='b0; 
                end
                end
            4'b1011:begin
                if (A>B) begin
                    ALU_OUT_comb='b10;  
                end
                else begin
                    ALU_OUT_comb='b0; 
                end
                end
            4'b1100:begin
                if (A<B) begin
                    ALU_OUT_comb='b11;  
                end
                else begin
                    ALU_OUT_comb='b0; 
                end
                end
            4'b1101:begin
                ALU_OUT_comb=A>>1;
                end
            4'b1110:begin
                ALU_OUT_comb=A<<1;
                end
            default:ALU_OUT_comb='b0;
        endcase
    end
    else begin
        OUT_VALID_comb= 1'b0;
    end
end
    
endmodule