`timescale 1ps/1ps 

module tb_mandelbrot_calc;

    // Parameters
    parameter WIDTH = 27;
    parameter FBITS = 23;

    // Inputs
    reg clk;
    reg rst;
    reg start;
    reg signed [WIDTH-1:0] c_real;
    reg signed [WIDTH-1:0] c_imag;
    reg [7:0] max_iter;

    // Outputs
    wire [7:0] iter_count;
    wire is_inside;
    wire is_done;

    // Instantiate the Unit Under Test (UUT)
    mandelbrot_calc #(WIDTH, FBITS) uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .c_real(c_real),
        .c_imag(c_imag),
        .max_iter(max_iter),
        .iter_count(iter_count),
        .is_inside(is_inside),
        .is_done(is_done)
    );

    // Clock generation
    always #1 clk = ~clk; // 1ns period clock

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        start <= 0;
        c_real <= 0;
        c_imag <= 0;
        max_iter <= 100;

        // Wait for global reset to finish
        #4;
        rst = 0;

        // Apply test vectors
        @(posedge clk);
        start <= 1;
        c_real <= 27'sh0400000; // 1.0 in fixed-point 4.23 format
        c_imag <= 27'sh0000000; // 0.0 in fixed-point 4.23 format
        max_iter <= 100;

       

        // Wait for the computation to complete
        wait (is_done);

        // Check the result
        $display("Iteration Count: %d", iter_count);
        $display("Is Inside: %d", is_inside);
        // Apply reset to initialize internal states before the next test
       
        // Test another point
        @(posedge clk);
        start <= 1;
        c_real <= 27'sh0000000; // 0.0 in fixed-point 4.23 format
        c_imag <= 27'sh0400000; // 1.0 in fixed-point 4.23 format
        max_iter <= 100;
        @(posedge clk);
        @(posedge clk);

        // Wait for the computation to complete
        wait (is_done);

        // Check the result
        $display("Iteration Count: %d", iter_count);
        $display("Is Inside: %d", is_inside);

        // Finish simulation
        $stop;
    end

endmodule
