#Basado en https://github.com/Digilent/digilent-xdc/blob/master/Zybo-Master.xdc

#-- Creo el clock --
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports ena]
#create_clock -period 5.000 -name sys_clk_pin -waveform {0.000 2.500} -add [get_ports clk]

#-- Restricciones de los I/O --
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports d]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports q]