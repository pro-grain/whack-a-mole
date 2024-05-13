`timescale 1ns / 1ps
//////////////////////////////////
// stores the current active moles
// if active mole is hit, score_trigger is sent, and that mole is set to inactive
// 
// clk - system clock
// rst_n - active low reset
// load - active high load
// loadval - active high state
// button - active high pulse
// score_trigger - active high pulse
// board_state - active high state
///////////////////////////////////
module board_state(
    input clk,
    input rst_n,
    input load,
    input [4:0] loadval,
    input [4:0] button,
    output score_trigger,
    output [4:0] board_state
    );
endmodule
