module MUX_4x1 (
//Input and Output Ports 
input              A,B,C,D,
input      [1:0]   mux_sel,
output reg         mux_out
);
///////////////////////////////////////

always @(*) begin
    mux_out=1'b1;
    case (mux_sel)
        2'b00:begin
            mux_out=A; 
        end
        2'b01:begin
            mux_out=B; 
        end
        2'b10:begin
            mux_out=C; 
        end
        2'b11:begin
            mux_out=D; 
        end
    endcase
end
    
endmodule