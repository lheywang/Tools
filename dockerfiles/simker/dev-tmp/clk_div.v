




module clk_div
  (input  clk,
   input  rstn,
   output clk2);
  reg [31:0] count;
  reg tmp;
  wire n5;
  wire [31:0] n8;
  wire n10;
  wire n11;
  wire [31:0] n13;
  reg [31:0] n22;
  wire n23;
  reg n24;
  assign clk2 = tmp; //(module output)
  /* clk_div.vhd:12:8  */
  always @*
    count = n22; // (isignal)
  initial
    count = 32'b00000000000000000000000000000001;
  /* clk_div.vhd:13:8  */
  always @*
    tmp = n24; // (isignal)
  initial
    tmp = 1'b0;
  /* clk_div.vhd:19:8  */
  assign n5 = ~rstn;
  /* clk_div.vhd:23:14  */
  assign n8 = count + 32'b00000000000000000000000000000001;
  /* clk_div.vhd:24:11  */
  assign n10 = count == 32'b00000000000000000000000000000010;
  /* clk_div.vhd:25:8  */
  assign n11 = ~tmp;
  /* clk_div.vhd:24:1  */
  assign n13 = n10 ? 32'b00000000000000000000000000000001 : n8;
  /* clk_div.vhd:22:1  */
  always @(posedge clk or posedge n5)
    if (n5)
      n22 <= 32'b00000000000000000000000000000001;
    else
      n22 <= n13;
  /* clk_div.vhd:22:1  */
  assign n23 = n10 ? n11 : tmp;
  /* clk_div.vhd:22:1  */
  always @(posedge clk or posedge n5)
    if (n5)
      n24 <= 1'b0;
    else
      n24 <= n23;
endmodule

