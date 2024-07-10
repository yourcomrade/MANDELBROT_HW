module framebuffer_dpram #(
    parameter WIDTH = 8,
    parameter ver_x = 640,
    parameter hor_y = 480
)(
    input wire clk,
    input wire rst,

    input wire hps_read,
    input wire hps_write,
   
    input wire [9:0]hdmi_pix_x,
    input wire [9:0]hdmi_pix_y,

    input wire [9:0] hps_pix_x,
    input wire [9:0] hps_pix_y,
    output wire [WIDTH - 1:0] hdmi_rgb,
    output wire [WIDTH - 1:0] hps_rrgb, //read rgb for hps
    input wire [WIDTH - 1:0] hps_wrgb //write rgb for hps
);
reg [WIDTH - 1:0]rgb_data;
reg [18:0] raddr, waddr; //address for reading, address for writing
wire [WIDTH - 1:0]hdmi_rgb_256k, hdmi_rgb_64k, hps_rrgb_256k, hps_rrgb_64k;
reg we_r = 0; //write enable to 0 to always read
reg we_w;
wire we_w64k, we_w256k;

reg [9:0] api_x, api_y; //pixel x and y coordinate from avalon bus
dpram #(.DATA_WIDTH(8), .ADDR_WIDTH(18)) mem_256k  (
    .clk(clk),
    .wdata_a(rgb_data),
    .addr_a(waddr[18 - 1:0]),
    .addr_b(raddr[18 - 1:0]),
    .we_a(we_w256k),
    .we_b(we_r),
    .rdata_a(hps_rrgb_256k),
    .rdata_b(hdmi_rgb_256k)
);
dpram #(.DATA_WIDTH(8), .ADDR_WIDTH(16)) mem_64k  (
    .clk(clk),
    .wdata_a(rgb_data),
    .addr_a(waddr[16 - 1:0]),
    .addr_b(raddr[16 - 1:0]),
    .we_a(we_w64k),
    .we_b(we_r),
    .rdata_a(hps_rrgb_64k),
    .rdata_b(hdmi_rgb_64k)
);

assign hps_rrgb = (raddr[18]) ? hps_rrgb_64k: hps_rrgb_256k;
assign hdmi_rgb = (raddr[18]) ? hdmi_rgb_64k : hdmi_rgb_256k;
assign we_w256k = we_w  & (~waddr[18]);
assign we_w64k = we_w & waddr[18];


always @(posedge clk) begin
    if(rst) begin
        raddr <= 0;
        waddr <= 0;
    end
    else begin
        raddr <= (hor_y * hdmi_pix_y) + hdmi_pix_x;
        waddr <= (hor_y * api_y) + api_x;
    end
end
always @(posedge clk ) begin
    if(rst)begin
        api_x <= 0;
        api_y <= 0;
    end
    else begin
        api_x <= hps_pix_x[9:0];
        api_y <= hps_pix_y[9:0];
    end
end

always @(posedge clk ) begin
    if(rst) begin
        rgb_data <= 0;
    end
    else begin
        if(hps_write ) begin
            rgb_data <= hps_wrgb;
            we_w <= 1;
        end
        else begin
            we_w <= 0;
        end
    end
end

endmodule