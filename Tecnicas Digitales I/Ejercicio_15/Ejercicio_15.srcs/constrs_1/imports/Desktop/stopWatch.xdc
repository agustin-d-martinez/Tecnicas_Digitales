#Basado en https://github.com/Digilent/digilent-xdc/blob/master/Zybo-Master.xdc

#-- Creo el clock --
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

#-- Restricciones de los I/O --
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports rst]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports start]

set_property -dict { PACKAGE_PIN T20  IOSTANDARD LVCMOS33 } [get_ports { salida[0] }];
set_property -dict { PACKAGE_PIN U20  IOSTANDARD LVCMOS33 } [get_ports { salida[1] }];
set_property -dict { PACKAGE_PIN V20  IOSTANDARD LVCMOS33 } [get_ports { salida[2] }];
set_property -dict { PACKAGE_PIN W20  IOSTANDARD LVCMOS33 } [get_ports { salida[3] }];
set_property -dict { PACKAGE_PIN Y18  IOSTANDARD LVCMOS33 } [get_ports { stop }];
