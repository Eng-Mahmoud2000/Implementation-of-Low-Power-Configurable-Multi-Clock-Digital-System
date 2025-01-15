module SYS_RX_FSM # ( parameter Width = 8 , Depth = 16)
(
//Input and Output Ports 
input           [Width-1:0]            RX_P_Data,
input                                  RX_D_VLD,
input                                  CLK,
input                                  RST,
output reg                             WrEn,
output reg                             RdEn,
output reg      [$clog2(Depth)-1:0]    Addr,
output reg      [Width-1:0]            Wr_D,
output reg      [3:0]                  ALU_FUN,
output reg                             ALU_EN,
output reg                             CLK_EN
);
///////////////////////////////////////////////////////

// define the states
localparam IDLE                        = 4'b0000 ;  
localparam Decode_state                = 4'b0001 ;  
localparam RF_Wr_Addr_state            = 4'b0010 ;
localparam RF_Wr_Data_state            = 4'b0011 ;
localparam RF_Rd_state                 = 4'b0100 ;
localparam ALU_OPER_W_OP_Data_A_state  = 4'b0101 ;
localparam ALU_OPER_W_OP_Data_B_state  = 4'b0110 ;
localparam ALU_OPER_ALUFUN_state       = 4'b0111 ;
localparam ALU_OPER_ALUFUN_Wait_state  = 4'b1000 ;
///////////////////////////////////////////////////////

//Internal Cnnections
reg     [3:0]                       current_state,next_state;
reg     [Width-1:0]                 Wr_D_c;
reg     [$clog2(Depth)-1:0]         Addr_c;     
reg     [3:0]                       ALU_FUN_c;     
reg                                 Trans_flag;           

//////////////////////////////////////////////////////
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        current_state <= IDLE;
        Addr          <= 'b0;
    end
    else begin
        current_state <= next_state;
        if (current_state == IDLE) begin
            Addr          <= 'b0;
        end
        if (current_state == RF_Wr_Addr_state || current_state == RF_Rd_state || current_state == ALU_OPER_W_OP_Data_A_state || current_state == ALU_OPER_W_OP_Data_B_state) begin
            Addr          <= Addr_c; 
        end 
        if (current_state == RF_Wr_Data_state || current_state == ALU_OPER_W_OP_Data_A_state || current_state == ALU_OPER_W_OP_Data_B_state ) begin
            Wr_D          <= Wr_D_c;
        end
        if (current_state == ALU_OPER_ALUFUN_state) begin
            ALU_FUN       <= ALU_FUN_c;
        end
end
end
/////////////////////////////////

always @(*) begin
    case(current_state)
    IDLE: begin
        WrEn      = 1'b0;
        RdEn      = 1'b0;
        ALU_EN    = 1'b0;
        CLK_EN    = 1'b0;
        Trans_flag   = 1'b0;
        Addr_c    = 'b0;
        Wr_D_c    = 'b0;
        ALU_FUN_c = 4'b0;
        if(RX_D_VLD)begin
            next_state = Decode_state;
        end
        else begin
            next_state = IDLE;
        end
    end
    Decode_state: begin
        WrEn       = 1'b0;
        RdEn       = 1'b0;
        ALU_EN     = 1'b0;
        CLK_EN     = 1'b0;
        Trans_flag = 1'b0;
        Addr_c     = 'b0;
        Wr_D_c     = 'b0;
        ALU_FUN_c  = 4'b0;
        case (RX_P_Data)
            8'b10101010:begin
                next_state = RF_Wr_Addr_state;
            end
            8'b10111011:begin
                next_state = RF_Rd_state;
            end
            8'b11001100:begin
                next_state = ALU_OPER_W_OP_Data_A_state;
            end
            8'b11011101:begin
                next_state = ALU_OPER_ALUFUN_state;
            end
            default:begin
                next_state = IDLE;
            end 
        endcase
        end
    RF_Wr_Addr_state: begin
        WrEn       = 1'b0;
        RdEn       = 1'b0;
        ALU_EN     = 1'b0;
        CLK_EN     = 1'b0;
        Trans_flag = 1'b0;
        Wr_D_c     = 'b0;
        ALU_FUN_c  = 4'b0;
        if (RX_D_VLD) begin
            Addr_c     = RX_P_Data;
            next_state = RF_Wr_Data_state; 
        end
        else begin
            next_state = RF_Wr_Addr_state; 
            Addr_c     = 'b0;
        end
    end
    RF_Wr_Data_state: begin
        RdEn         = 1'b0;
        ALU_EN       = 1'b0;
        CLK_EN       = 1'b0;
        Addr_c       = 'b0;
        ALU_FUN_c    = 4'b0;
        if (RX_D_VLD) begin
            Wr_D_c        = RX_P_Data;
            WrEn          = 1'b1;
            Trans_flag    = 1'b1 ;
            next_state    = RF_Wr_Data_state;
        end
        else if (Trans_flag) begin
            Wr_D_c        = 'b0;
            WrEn          = 1'b1;
            Trans_flag    = 1'b0;
            next_state    = IDLE; 
        end
        else begin
            Wr_D_c     = 'b0;
            WrEn       = 1'b0;
            Trans_flag = 1'b0;
            next_state = RF_Wr_Data_state; 
        end
    end
    RF_Rd_state: begin
        WrEn         = 1'b0;
        ALU_EN       = 1'b0;
        CLK_EN       = 1'b0;
        Wr_D_c       = 'b0;
        ALU_FUN_c    = 4'b0;
        if (RX_D_VLD) begin
            Addr_c     = RX_P_Data;
            RdEn       = 1'b1;
            Trans_flag = 1'b1 ;
            next_state = RF_Rd_state;
        end
        else if (Trans_flag) begin
            Addr_c     = 'b0;
            RdEn       = 1'b1;
            Trans_flag = 1'b0;
            next_state = IDLE; 
        end
        else begin
            Addr_c     = 'b0 ;
            RdEn       = 1'b0;
            Trans_flag = 1'b0;
            next_state = RF_Rd_state;
        end
    end
    ALU_OPER_W_OP_Data_A_state: begin
        RdEn       = 1'b0;
        ALU_EN     = 1'b0;
        CLK_EN     = 1'b0;
        ALU_FUN_c  = 4'b0;
        if (RX_D_VLD) begin
            Wr_D_c     = RX_P_Data;
            Addr_c     = 'b0;
            WrEn       = 1'b1;
            Trans_flag = 1'b1 ;
            next_state = ALU_OPER_W_OP_Data_A_state; 
        end
        else if (Trans_flag) begin
            Wr_D_c     = 'b0;
            Addr_c     = 'b0;
            WrEn       = 1'b1;
            Trans_flag = 1'b0;
            next_state = ALU_OPER_W_OP_Data_B_state; 
        end
        else begin
            Wr_D_c     = 'b0;
            Addr_c     = 'b0;
            WrEn       = 1'b0;
            Trans_flag = 1'b0;
            next_state = ALU_OPER_W_OP_Data_A_state; 
        end
    end
    ALU_OPER_W_OP_Data_B_state: begin
        RdEn       = 1'b0;
        ALU_EN     = 1'b0;
        CLK_EN     = 1'b0;
        Addr_c     = 'b01;
        ALU_FUN_c  = 4'b0;
        if (RX_D_VLD) begin
            Wr_D_c     = RX_P_Data;
            WrEn       = 1'b1;
            Trans_flag = 1'b1 ;
            next_state = ALU_OPER_W_OP_Data_B_state; 
        end
        else if (Trans_flag) begin
            Wr_D_c     = 'b0;
            WrEn       = 1'b1;
            Trans_flag = 1'b0;
            next_state = ALU_OPER_ALUFUN_state; 
        end
        else begin
            Wr_D_c     = 'b0;
            WrEn       = 1'b0;
            Trans_flag = 1'b0;
            next_state = ALU_OPER_W_OP_Data_B_state; 
        end
    end
    ALU_OPER_ALUFUN_state: begin
        WrEn    = 1'b0;
        RdEn    = 1'b0;
        Addr_c  = 'b0;
        Wr_D_c  = 'b0;
        if (RX_D_VLD) begin
            ALU_FUN_c    = RX_P_Data;
            ALU_EN       = 1'b1;
            CLK_EN       = 1'b1;
            Trans_flag   = 1'b1;
            next_state   = ALU_OPER_ALUFUN_state;
        end
        else if (Trans_flag) begin
            ALU_FUN_c    = 4'b0;
            ALU_EN       = 1'b1;
            CLK_EN       = 1'b1;
            Trans_flag   = 1'b0;
            next_state   = ALU_OPER_ALUFUN_Wait_state; 
        end
        else begin
            ALU_EN       = 1'b0;
            CLK_EN       = 1'b0;
            Trans_flag   = 1'b0;
            Addr_c       = 'b0;
            Wr_D_c       = 'b0;
            ALU_FUN_c    = 4'b0;
            next_state   = ALU_OPER_ALUFUN_state;
        end 
    end
    ALU_OPER_ALUFUN_Wait_state: begin
        next_state = IDLE;
        WrEn       = 1'b0;
        RdEn       = 1'b0;
        ALU_EN     = 1'b0;
        CLK_EN     = 1'b1;
        Trans_flag = 1'b0;
        Addr_c     = 'b0;
        Wr_D_c     = 'b0;
        ALU_FUN_c  = 4'b0;
    end
    default: begin
        next_state = IDLE;
        WrEn       = 1'b0;
        RdEn       = 1'b0;
        ALU_EN     = 1'b0;
        CLK_EN     = 1'b0;
        Trans_flag = 1'b0;
        Addr_c     = 'b0;
        Wr_D_c     = 'b0;
        ALU_FUN_c  = 4'b0;
    end
    endcase
end
endmodule