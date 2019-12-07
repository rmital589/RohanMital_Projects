module Complete_MIPS(CLK, rst, SW0,SW1,SW2,btnL,btnR,sev_seg,an,dp);
  // Will need to be modified to add functionality
  input CLK;
  input rst;
  input SW0,SW1,SW2,btnL,btnR;
  output [6:0] sev_seg;
  output [3:0] an;
  output dp;
  wire [15:0] readreg;
  wire CS, WE;
  wire [6:0] ADDR;
  wire [31:0] Mem_Bus;
  wire slow_clk_240Hz;

  MIPS CPU(SW0,SW1,SW2,btnL,btnR, CLK, rst, CS, WE, ADDR, Mem_Bus,readreg);
  Memory MEM(CS, WE, CLK, ADDR, Mem_Bus);
  ClkDivider #(19, 416666) C0(CLK, slow_clk_240Hz);
  FourDigitOut FDO(readreg[3:0], readreg[7:4], readreg[11:8], readreg[15:12], 2'b00, slow_clk_240Hz, sev_seg, an, dp);

endmodule
