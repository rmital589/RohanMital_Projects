module Clkdivider (clk100Mhz, slowClk);
  input clk100Mhz; //fast clock
  output  slowClk; //slow clock
  reg Clk;

  reg[27:0] counter;

  initial begin
    counter <= 0;
    Clk <=0;
  end

  always @ (posedge clk100Mhz)
  begin
    if(counter == 500000) begin
      counter <= 1;
      Clk <= ~Clk;
    end
    else begin
      counter <= counter + 1;
    end
  end

assign slowClk = Clk;

endmodule


