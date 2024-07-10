module mandelbrot_single_sys #(parameter WIDTH = 27, parameter FBITS = 23, 
parameter MAX_H = 640, parameter MAX_V = 480)(
    input wire clk,
    input wire rst,
    input wire start,
    output reg [31:0] pos_rgb_data,
    output reg data_valid,
    output reg busy,
    output reg done
);
// Constants for the grid and scaling (4.23 fixed-point format)
  
    //// mandelbrot params ////
localparam real FP_VAL        = 2**FBITS;
localparam real MAN_X_MIN_F  = -2.0;
localparam real MAN_X_MAX_F  = 1.0;
localparam real MAN_Y_MIN_F  = -1.0;
localparam real MAN_Y_MAX_F  = 1.0;
localparam real MAN_DEF_Z_F   = 1.0;
localparam real MAN_DEF_dx_F  = 1.0*(MAN_X_MAX_F - MAN_X_MIN_F)/(MAX_H);
localparam real MAN_DEF_dy_F  = 1.0*(MAN_Y_MAX_F - MAN_Y_MIN_F)/(MAX_V);
localparam      MAN_X_MIN    = MAN_X_MIN_F * FP_VAL;
localparam      MAN_Y_MIN    = MAN_Y_MIN_F * FP_VAL;
localparam      MAN_DEF_dx    = MAN_DEF_dx_F * FP_VAL;
localparam      MAN_DEF_dy    = MAN_DEF_dy_F * FP_VAL;


localparam [WIDTH - 1:0] total_pix = (MAX_H - 1) * (MAX_V);
localparam [1:0] IDLE = 2'd0;
localparam [1:0] START = 2'd1;
localparam [1:0] CALC = 2'd2;
localparam [1:0] FIN = 2'd3;
reg [WIDTH - 1:0] c_re, c_im;
wire [WIDTH - 1:0] c_re_next, c_im_next;
reg [9:0] pix_x, pix_y;
reg start_en;
wire [31:0] out_pix_data;
wire core_busy, core_done;
reg [1:0] state;
wire [WIDTH - 1:0] delta_x, delta_y;
wire signed [WIDTH - 1:0] X_MIN, X_MAX, Y_MIN, Y_MAX;
assign delta_x = MAN_DEF_dx;
assign delta_y = MAN_DEF_dy;
assign X_MIN = MAN_X_MIN;
assign Y_MIN = MAN_Y_MIN;
fxp_add #(.WIDTH(WIDTH)) incre_real (.rhs(c_re), .lhs(delta_x), .res(c_re_next));
fxp_add #(.WIDTH(WIDTH)) incre_imag (.rhs(c_im), .lhs(delta_y), .res(c_im_next));
mandelbrot_core #(.WIDTH(WIDTH), .FBITS(FBITS)) core (
    .clk(clk),
    .rst(rst),
    .start(start_en),
    .pixel_x(pix_x),
    .pixel_y(pix_y),
    .real_num(c_re),
    .imag_num(c_im),
    .pixel_data(out_pix_data),
    .busy(core_busy),
    .done(core_done)
);

always @(posedge clk or posedge rst) begin
    if(rst) begin
       
        pix_x <= 0;
        pix_y <= 0;
        
        c_re <= X_MIN;
        c_im <= Y_MIN;
        
        data_valid <= 0;
        state <= IDLE;
        done <= 0;
    end
    else begin
        case(state)
            START: begin
                done <= 0;
                busy <= 1;
                state <= CALC;
                start_en <= 1;
                
            end
            CALC: begin
                if(pix_x >= (MAX_H -1) && pix_y >= (MAX_V - 1))begin
                   
                    if(core_done)begin
                        data_valid <= 1;
                        pos_rgb_data <= out_pix_data;
                       
                        state <= FIN;
                    end
                    else begin
                        start_en <= 0;
                        data_valid <= 1;
                        state <= state;
                    end
                    
                end
                else begin
                    state <= state;
                    if(core_done)begin
                        data_valid <= 1;
                        pos_rgb_data <= out_pix_data;
                        
                        if(pix_x == (MAX_H - 1))begin
                            
                            pix_x <= 0;
                            c_re <= X_MIN;
                            pix_y <= pix_y + 1'b1;
                            c_im <= c_im_next;
                        end
                        else begin
                            pix_x <= pix_x + 1'b1;
                            c_re <= c_re_next;
                        end
                        
                        start_en <= 1;
                    end
                    else begin
                        data_valid <= 0;
                        start_en <= 0;
                    end
                end
            end
            FIN: begin
                done <= 1;
                busy <= 0;
                state <= IDLE;
            end
            default: begin
               
                pix_x <= 0;
                pix_y <= 0;
                c_re <= X_MIN;
                c_im <= Y_MIN;
                data_valid <= 0;
                if(start) begin
                    state <= START;
                end
                else begin
                    state <= state;
                end
            end
        endcase
    end
end


endmodule