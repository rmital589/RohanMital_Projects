`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2019 10:39:29 PM
// Design Name: 
// Module Name: DisplayModule
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


module DisplayModule(
    input clk,
    input buttonU,
    input buttonL,
    input buttonR,
    input buttonD,
    input sw0,
    input sw1,
    output [3:0] an,
    output [6:0] sev_seg,
    output dp
    );
    
    reg BCDEnable = 1'b0;
    reg flashState = 1'b0;
    reg [6:0] sevSeg2Hz = 0 , sevSeg1Hz = 0;
    
    wire clk10Hz, clk1Hz, clk0_5Hz, clk240Hz;
    wire stableButtonU, stableButtonL, stableButtonR, stableButtonD;
    wire loadBCD, CO, sevSegOut;
    wire [15:0] newBCD, parkingTime;
    wire [3:0] Cout;
    
    ClkDivider #(24, 10000000) c0 (clk, clk10Hz);
    ClkDivider #(27, 100000000) c1 (clk, clk1Hz);
    ClkDivider #(16, 41666) c2 (clk, clk240Hz);
    ClkDivider #(28, 200000000) c3 (clk, clk0_5Hz);
    
    SynchSinglePulse ssp0(buttonU, clk10Hz, stableButtonU);
    SynchSinglePulse ssp1(buttonL, clk10Hz, stableButtonL);
    SynchSinglePulse ssp2(buttonR, clk10Hz, stableButtonR);
    SynchSinglePulse ssp3(buttonD, clk10Hz, stableButtonD);
    
    assign loadBCD = stableButtonU | stableButtonL | stableButtonR |stableButtonD | sw0 | sw1;
    
    FourDigBCD Dig1 (1'b0, clk1Hz, BCDEnable, loadBCD, 1'b0, newBCD, parkingTime, CO);
    Control4Adder Dig2 (sw0, sw1, stableButtonU, stableButtonL, stableButtonR, stableButtonD, parkingTime, newBCD, Cout);
    
    FourDigitOut Dig3 (parkingTime[3:0], parkingTime[7:4], parkingTime[11:8], parkingTime[15:12], 2'b00, clk240Hz, sevSegOut, an, dp);
    
    always@(loadBCD, CO, parkingTime) begin
        if((parkingTime > 0) && (parkingTime < 16'h9999))
            BCDEnable <= 1'b1;
        else
            BCDEnable <= 1'b0 | loadBCD;
    end
    
    always@(negedge clk1Hz) begin
        if(parkingTime <= 16'h0200)
            sevSeg2Hz <= (parkingTime[0]) ? 7'hFF : sevSegOut;
        else
            sevSeg2Hz <= sevSegOut;
    end
    
    always@(negedge clk0_5Hz) begin
        if(parkingTime == 0)
            sevSeg1Hz <= (sevSeg1Hz == 7'hFF) ? sevSegOut : 7'hFF;
        else
            sevSeg1Hz <= sevSegOut;
    end
    
    assign sev_seg = (parkingTime <= 16'h0200) ? ((parkingTime > 0) ? sevSeg2Hz : sevSeg1Hz) : sevSegOut;
    
    
    
    
endmodule
