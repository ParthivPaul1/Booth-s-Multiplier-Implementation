`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2025 17:09:56
// Design Name: 
// Module Name: multiplier
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

module Start(
    input clk,
    input rst,
    input start,
    output reg start_actual
    );
    reg out1;
    always@(negedge clk or negedge rst) begin
        if(!rst) begin
            out1 <= 1'b0;
            start_actual <= 1'b0;
        end else begin
            out1 <= start;
            if(start == 1'b1 && out1 == 1'b0) start_actual <= 1'b1;
            else start_actual <= 1'b0; 
        end
    end
endmodule

// Mod-5-Counter
module Counter(
    input clk,
    input rst,
    input control,
    output reg [2:0] count
    );
    always@(negedge clk or negedge rst) begin
        if(!rst) count <= 3'b101;
        else begin
            if(control) begin
                if(count == 3'b000) count <= 3'b101;
                else count <= count-1;
            end else count <= count;
        end
    end
endmodule

// Acc
module Load_Shift_Register1(
    input clk,
    input rst,
    input load,
    input shift,
    input [4:0] in,
    output reg [4:0] out
    );
    always@(negedge clk or negedge rst) begin
        if(!rst) out <= 5'b00000;
        else begin
            if(load == 1'b1 && shift == 1'b0) out <= in;
            else if(load == 1'b0 && shift == 1'b1) out <= {out[4],out[4:1]};
            else out <= out;
        end
    end
endmodule

// Q
module Load_Shift_Register(
    input clk,
    input rst,
    input load,
    input shift,
    input [4:0] in,
    input ser_in,
    output reg [4:0] out
    );
    always@(negedge clk or negedge rst) begin
        if(!rst) out <= 5'b00000;
        else begin
            if(load == 1'b1 && shift == 1'b0) out <= in;
            else if(load == 1'b0 && shift == 1'b1) out <= {ser_in,out[4:1]};
            else out <= out;
        end
    end
endmodule

// M
module Load_Register(
    input clk,
    input rst,
    input load,
    input [4:0] in,
    output reg [4:0] out
    );
    always@(negedge clk or negedge rst) begin
        if(!rst) out <= 5'b00000;
        else if(load) out <= in;
        else out <= out;
    end
endmodule

// 1 bit register Q_b
module Register_1_bit(
    input clk,
    input rst,
    input load,
    input in,
    output reg out
    );
    always@(negedge clk or negedge rst) begin
        if(!rst) out <= 1'b0;
        else if(load) out <= in;
        else out <= out;
    end
endmodule

module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
    assign sum = a^b^cin;
    assign cout = ((a^b)&cin)|(a&b);
endmodule

// 5 bit adder-subtractor
module adder_subtractor(
    input [4:0] a,
    input [4:0] b,
    input n,
    output [4:0] sum,
    output cout
    );
    wire [3:0] c;
    wire [4:0] x;
    assign x[0] = b[0]^n;
    assign x[1] = b[1]^n;
    assign x[2] = b[2]^n;
    assign x[3] = b[3]^n;
    assign x[4] = b[4]^n;
    full_adder fa0(
        .a(a[0]),
        .b(x[0]),
        .cin(n),
        .sum(sum[0]),
        .cout(c[0])
        );
    full_adder fa1(
        .a(a[1]),
        .b(x[1]),
        .cin(c[0]),
        .sum(sum[1]),
        .cout(c[1])
        );
    full_adder fa2(
        .a(a[2]),
        .b(x[2]),
        .cin(c[1]),
        .sum(sum[2]),
        .cout(c[2])
        );
    full_adder fa3(
        .a(a[3]),
        .b(x[3]),
        .cin(c[2]),
        .sum(sum[3]),
        .cout(c[3])
        );
    full_adder fa4(
        .a(a[4]),
        .b(x[4]),
        .cin(c[3]),
        .sum(sum[4]),
        .cout(cout)
        );
endmodule

module Control_Unit(
    input clk,
    input rst,
    input start,
    input [1:0] q,
    input check,
    output reg [5:0] state
    );
    reg [5:0] next_state;
    parameter s0 = 6'b000001;
    parameter s1 = 6'b000010;
    parameter s2 = 6'b000100;
    parameter s3 = 6'b001000;
    parameter s4 = 6'b010000;
    parameter s5 = 6'b100000;
    // Combinational
    always@(*) begin
        case(state)
            s0: begin
                if(start) next_state = s1;
                else next_state = s0;
            end
            s1: next_state = s2;
            s2: begin
                if(q == 2'b01) next_state = s3;
                else if(q == 2'b10) next_state = s4;
                else if(q == 2'b00 || q == 2'b11) next_state = s5;
                else next_state = 6'b000000;
            end
            s3: next_state = s5;
            s4: next_state = s5;
            s5: begin
                if(check) next_state = s2;
                else next_state = s0;
            end
            default: next_state = 6'b000000;
        endcase
    end
    // Sequential
    always@(posedge clk or negedge rst) begin
        if(!rst) state <= s0;
        else state <= next_state;
    end
endmodule

module Datapath(
    input clk,
    input rst,
    input [4:0] A,
    input [4:0] B,
    input [5:0] state,
    output q_b,
    output check,
    output [9:0] Z
    );
    wire y;
    wire [4:0] m,acc;
    wire [2:0] count;
    assign check = count[0]|count[1]|count[2];
    adder_subtractor block(
        .a(Z[9:5]),
        .b(m),
        .n(state[4]),
        .sum(acc),
        .cout(y)
        );
    Load_Register M(
        .clk(clk),
        .rst(rst),
        .load(state[1]),
        .in(A),
        .out(m)
        );
    Load_Shift_Register Q(
        .clk(clk),
        .rst(rst),
        .load(state[1]),
        .shift(state[5]),
        .in(B),
        .ser_in(Z[5]),
        .out(Z[4:0])
        );
    Load_Shift_Register1 Acc(
        .clk(clk),
        .rst(rst),
        .load(state[3]|state[4]),
        .shift(state[5]),
        .in(acc),
        .out(Z[9:5])
        );
    Register_1_bit Q_1(
        .clk(clk),
        .rst(rst),
        .load(state[5]),
        .in(Z[0]),
        .out(q_b)
        );
    Counter c(
        .clk(clk),
        .rst(rst),
        .control(state[5]),
        .count(count)
        );
endmodule

module multiplier(
    input clk,
    input rst,
    input start,
    input [4:0] A,
    input [4:0] B,
    output [9:0] Z
    );
    wire s,q_b,check;
    wire [5:0] state;
    Start sta_rt(
        .clk(clk),
        .rst(rst),
        .start(start),
        .start_actual(s)
        );
    Control_Unit CU(
        .clk(clk),
        .rst(rst),
        .start(s),
        .q({Z[0],q_b}),
        .check(check),
        .state(state)
        );
    Datapath DU(
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .state(state),
        .q_b(q_b),
        .check(check),
        .Z(Z)
        );
endmodule
