#Basado en https://github.com/Digilent/digilent-xdc/blob/master/Zybo-Master.xdc

#-- Creo el clock --
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 5.000 -name sys_clk_pin -waveform {0.000 2.500} -add [get_ports clk]

#-- Restricciones de los I/O --
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports rst]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports d]

set_property -dict { PACKAGE_PIN T20   IOSTANDARD LVCMOS33 } [get_ports { q[0] }];
set_property -dict { PACKAGE_PIN U20   IOSTANDARD LVCMOS33 } [get_ports { q[1] }];
set_property -dict { PACKAGE_PIN V20   IOSTANDARD LVCMOS33 } [get_ports { q[2] }];
set_property -dict { PACKAGE_PIN W20   IOSTANDARD LVCMOS33 } [get_ports { q[3] }];
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { q[4] }];
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { q[5] }];
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { q[6] }];
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { q[7] }];
