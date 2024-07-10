`timescale 1ns / 1ns

module framebuffer_tb;

    // Parameters
    parameter WIDTH = 32;
    parameter base_addr = 32'h20000000;
    parameter ver_x = 640;
    parameter hor_y = 480;

    // Signals
    reg clk, rst;
    reg do_read, do_write;
    wire busy, done;
    reg ava_agent_waitrequest;
    wire ava_read;
    wire [WIDTH* 2 - 1:0] ava_readdata;
    reg ava_readdatavalid;
    reg [9:0] pix_x, pix_y;
    wire ava_write;
    wire [WIDTH*2 - 1:0] ava_writedata;
    wire [WIDTH - 1:0] ava_address;
    wire [3:0] ava_byteenable;
    wire [7:0] ava_burstcount;
    wire [WIDTH - 1:0] read_rgb;
    reg [WIDTH - 1:0] write_rgb;

    // Instantiate the framebuffer module
    framebuffer #(
        .WIDTH(WIDTH),
        .base_addr(base_addr),
        .ver_x(ver_x),
        .hor_y(hor_y)
    ) framebuffer_inst (
        .clk(clk),
        .rst(rst),
        .do_read(do_read),
        .do_write(do_write),
        .busy(busy),
        .done(done),
        .ava_agent_waitrequest(ava_agent_waitrequest),
        .ava_read(ava_read),
        .ava_readdata(ava_readdata),
        .ava_readdatavalid(ava_readdatavalid),
        .pix_x(pix_x),
        .pix_y(pix_y),
        .ava_write(ava_write),
        .ava_writedata(ava_writedata),
        .ava_address(ava_address),
        .ava_byteenable(ava_byteenable),
        .ava_burstcount(ava_burstcount),
        .read_rgb(read_rgb),
        .write_rgb(write_rgb)
    );

    // Clock generation
    always #1 clk = ~clk;

    // Reset generation
    initial begin
        clk = 0;
        rst = 1;
        #2 rst = 0;
    end

    // Test sequence
    initial begin
        // Initialize test sequence here
        // Example: Assign values to inputs, toggle signals, etc.
        // Simulate some clock cycles
        #2;

        // Example: Start a read operation
        do_read = 1;
        do_write = 0;
        // Assign values to other inputs if needed
        pix_x = 10;
        pix_y = 20;
        // Simulate some clock cycles
        #1 ava_agent_waitrequest = 1;
        #2 ava_agent_waitrequest = 0;
        #4 ava_readdatavalid = 1;
        do_read = 0;
        #2;
        // Example: Assert signal indicating read operation is done
        // Check the output values if needed
        if (done) begin
            $display("Read operation completed successfully!");
        end else begin
            $display("Read operation failed!");
        end
        #2 do_read = 0;
        // Example: Start a write operation
        do_write = 1;
        // Assign values to other inputs if needed
        pix_x = 100;
        pix_y = 200;
        write_rgb = 32'h00BBCCDD;
        // Simulate some clock cycles
        #1 ava_agent_waitrequest = 1;
        #2 ava_agent_waitrequest = 0;
        #4;

        // Example: Assert signal indicating write operation is done
        // Check the output values if needed
        if (done) begin
            $display("Write operation completed successfully!");
        end else begin
            $display("Write operation failed!");
        end

        // End simulation
        $stop;
    end

endmodule
