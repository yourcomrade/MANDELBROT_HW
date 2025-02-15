// mandebrot_plot_mm_interconnect_0.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 23.1 991

`timescale 1 ps / 1 ps
module mandebrot_plot_mm_interconnect_0 (
		input  wire        pll_0_outclk0_clk,                             //                           pll_0_outclk0.clk
		input  wire        mm_bridge_0_reset_reset_bridge_in_reset_reset, // mm_bridge_0_reset_reset_bridge_in_reset.reset
		input  wire [9:0]  mm_bridge_0_m0_address,                        //                          mm_bridge_0_m0.address
		output wire        mm_bridge_0_m0_waitrequest,                    //                                        .waitrequest
		input  wire [0:0]  mm_bridge_0_m0_burstcount,                     //                                        .burstcount
		input  wire [3:0]  mm_bridge_0_m0_byteenable,                     //                                        .byteenable
		input  wire        mm_bridge_0_m0_read,                           //                                        .read
		output wire [31:0] mm_bridge_0_m0_readdata,                       //                                        .readdata
		output wire        mm_bridge_0_m0_readdatavalid,                  //                                        .readdatavalid
		input  wire        mm_bridge_0_m0_write,                          //                                        .write
		input  wire [31:0] mm_bridge_0_m0_writedata,                      //                                        .writedata
		input  wire        mm_bridge_0_m0_debugaccess,                    //                                        .debugaccess
		output wire        hdmi_driver_0_s0_write,                        //                        hdmi_driver_0_s0.write
		output wire        hdmi_driver_0_s0_read,                         //                                        .read
		input  wire [31:0] hdmi_driver_0_s0_readdata,                     //                                        .readdata
		output wire [31:0] hdmi_driver_0_s0_writedata,                    //                                        .writedata
		input  wire        hdmi_driver_0_s0_readdatavalid,                //                                        .readdatavalid
		input  wire        hdmi_driver_0_s0_waitrequest                   //                                        .waitrequest
	);

	wire         mm_bridge_0_m0_translator_avalon_universal_master_0_waitrequest;   // hdmi_driver_0_s0_translator:uav_waitrequest -> mm_bridge_0_m0_translator:uav_waitrequest
	wire  [31:0] mm_bridge_0_m0_translator_avalon_universal_master_0_readdata;      // hdmi_driver_0_s0_translator:uav_readdata -> mm_bridge_0_m0_translator:uav_readdata
	wire         mm_bridge_0_m0_translator_avalon_universal_master_0_debugaccess;   // mm_bridge_0_m0_translator:uav_debugaccess -> hdmi_driver_0_s0_translator:uav_debugaccess
	wire   [9:0] mm_bridge_0_m0_translator_avalon_universal_master_0_address;       // mm_bridge_0_m0_translator:uav_address -> hdmi_driver_0_s0_translator:uav_address
	wire         mm_bridge_0_m0_translator_avalon_universal_master_0_read;          // mm_bridge_0_m0_translator:uav_read -> hdmi_driver_0_s0_translator:uav_read
	wire   [3:0] mm_bridge_0_m0_translator_avalon_universal_master_0_byteenable;    // mm_bridge_0_m0_translator:uav_byteenable -> hdmi_driver_0_s0_translator:uav_byteenable
	wire         mm_bridge_0_m0_translator_avalon_universal_master_0_readdatavalid; // hdmi_driver_0_s0_translator:uav_readdatavalid -> mm_bridge_0_m0_translator:uav_readdatavalid
	wire         mm_bridge_0_m0_translator_avalon_universal_master_0_lock;          // mm_bridge_0_m0_translator:uav_lock -> hdmi_driver_0_s0_translator:uav_lock
	wire         mm_bridge_0_m0_translator_avalon_universal_master_0_write;         // mm_bridge_0_m0_translator:uav_write -> hdmi_driver_0_s0_translator:uav_write
	wire  [31:0] mm_bridge_0_m0_translator_avalon_universal_master_0_writedata;     // mm_bridge_0_m0_translator:uav_writedata -> hdmi_driver_0_s0_translator:uav_writedata
	wire   [2:0] mm_bridge_0_m0_translator_avalon_universal_master_0_burstcount;    // mm_bridge_0_m0_translator:uav_burstcount -> hdmi_driver_0_s0_translator:uav_burstcount

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (10),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (10),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (1),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) mm_bridge_0_m0_translator (
		.clk                    (pll_0_outclk0_clk),                                                 //                       clk.clk
		.reset                  (mm_bridge_0_reset_reset_bridge_in_reset_reset),                     //                     reset.reset
		.uav_address            (mm_bridge_0_m0_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount         (mm_bridge_0_m0_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read               (mm_bridge_0_m0_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write              (mm_bridge_0_m0_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest        (mm_bridge_0_m0_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid      (mm_bridge_0_m0_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable         (mm_bridge_0_m0_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata           (mm_bridge_0_m0_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata          (mm_bridge_0_m0_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock               (mm_bridge_0_m0_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess        (mm_bridge_0_m0_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address             (mm_bridge_0_m0_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest         (mm_bridge_0_m0_waitrequest),                                        //                          .waitrequest
		.av_burstcount          (mm_bridge_0_m0_burstcount),                                         //                          .burstcount
		.av_byteenable          (mm_bridge_0_m0_byteenable),                                         //                          .byteenable
		.av_read                (mm_bridge_0_m0_read),                                               //                          .read
		.av_readdata            (mm_bridge_0_m0_readdata),                                           //                          .readdata
		.av_readdatavalid       (mm_bridge_0_m0_readdatavalid),                                      //                          .readdatavalid
		.av_write               (mm_bridge_0_m0_write),                                              //                          .write
		.av_writedata           (mm_bridge_0_m0_writedata),                                          //                          .writedata
		.av_debugaccess         (mm_bridge_0_m0_debugaccess),                                        //                          .debugaccess
		.av_beginbursttransfer  (1'b0),                                                              //               (terminated)
		.av_begintransfer       (1'b0),                                                              //               (terminated)
		.av_chipselect          (1'b0),                                                              //               (terminated)
		.av_lock                (1'b0),                                                              //               (terminated)
		.uav_clken              (),                                                                  //               (terminated)
		.av_clken               (1'b1),                                                              //               (terminated)
		.uav_response           (2'b00),                                                             //               (terminated)
		.av_response            (),                                                                  //               (terminated)
		.uav_writeresponsevalid (1'b0),                                                              //               (terminated)
		.av_writeresponsevalid  ()                                                                   //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (1),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (10),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (1),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) hdmi_driver_0_s0_translator (
		.clk                    (pll_0_outclk0_clk),                                                 //                      clk.clk
		.reset                  (mm_bridge_0_reset_reset_bridge_in_reset_reset),                     //                    reset.reset
		.uav_address            (mm_bridge_0_m0_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount         (mm_bridge_0_m0_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read               (mm_bridge_0_m0_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write              (mm_bridge_0_m0_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest        (mm_bridge_0_m0_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid      (mm_bridge_0_m0_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable         (mm_bridge_0_m0_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata           (mm_bridge_0_m0_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata          (mm_bridge_0_m0_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock               (mm_bridge_0_m0_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess        (mm_bridge_0_m0_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_write               (hdmi_driver_0_s0_write),                                            //      avalon_anti_slave_0.write
		.av_read                (hdmi_driver_0_s0_read),                                             //                         .read
		.av_readdata            (hdmi_driver_0_s0_readdata),                                         //                         .readdata
		.av_writedata           (hdmi_driver_0_s0_writedata),                                        //                         .writedata
		.av_readdatavalid       (hdmi_driver_0_s0_readdatavalid),                                    //                         .readdatavalid
		.av_waitrequest         (hdmi_driver_0_s0_waitrequest),                                      //                         .waitrequest
		.av_address             (),                                                                  //              (terminated)
		.av_begintransfer       (),                                                                  //              (terminated)
		.av_beginbursttransfer  (),                                                                  //              (terminated)
		.av_burstcount          (),                                                                  //              (terminated)
		.av_byteenable          (),                                                                  //              (terminated)
		.av_writebyteenable     (),                                                                  //              (terminated)
		.av_lock                (),                                                                  //              (terminated)
		.av_chipselect          (),                                                                  //              (terminated)
		.av_clken               (),                                                                  //              (terminated)
		.uav_clken              (1'b0),                                                              //              (terminated)
		.av_debugaccess         (),                                                                  //              (terminated)
		.av_outputenable        (),                                                                  //              (terminated)
		.uav_response           (),                                                                  //              (terminated)
		.av_response            (2'b00),                                                             //              (terminated)
		.uav_writeresponsevalid (),                                                                  //              (terminated)
		.av_writeresponsevalid  (1'b0)                                                               //              (terminated)
	);

endmodule
