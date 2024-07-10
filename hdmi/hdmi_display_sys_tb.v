`timescale 1ps/1ps

module hdmi_display_sys_tb;

// Parameters
parameter CLK_PERIOD = 2; // Clock period in ns

// Signals
reg clk = 0;
reg rst = 1;
reg [31:0] avs_s0_writedata;
reg avs_s0_write;
reg avs_s0_read;
wire [31:0] avs_s0_readdata;
wire avs_s0_readdatavalid;
wire avs_s0_waitrequest;
wire [26:0] hdmi_tx_out;
reg clk_hdmi = 0;
reg rst_hdmi = 1;
integer i, j;
reg [9:0] a, b;
// Instantiate the module
hdmi_display_sys hdmi_display_sys_inst (
    .clk(clk),
    .rst(rst),
    .reset_hdmi(rst),
    .avs_s0_writedata(avs_s0_writedata),
    .avs_s0_write(avs_s0_write),
    .avs_s0_read(avs_s0_read),
    .avs_s0_readdata(avs_s0_readdata),
    .avs_s0_readdatavalid(avs_s0_readdatavalid),
    .avs_s0_waitrequest(avs_s0_waitrequest),
    .hdmi_tx_out(hdmi_tx_out),
    .clk_hdmi(clk_hdmi)
);

// Clock generation
always #((CLK_PERIOD / 2)) clk = ~clk;
always #(CLK_PERIOD) clk_hdmi = ~clk_hdmi;
// Test sequence
initial begin
    // Release reset
   
    rst = 1;
    rst_hdmi = 0;
    #2;
    rst = 0;
    rst_hdmi = 1;

    // Example Avalon write transaction
    avs_s0_write = 1;
    avs_s0_read = 0;
    // Simulate a frame
   for(i = 0; i < 525; i = i + 1) begin // Vertical frame loop
        for( j = 0; j < 800; j = j + 1) begin // Horizontal frame loop for 640 pixels
            #2; // Advance time for each pixel
            
            // Send RGB data
            // For simplicity, we're using the same RGB data for each pixel
            a = i;
            b = j;
            avs_s0_writedata =  {a,b,12'h0FA};// Example data
        end
    end
    
    #100;
    

    // Example Avalon read transaction
    avs_s0_read = 1;
    #100;
    avs_s0_read = 0;

    // Simulate for some time
    #1000;

    $stop;
end

endmodule
