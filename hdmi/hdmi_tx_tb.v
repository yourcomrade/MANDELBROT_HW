`timescale 1ps/1ps

module hdmi_tx_tb;

// Parameters
parameter CLK_PERIOD = 2; // Clock period in ns
//h_total : total - 1
//h_sync : sync - 1
//h_start : sync + back porch - 1 - 2(delay)
//h_end : h_start + active
//v_total : total - 1
//v_sync : sync - 1
//v_start : sync + back porch - 1
//v_end : v_start + active
// Signals
reg clk = 0;
reg reset_n = 1;
reg [11:0] h_total = 12'd799 ; // Horizontal total
reg [11:0] h_sync = 12'd95; // Horizontal sync
reg [11:0] h_start = 12'd141; // Horizontal front porch
reg [11:0] h_end = 12'd781; // Horizontal back porch
reg [11:0] v_total = 12'd524 ; // Vertical total
reg [11:0] v_sync = 12'd1; // Vertical sync
reg [11:0] v_start = 12'd34; // Vertical front porch
reg [11:0] v_end = 12'd514; // Vertical back porch
reg [23:0] rgb_data = 24'hFFAABB; // Example RGB data
wire [9:0] pix_x;
wire [9:0] pix_y;
wire vga_hs;
wire vga_vs;
wire vga_de;
wire [7:0] vga_r;
wire [7:0] vga_g;
wire [7:0] vga_b;

// Instantiate the module
hdmi_tx hdmi_tx_inst (
    .clk(clk),
    .reset_n(reset_n),
    .h_total(h_total),
    .h_sync(h_sync),
    .h_start(h_start),
    .h_end(h_end),
    .v_total(v_total),
    .v_sync(v_sync),
    .v_start(v_start),
    .v_end(v_end),
    .rgb_data(rgb_data),
    .pix_x(pix_x),
    .pix_y(pix_y),
    .vga_hs(vga_hs),
    .vga_vs(vga_vs),
    .vga_de(vga_de),
    .vga_r(vga_r),
    .vga_g(vga_g),
    .vga_b(vga_b)
);

// Clock generation
always #((CLK_PERIOD / 2)) clk = ~clk;

// Test sequence
initial begin
    // Release reset
    reset_n = 0;
    #4;
    reset_n = 1;
    // Simulate a frame
    repeat(525) begin // Vertical frame loop
        repeat(800) begin // Horizontal frame loop for 640 pixels
            #1; // Advance time for each pixel
            
            // Send RGB data
            // For simplicity, we're using the same RGB data for each pixel
            rgb_data <= 24'hFFAABB;
        end
    end
    

    // Add your test sequences here

    
    $stop;
end

endmodule