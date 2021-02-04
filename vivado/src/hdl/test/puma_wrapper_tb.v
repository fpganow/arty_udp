`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2021 03:35:02 PM
// Design Name: 
// Module Name: puma_wrapper_tb
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


module puma_wrapper_tb(
    );

    localparam period = 20;

    reg clk;

    always
    begin
        clk = 1'b1;
        #20;

        clk = 1'b0;
        #20;
    end

    reg[7:0] packet_buffer;
    reg[31:0]   data;

    always @(posedge clk)
    begin

        packet_buffer = 8'hEF;
        data = 32'hAABBCCDD;

        #10
        data = (packet_buffer << 24) | 8'hFF;

        #50;
    end

endmodule
