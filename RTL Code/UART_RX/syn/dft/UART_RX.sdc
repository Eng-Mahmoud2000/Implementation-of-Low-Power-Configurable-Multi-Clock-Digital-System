###################################################################

# Created by write_sdc on Tue Dec 13 05:46:44 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -max_library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -min scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c -min_library scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c
set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports RX_IN]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {Prescale[4]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {Prescale[3]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {Prescale[2]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {Prescale[1]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {Prescale[0]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports PAR_EN]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports PAR_TYP]
set_load -pin_load 2 [get_ports data_valid]
set_load -pin_load 2 [get_ports {P_DATA[7]}]
set_load -pin_load 2 [get_ports {P_DATA[6]}]
set_load -pin_load 2 [get_ports {P_DATA[5]}]
set_load -pin_load 2 [get_ports {P_DATA[4]}]
set_load -pin_load 2 [get_ports {P_DATA[3]}]
set_load -pin_load 2 [get_ports {P_DATA[2]}]
set_load -pin_load 2 [get_ports {P_DATA[1]}]
set_load -pin_load 2 [get_ports {P_DATA[0]}]
create_clock [get_ports CLK]  -period 100  -waveform {0 50}
set_clock_latency 0  [get_clocks CLK]
set_clock_uncertainty -setup 0.25  [get_clocks CLK]
set_clock_uncertainty -hold 0.05  [get_clocks CLK]
set_clock_transition -min -fall 0.1 [get_clocks CLK]
set_clock_transition -max -fall 0.1 [get_clocks CLK]
set_clock_transition -min -rise 0.1 [get_clocks CLK]
set_clock_transition -max -rise 0.1 [get_clocks CLK]
set_input_delay -clock CLK  20  [get_ports RX_IN]
set_input_delay -clock CLK  20  [get_ports {Prescale[4]}]
set_input_delay -clock CLK  20  [get_ports {Prescale[3]}]
set_input_delay -clock CLK  20  [get_ports {Prescale[2]}]
set_input_delay -clock CLK  20  [get_ports {Prescale[1]}]
set_input_delay -clock CLK  20  [get_ports {Prescale[0]}]
set_input_delay -clock CLK  20  [get_ports PAR_EN]
set_input_delay -clock CLK  20  [get_ports PAR_TYP]
set_output_delay -clock CLK  20  [get_ports data_valid]
set_output_delay -clock CLK  20  [get_ports {P_DATA[7]}]
set_output_delay -clock CLK  20  [get_ports {P_DATA[6]}]
set_output_delay -clock CLK  20  [get_ports {P_DATA[5]}]
set_output_delay -clock CLK  20  [get_ports {P_DATA[4]}]
set_output_delay -clock CLK  20  [get_ports {P_DATA[3]}]
set_output_delay -clock CLK  20  [get_ports {P_DATA[2]}]
set_output_delay -clock CLK  20  [get_ports {P_DATA[1]}]
set_output_delay -clock CLK  20  [get_ports {P_DATA[0]}]
