`timescale 1ns / 1ns

module fb_controller_tb;

    // Define parameters
    parameter WIDTH = 32;
    parameter HEIGHT = 32;

    // Signals
    reg clk, rst;
    reg [63:0] ava_writedata;
    reg ava_write;
    wire do_read, do_write;
    wire [15:0] pix_x;
    wire [15:0] pix_y;
    wire [31:0] write_rgb;
    reg [31:0] read_rgb;
    reg ava_read;
    wire [63:0] ava_readdata;
    wire ava_readdatavalid;
    wire ava_waitrequest;
    reg busy;
    reg done;

    // Instantiate the fb_controller module
    fb_controller fb_controller_inst (
        .clk(clk),
        .rst(rst),
        .ava_writedata(ava_writedata),
        .ava_write(ava_write),
        .do_read(do_read),
        .do_write(do_write),
        .pix_x(pix_x),
        .pix_y(pix_y),
        .write_rgb(write_rgb),
        .read_rgb(read_rgb),
        .ava_read(ava_read),
        .ava_readdata(ava_readdata),
        .ava_readdatavalid(ava_readdatavalid),
        .ava_waitrequest(ava_waitrequest),
        .busy(busy),
        .done(done)
    );

    // Clock generation
    always #1 clk = ~clk;

    // Reset generation
    initial begin
        clk = 1;
        rst = 1;
        #2 rst = 0;
    end

    // Test sequence
    initial begin
        // Example: Simulate some clock cycles
        #4;

        // Example: Write operation
        ava_writedata = { 12'd100, 12'd200, 32'hAABBCCDD}; // Write RGB data and pixel coordinates
        ava_write = 1;
        ava_read = 0;
        // Simulate some clock cycles
        #2;
        busy = 1;
        done = 0;
        #2;
        busy = 0;
        done = 1;
        #2
        busy = 0;
        done = 0;
        #2
        // Example: Read operation
        ava_read = 1;
        // Simulate some clock cycles
        #2;

        // Example: Check read data
        if (ava_readdatavalid) begin
            $display("Read RGB data: %h", ava_readdata);
        end else begin
            $display("Read operation failed!");
        end

        // End simulation
        $stop;
    end

endmodule
