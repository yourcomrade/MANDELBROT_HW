module mand_total_sys #(parameter WIDTH = 32)(
    input wire clk,
    input wire rst,
    input avm_m0_waitrequest,
    input wire start_sw,
    output wire busy,
    output wire done,
    output reg avm_m0_write,
    output reg [WIDTH - 1:0]avm_m0_writedata

);
wire data_valid;
wire calc_done;
wire [WIDTH - 1:0] pos_rgb_data;
localparam [1:0] IDLE = 2'd0;
localparam [1:0] CALC = 2'd1;
mandelbrot_single_sys #(.WIDTH(27), .FBITS(23), 
.MAX_H(400),.MAX_V(300)) mand_sys
(
    .clk(clk),
    .rst(rst),
    .start(start_sw),
    .pos_rgb_data(pos_rgb_data),
    .data_valid(data_valid),
    .busy(busy),
    .done(calc_done)
);
assign done = calc_done;

reg [1:0] state;
always @(posedge clk or posedge rst) begin
    if(rst)begin
        state <= IDLE;
        avm_m0_write <= 0;
        avm_m0_writedata <= 0;
    end
    else begin
        case(state)
            CALC:begin
                if(calc_done)begin
                    state <= IDLE;
                end
                else begin
                    state <= state;
                    if(data_valid) begin
                        avm_m0_writedata <= pos_rgb_data;
                        avm_m0_write <= 1;
                    end
                    else begin
                        
                    end
                end

            end
            default: begin
                avm_m0_write <= 0;
                if(start_sw)begin
                    state <= CALC;
                    

                end
                else begin
                    state <= state;
                    
                end
            end

        endcase
        
    end
    
end
endmodule