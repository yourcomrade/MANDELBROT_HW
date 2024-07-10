module hdmi_tx(                                    
  input						clk,                
  input						reset_n,                                                
  input			[11:0]	h_total,           
  input			[11:0]	h_sync,           
  input			[11:0]	h_start, // horizontal front porch          
  input			[11:0]	h_end,  // horizontal back porch                                                
  input			[11:0]	v_total,           
  input			[11:0]	v_sync,            
  input			[11:0]	v_start, // vertical front porch           
  input			[11:0]	v_end, // vertival Back Porch
  input         [23:0] rgb_data,
  output    wire [9:0]   pix_x,
  output    wire [9:0]   pix_y,
  
  output	reg				vga_hs,             
  output	reg				vga_vs,           
  output	reg				vga_de,
  output	reg	[7:0]		vga_r,
  output	reg	[7:0]		vga_g,
  output	reg	[7:0]		vga_b                                                 
);

//=======================================================
//  Signal declarations
//=======================================================
reg	[11:0]	h_count;
reg	[9:0]		pixel_x, pixel_y;

reg	[11:0]	v_count;
reg				h_act; 
reg				h_act_d;
reg				v_act; 
reg				v_act_d; 
reg				pre_vga_de;
wire				h_max, hs_end, hr_start, hr_end;
wire				v_max, vs_end, vr_start, vr_end;
reg				boarder;
reg	[3:0]		color_mode;

//=======================================================
//  Structural coding
//=======================================================
assign h_max = h_count == h_total;
assign hs_end = h_count >= h_sync;
assign hr_start = h_count == h_start; 
assign hr_end = h_count == h_end;
assign v_max = v_count == v_total;
assign vs_end = v_count >= v_sync;
assign vr_start = v_count == v_start; 
assign vr_end = v_count == v_end;
assign pix_x = pixel_x;
assign pix_y = pixel_y;
//horizontal control signals
always @ (posedge clk or negedge reset_n)
	if (!reset_n)
	begin
		h_act_d	<=	1'b0;
		h_count	<=	12'b0;
		pixel_x	<=	0;
		
		vga_hs	<=	1'b1;
		h_act		<=	1'b0;
	end
	else
	begin
		h_act_d	<=	h_act;

		if (h_max)
			h_count	<=	12'b0;
		else
			h_count	<=	h_count + 12'b1;

		if (h_act_d)
			pixel_x	<=	pixel_x + 1'b1;
		else
			pixel_x	<=	0;

		if (hs_end && !h_max)
			vga_hs	<=	1'b1;
		else
			vga_hs	<=	1'b0;

		if (hr_start)
			h_act		<=	1'b1;
		else if (hr_end)
			h_act		<=	1'b0;
	end

//vertical control signals
always@(posedge clk or negedge reset_n)
	if(!reset_n)
	begin
		v_act_d		<=	1'b0;
		v_count		<=	12'b0;
		vga_vs		<=	1'b1;
		v_act			<=	1'b0;
		color_mode	<=	4'b0;
		pixel_y <= 0;
	end
	else 
	begin		
		if (h_max)
		begin		  
			v_act_d	  <=	v_act;
		  
			if (v_max)
				v_count	<=	12'b0;
			else
				v_count	<=	v_count + 12'b1;

			if (vs_end && !v_max)
				vga_vs	<=	1'b1;
			else
				vga_vs	<=	1'b0;
			
			if(v_act_d) begin
				pixel_y <= pixel_y + 1'b1;
			end
			else
				pixel_y <= 0;

			if (vr_start)
				v_act <=	1'b1;
			else if (vr_end)
				v_act <=	1'b0;

		end
	end

//pattern generator and display enable
always @(posedge clk or negedge reset_n)
begin
	if (!reset_n)
	begin
		vga_de		<=	1'b0;
		pre_vga_de	<=	1'b0;
		boarder		<=	1'b0;		
	end
	else
	begin
		vga_de		<=	pre_vga_de;
		pre_vga_de	<=	v_act && h_act;
    
		if ((!h_act_d&&h_act) || hr_end || (!v_act_d&&v_act) || vr_end)
			boarder	<=	1'b1;
		else
			boarder	<=	1'b0;   		
		
		if (boarder)
			{vga_r, vga_g, vga_b} <= {8'hFF,8'hFF,8'hFF};
		else begin
			{vga_r, vga_g, vga_b} <= rgb_data;
		end	
			
	end
end	

endmodule