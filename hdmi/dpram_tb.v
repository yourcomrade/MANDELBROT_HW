`timescale 1ps / 1ps

module dpram_tb;

// Parameters
parameter addr_width = 19;
parameter data_width = 12;
parameter ram_depth = 1 << addr_width;

// Signals
reg clk;
reg [data_width - 1:0] wdata_a, wdata_b;
reg [addr_width - 1:0] addr_a, addr_b;
reg we_a, we_b;
wire [data_width - 1:0] rdata_a, rdata_b;

// Instantiate the module
dpram #(
    .addr_width(addr_width),
    .data_width(data_width)
) dpram_inst (
    .clk(clk),
    .wdata_a(wdata_a),
    .wdata_b(wdata_b),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .we_a(we_a),
    .we_b(we_b),
    .rdata_a(rdata_a),
    .rdata_b(rdata_b)
);

// Clock generation
always #1 clk = ~clk;
initial begin
    clk = 0;
    
end

// Test stimulus
initial begin
    // Initialize inputs
    wdata_a = 0;
    wdata_b = 0;
    addr_a = 0;
    addr_b = 0;
    we_a = 0;
    we_b = 0;

    // Test sequence
    #10;
    addr_a = 3;
    wdata_a = 8'hFF;
    we_a = 1;
    #10;
    we_a = 0;
    #10;
    addr_b = 5;
    wdata_b = 8'hAA;
    we_b = 1;
    #10;
    we_b = 0;
    #10;

    // Add more test sequences as needed

    $stop;
end

// Display outputs
always @(posedge clk) begin
    $display("Time = %t, rdata_a = %h, rdata_b = %h", $time, rdata_a, rdata_b);
end

endmodule
