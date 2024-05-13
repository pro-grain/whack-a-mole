`timescale 1ns / 1ps
/////////////////////////////////////
// Keeps track of the score. It is cleared when global_state == LOAD. 
// Trigger is active when global_state == START.
//
// Input clk - system clock
// Input rst_n - active low reset
// input clear - active high, set scoreboard to 000
// input score_trigger - active high pulse, increase score by one
// output [3:0] hundreds_digit - bcd for 100's
// output [3:0] tens_digit - bcd for 10's
// output [3:0] ones_digit - bcd for 1's
/////////////////////////////////////
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