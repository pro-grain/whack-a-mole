`timescale 1ns / 1ps

module rand_state(
    input clk,
    input rst_n,
    output [4:0] rand_state
    );
    // rand_gen
    wire [4:0] rand;
    rand_gen U0(
        .clk        (clk),
        .rst_n      (rst_n),
        .rand       (rand)
    );
    // rand_to_state
    rand_to_state U1(
        .rand       (rand),
        .state      (rand_state)
    );
endmodule
