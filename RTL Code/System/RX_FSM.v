module RX_FSM (
//Input and Output Ports 
input                       RX_IN,PAR_EN,
input                       par_err,strt_glitch,stp_err,
input           [3:0]       bit_cnt,
input           [3:0]       edge_cnt,
input                       Clk,
input                       RST,
output reg                  enable,
output reg                  par_chk_en,
output reg                  strt_chk_en,
output reg                  stp_chk_en,
output reg                  dat_samp_en,
output reg                  deser_en,
output reg                  reset_cnt,
output reg                  data_valid
);
///////////////////////////////////////////////////////

// define the states
localparam IDLE = 3'b000 ;  
localparam start_state = 3'b001 ;  
localparam data_state = 3'b010 ;
localparam parity_state = 3'b011 ;
localparam stop_state = 3'b100 ;
localparam valid_state = 3'b101 ;
///////////////////////////////////////////////////////

//Internal Cnnections
reg     [2:0]   current_state,next_state;


//////////////////////////////////////////////////////
always @(posedge Clk or negedge RST) begin
    if (!RST) begin
        current_state<=IDLE;
    end
    else begin
        current_state<=next_state;
    end
end
/////////////////////////////////

always @(*) begin
    case(current_state)
    IDLE: begin
        enable=1'b1;
        par_chk_en=1'b0;
        strt_chk_en=1'b0;
        stp_chk_en=1'b0;
        dat_samp_en=1'b0;
        deser_en=1'b0;
        reset_cnt=1'b1;
        data_valid=1'b0;
        if(!RX_IN)begin
            enable=1'b1;
            dat_samp_en=1'b1;
            next_state=start_state;
        end
        else begin
            next_state=IDLE;
        end
    end

    start_state: begin
        enable=1'b1;
        par_chk_en=1'b0;
        strt_chk_en=1'b1;
        stp_chk_en=1'b0;
        dat_samp_en=1'b1;
        deser_en=1'b0;
        reset_cnt=1'b0;
        data_valid=1'b0;
        if (bit_cnt == 4'd0 && edge_cnt == 4'd7) begin
            if (strt_glitch) begin
                next_state=IDLE;
            end
            else begin
                next_state=data_state;
            end
        end
        else begin
                next_state=start_state;
        end
    end

    data_state: begin
        enable=1'b1;
        par_chk_en=1'b0;
        strt_chk_en=1'b0;
        stp_chk_en=1'b0;
        deser_en=1'b1;
        dat_samp_en=1'b1;
        reset_cnt=1'b0;
        data_valid=1'b0;
        if (bit_cnt == 4'd8 && edge_cnt == 4'd7) begin
            if (PAR_EN) begin
                    next_state=parity_state;
                end
                else begin
                    next_state=stop_state;
                end 
        end
        else begin
            next_state=data_state; 
        end
    end
    parity_state: begin
        enable=1'b1;
        par_chk_en=1'b1;
        strt_chk_en=1'b0;
        stp_chk_en=1'b0;
        dat_samp_en=1'b1;
        deser_en=1'b0;
        reset_cnt=1'b0;
        data_valid=1'b0;
        if (bit_cnt == 4'd9 && edge_cnt == 4'd7) begin
            if (par_err) begin
                next_state=IDLE;
            end
            else begin
                next_state=stop_state;
            end
        end
        else begin
            next_state=parity_state;
        end
    end

    stop_state: begin
        enable=1'b1;
        par_chk_en=1'b0;
        strt_chk_en=1'b0;
        stp_chk_en=1'b1;
        dat_samp_en=1'b1;
        deser_en=1'b0;
        reset_cnt=1'b0;
        data_valid=1'b0;
        if (PAR_EN) begin
            if (bit_cnt == 4'd10 && edge_cnt == 4'd6) begin
                next_state=valid_state;
            end
            else begin
                next_state=stop_state;
            end
        end
        else begin
            if (bit_cnt == 4'd9 && edge_cnt == 4'd6) begin
                next_state=valid_state;
            end
            else begin
                next_state=stop_state;
            end    
        end
    end
    valid_state: begin
        enable=1'b1;
        par_chk_en=1'b0;
        strt_chk_en=1'b0;
        stp_chk_en=1'b0;
        dat_samp_en=1'b0;
        deser_en=1'b0;
        reset_cnt=1'b0; 
        if (PAR_EN) begin
            if (!(par_err|stp_err)) begin
                data_valid=1'b1;
            end
            else begin
                data_valid=1'b0;
            end
        end
        else begin
            if (!stp_err) begin
                data_valid=1'b1;
            end
            else begin
                data_valid=1'b0;
            end
        end 
        if(!RX_IN) begin
		    next_state = start_state ;
            reset_cnt=1'b1;  
        end
		else begin
		    next_state = IDLE ; 	
        end
    end
    default: begin
        next_state=IDLE;
        enable=1'b0;
        par_chk_en=1'b0;
        strt_chk_en=1'b0;
        stp_chk_en=1'b0;
        dat_samp_en=1'b0;
        deser_en=1'b0;
        reset_cnt=1'b0;
        data_valid=1'b0;
    end
    endcase
end
endmodule