`timescale 1ps / 1ps

module tb_mand_total_single_sys;

    // Parameters
    parameter WIDTH = 32;

    // Inputs
    reg clk;
    reg rst;
    reg avm_m0_waitrequest;
    reg start_sw;

    // Outputs
    wire busy;
    wire avm_m0_write;
    wire [WIDTH - 1:0] avm_m0_writedata;

    // Instantiate the Unit Under Test (UUT)
    mand_total_sys #(
        .WIDTH(WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .avm_m0_waitrequest(avm_m0_waitrequest),
        .start_sw(start_sw),
        .busy(busy),
        .avm_m0_write(avm_m0_write),
        .avm_m0_writedata(avm_m0_writedata)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        avm_m0_waitrequest = 0;
        start_sw = 0;

        // Wait for 100 ns for global reset to finish
        #4;

        // Release reset
        rst = 0;

        // Start the Mandelbrot calculation
        start_sw = 1;
        #4;
        start_sw = 0;

        // Wait for the operation to complete
        wait(!busy);
        $display("Mandelbrot calculation complete. avm_m0_writedata = %h", avm_m0_writedata);

        // Finish simulation
        $stop;
    end

    // Clock generation
    always #1 clk = ~clk;

endmodule
