module dct_stage0_input(
  input  wire clk,
  input  wire rst,

  input  wire signed [15:0] xin,
  input  wire xin_valid,
  output wire xin_ready,

  output reg signed [15:0] x0,
  output reg signed [15:0] x1,
  output reg signed [15:0] x2,
  output reg signed [15:0] x3,
  output reg signed [15:0] x4,
  output reg signed [15:0] x5,
  output reg signed [15:0] x6,
  output reg signed [15:0] x7,
  output reg signed [15:0] x8,
  output reg signed [15:0] x9,
  output reg signed [15:0] x10,
  output reg signed [15:0] x11,
  output reg signed [15:0] x12,
  output reg signed [15:0] x13,
  output reg signed [15:0] x14,
  output reg signed [15:0] x15,
  output reg signed [15:0] x16,

  output reg vout
);

reg [4:0] in_cnt;

assign xin_ready = 1'b1;

//////////////////////////////////////////////////////////
// Input capture
//////////////////////////////////////////////////////////

always @(posedge clk) begin
  if (rst) begin

    in_cnt <= 0;
    vout <= 0;

    x0<=0;  x1<=0;  x2<=0;  x3<=0;
    x4<=0;  x5<=0;  x6<=0;  x7<=0;
    x8<=0;  x9<=0;  x10<=0; x11<=0;
    x12<=0; x13<=0; x14<=0; x15<=0;
    x16<=0;

  end 
  else begin

    vout <= 0;

    if (xin_valid) begin

      case (in_cnt)
        5'd0  : x0  <= xin;
        5'd1  : x1  <= xin;
        5'd2  : x2  <= xin;
        5'd3  : x3  <= xin;
        5'd4  : x4  <= xin;
        5'd5  : x5  <= xin;
        5'd6  : x6  <= xin;
        5'd7  : x7  <= xin;
        5'd8  : x8  <= xin;
        5'd9  : x9  <= xin;
        5'd10 : x10 <= xin;
        5'd11 : x11 <= xin;
        5'd12 : x12 <= xin;
        5'd13 : x13 <= xin;
        5'd14 : x14 <= xin;
        5'd15 : x15 <= xin;
        5'd16 : begin
                  x16 <= xin;
                  vout <= 1;  // one-cycle pulse
                end
      endcase

      if (in_cnt == 5'd16)
        in_cnt <= 0;
      else
        in_cnt <= in_cnt + 1;

    end

  end
end

endmodule