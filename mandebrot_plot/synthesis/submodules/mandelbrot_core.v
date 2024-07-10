module mandelbrot_core #(parameter WIDTH = 27, parameter FBITS = 23, parameter MAX_ITERATION = 255)(
    input wire clk,
    input wire rst,
    input wire start,
    input wire [9:0] pixel_x,
    input wire [9:0] pixel_y,
    input wire signed [WIDTH - 1:0] real_num,
    input wire signed [WIDTH - 1:0] imag_num,
    output reg [31:0] pixel_data,
    output wire busy,
    output reg done
);
   

    wire [7:0] iter_count;
    wire is_inside;
    wire nearly_done;
    wire ov;
    
    // Instantiate Mandelbrot module
    mandelbrot_calc #(.WIDTH(WIDTH), .FBITS(FBITS)) mandelbrot_inst (
        .clk(clk),
        .rst(rst),
        .start(start),
        .c_real(real_num),
        .c_imag(imag_num),
        .max_iter(MAX_ITERATION),
        .iter_count(iter_count),
        .is_inside(is_inside),
        .is_done(nearly_done)
    );

    reg calculation_active;
    assign busy = calculation_active;
    // Output pixel color based on iteration count
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            done <= 0;
            calculation_active <= 0;
            pixel_data <= 0;
        end
        else if(start) begin
            calculation_active <= 1;
            done <= 0;
        end
        else if (nearly_done) begin
            if(is_inside)begin
                pixel_data <= {pixel_x, pixel_y, iter_count}; // Inside Mandelbrot set: Black
            end
            else begin
                pixel_data <= {pixel_x, pixel_y, iter_count}; // Inside Mandelbrot set: Black
            end
           
            
            calculation_active <= 0;
            done <= 1;
        end
            
        else begin
            done <= 0;
            
        end
    end
endmodule