`timescale 1ns / 1ps

module five_button(
    input clk,
    input rst_n,
    input [4:0] raw_button,
    output [4:0] button
    );
    button U0(
        .clk        (clk),
        .rst_n      (rst_n),
        .raw_button (raw_button[0]),
        .button     (button[0])
    );
    button U1(
        .clk        (clk),
        .rst_n      (rst_n),
        .raw_button (raw_button[1]),
        .button     (button[1])
    );
    button U2(
        .clk        (clk),
        .rst_n      (rst_n),
        .raw_button (raw_button[2]),
        .button     (button[2])
    );
    button U3(
        .clk        (clk),
        .rst_n      (rst_n),
        .raw_button (raw_button[3]),
        .button     (button[3])
    );
    button U4(
        .clk        (clk),
        .rst_n      (rst_n),
        .raw_button (raw_button[4]),
        .button     (button[4])
    );
endmodule
