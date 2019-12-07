
module SysArr3x3 (
        input clk,
        input [71:0] A,
        input [71:0] B,
        input start,
        output reg valid = 0,
        output [71:0] C
    );
    
	reg  [71:0] fp1 = 0, fp2 = 0;
	reg  [8:0] PE_Start = 0, PE_Reset = 0;
    
    //reg [47:0] queueA0 = 0, queueA1 = 0, queueA2 = 0, queueB0 = 0, queueB1 = 0, queueB2 = 0;
    wire [47:0] queueA0, queueA1, queueA2, queueB0, queueB1, queueB2;
    
    assign queueA0 = {8'h00, 8'h00, 8'h00, A[23:16], A[15:8], A[7:0]};
    assign queueA1 = {8'h00, 8'h00, A[47:40], A[39:32], A[31:24], 8'h00};
    assign queueA2 = {8'h00, A[71:64], A[63:56], A[55:48], 8'h00, 8'h00};
                
    assign queueB0 = {8'h00, 8'h00, 8'h00, B[55:48], B[31:24], B[7:0]};
    assign queueB1 = {8'h00, 8'h00, B[63:56], B[39:32], B[15:8], 8'h00};
    assign queueB2 = {8'h00, B[71:64], B[47:40], B[23:16], 8'h00, 8'h00};
    
    generate
    genvar gi;
        for(gi = 0; gi < 9; gi=gi+1) begin
            FpMac pe(clk, fp1[8*gi+7:8*gi], fp2[8*gi+7:8*gi], PE_Start[gi], PE_Reset[gi], C[8*gi+7:8*gi]);
        end
    endgenerate
    
    reg [11:0] state = 12'h002;
    
    integer i;
    
    always@(posedge clk) begin
        case(state)
            11'h001: begin
                if(~start) begin
                    valid <= 1'b0;
                    state <= state << 1;
                    PE_Reset <= 9'hFFF;
                end
            end
            11'h002: begin
                PE_Reset <= 9'hFFF;
                PE_Start <= 9'h000;
                i <= 0;
                
                //queueA0 <= {8'h00, 8'h00, 8'h00, A[23:16], A[15:8], A[7:0]};
                //queueA1 <= {8'h00, 8'h00, A[47:40], A[39:32], A[31:24], 8'h00};
                //queueA2 <= {8'h00, A[71:64], A[63:56], A[55:48], 8'h00, 8'h00};
                //queueB0 <= {8'h00, 8'h00, 8'h00, B[55:48], B[31:24], B[7:0]};
                //queueB1 <= {8'h00, 8'h00, B[63:56], B[39:32], B[15:8], 8'h00};
                //queueB2 <= {8'h00, B[71:64], A[47:40], A[23:16], 8'h00, 8'h00};
                
                if(start) begin
                    PE_Start <= 9'hFFF;
                    PE_Reset <= 9'h000;
                    fp1[7:0] <= queueA0 & 8'hFF;
                    fp1[31:24] <= queueA1 & 8'hFF;
                    fp1[55:48] <= queueA2 & 8'hFF;
                    fp2[7:0] <= queueB0 & 8'hFF;
                    fp2[15:8] <= queueB1 & 8'hFF;
                    fp2[23:16] <= queueB2 & 8'hFF;
                    state <= state << 1;
                end
            end
            
            /*11'h004: begin
                PE_Reset <= 9'h000;
                PE_Start <= 9'hFFF;
                fp1[7:0] <= queueA0 & 8'hFF;
                fp1[31:24] <= queueA1 & 8'hFF;
                fp1[55:48] <= queueA2 & 8'hFF;
                fp2[7:0] <= queueB0 & 8'hFF;
                fp2[15:8] <= queueB1 & 8'hFF;
                fp2[23:16] <= queueB2 & 8'hFF;
                state <= state << 1;
            end*/
            
            default: begin
                PE_Reset <= 9'h000;
                PE_Start <= 9'hFFF;
                if(i <= 5) begin
                    fp1[7:0] <= (queueA0 >> (8*(i+1))) & 8'hFF;
                    fp1[15:8] <= fp1[7:0];
                    fp1[23:16] <= fp1[15:8];
            
                    fp1[31:24] <= (queueA1 >> (8*(i+1))) & 8'hFF;
                    fp1[39:32] <= fp1[31:24];
                    fp1[47:40] <= fp1[39:32];
            
                    fp1[55:48] <= (queueA2 >> (8*(i+1))) & 8'hFF;
                    fp1[63:56] <= fp1[55:48];
                    fp1[71:64] <= fp1[63:56];
            
                    fp2[7:0] <= (queueB0 >> (8*(i+1))) & 8'hFF;
                    fp2[31:24] <= fp2[7:0];
                    fp2[55:48] <= fp2[31:24];
            
                    fp2[15:8] <= (queueB1 >> (8*(i+1))) & 8'hFF;
                    fp2[39:32] <= fp2[15:8];
                    fp2[63:56] <= fp2[39:32];
            
                    fp2[23:16] <= (queueB2 >> (8*(i+1))) & 8'hFF;
                    fp2[47:40] <= fp2[23:16];
                    fp2[71:64] <= fp2[47:40];

                    state <= state <<< 1;
                    i <= i + 1;
                    //PE_Start <= 9'h000;
                end else begin
                    state <= 12'h001;
                    valid <= 1'b1;
                    PE_Start <= 9'h000;
                end
            end
            
            endcase
    end
    
	
endmodule