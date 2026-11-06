module dct_stage3_s(
    input clk,
    input rst,
    input vin,

    input signed [31:0] p0,p3,p4,p5,p6,p7,p8,p9,
                         p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,
                         p20,p22,p23,p24,p25,p26,p27,p28,p29,
                         p30,p31,p32,p33,

    output reg signed [31:0] s1,s2,s3,s4,s5,s6,s7,
                              s8,s9,s10,s11,s12,s13,
    output reg vout
);

reg signed [31:0] s1_a,s1_b,s2_a,s2_b,s3_a;
reg signed [31:0] s5_a,s5_b,s6_a,s6_b,s8_a,s8_b,s9_a,s9_b;
reg signed [31:0] s10_a,s12_a,s12_b,s13_a,s13_b;
reg v2;

always @(posedge clk) begin
    if(rst) begin
        s1<=0; s2<=0; s3<=0; s4<=0; s5<=0; s6<=0; s7<=0;
        s8<=0; s9<=0; s10<=0; s11<=0; s12<=0; s13<=0;
        vout<=0;
        v2<=0;
    end else begin
        v2 <= vin;

        // Level 1
        s1_a <= p0+p4; s1_b <= p6+p8;
        s2_a <= p3+p5; s2_b <= p7+p9;
        s3_a <= p0+p12;
        s5_a <= p0+p15; s5_b <= -p6-p18;
        s6_a <= p14-p16; s6_b <= -p17-p19;
        s8_a <= p0-p23; s8_b <= -p6+p26;
        s9_a <= p22-p24; s9_b <= p25+p27;
        s10_a <= p0-p12;
        s12_a <= p0-p4; s12_b <= p6-p8;
        s13_a <= p30-p31; s13_b <= p32-p33;

        // Level 2
        s1 <= s1_a+s1_b;
        s2 <= s2_a+s2_b;
        s3 <= s3_a-p10;
        s4 <= p11+p13;
        s5 <= s5_a+s5_b;
        s6 <= s6_a+s6_b;
        s7 <= p0+p20;
        s8 <= s8_a+s8_b;
        s9 <= s9_a+s9_b;
        s10 <= s10_a-p10;
        s11 <= p28+p29;
        s12 <= s12_a+s12_b;
        s13 <= s13_a+s13_b;

        vout <= v2;
    end
end

endmodule