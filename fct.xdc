## =========================
## SWITCHES → xin[15:0]
## =========================
set_property PACKAGE_PIN V17 [get_ports {xin[0]}]
set_property PACKAGE_PIN V16 [get_ports {xin[1]}]
set_property PACKAGE_PIN W16 [get_ports {xin[2]}]
set_property PACKAGE_PIN W17 [get_ports {xin[3]}]
set_property PACKAGE_PIN W15 [get_ports {xin[4]}]
set_property PACKAGE_PIN V15 [get_ports {xin[5]}]
set_property PACKAGE_PIN W14 [get_ports {xin[6]}]
set_property PACKAGE_PIN W13 [get_ports {xin[7]}]
set_property PACKAGE_PIN V2  [get_ports {xin[8]}]
set_property PACKAGE_PIN T3  [get_ports {xin[9]}]
set_property PACKAGE_PIN T2  [get_ports {xin[10]}]
set_property PACKAGE_PIN R3  [get_ports {xin[11]}]
set_property PACKAGE_PIN W2  [get_ports {xin[12]}]
set_property PACKAGE_PIN U1  [get_ports {xin[13]}]
set_property PACKAGE_PIN T1  [get_ports {xin[14]}]
set_property PACKAGE_PIN R2  [get_ports {xin[15]}]

set_property IOSTANDARD LVCMOS33 [get_ports {xin[*]}]

## =========================
## LEDs → yout[15:0]
## =========================
set_property PACKAGE_PIN U16 [get_ports {yout[0]}]
set_property PACKAGE_PIN E19 [get_ports {yout[1]}]
set_property PACKAGE_PIN U19 [get_ports {yout[2]}]
set_property PACKAGE_PIN V19 [get_ports {yout[3]}]
set_property PACKAGE_PIN W18 [get_ports {yout[4]}]
set_property PACKAGE_PIN U15 [get_ports {yout[5]}]
set_property PACKAGE_PIN U14 [get_ports {yout[6]}]
set_property PACKAGE_PIN V14 [get_ports {yout[7]}]
set_property PACKAGE_PIN V13 [get_ports {yout[8]}]
set_property PACKAGE_PIN V3  [get_ports {yout[9]}]
set_property PACKAGE_PIN W3  [get_ports {yout[10]}]
set_property PACKAGE_PIN U3  [get_ports {yout[11]}]
set_property PACKAGE_PIN P3  [get_ports {yout[12]}]
set_property PACKAGE_PIN N3  [get_ports {yout[13]}]
set_property PACKAGE_PIN P1  [get_ports {yout[14]}]
set_property PACKAGE_PIN L1  [get_ports {yout[15]}]

set_property IOSTANDARD LVCMOS33 [get_ports {yout[*]}]


## =========================
## CLOCK (100 MHz)
## =========================
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk [get_ports clk]



## =========================
## BUTTONS (Control Signals)
## =========================

## Reset (Center Button) 
set_property PACKAGE_PIN U18 [get_ports rst] 
set_property IOSTANDARD LVCMOS33 [get_ports rst] 
## xin_valid (BTNU) 
set_property PACKAGE_PIN T17 [get_ports xin_valid] 
set_property IOSTANDARD LVCMOS33 [get_ports xin_valid]
 ## xin_ready (BTNR) 
 set_property PACKAGE_PIN T18 [get_ports xin_ready] 
 set_property IOSTANDARD LVCMOS33 [get_ports xin_ready]
  ## yout_valid (BTND)
   set_property PACKAGE_PIN U17 [get_ports yout_valid]
    set_property IOSTANDARD LVCMOS33 [get_ports yout_valid]
     ## yout_ready (BTNL)
      set_property PACKAGE_PIN W19 [get_ports yout_ready] 
      set_property IOSTANDARD LVCMOS33 [get_ports yout_ready] 


set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]