`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2023 03:36:30 PM
// Design Name: 
// Module Name: bin2BCD_TB
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


module bin2BCD_TB();

    reg clk = 0;
    reg en;// = 0;
    reg [3:0] A,B;
    reg Cin;
    wire [15:0] bcd_d_out;
    wire rdy;

    // 2. Instantiate the design and connect to testbench variables
    top fa0(
    .A(A),
    .B(B),
    .Cin(Cin),
    .clk(clk),
    .en(en),
    .bcd_d_out(bcd_d_out),
    .rdy(rdy)
    
    );
    
    initial
    begin
    //clk = 0;
    forever
    begin
    #10 clk = ~clk; //10*2 for full wave
   // A = 4'b0000; B = 4'b0000; Cin = 1'b0;
    end
    end
    
    initial
    begin
    forever
    begin
    en = 1;
    A = 4'b0110; B = 4'b0000; Cin = 1'b0;
    #20 //en must catch rising edge of clk
    en = 0;
    #620; 
    
    en = 1;
    #20
    A = 4'b0101; B = 4'b0000; Cin = 1'b0;
    en = 0;
     
    #620; 
    

    en = 1;
    A = 4'b1101; B = 4'b0000; Cin = 1'b0;
    #20
    en = 0;
    //A = 4'b1001; B = 4'b1001; Cin = 1'b0;
    #620; 
    

    en = 1;
     A = 4'b1001; B = 4'b0000; Cin = 1'b0;
    #20
    en = 0;
    // A = 4'b1001; B = 4'b1111; Cin = 1'b1;
    #620; 
    

    en = 1;
     A = 4'b1111; B = 4'b0000; Cin = 1'b0;
    #20
    en = 0;
     //A = 4'b1000; B = 4'b0001; Cin = 1'b1;
    #620; //IDEL (+1); SETUP (+1); ADD (+12*4); SHIFT (+12); DONE (+1); extra for edge case (+4); enable
    
    

    en = 1;
    A = 4'b1011; B = 4'b0000; Cin = 1'b0;
    #20
    en = 0;
    //A = 4'b1011; B = 4'b1101; Cin = 1'b1;
    #620; //IDEL (+1); SETUP (+1); ADD (+12*4); SHIFT (+12); DONE (+1); extra for edge case (+4); enable
    
    

    en = 1;
    A = 4'b1011; B = 4'b0001; Cin = 1'b0;
    #20
    en = 0;
    //A = 4'b1011; B = 4'b0001; Cin = 1'b1;
    #1340; //IDEL (+1); SETUP (+1); ADD (+12*4); SHIFT (+12); DONE (+1); extra for edge case (+4);
    
    

    en = 1;
    A = 4'b1000; B = 4'b1101; Cin = 1'b0;
    #20
    en = 0;
    //A = 4'b1000; B = 4'b1101; Cin = 1'b1;
    #1340; //IDEL (+1); SETUP (+1); ADD (+12*4); SHIFT (+12); DONE (+1); extra for edge case (+4);
    
    

    en = 1;
    A = 4'b1111; B = 4'b1111; Cin = 1'b0;
    #20
    en = 0;
    //A = 4'b0000; B = 4'b0000; Cin = 1'b0;
    #1340; //IDEL (+1); SETUP (+1); ADD (+12*4); SHIFT (+12); DONE (+1); extra for edge case (+4);
    

    en = 1;
    #20
    en = 0;
    #1340; 
    end
    end
endmodule
