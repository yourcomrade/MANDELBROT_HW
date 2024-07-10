
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module MANDELBROT_HW(

	//////////// ADC //////////
	output		          		ADC_CONVST,
	output		          		ADC_SCK,
	output		          		ADC_SDI,
	input 		          		ADC_SDO,

	//////////// ARDUINO //////////
	inout 		    [15:0]		ARDUINO_IO,
	inout 		          		ARDUINO_RESET_N,

	//////////// CLOCK //////////
	input 		          		FPGA_CLK1_50,
	input 		          		FPGA_CLK2_50,
	input 		          		FPGA_CLK3_50,

	//////////// HDMI //////////
	inout 		          		HDMI_I2C_SCL,
	inout 		          		HDMI_I2C_SDA,
	inout 		          		HDMI_I2S,
	inout 		          		HDMI_LRCLK,
	inout 		          		HDMI_MCLK,
	inout 		          		HDMI_SCLK,
	output		          		HDMI_TX_CLK,
	output		          		HDMI_TX_DE,
	output		    [23:0]		HDMI_TX_D,
	output		          		HDMI_TX_HS,
	input 		          		HDMI_TX_INT,
	output		          		HDMI_TX_VS,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [7:0]		LED,

	//////////// SW //////////
	input 		     [3:0]		SW
);




//=======================================================
//  REG/WIRE declarations
//=======================================================

wire [26:0] hdmi_output;
wire pll_clk_hdmi;
wire reset_n;
wire fpga_clk_50;
assign {HDMI_TX_HS, HDMI_TX_VS, HDMI_TX_DE, HDMI_TX_D} = {hdmi_output[26:0]}; 
assign fpga_clk_50 = FPGA_CLK1_50;
assign HDMI_TX_CLK = pll_clk_hdmi;
wire pll_clk_100;
//=======================================================
//  Structural coding
//=======================================================
pll my_pll(
		.refclk(fpga_clk_50),   //  refclk.clk
		.rst(!KEY[0]),      //   reset.reset
		.outclk_0(pll_clk_hdmi), // outclk0.clk
		.outclk_1(pll_clk_100),
		.locked(reset_n)    //  locked.export
	);
I2C_HDMI_Config u_I2C_HDMI_Config (
	.iCLK(FPGA_CLK2_50),
	.iRST_N(reset_n),
	.I2C_SCLK(HDMI_I2C_SCL),
	.I2C_SDAT(HDMI_I2C_SDA),
	.HDMI_TX_INT(HDMI_TX_INT)
	 );

mandebrot_plot u0 (
		.clk_clk                                       (fpga_clk_50),                                       //                                  clk.clk
		.reset_reset_n                                 (reset_n),                                 //                                reset.reset_n
		.hdmi_driver_conduit_out_hdmi_out              (hdmi_output),              //              hdmi_driver_conduit_out.hdmi_out
		.hdmi_driver_conduit_rst_rst                   (!reset_n),                   //              hdmi_driver_conduit_rst.rst
		.hdmi_driver_conduit_hdmi_clk_clk              (pll_clk_hdmi),               //         hdmi_driver_conduit_hdmi_clk.clk
		.mand_total_single_sys_conduit_signal_start_sw (SW[0]), // mand_total_single_sys_conduit_signal.start_sw
		.mand_total_single_sys_conduit_signal_busy     (LED[1]),      //                                     .busy
		.mand_total_single_sys_conduit_signal_done(LED[2])
	);

reg [25: 0] counter;
reg led_level;
always @(posedge fpga_clk_50 or negedge reset_n) begin
	if(!reset_n) begin
		counter <= 0;
		led_level <= 0;
	end
    else if (counter == 24999999) begin
        counter <= 0;
        led_level <= ~led_level;
    end
    else
        counter <= counter + 1'b1;
end

assign LED[0] = led_level;


endmodule
