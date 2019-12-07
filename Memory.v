module Memory(CS, WE, CLK, ADDR, Mem_Bus); //SRAM model
  input CS; //Chip-select
  input WE; //Write Enabled
  input CLK; //clk
  input [6:0] ADDR;
  inout [31:0] Mem_Bus;

  reg [31:0] data_out;
  reg [31:0] RAM [0:127];
  integer i; 
 

  initial
  begin
    /* Write your Verilog-Text IO code here */
	for (i=0; i<128; i=i+1)
	begin
		RAM[i] = 32'd0;
	end
	$readmemh("C:/Users/rmita/Desktop/EE460M/Mital_Lab7/MIPS_Instructions.txt",RAM);
  end

  assign Mem_Bus = ((CS == 1'b0) || (WE == 1'b1)) ? 32'bZ : data_out; //tristate

  always @(negedge CLK)
  begin

    if((CS == 1'b1) && (WE == 1'b1))
      RAM[ADDR] <= Mem_Bus[31:0];// write 

    data_out <= RAM[ADDR]; // read 
  end
endmodule
