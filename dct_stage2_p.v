module dct_stage2_p(
    input clk,
    input rst,
    input vin,

    input signed [15:0] x0,x4,x8,x12,x16,
    input signed [19:0] r0,r1,r2,r3,r4,r5,r6,r7,
    input signed [19:0] r8,r9,r10,r11,r12,r13,

    output reg signed [31:0] p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,
                             p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,
                             p20,p21,p22,p23,p24,p25,p26,p27,p28,p29,
                             p30,p31,p32,p33,p34,
    output reg vout
);

//////////////////////////////////////////////////////////
// PIPELINE STAGE A (OPTIMIZED WIDTHS)
//////////////////////////////////////////////////////////

// x-domain
reg signed [16:0] t0;        // x0 + x16
reg signed [15:0] t10;       // x8
reg signed [17:0] t20;       // -x4 + x8 - x12

// r-domain
reg signed [20:0] t1,t2,t21,t34;
reg signed [19:0] t3,t4,t5,t6,t7,t8,t9;
reg signed [19:0] t11,t12,t13,t14,t15,t16,t17,t18,t19;
reg signed [19:0] t22,t23,t24,t25,t26,t27,t28,t29;
reg signed [19:0] t30,t31,t32,t33;

reg v1;

always @(posedge clk) begin
    if(rst) begin
        v1 <= 0;
    end else begin
        v1 <= vin;

        // x-domain
        t0  <= x0 + x16;
        t10 <= x8;
        t20 <= -x4 + x8 - x12;

        // r-domain
        t1  <= r0 + r1;
        t2  <= r2 + r3;
        t3  <= r4;
        t4  <= r5;
        t5  <= r6;
        t6  <= r7;
        t7  <= r8;
        t8  <= r9;
        t9  <= r10;
        t11 <= r11;
        t12 <= r12;
        t13 <= r13;
        t14 <= r4;
        t15 <= r5;
        t16 <= r6;
        t17 <= r8;
        t18 <= r9;
        t19 <= r10;

        t21 <= r2 - r3;
        t22 <= r4;
        t23 <= r5;
        t24 <= r6;
        t25 <= r8;
        t26 <= r9;
        t27 <= r10;
        t28 <= r11;
        t29 <= -r13;
        t30 <= r4;
        t31 <= r6;
        t32 <= r8;
        t33 <= r10;
        t34 <= r0 - r1;
    end
end

//////////////////////////////////////////////////////////
// MCM FUNCTIONS (UNCHANGED)
//////////////////////////////////////////////////////////

function signed [31:0] mcm_c1; input signed [31:0] a;
    mcm_c1 = ((a<<<13)+(a<<<11)+(a<<<10)+(a<<<8)+(a<<<6)+16384)>>>15;
endfunction

function signed [31:0] mcm_c3; input signed [31:0] a;
    mcm_c3 = ((a<<<12)+(a<<<10)+(a<<<9)+(a<<<7)+(a<<<4)+(a<<<3)+16384)>>>15;
endfunction

function signed [31:0] mcm_c4; input signed [31:0] a;
    mcm_c4 = ((a<<<13)+(a<<<11)+(a<<<10)+(a<<<6)+(a<<<5)+16384)>>>15;
endfunction

function signed [31:0] mcm_c5; input signed [31:0] a;
    mcm_c5 = ((a<<<13)+(a<<<11)+(a<<<8)+(a<<<7)+(a<<<6)+(a<<<4)+16384)>>>15;
endfunction

function signed [31:0] mcm_c6; input signed [31:0] a;
    mcm_c6 = ((a<<<13)+(a<<<10)+(a<<<8)+(a<<<7)+(a<<<5)+16384)>>>15;
endfunction

function signed [31:0] mcm_c7; input signed [31:0] a;
    mcm_c7 = ((a<<<13)+16384)>>>15;
endfunction

function signed [31:0] mcm_c8; input signed [31:0] a;
    mcm_c8 = ((a<<<12)+(a<<<11)+(a<<<8)+(a<<<5)+(a<<<3)+16384)>>>15;
endfunction

function signed [31:0] mcm_c9; input signed [31:0] a;
    mcm_c9 = ((a<<<12)+(a<<<8)+(a<<<6)+(a<<<4)+16384)>>>15;
endfunction

function signed [31:0] mcm_c10; input signed [31:0] a;
    mcm_c10 = ((a<<<11)+(a<<<7)+(a<<<6)+(a<<<4)+16384)>>>15;
endfunction

//////////////////////////////////////////////////////////
// HELPER: SIGN EXTENSION TO 32-BIT
//////////////////////////////////////////////////////////

function signed [31:0] sx;
    input signed [31:0] in;
    sx = in;
endfunction

//////////////////////////////////////////////////////////
// PIPELINE STAGE B (WITH EXPLICIT EXTENSION)
//////////////////////////////////////////////////////////

always @(posedge clk) begin
    if(rst) begin
        vout <= 0;
    end else begin
        vout <= v1;

        p0  <= mcm_c3({{15{t0[16]}}, t0});
        p1  <= {{11{t1[20]}}, t1};
        p2  <= {{11{t2[20]}}, t2};
        p3  <= mcm_c4({{12{t3[19]}}, t3});
        p4  <= mcm_c5({{12{t4[19]}}, t4});
        p5  <= mcm_c6({{12{t5[19]}}, t5});
        p6  <= mcm_c7({{12{t6[19]}}, t6});
        p7  <= mcm_c8({{12{t7[19]}}, t7});
        p8  <= mcm_c9({{12{t8[19]}}, t8});
        p9  <= mcm_c10({{12{t9[19]}}, t9});

        p10 <= mcm_c1({{16{t10[15]}}, t10});
        p11 <= mcm_c5({{12{t11[19]}}, t11});
        p12 <= mcm_c7({{12{t12[19]}}, t12});
        p13 <= mcm_c9({{12{t13[19]}}, t13});

        p14 <= mcm_c6({{12{t14[19]}}, t14});
        p15 <= mcm_c9({{12{t15[19]}}, t15});
        p16 <= mcm_c10({{12{t16[19]}}, t16});
        p17 <= mcm_c4({{12{t17[19]}}, t17});
        p18 <= mcm_c5({{12{t18[19]}}, t18});
        p19 <= mcm_c8({{12{t19[19]}}, t19});

        p20 <= mcm_c1({{14{t20[17]}}, t20});
        p21 <= mcm_c7({{11{t21[20]}}, t21});
        p22 <= mcm_c8({{12{t22[19]}}, t22});
        p23 <= mcm_c9({{12{t23[19]}}, t23});
        p24 <= mcm_c4({{12{t24[19]}}, t24});
        p25 <= mcm_c10({{12{t25[19]}}, t25});
        p26 <= mcm_c5({{12{t26[19]}}, t26});
        p27 <= mcm_c6({{12{t27[19]}}, t27});
        p28 <= mcm_c9({{12{t28[19]}}, t28});
        p29 <= mcm_c5({{12{t29[19]}}, t29});

        p30 <= mcm_c10({{12{t30[19]}}, t30});
        p31 <= mcm_c8({{12{t31[19]}}, t31});
        p32 <= mcm_c6({{12{t32[19]}}, t32});
        p33 <= mcm_c4({{12{t33[19]}}, t33});

        p34 <= {{11{t34[20]}}, t34};
    end
end

endmodule