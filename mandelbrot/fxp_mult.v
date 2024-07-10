module fxp_mult #(parameter WIDTH = 27, parameter FBITS = 23) (
    input wire signed [WIDTH - 1:0] rhs,
    input wire signed [WIDTH - 1:0] lhs,
    output wire signed [WIDTH - 1:0] res
);
wire [WIDTH * 2 - 1:0] temp;
assign temp = rhs * lhs;
assign res = {rhs[WIDTH - 1] ^lhs[WIDTH - 1],temp[(WIDTH + FBITS - 2) :FBITS]};

endmodule