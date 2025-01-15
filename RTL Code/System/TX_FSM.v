module TX_FSM (
//Input and Output Ports 
input                       Data_Valid,ser_done,PAR_EN,
input                       Clk,
input                       RST,
output reg      [1:0]       mux_sel,
output reg                  ser_en,busy
);
///////////////////////////////////////////////////////

// define the states
localparam IDLE = 3'b000 ;  
localparam start_state = 3'b001 ;  
localparam data_state = 3'b010 ;
localparam parity_state = 3'b011 ;
localparam stop_state = 3'b100 ;
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
        busy=1'b0;
        ser_en=1'b0;
        mux_sel=2'b01;
        if(Data_Valid)begin
            next_state=start_state;
        end
        else begin
            next_state=IDLE;
        end
    end

    start_state: begin
        busy=1'b1;
        ser_en=1'b1;
        mux_sel=2'b00;
        next_state=data_state;
    end

    data_state: begin
        busy=1'b1;
        mux_sel=2'b10;
        if(ser_done)begin
            ser_en=1'b0;
            if (PAR_EN) begin
                next_state=parity_state;  // with parity bit
            end
            else begin
                next_state=stop_state;    //without parity bit
            end
        end
        else begin
            ser_en=1'b1;
            next_state=data_state;
        end
    end

    parity_state: begin
        busy=1'b1;
        ser_en=1'b0;
        mux_sel=2'b11;
        next_state=stop_state;
    end

    stop_state: begin
        busy=1'b1;
        ser_en=1'b0;
        mux_sel=2'b01;
        next_state=IDLE;
    end  
       
    default: begin
        next_state=IDLE;
        busy=1'b0;
        ser_en=1'b0;
        mux_sel=2'b01;
    end
    endcase
end
endmodule