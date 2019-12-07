module REG(CLK, HLT, RegW, DR, SR1, SR2, Reg_In, ReadReg1, ReadReg2);
  input CLK,HLT;
  input RegW;
  input [4:0] DR; //Destination Register
  input [4:0] SR1; //Source Register1
  input [4:0] SR2; //Source Register2
  input [31:0] Reg_In; //Instruction
  output reg [31:0] ReadReg1; //Data from SR1
  output reg [31:0] ReadReg2; //Data from SR2

  reg [31:0] REG [0:31];
  integer i;

  initial begin
    ReadReg1 = 0;
    ReadReg2 = 0;
    for(i=0;i<32;i=i+1) begin
 	REG[i]=0;
    end
  end

  always @(posedge CLK)
  begin

    if(RegW == 1'b1)
      REG[DR] <= Reg_In[31:0];
    if(HLT)
	ReadReg1<=REG[5'd1];
    ReadReg1 <= REG[SR1];
    ReadReg2 <= REG[SR2];
  end
endmodule

