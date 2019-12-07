`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2019 10:29:44 PM
// Design Name: 
// Module Name: SynchSinglePulse
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SynchSinglePulse(
    input buttonIn,
    input button_clk,
    output reg stableButton = 1'b0
    );
    
    reg synch0 = 1'b0, synch1 = 1'b0;
    
    always@(posedge button_clk) begin
        //double synchronizer circuit
        synch0 <= buttonIn;
        synch1 <= synch0;
        //single pulse state machine
        case(stableButton)
            1'b0: stableButton <= (synch1) ? 1'b1 : 1'b0;
            1'b1: stableButton <= (synch1) ? 1'b1 : 1'b0;
        endcase
    end
    
    
    
endmodule
