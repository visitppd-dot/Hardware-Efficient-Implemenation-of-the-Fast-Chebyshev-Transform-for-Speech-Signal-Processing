`timescale 1ns/1ps

module tb_fct16_stream;

  reg clk;
  reg rst;

  reg  signed [15:0] xin;
  reg  xin_valid;
  wire xin_ready;

  wire signed [15:0] yout;
  wire yout_valid;
  reg  yout_ready;

  // ==========================================================
  // DUT
  // ==========================================================
  fct16_stream_top dut (
    .clk(clk),
    .rst(rst),
    .xin(xin),
    .xin_valid(xin_valid),
    .xin_ready(xin_ready),
    .yout(yout),
    .yout_valid(yout_valid),
    .yout_ready(yout_ready)
  );

  // ==========================================================
  // CLOCK
  // ==========================================================
  initial clk = 0;
  always #5 clk = ~clk;

  // ==========================================================
  // INPUT DATA (Q1.15 scaled)
  // ==========================================================
  reg signed [15:0] fct_in [0:16];
  integer in_idx;
  integer out_idx;

  initial begin
    // Q1.15 scaling for integers 1..18
  fct_in[0]=-844;   fct_in[1]=-672;   fct_in[2]=-358;   fct_in[3]=-65;
  fct_in[4]=168;   fct_in[5]=542;  fct_in[6]=1102;  fct_in[7]=1463;
  fct_in[8]=1576;   fct_in[9]=1724;   fct_in[10]=1866; fct_in[11]=1810;
  fct_in[12]=1582; fct_in[13]=1217; fct_in[14]=820;
  fct_in[15]=450; fct_in[16]=-47;
  end



  // ==========================================================
  // RESET
  // ==========================================================
  initial begin
    rst = 1;
    xin = 0;
    xin_valid = 0;
    yout_ready = 1;

    in_idx = 0;
    out_idx = 0;

    #40;
    rst = 0;
  end

  // ==========================================================
  // INPUT STREAM (ready/valid)
  // ==========================================================
  always @(posedge clk) begin
    if (rst) begin
      xin_valid <= 0;
      in_idx <= 0;
    end else begin
      if (xin_ready && in_idx < 17) begin
        xin       <= dct_in[in_idx];
        xin_valid <= 1;
        $display("[%0t] INPUT  x[%0d] = %0d", $time, in_idx, dct_in[in_idx]);
        in_idx <= in_idx + 1;
      end else begin
        xin_valid <= 0;
      end
    end
  end

  // ==========================================================
  // OUTPUT MONITOR
  // ==========================================================
  
  always @(posedge clk) begin

    // ================= Stage0 =================
    if(dut.v0) begin
        $display("Stage0 Inputs:");
        $display("x0=%0d x1=%0d x2=%0d x3=%0d x4=%0d x5=%0d x6=%0d x7=%0d",
                  dut.x0,dut.x1,dut.x2,dut.x3,dut.x4,dut.x5,dut.x6,dut.x7);
        $display("x8=%0d x9=%0d x10=%0d x11=%0d x12=%0d x13=%0d x14=%0d x15=%0d x16=%0d",
                  dut.x8,dut.x9,dut.x10,dut.x11,dut.x12,dut.x13,dut.x14,dut.x15,dut.x16);
    end

    // ================= Stage1 =================
    if(dut.v1) begin
        $display("Stage1:");
        $display("r0=%0d r1=%0d r2=%0d r3=%0d", dut.r0,dut.r1,dut.r2,dut.r3);
        $display("r4=%0d r5=%0d r6=%0d r7=%0d", dut.r4,dut.r5,dut.r6,dut.r7);
        $display("r8=%0d r9=%0d r10=%0d", dut.r8,dut.r9,dut.r10);
        $display("r11=%0d r12=%0d r13=%0d", dut.r11,dut.r12,dut.r13);
    end

    // ================= Stage2 =================
    if(dut.v2) begin
        $display("Stage2:");
        
        $display("p0=%0d p1=%0d p2=%0d p3=%0d p4=%0d p5=%0d p6=%0d p7=%0d",
                 dut.p0,dut.p1,dut.p2,dut.p3,dut.p4,dut.p5,dut.p6,dut.p7);

        $display("p8=%0d p9=%0d p10=%0d p11=%0d p12=%0d p13=%0d p14=%0d p15=%0d",
                 dut.p8,dut.p9,dut.p10,dut.p11,dut.p12,dut.p13,dut.p14,dut.p15);

        $display("p16=%0d p17=%0d p18=%0d p19=%0d p20=%0d p21=%0d p22=%0d p23=%0d",
                 dut.p16,dut.p17,dut.p18,dut.p19,dut.p20,dut.p21,dut.p22,dut.p23);

        $display("p24=%0d p25=%0d p26=%0d p27=%0d p28=%0d p29=%0d p30=%0d p31=%0d",
                 dut.p24,dut.p25,dut.p26,dut.p27,dut.p28,dut.p29,dut.p30,dut.p31);

        $display("p32=%0d p33=%0d p34=%0d",
                 dut.p32,dut.p33,dut.p34);
    end

    // ================= Stage3 =================
    if(dut.v3) begin
        $display("Stage3:");
        $display("s1=%0d s2=%0d s3=%0d s4=%0d s5=%0d s6=%0d s7=%0d",
                 dut.s1,dut.s2,dut.s3,dut.s4,dut.s5,dut.s6,dut.s7);

        $display("s8=%0d s9=%0d s10=%0d s11=%0d s12=%0d s13=%0d",
                 dut.s8,dut.s9,dut.s10,dut.s11,dut.s12,dut.s13);
    end

end
 always @(posedge clk) begin
  if (rst) begin
    out_idx <= 0;
  end
  else if (yout_valid && yout_ready) begin
    $display("[%0t] OUTPUT y[%0d] = %0d", $time, out_idx, yout);
    out_idx <= out_idx + 1;

    if (out_idx == 17) begin
      $display("------ FCT FRAME COMPLETE ------");
      #40;
      $finish;
    end
  end
end

endmodule