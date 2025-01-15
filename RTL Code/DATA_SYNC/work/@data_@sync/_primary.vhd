library verilog;
use verilog.vl_types.all;
entity Data_Sync is
    generic(
        Width           : integer := 8
    );
    port(
        P_Data_in       : in     vl_logic_vector;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        bus_enable      : in     vl_logic;
        Sync_Data       : out    vl_logic_vector;
        enable_pulse_d  : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Width : constant is 1;
end Data_Sync;
