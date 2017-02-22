# Nexys4 Pin Asswitchnments
##########################################
# On-board Slide Switches/Button/Signal  #
##########################################
set_property PACKAGE_PIN E3 [get_ports clk_src]
set_property IOSTANDARD LVCMOS33 [get_ports clk_src]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[0]]
set_property PACKAGE_PIN U9 [get_ports choose[0]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[0]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[1]]
set_property PACKAGE_PIN U8 [get_ports choose[1]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[1]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[2]]
set_property PACKAGE_PIN R7 [get_ports choose[2]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[2]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[3]]
set_property PACKAGE_PIN R6 [get_ports choose[3]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[3]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[4444]]
set_property PACKAGE_PIN R5 [get_ports choose[4]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[4]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[5]]
set_property PACKAGE_PIN V7 [get_ports choose[5]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[5]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[6]]
set_property PACKAGE_PIN V6 [get_ports choose[6]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[6]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[7]]
set_property PACKAGE_PIN V5 [get_ports choose[7]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[7]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[8]]
set_property PACKAGE_PIN U4 [get_ports choose[8]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[8]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[9]]
set_property PACKAGE_PIN V2 [get_ports choose[9]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[9]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[10]]
set_property PACKAGE_PIN U2 [get_ports choose[10]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[10]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[11]]
set_property PACKAGE_PIN T3 [get_ports choose[11]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[11]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[12]]
set_property PACKAGE_PIN T1 [get_ports choose[12]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[12]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[13]]
set_property PACKAGE_PIN R3 [get_ports choose[13]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[13]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[14]]
set_property PACKAGE_PIN P3 [get_ports choose[14]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[14]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets choose[15]]
set_property PACKAGE_PIN P4 [get_ports choose[15]]
set_property IOSTANDARD LVCMOS33 [get_ports choose[15]]

############################
# Output                   #
############################

set_property PACKAGE_PIN N6 [get_ports anodes[0]]
set_property IOSTANDARD LVCMOS33 [get_ports anodes[0]]
set_property PACKAGE_PIN M6 [get_ports anodes[1]]
set_property IOSTANDARD LVCMOS33 [get_ports anodes[1]]
set_property PACKAGE_PIN M3 [get_ports anodes[2]]
set_property IOSTANDARD LVCMOS33 [get_ports anodes[2]]
set_property PACKAGE_PIN N5 [get_ports anodes[3]]
set_property IOSTANDARD LVCMOS33 [get_ports anodes[3]]
set_property PACKAGE_PIN N2 [get_ports anodes[4]]
set_property IOSTANDARD LVCMOS33 [get_ports anodes[4]]
set_property PACKAGE_PIN N4 [get_ports anodes[5]]
set_property IOSTANDARD LVCMOS33 [get_ports anodes[5]]
set_property PACKAGE_PIN L1 [get_ports anodes[6]]
set_property IOSTANDARD LVCMOS33 [get_ports anodes[6]]
set_property PACKAGE_PIN M1 [get_ports anodes[7]]
set_property IOSTANDARD LVCMOS33 [get_ports anodes[7]]

set_property PACKAGE_PIN L3 [get_ports cnodes[0]]
set_property IOSTANDARD LVCMOS33 [get_ports cnodes[0]]
set_property PACKAGE_PIN N1 [get_ports cnodes[1]]
set_property IOSTANDARD LVCMOS33 [get_ports cnodes[1]]
set_property PACKAGE_PIN L5 [get_ports cnodes[2]]
set_property IOSTANDARD LVCMOS33 [get_ports cnodes[2]]
set_property PACKAGE_PIN L4 [get_ports cnodes[3]]
set_property IOSTANDARD LVCMOS33 [get_ports cnodes[3]]
set_property PACKAGE_PIN K3 [get_ports cnodes[4]]
set_property IOSTANDARD LVCMOS33 [get_ports cnodes[4]]
set_property PACKAGE_PIN M2 [get_ports cnodes[5]]
set_property IOSTANDARD LVCMOS33 [get_ports cnodes[5]]
set_property PACKAGE_PIN L6 [get_ports cnodes[6]]
set_property IOSTANDARD LVCMOS33 [get_ports cnodes[6]]
set_property PACKAGE_PIN M4 [get_ports cnodes[7]]
set_property IOSTANDARD LVCMOS33 [get_ports cnodes[7]]

#set_property PACKAGE_PIN P2 [get_ports power_light]
#set_property IOSTANDARD LVCMOS33 [get_ports power_light]

