`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////
// Debounce and edge-checking circuit for one button. It is always active.
//
// clk - system clock
// rst_n - active low reset
// raw_button - raw button input from hardware, active high
// button - active high pulse, lasts for one clock cycle when button is pressed
////////////////////////////////////////////////////////////////////////
module button(
    input clk,
    input rst_n,
    input raw_button,
    output button
    );

    reg prev_button = 0;

    always@(posedge clk)begin
        if (prev_button != raw_button && raw_button) begin
            button = 1;
        end else begin
            button = 0;
        end

        prev_button = raw_button;
    end

endmodule
