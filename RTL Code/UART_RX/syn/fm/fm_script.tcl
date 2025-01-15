
set synopsys_auto_setup true
######################## Read Reference technology libs ######################## 
 
set SSLIB "/home/IC/Assignments/Ass_Syn_UART_RX/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/IC/Assignments/Ass_Syn_UART_RX/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/IC/Assignments/Ass_Syn_UART_RX/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

read_db -container Ref [list $SSLIB $TTLIB $FFLIB]

########################  Read Reference Design Files ######################## 
read_verilog -container Ref "/home/IC/Assignments/Ass_Syn_UART_RX/rtl/data_sampling.v"
read_verilog -container Ref "/home/IC/Assignments/Ass_Syn_UART_RX/rtl/deserializer.v"
read_verilog -container Ref "/home/IC/Assignments/Ass_Syn_UART_RX/rtl/edge_bit_counter.v"
read_verilog -container Ref "/home/IC/Assignments/Ass_Syn_UART_RX/rtl/FSM.v"
read_verilog -container Ref "/home/IC/Assignments/Ass_Syn_UART_RX/rtl/parity_check.v"
read_verilog -container Ref "/home/IC/Assignments/Ass_Syn_UART_RX/rtl/Stop_check.v"
read_verilog -container Ref "/home/IC/Assignments/Ass_Syn_UART_RX/rtl/strt_check.v"
read_verilog -container Ref "/home/IC/Assignments/Ass_Syn_UART_RX/rtl/UART_RX.v"

######################## set the top Reference Design ######################## 

set_reference_design UART_RX
set_top UART_RX

####################### Read Implementation tech libs ######################## 

read_db -container Imp [list $SSLIB $TTLIB $FFLIB]

#################### Read Implementation Design Files ######################## 

read_verilog -container Imp -netlist "/home/IC/Assignments/Ass_Syn_UART_RX/syn/UART_RX.v"

####################  set the top Implementation Design ######################

set_implementation_design UART_RX
set_top UART_RX

######################## matching Compare points #############################

match

################################### verify ################################### 

set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

############################### Reporting ####################################
report_passing_points > "passing_points.rpt"
report_failing_points > "failing_points.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"


start_gui
