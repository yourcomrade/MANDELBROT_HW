module hdmi_display_sys #(parameter WIDTH = 8)
(
   
    input wire clk,
    input wire clk_hdmi,
    input wire reset_hdmi,
    input wire rst,
    input wire [31:0] avs_s0_writedata,
    input wire avs_s0_write,

    input wire avs_s0_read,
    output wire [31:0] avs_s0_readdata,
    output reg avs_s0_readdatavalid,
    output reg avs_s0_waitrequest,
    output wire [26:0] hdmi_tx_out
    
);
reg [WIDTH - 1:0] rgb_data;
assign avs_s0_readdata = {20'h0,rgb_data};
wire [9:0] hps_pix_x, hps_pix_y;
wire [9:0] hdmi_pix_x, hdmi_pix_y;
wire [7:0] vga_r, vga_b, vga_g;
wire vga_hs, vga_vs, vga_de;
wire [7:0] hdmi_rgb;
wire [WIDTH - 1:0] hps_rrgb, hps_wrgb;
assign hdmi_tx_out = {vga_hs,vga_vs, vga_de,vga_r, vga_g, vga_b};
assign hps_pix_x = avs_s0_writedata[27:18];
assign hps_pix_y = avs_s0_writedata[17:8];
assign hps_wrgb = avs_s0_writedata[7:0]; 
wire [23:0] hdmi_rgb_24bits = {hdmi_rgb[7:5], 5'h0, hdmi_rgb[4:2], 5'h0, hdmi_rgb[1:0], 6'h0};
localparam IDLE = 3'd0;
localparam WAIT = 3'd1;
localparam DONE = 3'd2;
reg [2:0]state;
reg hps_read, hps_write;
//h_total : total - 1
//h_sync : sync - 1
//h_start : sync + back porch - 1 - 2(delay)
//h_end : h_start + active
//v_total : total - 1
//v_sync : sync - 1
//v_start : sync + back porch - 1
//v_end : v_start + active
// Signals 640x480 resolution
reg [11:0] h_total ; // Horizontal total
reg [11:0] h_sync ; // Horizontal sync
reg [11:0] h_start; // Horizontal front porch
reg [11:0] h_end ; // Horizontal back porch
reg [11:0] v_total ; // Vertical total
reg [11:0] v_sync; // Vertical sync
reg [11:0] v_start; // Vertical front porch
reg [11:0] v_end; // Vertical back porch
always @(posedge clk ) begin
    h_total <= 12'd799;
    h_sync <= 12'd95;
    h_start <= 12'd141;
    h_end <= 12'd781;
    v_total <= 12'd524 ;
    v_sync <= 12'd1; 
    v_start <= 12'd34;
    v_end <= 12'd514; 
end
framebuffer_dpram fb (
    .clk(clk),
    .rst(rst),
    .hps_read(hps_read),
    .hps_write(hps_write),
    .hdmi_pix_x(hdmi_pix_x),
    .hdmi_pix_y(hdmi_pix_y),
    .hps_pix_x(hps_pix_x),
    .hps_pix_y(hps_pix_y),
    .hdmi_rgb(hdmi_rgb),
    .hps_rrgb(hps_rrgb),
    .hps_wrgb(hps_wrgb)
);
hdmi_tx tx(                                    
    .clk(clk_hdmi),                
    .reset_n(!reset_hdmi),                                                
    .h_total(h_total),
    .h_sync(h_sync),
    .h_start(h_start),
    .h_end(h_end),
    .v_total(v_total),
    .v_sync(v_sync),
    .v_start(v_start),
    .v_end(v_end),
    .rgb_data(hdmi_rgb_24bits),
    .pix_x(hdmi_pix_x),
    .pix_y(hdmi_pix_y),
    .vga_hs(vga_hs),             
    .vga_vs(vga_vs),           
    .vga_de(vga_de),
    .vga_r(vga_r),
    .vga_g(vga_g),
    .vga_b(vga_b)                                                 
);

always @(posedge clk)
begin
    if(rst) begin
       
        state = IDLE;
    end
    else begin
       case(state)
            IDLE: begin
                if(avs_s0_write | avs_s0_read == 1)begin
                    state = WAIT;
                end
            end
            WAIT: begin
                state = DONE;
                
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
            hps_read = 0;
            hps_write = 0;
            avs_s0_waitrequest = 0;
            avs_s0_readdatavalid = 0;
        end
        WAIT: begin
            avs_s0_waitrequest = 1;
            if(avs_s0_read) begin
                hps_read = 1;
                rgb_data <= hps_rrgb;
            end
            else begin
                hps_write = 1;
            end

        end
        DONE: begin
            avs_s0_waitrequest = 0;
            if(avs_s0_read) begin
                avs_s0_readdatavalid = 1;
                
            end
            
        end
        default: begin
        end
    endcase
end

endmodule