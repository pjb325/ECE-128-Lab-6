`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2023 03:05:16 PM
// Design Name: 
// Module Name: top
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


module top(input [3:0] A,
           input [3:0] B,
           input Cin, 
           input clk, 
           input en, 
           output [15:0] bcd_d_out,
           output rdy);

    wire [3:0] S;
    wire Co;
    wire [11:0] bin_d_in;
    
    carry_look_adder add(.A(A), .B(B), .Cin(Cin), .S(S), .Co(Co));
    
    assign bin_d_in = {7'b0, Co, S};
    
    bin2BCD bcdthisup(.clk(clk), .en(en), .bin_d_in(bin_d_in), .bcd_d_out(bcd_d_out), .rdy(rdy));
    
    
endmodule
