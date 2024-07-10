module mandelbrot_calc #(parameter WIDTH = 27, parameter FBITS = 23)(
    input wire clk,
    input wire rst,
    input wire start,
    input wire signed [WIDTH-1:0] c_real,
    input wire signed [WIDTH-1:0] c_imag,
    input wire [7:0] max_iter,
    output wire [7:0] iter_count,
    output reg is_inside,
    output wire is_done
);
    localparam IDLE = 2'd0;
    localparam CALC = 2'd1;
    localparam FIN = 2'd2;
    reg [1:0] state;
    reg signed [WIDTH-1:0] z_real, z_imag;
    wire signed [WIDTH-1:0] z_real_sq, z_imag_sq, z_real_x_z_imag;
    wire signed [WIDTH-1:0] z_real_next, z_imag_next;
    wire signed [WIDTH-1:0] two_z_real_z_imag;
    wire signed [WIDTH-1:0] temp_add_1;
    wire signed [WIDTH-1:0] real_part_diff;
    

    reg [7:0] iter;
    
    assign two_z_real_z_imag = z_real_x_z_imag << 1;
    // Instantiate fixed-point multiplication and addition modules
    fxp_mult #(.WIDTH(WIDTH), .FBITS(FBITS)) mult_real_sq (.rhs(z_real), .lhs(z_real), .res(z_real_sq));
    fxp_mult #(.WIDTH(WIDTH), .FBITS(FBITS)) mult_imag_sq (.rhs(z_imag), .lhs(z_imag), .res(z_imag_sq));
    fxp_mult #(.WIDTH(WIDTH), .FBITS(FBITS)) mult_two_real_imag (.rhs(z_real), .lhs(z_imag), .res(z_real_x_z_imag));

    fxp_add #(.WIDTH(WIDTH)) add_real_sq (.rhs(z_real_sq), .lhs(z_imag_sq), .res(temp_add_1));
    fxp_add #(.WIDTH(WIDTH)) sub_real_imag (.rhs(z_real_sq), .lhs(-z_imag_sq), .res(real_part_diff));
    fxp_add #(.WIDTH(WIDTH)) add_real_c (.rhs(real_part_diff), .lhs(c_real), .res(z_real_next));
    fxp_add #(.WIDTH(WIDTH)) add_imag_c (.rhs(two_z_real_z_imag), .lhs(c_imag), .res(z_imag_next));
    assign is_done = (state == FIN);
    assign iter_count = iter;
   
    always @(posedge clk or posedge rst) begin
        
        if (rst) begin
            z_real <= 0;
            z_imag <= 0;
            iter <= 0;
            is_inside <= 0;
            state <= IDLE;
            
            
        end
        else begin
           
            case(state)
                CALC: begin
                    
                    // Check for escape condition
                    if (temp_add_1 > ({{(WIDTH - FBITS - 3){1'h0}},3'h4,{FBITS{1'h0}}})) begin // 4 in 4.23 fixed-point format
                        is_inside <= 0;
                       
                        state <= FIN;
                    end 
                    else if ((iter == max_iter)) begin
                        is_inside <= 1;
                        state <= FIN;
                    end
                   
                    else begin
                        // Increment iteration count
                        iter <= iter + 1;
                    end
                    // Update z_real and z_imag
                    z_real <= z_real_next;
                    z_imag <= z_imag_next;
                    
                end
                FIN: begin
                    
                    
                    state <= IDLE;
                end
                default: begin
                    z_real <= 0;
                    z_imag <= 0;
                    iter <= 0;
                    is_inside <= 0;
                    if(start) begin
                        state <= CALC;
                    end
                    else begin
                        state <= IDLE;
                    end
                end
            endcase
            
        end
       
    end

    
endmodule
