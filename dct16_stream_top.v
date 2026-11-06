`timescale 1ns/1ps

module dct16_stream_top (
  input  wire clk,
  input  wire rst,

  input  wire signed [15:0] xin,
  input  wire xin_valid,
  output wire xin_ready,

  output wire signed [15:0] yout,
  output wire yout_valid,
  input  wire yout_ready
);


////////////////////////////////////////////////////////////
// Stage interconnect signals
////////////////////////////////////////////////////////////

// x stage
wire signed [15:0]
x0,x1,x2,x3,x4,x5,x6,x7,
x8,x9,x10,x11,x12,x13,x14,x15,x16;

// r stage
wire signed [19:0]
r0,r1,r2,r3,r4,r5,r6,r7,
r8,r9,r10,r11,r12,r13;

// p stage
wire signed [31:0]
p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,
p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,
p20,p21,p22,p23,p24,p25,p26,p27,p28,p29,
p30,p31,p32,p33,p34;

// s stage
wire signed [31:0]
s1,s2,s3,s4,s5,s6,s7,
s8,s9,s10,s11,s12,s13;

// pipeline valid signals
wire v0,v1,v2,v3;



////////////////////////////////////////////////////////////
// Stage0 : Input Capture
////////////////////////////////////////////////////////////

dct_stage0_input stage0(
.clk(clk),
.rst(rst),

.xin(xin),
.xin_valid(xin_valid),
.xin_ready(xin_ready),

.x0(x0), .x1(x1), .x2(x2), .x3(x3),
.x4(x4), .x5(x5), .x6(x6), .x7(x7),
.x8(x8), .x9(x9), .x10(x10), .x11(x11),
.x12(x12), .x13(x13), .x14(x14), .x15(x15),
.x16(x16),

.vout(v0)
);

////////////////////////////////////////////////////////////
// Stage1 : r stage
////////////////////////////////////////////////////////////

dct_stage1_r stage1(
.clk(clk),
.rst(rst),

 .x1(x1), .x2(x2), .x3(x3),
.x4(x4), .x5(x5), .x6(x6), .x7(x7),
.x8(x8), .x9(x9), .x10(x10), .x11(x11),
.x12(x12), .x13(x13), .x14(x14), .x15(x15),


.vin(v0),

.r0(r0), .r1(r1), .r2(r2), .r3(r3),
.r4(r4), .r5(r5), .r6(r6), .r7(r7),
.r8(r8), .r9(r9), .r10(r10),
.r11(r11), .r12(r12), .r13(r13),

.vout(v1)
);

////////////////////////////////////////////////////////////
// Stage2 : p stage
////////////////////////////////////////////////////////////

dct_stage2_p stage2(
.clk(clk),
.rst(rst),

.x0(x0), .x4(x4), .x8(x8), .x12(x12), .x16(x16),

.r0(r0), .r1(r1), .r2(r2), .r3(r3),
.r4(r4), .r5(r5), .r6(r6), .r7(r7),
.r8(r8), .r9(r9), .r10(r10),
.r11(r11), .r12(r12), .r13(r13),

.vin(v1),

.p0(p0), .p1(p1), .p2(p2), .p3(p3),
.p4(p4), .p5(p5), .p6(p6), .p7(p7),
.p8(p8), .p9(p9), .p10(p10), .p11(p11),
.p12(p12), .p13(p13), .p14(p14), .p15(p15),
.p16(p16), .p17(p17), .p18(p18), .p19(p19),
.p20(p20), .p21(p21), .p22(p22), .p23(p23),
.p24(p24), .p25(p25), .p26(p26), .p27(p27),
.p28(p28), .p29(p29), .p30(p30), .p31(p31),
.p32(p32), .p33(p33), .p34(p34),

.vout(v2)
);

////////////////////////////////////////////////////////////
// Stage3 : s stage
////////////////////////////////////////////////////////////

dct_stage3_s stage3(
.clk(clk),
.rst(rst),

.vin(v2),

.p0(p0), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7),
.p8(p8), .p9(p9), .p10(p10), .p11(p11), .p12(p12),
.p13(p13), .p14(p14), .p15(p15), .p16(p16), .p17(p17),
.p18(p18), .p19(p19), .p20(p20), .p22(p22),
.p23(p23), .p24(p24), .p25(p25), .p26(p26), .p27(p27),
.p28(p28), .p29(p29), .p30(p30), .p31(p31), .p32(p32),
.p33(p33),

.s1(s1), .s2(s2), .s3(s3), .s4(s4), .s5(s5),
.s6(s6), .s7(s7), .s8(s8), .s9(s9),
.s10(s10), .s11(s11), .s12(s12), .s13(s13),

.vout(v3)
);

////////////////////////////////////////////////////////////
// Stage4 : Output stage
////////////////////////////////////////////////////////////

dct_stage4_y stage4(
.clk(clk),
.rst(rst),

.vin(v3),


.p0(p0), .p1(p1), .p2(p2), .p21(p21), .p34(p34),

.s1(s1), .s2(s2), .s3(s3), .s4(s4),
.s5(s5), .s6(s6), .s7(s7), .s8(s8),
.s9(s9), .s10(s10), .s11(s11),
.s12(s12), .s13(s13),

.yout(yout),
.yout_valid(yout_valid),
.yout_ready(yout_ready)
);

endmodule