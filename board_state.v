`timescale 1ns / 1ps

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
