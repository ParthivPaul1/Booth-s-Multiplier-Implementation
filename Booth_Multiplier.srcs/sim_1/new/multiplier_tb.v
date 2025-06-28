`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2025 00:07:51
// Design Name: 
// Module Name: multiplier_tb
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


module multiplier_tb;
    reg clk,rst,start;
    reg [4:0] A,B;
    wire [9:0] Z;
    // Instantiation
    multiplier uut(
        .clk(clk),
        .rst(rst),
        .start(start),
        .A(A),
        .B(B),
        .Z(Z)
        );
    // Initialisation
    initial begin
        clk = 1'b0;
        rst = 1'b0;
        start = 1'b0;
        A = 5'b00000;
        B = 5'b00000;
    end
    // clock Generation
    always #5 clk = ~clk;
    // Varying Stimuli
    initial begin
        #3 rst = 1'b1;
        #2 A = 5'b11101;
        B = 5'b00100;
        #3 start = 1'b1;
        #200 $finish;
    end
    // Monitoring
    initial begin
        $monitor("Time=%t\tA=%b\tB=%b\tZ=%b\n", $time,A,B,Z);
    end
endmodule
