library verilog;
use verilog.vl_types.all;
entity UART_TOP is
    generic(
        DATA_WIDTH      : integer := 8;
        PRESCALE_WIDTH  : integer := 5
    );
    port(
        RX_IN_S         : in     vl_logic;
        TX_IN_P         : in     vl_logic_vector;
        TX_IN_V         : in     vl_logic;
        PAR_EN          : in     vl_logic;
        Prescale        : in     vl_logic_vector;
        PAR_TYP         : in     vl_logic;
        TX_CLK          : in     vl_logic;
        RX_CLK          : in     vl_logic;
        RST             : in     vl_logic;
        TX_OUT_S        : out    vl_logic;
        TX_OUT_V        : out    vl_logic;
        RX_OUT_V        : out    vl_logic;
        RX_OUT_P        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of PRESCALE_WIDTH : constant is 1;
end UART_TOP;
