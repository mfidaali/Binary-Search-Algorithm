## Generated SDC file "binarySearchAlgo.sdc"

## Copyright (C) 2018  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

## DATE    "Tue Dec 04 15:58:51 2018"

##
## DEVICE  "5CGXFC7C7F23C8"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}] -hold 0.060  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay -max -clock [get_clocks {clk}]  3.000 [get_ports {SW[0]}]
set_input_delay -add_delay -min -clock [get_clocks {clk}]  2.000 [get_ports {SW[0]}]
set_input_delay -add_delay -max -clock [get_clocks {clk}]  3.000 [get_ports {SW[1]}]
set_input_delay -add_delay -min -clock [get_clocks {clk}]  2.000 [get_ports {SW[1]}]
set_input_delay -add_delay -max -clock [get_clocks {clk}]  3.000 [get_ports {SW[2]}]
set_input_delay -add_delay -min -clock [get_clocks {clk}]  2.000 [get_ports {SW[2]}]
set_input_delay -add_delay -max -clock [get_clocks {clk}]  3.000 [get_ports {SW[3]}]
set_input_delay -add_delay -min -clock [get_clocks {clk}]  2.000 [get_ports {SW[3]}]
set_input_delay -add_delay -max -clock [get_clocks {clk}]  3.000 [get_ports {SW[4]}]
set_input_delay -add_delay -min -clock [get_clocks {clk}]  2.000 [get_ports {SW[4]}]
set_input_delay -add_delay -max -clock [get_clocks {clk}]  3.000 [get_ports {SW[5]}]
set_input_delay -add_delay -min -clock [get_clocks {clk}]  2.000 [get_ports {SW[5]}]
set_input_delay -add_delay -max -clock [get_clocks {clk}]  3.000 [get_ports {SW[6]}]
set_input_delay -add_delay -min -clock [get_clocks {clk}]  2.000 [get_ports {SW[6]}]
set_input_delay -add_delay -max -clock [get_clocks {clk}]  3.000 [get_ports {SW[7]}]
set_input_delay -add_delay -min -clock [get_clocks {clk}]  2.000 [get_ports {SW[7]}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.000 [get_ports {L[0]}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {L[0]}]
set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.000 [get_ports {L[1]}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {L[1]}]
set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.000 [get_ports {L[2]}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {L[2]}]
set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.000 [get_ports {L[3]}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {L[3]}]
set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.000 [get_ports {L[4]}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {L[4]}]
set_output_delay -add_delay -max -clock [get_clocks {clk}]  2.000 [get_ports {found}]
set_output_delay -add_delay -min -clock [get_clocks {clk}]  1.000 [get_ports {found}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

