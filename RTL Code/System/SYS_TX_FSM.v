module SYS_TX_FSM # ( parameter Width = 8 )
(
//Input and Output Ports 
input           [Width-1:0]            Rd_D,
input                                  Rd_D_VLD,
input                                  CLK,
input                                  RST,
input                                  busy,
input           [2*Width-1:0]          ALU_OUT,
input                                  OUT_VLD,
output reg      [Width-1:0]            TX_P_Data,
output reg                             TX_D_VLD,
output reg                             clk_div_en
);
///////////////////////////////////////////////////////

// define the states
localparam IDLE                         = 3'b000 ;  
localparam Reg_frame_tx_state           = 3'b001 ;
localparam Alu_frame1_tx_state          = 3'b010 ;
localparam busy_state                   = 3'b011 ;
localparam Alu_frame2_tx_state          = 3'b100 ;
///////////////////////////////////////////////////////

//Internal Cnnections
reg             [2:0]                   current_state,next_state;
reg             [2*Width-1:0]           ALU_OUT_Reg;
reg                                     frame1_done;
//////////////////////////////////////////////////////
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        current_state <= IDLE;
        clk_div_en  <= 1'b0;
        TX_P_Data   <= 'b0 ;
        ALU_OUT_Reg <= 'b0;
        frame1_done <= 1'b0 ;
    end
    else begin
        current_state <= next_state;
        clk_div_en <= 1'b1;
        if(Rd_D_VLD)begin
            TX_P_Data <= Rd_D;
        end
        if (OUT_VLD) begin
            ALU_OUT_Reg <= ALU_OUT;
        end
        if ((current_state == Alu_frame1_tx_state) && !busy) begin
            TX_P_Data <= ALU_OUT_Reg[Width-1:0];
            frame1_done <= 1'b1;
        end
        if ( (current_state == Alu_frame2_tx_state) && !busy ) begin
            TX_P_Data <= ALU_OUT_Reg[2*Width-1:Width];
            frame1_done <= 1'b0;
        end
        end
end
///////////////////////////////////////////////////////

always @(*) begin
    case(current_state)
    IDLE: begin
        TX_D_VLD = 1'b0;
        if(Rd_D_VLD)begin
            next_state = Reg_frame_tx_state;
        end
        else if (OUT_VLD)begin
            next_state = Alu_frame1_tx_state;
        end 
        else begin
            next_state = IDLE;
        end
    end
    Reg_frame_tx_state: begin
        TX_D_VLD = 1'b1;
        if (busy) begin
            next_state  = IDLE;  
        end
        else begin
            next_state  = Reg_frame_tx_state;  
        end
    end
    Alu_frame1_tx_state: begin
        if (busy) begin
            next_state  = busy_state;
            TX_D_VLD  = 1'b0;
        end  
        else begin
            next_state  = Alu_frame1_tx_state;  
            TX_D_VLD  = 1'b1;
        end
    end
    busy_state: begin
        if (!busy) begin
            if (frame1_done) begin
                next_state  = Alu_frame2_tx_state;  
            end
            else begin
                next_state  = Alu_frame1_tx_state;  
            end
            TX_D_VLD  = 1'b1;
        end  
        else begin
            next_state  = busy_state; 
            TX_D_VLD  = 1'b0; 
        end
    end
    Alu_frame2_tx_state: begin
        if (busy) begin
            next_state  = IDLE;  
            TX_D_VLD  = 1'b0;
        end  
        else begin
            next_state  = Alu_frame2_tx_state; 
            TX_D_VLD  = 1'b1; 
        end
    end    
    default: begin
        next_state   = IDLE;
        TX_D_VLD   = 1'b0;
    end
    endcase
end
endmodule