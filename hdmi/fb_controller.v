module fb_controller(
    input wire clk,
    input wire rst,
    input wire [63:0] ava_writedata,
    input wire ava_write,

    output reg do_read,
    output reg do_write,

    output wire [15:0]pix_x,
    output wire [15:0]pix_y,
    output wire [31:0] write_rgb,
    input wire [31:0] read_rgb,

    input wire ava_read,
    output wire [63:0] ava_readdata,
    output reg ava_readdatavalid,
    output reg ava_waitrequest,
    input wire busy,
    input wire done

);
reg [31:0] rgb_data;
assign ava_readdata = rgb_data;
assign pix_x = ava_writedata[47:32];
assign pix_y = ava_writedata[63:48];
localparam IDLE = 3'd0;
localparam WAIT = 3'd1;
localparam DONE = 3'd2;
reg [2:0]state;
always @(posedge clk)
begin
    if(rst) begin
       
        state = IDLE;
    end
    else begin
       case(state)
            IDLE: begin
                if(ava_write | ava_read == 1)begin
                    state = WAIT;
                end
            end
            WAIT: begin
                if({busy, done} == 2'b10) begin
                    state = WAIT;
                end
                else begin
                    state = DONE;
                end
                
            end
            DONE: begin
                state = IDLE;
            end
            default: begin
            end
       endcase
    end
end
always @(state) begin
    case(state)
        IDLE: begin
            rgb_data <= 0;
            do_read = 0;
            do_write = 0;
            ava_waitrequest = 0;
            ava_readdatavalid = 0;
        end
        WAIT: begin
            ava_waitrequest = 1;
            if(ava_read) begin
                do_read = 1;
                
            end
            else begin
                do_write = 1;
            end

        end
        DONE: begin
            ava_waitrequest = 0;
            if(ava_read) begin
                ava_readdatavalid = 1;
                rgb_data <= read_rgb;
            end
            
        end
        default: begin
        end
    endcase
end

endmodule