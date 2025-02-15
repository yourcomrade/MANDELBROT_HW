// mandebrot_plot.v

// Generated using ACDS version 23.1 991

`timescale 1 ps / 1 ps
module mandebrot_plot (
		input  wire        clk_clk,                                       //                                  clk.clk
		input  wire        hdmi_driver_conduit_hdmi_clk_clk,              //         hdmi_driver_conduit_hdmi_clk.clk
		output wire [26:0] hdmi_driver_conduit_out_hdmi_out,              //              hdmi_driver_conduit_out.hdmi_out
		input  wire        hdmi_driver_conduit_rst_rst,                   //              hdmi_driver_conduit_rst.rst
		input  wire        mand_total_single_sys_conduit_signal_start_sw, // mand_total_single_sys_conduit_signal.start_sw
		output wire        mand_total_single_sys_conduit_signal_busy,     //                                     .busy
		output wire        mand_total_single_sys_conduit_signal_done,     //                                     .done
		input  wire        reset_reset_n                                  //                                reset.reset_n
	);

	wire         pll_0_outclk0_clk;                                // pll_0:outclk_0 -> [hdmi_driver_0:clk, mand_total_single_sys_0:clk, mm_bridge_0:clk, mm_interconnect_0:pll_0_outclk0_clk, mm_interconnect_1:pll_0_outclk0_clk, rst_controller:clk]
	wire         mm_bridge_0_m0_waitrequest;                       // mm_interconnect_0:mm_bridge_0_m0_waitrequest -> mm_bridge_0:m0_waitrequest
	wire  [31:0] mm_bridge_0_m0_readdata;                          // mm_interconnect_0:mm_bridge_0_m0_readdata -> mm_bridge_0:m0_readdata
	wire         mm_bridge_0_m0_debugaccess;                       // mm_bridge_0:m0_debugaccess -> mm_interconnect_0:mm_bridge_0_m0_debugaccess
	wire   [9:0] mm_bridge_0_m0_address;                           // mm_bridge_0:m0_address -> mm_interconnect_0:mm_bridge_0_m0_address
	wire         mm_bridge_0_m0_read;                              // mm_bridge_0:m0_read -> mm_interconnect_0:mm_bridge_0_m0_read
	wire   [3:0] mm_bridge_0_m0_byteenable;                        // mm_bridge_0:m0_byteenable -> mm_interconnect_0:mm_bridge_0_m0_byteenable
	wire         mm_bridge_0_m0_readdatavalid;                     // mm_interconnect_0:mm_bridge_0_m0_readdatavalid -> mm_bridge_0:m0_readdatavalid
	wire  [31:0] mm_bridge_0_m0_writedata;                         // mm_bridge_0:m0_writedata -> mm_interconnect_0:mm_bridge_0_m0_writedata
	wire         mm_bridge_0_m0_write;                             // mm_bridge_0:m0_write -> mm_interconnect_0:mm_bridge_0_m0_write
	wire   [0:0] mm_bridge_0_m0_burstcount;                        // mm_bridge_0:m0_burstcount -> mm_interconnect_0:mm_bridge_0_m0_burstcount
	wire  [31:0] mm_interconnect_0_hdmi_driver_0_s0_readdata;      // hdmi_driver_0:avs_s0_readdata -> mm_interconnect_0:hdmi_driver_0_s0_readdata
	wire         mm_interconnect_0_hdmi_driver_0_s0_waitrequest;   // hdmi_driver_0:avs_s0_waitrequest -> mm_interconnect_0:hdmi_driver_0_s0_waitrequest
	wire         mm_interconnect_0_hdmi_driver_0_s0_read;          // mm_interconnect_0:hdmi_driver_0_s0_read -> hdmi_driver_0:avs_s0_read
	wire         mm_interconnect_0_hdmi_driver_0_s0_readdatavalid; // hdmi_driver_0:avs_s0_readdatavalid -> mm_interconnect_0:hdmi_driver_0_s0_readdatavalid
	wire         mm_interconnect_0_hdmi_driver_0_s0_write;         // mm_interconnect_0:hdmi_driver_0_s0_write -> hdmi_driver_0:avs_s0_write
	wire  [31:0] mm_interconnect_0_hdmi_driver_0_s0_writedata;     // mm_interconnect_0:hdmi_driver_0_s0_writedata -> hdmi_driver_0:avs_s0_writedata
	wire         mand_total_single_sys_0_m0_waitrequest;           // mm_interconnect_1:mand_total_single_sys_0_m0_waitrequest -> mand_total_single_sys_0:avm_m0_waitrequest
	wire         mand_total_single_sys_0_m0_write;                 // mand_total_single_sys_0:avm_m0_write -> mm_interconnect_1:mand_total_single_sys_0_m0_write
	wire  [31:0] mand_total_single_sys_0_m0_writedata;             // mand_total_single_sys_0:avm_m0_writedata -> mm_interconnect_1:mand_total_single_sys_0_m0_writedata
	wire  [31:0] mm_interconnect_1_mm_bridge_0_s0_readdata;        // mm_bridge_0:s0_readdata -> mm_interconnect_1:mm_bridge_0_s0_readdata
	wire         mm_interconnect_1_mm_bridge_0_s0_waitrequest;     // mm_bridge_0:s0_waitrequest -> mm_interconnect_1:mm_bridge_0_s0_waitrequest
	wire         mm_interconnect_1_mm_bridge_0_s0_debugaccess;     // mm_interconnect_1:mm_bridge_0_s0_debugaccess -> mm_bridge_0:s0_debugaccess
	wire   [9:0] mm_interconnect_1_mm_bridge_0_s0_address;         // mm_interconnect_1:mm_bridge_0_s0_address -> mm_bridge_0:s0_address
	wire         mm_interconnect_1_mm_bridge_0_s0_read;            // mm_interconnect_1:mm_bridge_0_s0_read -> mm_bridge_0:s0_read
	wire   [3:0] mm_interconnect_1_mm_bridge_0_s0_byteenable;      // mm_interconnect_1:mm_bridge_0_s0_byteenable -> mm_bridge_0:s0_byteenable
	wire         mm_interconnect_1_mm_bridge_0_s0_readdatavalid;   // mm_bridge_0:s0_readdatavalid -> mm_interconnect_1:mm_bridge_0_s0_readdatavalid
	wire         mm_interconnect_1_mm_bridge_0_s0_write;           // mm_interconnect_1:mm_bridge_0_s0_write -> mm_bridge_0:s0_write
	wire  [31:0] mm_interconnect_1_mm_bridge_0_s0_writedata;       // mm_interconnect_1:mm_bridge_0_s0_writedata -> mm_bridge_0:s0_writedata
	wire   [0:0] mm_interconnect_1_mm_bridge_0_s0_burstcount;      // mm_interconnect_1:mm_bridge_0_s0_burstcount -> mm_bridge_0:s0_burstcount
	wire         rst_controller_reset_out_reset;                   // rst_controller:reset_out -> [hdmi_driver_0:rst, mand_total_single_sys_0:rst, mm_bridge_0:reset, mm_interconnect_0:mm_bridge_0_reset_reset_bridge_in_reset_reset, mm_interconnect_1:mand_total_single_sys_0_reset_reset_bridge_in_reset_reset]

	hdmi_display_sys #(
		.WIDTH (8)
	) hdmi_driver_0 (
		.clk                  (pll_0_outclk0_clk),                                //            clock.clk
		.avs_s0_writedata     (mm_interconnect_0_hdmi_driver_0_s0_writedata),     //               s0.writedata
		.avs_s0_write         (mm_interconnect_0_hdmi_driver_0_s0_write),         //                 .write
		.avs_s0_read          (mm_interconnect_0_hdmi_driver_0_s0_read),          //                 .read
		.avs_s0_readdata      (mm_interconnect_0_hdmi_driver_0_s0_readdata),      //                 .readdata
		.avs_s0_readdatavalid (mm_interconnect_0_hdmi_driver_0_s0_readdatavalid), //                 .readdatavalid
		.avs_s0_waitrequest   (mm_interconnect_0_hdmi_driver_0_s0_waitrequest),   //                 .waitrequest
		.rst                  (rst_controller_reset_out_reset),                   //            reset.reset
		.clk_hdmi             (hdmi_driver_conduit_hdmi_clk_clk),                 // conduit_hdmi_clk.clk
		.reset_hdmi           (hdmi_driver_conduit_rst_rst),                      //      conduit_rst.rst
		.hdmi_tx_out          (hdmi_driver_conduit_out_hdmi_out)                  //      conduit_out.hdmi_out
	);

	mand_total_sys #(
		.WIDTH (32)
	) mand_total_single_sys_0 (
		.clk                (pll_0_outclk0_clk),                             //          clock.clk
		.avm_m0_waitrequest (mand_total_single_sys_0_m0_waitrequest),        //             m0.waitrequest
		.avm_m0_write       (mand_total_single_sys_0_m0_write),              //               .write
		.avm_m0_writedata   (mand_total_single_sys_0_m0_writedata),          //               .writedata
		.rst                (rst_controller_reset_out_reset),                //          reset.reset
		.start_sw           (mand_total_single_sys_conduit_signal_start_sw), // conduit_signal.start_sw
		.busy               (mand_total_single_sys_conduit_signal_busy),     //               .busy
		.done               (mand_total_single_sys_conduit_signal_done)      //               .done
	);

	altera_avalon_mm_bridge #(
		.DATA_WIDTH        (32),
		.SYMBOL_WIDTH      (8),
		.HDL_ADDR_WIDTH    (10),
		.BURSTCOUNT_WIDTH  (1),
		.PIPELINE_COMMAND  (1),
		.PIPELINE_RESPONSE (1)
	) mm_bridge_0 (
		.clk              (pll_0_outclk0_clk),                              //   clk.clk
		.reset            (rst_controller_reset_out_reset),                 // reset.reset
		.s0_waitrequest   (mm_interconnect_1_mm_bridge_0_s0_waitrequest),   //    s0.waitrequest
		.s0_readdata      (mm_interconnect_1_mm_bridge_0_s0_readdata),      //      .readdata
		.s0_readdatavalid (mm_interconnect_1_mm_bridge_0_s0_readdatavalid), //      .readdatavalid
		.s0_burstcount    (mm_interconnect_1_mm_bridge_0_s0_burstcount),    //      .burstcount
		.s0_writedata     (mm_interconnect_1_mm_bridge_0_s0_writedata),     //      .writedata
		.s0_address       (mm_interconnect_1_mm_bridge_0_s0_address),       //      .address
		.s0_write         (mm_interconnect_1_mm_bridge_0_s0_write),         //      .write
		.s0_read          (mm_interconnect_1_mm_bridge_0_s0_read),          //      .read
		.s0_byteenable    (mm_interconnect_1_mm_bridge_0_s0_byteenable),    //      .byteenable
		.s0_debugaccess   (mm_interconnect_1_mm_bridge_0_s0_debugaccess),   //      .debugaccess
		.m0_waitrequest   (mm_bridge_0_m0_waitrequest),                     //    m0.waitrequest
		.m0_readdata      (mm_bridge_0_m0_readdata),                        //      .readdata
		.m0_readdatavalid (mm_bridge_0_m0_readdatavalid),                   //      .readdatavalid
		.m0_burstcount    (mm_bridge_0_m0_burstcount),                      //      .burstcount
		.m0_writedata     (mm_bridge_0_m0_writedata),                       //      .writedata
		.m0_address       (mm_bridge_0_m0_address),                         //      .address
		.m0_write         (mm_bridge_0_m0_write),                           //      .write
		.m0_read          (mm_bridge_0_m0_read),                            //      .read
		.m0_byteenable    (mm_bridge_0_m0_byteenable),                      //      .byteenable
		.m0_debugaccess   (mm_bridge_0_m0_debugaccess),                     //      .debugaccess
		.s0_response      (),                                               // (terminated)
		.m0_response      (2'b00)                                           // (terminated)
	);

	mandebrot_plot_pll_0 pll_0 (
		.refclk   (clk_clk),           //  refclk.clk
		.rst      (~reset_reset_n),    //   reset.reset
		.outclk_0 (pll_0_outclk0_clk), // outclk0.clk
		.locked   ()                   // (terminated)
	);

	mandebrot_plot_mm_interconnect_0 mm_interconnect_0 (
		.pll_0_outclk0_clk                             (pll_0_outclk0_clk),                                //                           pll_0_outclk0.clk
		.mm_bridge_0_reset_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),                   // mm_bridge_0_reset_reset_bridge_in_reset.reset
		.mm_bridge_0_m0_address                        (mm_bridge_0_m0_address),                           //                          mm_bridge_0_m0.address
		.mm_bridge_0_m0_waitrequest                    (mm_bridge_0_m0_waitrequest),                       //                                        .waitrequest
		.mm_bridge_0_m0_burstcount                     (mm_bridge_0_m0_burstcount),                        //                                        .burstcount
		.mm_bridge_0_m0_byteenable                     (mm_bridge_0_m0_byteenable),                        //                                        .byteenable
		.mm_bridge_0_m0_read                           (mm_bridge_0_m0_read),                              //                                        .read
		.mm_bridge_0_m0_readdata                       (mm_bridge_0_m0_readdata),                          //                                        .readdata
		.mm_bridge_0_m0_readdatavalid                  (mm_bridge_0_m0_readdatavalid),                     //                                        .readdatavalid
		.mm_bridge_0_m0_write                          (mm_bridge_0_m0_write),                             //                                        .write
		.mm_bridge_0_m0_writedata                      (mm_bridge_0_m0_writedata),                         //                                        .writedata
		.mm_bridge_0_m0_debugaccess                    (mm_bridge_0_m0_debugaccess),                       //                                        .debugaccess
		.hdmi_driver_0_s0_write                        (mm_interconnect_0_hdmi_driver_0_s0_write),         //                        hdmi_driver_0_s0.write
		.hdmi_driver_0_s0_read                         (mm_interconnect_0_hdmi_driver_0_s0_read),          //                                        .read
		.hdmi_driver_0_s0_readdata                     (mm_interconnect_0_hdmi_driver_0_s0_readdata),      //                                        .readdata
		.hdmi_driver_0_s0_writedata                    (mm_interconnect_0_hdmi_driver_0_s0_writedata),     //                                        .writedata
		.hdmi_driver_0_s0_readdatavalid                (mm_interconnect_0_hdmi_driver_0_s0_readdatavalid), //                                        .readdatavalid
		.hdmi_driver_0_s0_waitrequest                  (mm_interconnect_0_hdmi_driver_0_s0_waitrequest)    //                                        .waitrequest
	);

	mandebrot_plot_mm_interconnect_1 mm_interconnect_1 (
		.pll_0_outclk0_clk                                         (pll_0_outclk0_clk),                              //                                       pll_0_outclk0.clk
		.mand_total_single_sys_0_reset_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),                 // mand_total_single_sys_0_reset_reset_bridge_in_reset.reset
		.mand_total_single_sys_0_m0_waitrequest                    (mand_total_single_sys_0_m0_waitrequest),         //                          mand_total_single_sys_0_m0.waitrequest
		.mand_total_single_sys_0_m0_write                          (mand_total_single_sys_0_m0_write),               //                                                    .write
		.mand_total_single_sys_0_m0_writedata                      (mand_total_single_sys_0_m0_writedata),           //                                                    .writedata
		.mm_bridge_0_s0_address                                    (mm_interconnect_1_mm_bridge_0_s0_address),       //                                      mm_bridge_0_s0.address
		.mm_bridge_0_s0_write                                      (mm_interconnect_1_mm_bridge_0_s0_write),         //                                                    .write
		.mm_bridge_0_s0_read                                       (mm_interconnect_1_mm_bridge_0_s0_read),          //                                                    .read
		.mm_bridge_0_s0_readdata                                   (mm_interconnect_1_mm_bridge_0_s0_readdata),      //                                                    .readdata
		.mm_bridge_0_s0_writedata                                  (mm_interconnect_1_mm_bridge_0_s0_writedata),     //                                                    .writedata
		.mm_bridge_0_s0_burstcount                                 (mm_interconnect_1_mm_bridge_0_s0_burstcount),    //                                                    .burstcount
		.mm_bridge_0_s0_byteenable                                 (mm_interconnect_1_mm_bridge_0_s0_byteenable),    //                                                    .byteenable
		.mm_bridge_0_s0_readdatavalid                              (mm_interconnect_1_mm_bridge_0_s0_readdatavalid), //                                                    .readdatavalid
		.mm_bridge_0_s0_waitrequest                                (mm_interconnect_1_mm_bridge_0_s0_waitrequest),   //                                                    .waitrequest
		.mm_bridge_0_s0_debugaccess                                (mm_interconnect_1_mm_bridge_0_s0_debugaccess)    //                                                    .debugaccess
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                 // reset_in0.reset
		.clk            (pll_0_outclk0_clk),              //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

endmodule
