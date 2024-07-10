module fxp_add #(parameter WIDTH = 27) (
    input wire signed [WIDTH - 1:0] rhs,
    input wire signed [WIDTH - 1:0] lhs,
    output wire signed [WIDTH - 1:0] res
);
assign res = rhs + lhs;
endmodule