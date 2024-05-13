`timescale 1ns / 1ps
//////////////////////////////////////////
// count-down timer that regulates board's state machine
// 
// clk - system clock
// rst_n - active low reset
// load - active high load
// loadval - time = loadval * 10ns
// time_trigger - active high pulse, triggered if timer == 0
/////////////////////////////////////////
module board_timer(
    input clk,
    input rst_n,
    input load,
    input [27:0] loadval,
    output time_trigger
    );
    
endmodule
