`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2023 01:50:05 PM
// Design Name: 
// Module Name: bin2BCD
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


module bin2BCD(
    input clk,
    input en,
    input [11:0] bin_d_in, //1's 10's 100's
    output [15:0] bcd_d_out, //display
    output rdy
    );
    
    //State variables
    parameter IDLE = 3'b000;
    parameter SETUP = 3'b001;
    parameter ADD = 3'b010;
    parameter SHIFT = 3'b011;
    parameter DONE = 3'b100;
    
    //reg [11:0] bin_data = 0;
    reg [27:0] bcd_data = 0;
    reg [2:0] state = 0;
    reg busy = 0;
    reg [3:0] sh_counter = 0;
    reg [1:0] add_counter = 0;
    reg result_rdy = 0;
    
    always @(posedge clk)
        begin
        if(en)
            begin
                if(~busy)
                     begin
                         bcd_data <= {16'b0, bin_d_in};
                         state <= SETUP;
                     end
            end
        case(state)
    
        IDLE:
            begin
               result_rdy <= 0;
               busy <= 0;
            end
    
        SETUP:
            begin
               busy <= 1;
               state <= ADD;
            end
    
        ADD:
            begin
    
            case(add_counter)
                0:
                   begin
                        if(bcd_data[15:12] > 4)
                             begin
                                 bcd_data[27:12] <= bcd_data[27:12] + 3;
    
                             end
                             add_counter <= add_counter + 1;
                   end
    
                1:
                   begin
                        if(bcd_data[19:16] > 4)
                             begin
                                 bcd_data[27:16] <= bcd_data[27:16] + 3;
                             end
                             add_counter <= add_counter + 1;
                   end
    
                2:
                   begin
                        if((add_counter == 2) && (bcd_data[23:20] > 4))
                             begin
                                  bcd_data[27:20] <= bcd_data[27:20] + 3;
                             end
                             add_counter <= add_counter + 1;
                   end
    
                3:
                   begin
                        if((add_counter == 3) && (bcd_data[27:24] > 4))
                            begin
                                 bcd_data[27:24] <= bcd_data[27:24] + 3;
                            end
                            add_counter <= 0;
    
                        state <= SHIFT;
                   end
            endcase
            end
    
    SHIFT:
         begin
    sh_counter <= sh_counter + 1;
    bcd_data <= bcd_data << 1;
    
    if(sh_counter == 11)
    begin
    sh_counter <= 0;
    state <= DONE;
    end
    else
    begin
    state <= ADD;
    end
    
    end
    
    DONE:
    begin
    result_rdy <= 1;
    state <= IDLE;
    end
    default:
    
    begin
    state <= IDLE;
    end
    
    endcase
    
    end
    assign bcd_d_out = bcd_data[27:12];
    assign rdy = result_rdy;
endmodule

module carry_look_adder(A,B,Cin,S,Co);
    input [3:0] A,B;
    input Cin;
    output [3:0] S;
    output Co;
    
    wire [3:0] P;
    wire [3:0] G; 
    wire [4:0] C; 
    //P = A XOR B
    assign P[0] = A[0]^B[0];
    assign P[1] = A[1]^B[1];
    assign P[2] = A[2]^B[2];
    assign P[3] = A[3]^B[3];
    //G = A and B
    assign G[0] = A[0]&B[0];
    assign G[1] = A[1]&B[1];
    assign G[2] = A[2]&B[2];
    assign G[3] = A[3]&B[3];
    
    assign C[0] = Cin;
    assign C[1] = C[0]&P[0]+G[0];
    assign C[2] = C[1]&P[1]+G[1];
    assign C[3] = C[2]&P[2]+G[2];
    assign C[4] = C[3]&P[3]+G[3];
    assign Co = C[4];
    
    //S = P XOR G
    assign S[0] = P[0]^C[0];
    assign S[1] = P[1]^C[1];
    assign S[2] = P[2]^C[2];
    assign S[3] = P[3]^C[3];

endmodule