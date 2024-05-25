`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////
// displays 8 bcd digits on FPGA 7 segment display
//
// clk - system clock
// rst_n - active low reset
// display7 ~ display0 - bcd digit, displayed from left to right
// segment - bit7 ~ bit0 represents abcdefg., active low
// enable - bit7 ~ bit0 represents CA~DP, active low
////////////////////////////////////////////////////////////////////////
module display(
    input clk,
    input rst_n,
    input [3:0] display7,
    input [3:0] display6,
    input [3:0] display5,
    input [3:0] display4,
    input [3:0] display3,
    input [3:0] display2,
    input [3:0] display1,
    input [3:0] display0,
    output reg [7:0] segment,
    output reg [7:0] enable
    );

    reg [3:0] current_digit;
    reg [2:0] count = 0;
    reg nclk;

    clk_div U0 (.clk(clk), .nclk(nclk));

    always@(posedge nclk)begin

    end


endmodule
