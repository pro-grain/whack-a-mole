`timescale 1ns / 1ps

module scoreboard(
    input clk,
    input rst_n,
    input clear,
    input score_trigger,
    output [3:0] hundreds_digit,
    output [3:0] tens_digit,
    output [3:0] ones_digit
    );
endmodule
