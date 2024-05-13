`timescale 1ns / 1ps
////////////////////////////////////////////////////
// Count-down timer that keeps track of game time
//
// Input clk - system clock
// Input rst_n - active low
// input load - active high
// input [3:0] load_tens_digit - bcd
// input [3:0] load_ones_digit - bcd
// output [3:0] tens_digit - bcd
// output [3:0] ones_digit - bcd
////////////////////////////////////////////////////
module timer(
    input clk,
    input rst_n,
    input load,
    input [3:0] load_tens_digit,
    input [3:0] load_ones_digit,
    output [3:0] tens_digit,
    output [3:0] ones_digit
    );
    
endmodule
