module Register_File # (parameter Width = 8 , Depth = 16 )
(                               
// Input and Output Ports 
input           [Width-1:0]         WrData,
input           [$clog2(Depth)-1:0] Address,
input                               CLK,
input                               RST,
input                               RdEn,
input                               WrEn,
output reg      [Width-1:0]         RdData,
output reg                          RdData_VLD,
output   wire   [Width-1:0]         REG0,
output   wire   [Width-1:0]         REG1,
output   wire   [Width-1:0]         REG2,
output   wire   [Width-1:0]         REG3
);
//////////////////////////////////////////

//Creating The Register File
reg [Width-1:0] Mem [Depth-1:0];
////////////////////////////////////////
integer i;
always @(posedge CLK or negedge RST) begin
    if (!RST) begin    //Asynchronous active low reset
        RdData<='b0;
        RdData_VLD<=1'b0;
        for ( i=0 ;i<Depth ;i=i+1 ) begin
            if(i==2) begin
                Mem[i] <= 'b001000_01 ;
            end
            else if (i==3) begin
                Mem[i] <= 'b0000_1000 ;
            end
            else begin
                Mem[i]<='b0; 
            end
        end
    end
    else begin
        if (WrEn&&!RdEn) begin
            Mem[Address]<=WrData;
        end
        else if (RdEn&&!WrEn) begin
            RdData<=Mem[Address];
            RdData_VLD<=1'b1;
        end
        else begin
            RdData_VLD<=1'b0;
        end
    end
end
assign REG0 = Mem[0] ;
assign REG1 = Mem[1] ;
assign REG2 = Mem[2] ;
assign REG3 = Mem[3] ;

endmodule