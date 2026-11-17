`timescale 1ns/1ps

module fct_stage4_y(
input clk,
input rst,

input vin,

input signed [31:0] p0,p1,p2,p21,p34,

input signed [31:0]
s1,s2,s3,s4,s5,s6,s7,
s8,s9,s10,s11,s12,s13,

output reg signed [15:0] yout,
output reg yout_valid,
input yout_ready
);

//////////////////////////////////////////////////////
// Q15 multiplier
//////////////////////////////////////////////////////

function signed [31:0] q15_mult;
input signed [31:0] a;
input signed [15:0] b;
reg signed [47:0] temp;
begin
    temp = a * b;
    q15_mult = temp >>> 15;
end
endfunction

localparam signed [15:0] C1 = 16'sd11584;

//////////////////////////////////////////////////////
// Output storage
//////////////////////////////////////////////////////

reg signed [31:0] y_pipe [0:16];
reg [4:0] out_cnt;

//////////////////////////////////////////////////////
// Dummy usage to remove unused-bit warnings
//////////////////////////////////////////////////////
wire _unused_inputs;
assign _unused_inputs = |{p0, p1, p2, p21, p34,
                         s1,s2,s3,s4,s5,s6,s7,
                         s8,s9,s10,s11,s12,s13};

//////////////////////////////////////////////////////
// Compute outputs
//////////////////////////////////////////////////////

always @(posedge clk) begin
    if(rst) begin
        yout_valid <= 0;
    end
    else if(vin) begin

        yout_valid <= 1;

        y_pipe[0]  <= p0 + q15_mult(p1+p2,C1);
        y_pipe[1]  <= s1+s2;
        y_pipe[2]  <= s3+s4;
        y_pipe[3]  <= s5+s6;
        y_pipe[4]  <= s7+p21;
        y_pipe[5]  <= s8+s9;
        y_pipe[6]  <= s10+s11;
        y_pipe[7]  <= s12+s13;
        y_pipe[8]  <= p0 + q15_mult(p34,C1);
        y_pipe[9]  <= s12-s13;
        y_pipe[10] <= s10-s11;
        y_pipe[11] <= s8-s9;
        y_pipe[12] <= s7-p21;
        y_pipe[13] <= s5-s6;
        y_pipe[14] <= s3-s4;
        y_pipe[15] <= s1-s2;
        y_pipe[16] <= p0 + q15_mult(p1-p2,C1);

    end
end

//////////////////////////////////////////////////////
// Output streaming
//////////////////////////////////////////////////////

always @(posedge clk) begin
    if(rst) begin
        out_cnt <= 0;
        yout <= 0;
    end
    else if(yout_valid && yout_ready) begin

        yout <= y_pipe[out_cnt][15:0];

        if(out_cnt == 16)
            out_cnt <= 0;
        else
            out_cnt <= out_cnt + 1;

    end
end

endmodule