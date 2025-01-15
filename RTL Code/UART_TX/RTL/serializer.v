module serializer (
//Input and Output Ports 
input       [7:0]       P_DATA,
input                   ser_en,busy,
input                   Clk,
input                   RST,
output reg              ser_done,
output reg              ser_data
);
////////////////////////////////////////////////////


//Internal Cnnections
reg         [3:0]       count;
reg         [7:0]       P_DATA_NEW;
/////////////////////////////////////////////////////


always @(posedge Clk or negedge RST) begin
    if(!RST) begin
        count<=0;
        ser_done<=1'b0;
        ser_data<=1'b0;
    end
    else begin
        if (!busy) begin
            P_DATA_NEW<=P_DATA;
            count<=0;
            ser_done<=1'b0;
            end
        else if (ser_en) begin
            ser_data<=P_DATA_NEW[count];
            if (count==7) begin
                ser_done<=1'b1;
            end
            count<=count+1;
            end   
    end
end
    
endmodule