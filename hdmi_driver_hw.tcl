# TCL File Generated by Component Editor 23.1
# Sat Jul 06 13:07:14 CEST 2024
# DO NOT MODIFY


# 
# hdmi_driver "hdmi_driver" v1.0
#  2024.07.06.13:07:14
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module hdmi_driver
# 
set_module_property DESCRIPTION ""
set_module_property NAME hdmi_driver
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME hdmi_driver
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL hdmi_display_sys
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file hdmi_display_sys.v VERILOG PATH hdmi/hdmi_display_sys.v TOP_LEVEL_FILE
add_fileset_file dpram.v VERILOG PATH hdmi/dpram.v
add_fileset_file framebuffer_dpram.v VERILOG PATH hdmi/framebuffer_dpram.v
add_fileset_file hdmi_tx.v VERILOG PATH hdmi/hdmi_tx.v


# 
# parameters
# 
add_parameter WIDTH INTEGER 8
set_parameter_property WIDTH DEFAULT_VALUE 8
set_parameter_property WIDTH DISPLAY_NAME WIDTH
set_parameter_property WIDTH TYPE INTEGER
set_parameter_property WIDTH UNITS None
set_parameter_property WIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property WIDTH HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point s0
# 
add_interface s0 avalon end
set_interface_property s0 addressUnits WORDS
set_interface_property s0 associatedClock clock
set_interface_property s0 associatedReset reset
set_interface_property s0 bitsPerSymbol 8
set_interface_property s0 burstOnBurstBoundariesOnly false
set_interface_property s0 burstcountUnits WORDS
set_interface_property s0 explicitAddressSpan 0
set_interface_property s0 holdTime 0
set_interface_property s0 linewrapBursts false
set_interface_property s0 maximumPendingReadTransactions 1
set_interface_property s0 maximumPendingWriteTransactions 0
set_interface_property s0 readLatency 0
set_interface_property s0 readWaitTime 1
set_interface_property s0 setupTime 0
set_interface_property s0 timingUnits Cycles
set_interface_property s0 writeWaitTime 0
set_interface_property s0 ENABLED true
set_interface_property s0 EXPORT_OF ""
set_interface_property s0 PORT_NAME_MAP ""
set_interface_property s0 CMSIS_SVD_VARIABLES ""
set_interface_property s0 SVD_ADDRESS_GROUP ""

add_interface_port s0 avs_s0_writedata writedata Input 32
add_interface_port s0 avs_s0_write write Input 1
add_interface_port s0 avs_s0_read read Input 1
add_interface_port s0 avs_s0_readdata readdata Output 32
add_interface_port s0 avs_s0_readdatavalid readdatavalid Output 1
add_interface_port s0 avs_s0_waitrequest waitrequest Output 1
set_interface_assignment s0 embeddedsw.configuration.isFlash 0
set_interface_assignment s0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset rst reset Input 1


# 
# connection point conduit_hdmi_clk
# 
add_interface conduit_hdmi_clk conduit end
set_interface_property conduit_hdmi_clk associatedClock ""
set_interface_property conduit_hdmi_clk associatedReset ""
set_interface_property conduit_hdmi_clk ENABLED true
set_interface_property conduit_hdmi_clk EXPORT_OF ""
set_interface_property conduit_hdmi_clk PORT_NAME_MAP ""
set_interface_property conduit_hdmi_clk CMSIS_SVD_VARIABLES ""
set_interface_property conduit_hdmi_clk SVD_ADDRESS_GROUP ""

add_interface_port conduit_hdmi_clk clk_hdmi clk Input 1


# 
# connection point conduit_rst
# 
add_interface conduit_rst conduit end
set_interface_property conduit_rst associatedClock clock
set_interface_property conduit_rst associatedReset ""
set_interface_property conduit_rst ENABLED true
set_interface_property conduit_rst EXPORT_OF ""
set_interface_property conduit_rst PORT_NAME_MAP ""
set_interface_property conduit_rst CMSIS_SVD_VARIABLES ""
set_interface_property conduit_rst SVD_ADDRESS_GROUP ""

add_interface_port conduit_rst reset_hdmi rst Input 1


# 
# connection point conduit_out
# 
add_interface conduit_out conduit end
set_interface_property conduit_out associatedClock ""
set_interface_property conduit_out associatedReset ""
set_interface_property conduit_out ENABLED true
set_interface_property conduit_out EXPORT_OF ""
set_interface_property conduit_out PORT_NAME_MAP ""
set_interface_property conduit_out CMSIS_SVD_VARIABLES ""
set_interface_property conduit_out SVD_ADDRESS_GROUP ""

add_interface_port conduit_out hdmi_tx_out hdmi_out Output 27

