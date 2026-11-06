module dct_stage1_r(
  input clk,
  input rst,

  input signed [15:0]
  x1,x2,x3,x4,x5,x6,x7,
  x8,x9,x10,x11,x12,x13,x14,x15,

  input vin,

  output reg signed [19:0]
  r0,r1,r2,r3,r4,r5,r6,r7,
  r8,r9,r10,r11,r12,r13,

  output reg vout
);
always @(posedge clk) begin
if(rst) vout<=0;
else begin

vout<=vin;

r0  <= x4 + x8 + x12;
r1  <= x2 + x6 + x10 + x14;
r2  <= x1 + x7 + x9 + x15;
r3  <= x3 + x5 + x11 + x13;

r4  <= x1 - x15;
r5  <= x2 - x14;
r6  <= x3 - x13;
r7  <= x4 - x12;

r8  <= x5 - x11;
r9  <= x6 - x10;
r10 <= x7 - x9;

r11 <= x1 + x15 - x7 - x9;
r12 <= x2 + x14 - x6 - x10;
r13 <= x3 + x13 - x5 - x11;

end
end

endmodule