# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct D:\0FPGA_SOFTWARE\UART3\uart3\platform.tcl
# 
# OR launch xsct and run below command.
# source D:\0FPGA_SOFTWARE\UART3\uart3\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {uart3}\
-hw {D:\0FPGA\project_uart3\top.xsa}\
-proc {microblaze_0} -os {standalone} -fsbl-target {psu_cortexa53_0} -out {D:/0FPGA_SOFTWARE/UART3}

platform write
platform generate -domains 
platform active {uart3}
platform generate
bsp reload
