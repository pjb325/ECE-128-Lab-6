`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2023 02:45:55 PM
// Design Name: 
// Module Name: carry_look_TB
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


module carry_look_TB();
    reg [3:0]A,B;
    reg Cin;
    wire [3:0] S;
    wire Co;
    
    carry_look_adder UUT(.A(A), .B(B), .Cin(Cin), .S(S), .Co(Co));
    initial 
    begin
        A = 1; B = 0; Cin = 0; #1;
        A = 2; B = 4; Cin = 1; #1;
        A = 4'hb; B = 4'h6; Cin = 0; #1;
        A = 5; B = 3; Cin = 1;#1
    $finish;
    end
    
endmodule
