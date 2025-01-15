module parityCalc (
//Input and Output Ports 
input       [7:0]   P_DATA,
input               Data_Valid,busy,
input               PAR_TYP,
input               Clk,
input               RST,
input               PAR_EN,
output reg          par_bit
);
//////////////////////////////////////////////


//Internal Cnnections
reg         [7:0]       P_DATA_NEW;
///////////////////////////////////////////

always @(posedge Clk or negedge RST) begin
    if(!RST) begin
        P_DATA_NEW<=8'b0;
    end
    else if (Data_Valid&!busy) begin
        P_DATA_NEW<=P_DATA;
    end
end
/////////////////////////////////////////


always @(*) begin
    if(PAR_EN) begin
        if (PAR_TYP) begin // Odd parity
            par_bit= ~^P_DATA_NEW;
        end
        else begin // Even parity
            par_bit= ^P_DATA_NEW;
        end
    end
    else begin
        par_bit=1'b0; 
    end
end
endmodule