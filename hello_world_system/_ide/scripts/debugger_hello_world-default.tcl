# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: D:\0FPGA_SOFTWARE\UART3\hello_world_system\_ide\scripts\debugger_hello_world-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source D:\0FPGA_SOFTWARE\UART3\hello_world_system\_ide\scripts\debugger_hello_world-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -filter {jtag_cable_name =~ "Digilent JTAG-SMT1 210203A7E8EDA" && level==0 && jtag_device_ctx=="jsn-JTAG-SMT1-210203A7E8EDA-33687093-0"}
fpga -file D:/0FPGA_SOFTWARE/UART3/hello_world/_ide/bitstream/top.bit
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
loadhw -hw D:/0FPGA_SOFTWARE/UART3/uart3/export/uart3/hw/top.xsa -regs
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
rst -system
after 3000
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
dow D:/0FPGA_SOFTWARE/UART3/hello_world/Debug/hello_world.elf
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
con
