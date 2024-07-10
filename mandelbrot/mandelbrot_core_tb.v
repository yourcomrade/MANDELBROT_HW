`timescale 1ps / 1ps

module tb_mandelbrot_core;

    // Parameters
    parameter WIDTH = 27;
    parameter FBITS = 23;
    parameter MAX_ITERATION = 255;

    // Inputs
    reg clk;
    reg rst;
    reg start;
    reg [9:0] pixel_x;
    reg [9:0] pixel_y;
    reg signed [WIDTH - 1:0] real_num;
    reg signed [WIDTH - 1:0] imag_num;

    // Outputs
    wire [31:0] pixel_data;
    wire busy;
    wire done;

    // Instantiate the Unit Under Test (UUT)
    mandelbrot_core #(
        .WIDTH(WIDTH),
        .FBITS(FBITS),
        .MAX_ITERATION(MAX_ITERATION)
    ) uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        .real_num(real_num),
        .imag_num(imag_num),
        .pixel_data(pixel_data),
        .busy(busy),
        .done(done)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        start = 0;
        pixel_x = 10'd320;
        pixel_y = 10'd240;
        real_num = 27'sb000000000000000000000000000; // Example real number input
        imag_num = 27'sb000000000000000000000000000; // Example imaginary number input

        // Wait for 100 ns for global reset to finish
        #4;

        // Release reset
        rst = 0;

        // Start the Mandelbrot core
        start = 1;
        #4;
        start = 0;

        // Wait for the operation to complete
        wait(done);
        $display("Mandelbrot calculation complete. pixel_data = %h", pixel_data);
        #10;
        // Finish simulation
        $stop;
    end

    // Clock generation
    always #1 clk = ~clk;

endmodule
