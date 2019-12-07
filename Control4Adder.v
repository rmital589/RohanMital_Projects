module Control4Adder(
input reset1,
input reset2,
input buttonU,
input buttonL,
input buttonR,
input buttonD,
input [15:0] Y,
output [15:0] adder_out,
output [3:0]Cout
);

wire [15:0]X;
wire [15:0]Z;
reg [15:0] X1;
reg [15:0] Z1;
initial 
begin
X1<=0;
Z1<=0; 
end

always @(*)
begin 
		case({buttonU,buttonL,buttonR,buttonD})
		4'b1000: X1<=16'h10;
		4'b0100: X1<=16'h180;
		4'b0010: X1<=16'h200;
		4'b0001: X1<=16'h550;
		default: X1<=0;
		endcase
	
end

assign X = X1;
assign adder_out = (~reset1 && ~reset2) ?  Z : Z1;
BCD_Adder_16 B5 (X, Y, Z, Cout);

always @(*)
begin 
	case({reset1,reset2})
        2'b10: Z1<=16'h10;
	2'b01: Z1<=16'h205;
	default:Z1<=0;
	endcase
		
end 

endmodule
