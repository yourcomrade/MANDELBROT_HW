`timescale 1ps / 1ps

module tb_mandelbrot_single_sys;

// Parameters
parameter WIDTH = 27;
parameter FBITS = 22;
parameter MAX_H = 640;
parameter MAX_V = 480;

// Inputs
reg clk;
reg rst;
reg start;

// Outputs
wire [31:0] pos_rgb_data;
wire busy;
wire done;
wire valid;
reg[9:0] csv_pixel_x, csv_pixel_y;
reg[26:0] real_num, imag_num, csv_real_num, csv_imag_num;
reg[7:0]  csv_iteration;
wire [9:0] pixel_x, pixel_y;
wire [7:0]iteration;

integer i, f, f1, j;

assign pixel_x = pos_rgb_data[27:18];
assign pixel_y = pos_rgb_data[17:8];
assign iteration = pos_rgb_data[7:0];
assign ov_in = pos_rgb_data[29:28];
// Instantiate the Unit Under Test (UUT)
mandelbrot_single_sys #(
    .WIDTH(WIDTH),
    .FBITS(FBITS),
    .MAX_H(MAX_H),
    .MAX_V(MAX_V)
) uut (
    .clk(clk), 
    .rst(rst), 
    .start(start), 
    .pos_rgb_data(pos_rgb_data), 
    .busy(busy),
    .data_valid(valid), 
    .done(done)
);

   
initial begin
    // Initialize Inputs
    clk = 0;
    rst = 1;
    start = 0;

    // Wait for 100 ns for global reset to finish
    #4;
    
    // Release reset
    rst = 0;
    
    // Start the calculation
    start = 1;
    f1 = $fopen("D:/software/verilog/hps_hdmi/mandelbrot/output.txt", "w");
    f = $fopen("D:/software/verilog/hps_hdmi/mandelbrot/mandelbrot_data.csv", "r"); 
    while(!$feof(f))
        begin
            if(valid)begin
            j = $fscanf(f,"%d,%d,%d,%d,%d",csv_pixel_x,csv_pixel_y,csv_real_num, csv_imag_num, csv_iteration);
            $fwrite(f1,"csv_x:%d, csv_y:%d, csv_iter:%d, x:%d, y:%d, iter:%d\n",csv_pixel_x,csv_pixel_y, csv_iteration,pixel_x, pixel_y, iteration);
            $display("csv_x:%d, csv_y:%d, csv_iter:%d, x:%d, y:%d, iter:%d",csv_pixel_x,csv_pixel_y, csv_iteration,pixel_x, pixel_y, iteration);
            end
            @(posedge clk);  
        end
    $fclose(f);
    $fclose(f1);
    // Wait for the operation to complete
    wait(done);
    $display("Mandelbrot calculation complete. pos_rgb_data = %h", pos_rgb_data);

    // Finish simulation
    $stop;
end

// Clock generation
always #1 clk = ~clk;

endmodule
