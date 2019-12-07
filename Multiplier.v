module Multiplier(
input start,
input S1,
input S2,
input [3:0] F1,
input [3:0] F2,
input [2:0] E1,
input [2:0] E2,
output [7:0] F
);

reg S;	
reg [9:0] Fout;
reg [3:0] E;

initial 
begin
S<=0;
Fout<=0;
E<=0;
end



always @(start)
begin
if(start)
begin
Fout <= {1'b1,F2}*{1'b1,F1};
E <= E1+E2+3'b101;
S<=S1^S2;
end
else
begin
	if(Fout[9])
	begin
		Fout<={1'b0,Fout[9:1]};
 		E <= E+1;
	end
	 if(~Fout[9] && ~Fout[8])
	begin
		Fout<={Fout[8:0],1'b0};
 		E <= E-1;
	end
    
	
end
end
assign F = (E1 | E2 | F1  |F2 ) ?   {S,E[2:0],Fout[7:4]} : 8'h00;

endmodule