#Basado en https://github.com/Digilent/digilent-xdc/blob/master/Zybo-Master.xdc

#-- Creo el clock --
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 5.000 -name sys_clk_pin -waveform {0.000 2.500} -add [get_ports clk]

#-- Restricciones de los I/O --
set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L19N_T3_VREF_35 Sch=SW0
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { start }];  #IO_L24P_T3_34 Sch=SW1
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { stop }]; #IO_L4N_T0_34 Sch=SW2

#set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { sw[3] }]; #IO_L9P_T1_DQS_34 Sch=SW3



set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { segundos[0] }]; #IO_L21P_T3_DQS_AD14P_35 Sch=JA1_R_p
set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { segundos[1] }]; #IO_L22P_T3_AD7P_35 Sch=JA2_R_P
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { segundos[2] }]; #IO_L24P_T3_AD15P_35 Sch=JA3_R_P
set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS33 } [get_ports { segundos[3] }]; #IO_L20P_T3_AD6P_35 Sch=JA4_R_P
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { segundos[4] }]; #IO_L21N_T3_DQS_AD14N_35 Sch=JA1_R_N
set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { segundos[5] }]; #IO_L22N_T3_AD7N_35 Sch=JA2_R_N
#set_property -dict { PACKAGE_PIN J16   IOSTANDARD LVCMOS33 } [get_ports { ja_n[2] }]; #IO_L24N_T3_AD15N_35 Sch=JA3_R_N
#set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { ja_n[3] }]; #IO_L20N_T3_AD6N_35 Sch=JA4_R_N



set_property -dict { PACKAGE_PIN T20   IOSTANDARD LVCMOS33 } [get_ports { minutos[0] }]; #IO_L15P_T2_DQS_34 Sch=JB1_p
set_property -dict { PACKAGE_PIN U20   IOSTANDARD LVCMOS33 } [get_ports { minutos[1] }]; #IO_L15N_T2_DQS_34 Sch=JB1_N
set_property -dict { PACKAGE_PIN V20   IOSTANDARD LVCMOS33 } [get_ports { minutos[2] }]; #IO_L16P_T2_34 Sch=JB2_P
set_property -dict { PACKAGE_PIN W20   IOSTANDARD LVCMOS33 } [get_ports { minutos[3] }]; #IO_L16N_T2_34 Sch=JB2_N
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { minutos[4] }]; #IO_L17P_T2_34 Sch=JB3_P
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { minutos[5] }]; #IO_L17N_T2_34 Sch=JB3_N
#set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { jb_p[3] }]; #IO_L22P_T3_34 Sch=JB4_P
#set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { jb_n[3] }]; #IO_L22N_T3_34 Sch=JB4_N


