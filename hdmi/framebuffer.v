module framebuffer #(
    parameter WIDTH = 32,
    parameter base_addr = 32'h20000000,
    parameter ver_x = 640,
    parameter hor_y = 480
)(
    input wire clk,
    input wire rst,

    input wire do_read,
    input wire do_write,
    output reg busy,
    output reg done, 

    input wire ava_agent_waitrequest,
    output reg ava_read,
    input wire [WIDTH * 2 - 1:0]ava_readdata,
    input wire ava_readdatavalid,
    
    input wire [15:0]pix_x,
    input wire [15:0]pix_y,

    output reg ava_write,
    output wire [WIDTH * 2 - 1:0]ava_writedata,
    output wire [WIDTH - 1:0]ava_address,
    output reg [7:0] ava_byteenable,
    output reg [7:0] ava_burstcount,
    output wire [WIDTH - 1:0]read_rgb,
    input wire [WIDTH - 1:0] write_rgb
);
reg [WIDTH - 1:0] addr;
reg [WIDTH - 1:0] rgb;
assign read_rgb = rgb;
assign ava_address = addr;
assign ava_writedata = write_rgb;
localparam IDLE = 3'd00;
localparam INIT_READ = 3'd1;
localparam Read_start =3'd2 ;
localparam Read_end = 3'd3;
localparam INIT_WRITE = 3'd4;
localparam Write_start = 3'd5;
localparam Write_end = 3'd6;
reg [2:0] cur_state, next_state;
always @(posedge clk) begin
    if(rst) begin
        addr <=  base_addr;
    end
    else begin
        addr <= base_addr + (hor_y * pix_y) + pix_x;
    end
end

always @(posedge clk) begin
    if(rst)begin
        cur_state <= IDLE;
    end
    else begin
        case({do_read, do_write}) 
            2'b10:begin
                if(cur_state == IDLE)begin
                    cur_state <= INIT_READ;
                end
                else begin
                    cur_state <= next_state;
                end
            end
            2'b01:begin
                if(cur_state == IDLE) begin
                    cur_state <= INIT_WRITE;
                end
                else begin
                    cur_state <= next_state; 
                end
            end
            default: begin
                
            end
        endcase
    end
    
end
always @(*) begin

    case(cur_state)
        IDLE: begin
            busy = 0;
            done = 0;
            ava_write = 0;
            ava_read = 0;
            ava_burstcount = 8'd0; 
            ava_byteenable = 0; 
        end
        INIT_READ: begin
            busy = 1;
            ava_read = 1;
            ava_burstcount = 8'd1; // Get only 1 address
            ava_byteenable = 8'hF; // Get 32 bits only.
            next_state = Read_start;
        end
        Read_start: begin
            if(ava_agent_waitrequest) begin
                next_state = Read_start;
            end
            else next_state = Read_end;
            
        end
        Read_end: begin
            if(ava_readdatavalid) begin
                rgb <= ava_readdata;
                next_state = IDLE;
                busy = 0;
                done = 1;
            end
            else begin
                next_state = Read_end;
            end
        end
        INIT_WRITE: begin
            busy = 1;
            ava_write = 1;
            ava_burstcount = 8'd1; // Get only 1 address
            ava_byteenable = 8'hF; // Get 32 bits only.
            next_state = Write_start;

        end
        Write_start: begin
            if(ava_agent_waitrequest)begin
                next_state = Write_start;
            end
            else next_state = Write_end;
        end
        Write_end: begin
            busy = 0;
            done = 1;
            next_state = IDLE;
        end

        default: begin
            next_state = cur_state;
        end

    endcase
end
endmodule