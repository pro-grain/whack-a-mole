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
    output reg [3:0] hundreds_digit,
    output reg [3:0] tens_digit,
    output reg [3:0] ones_digit
    );

    // Initialize the digits to 0
    initial begin
        hundreds_digit = 0;
        tens_digit = 0;
        ones_digit = 0;
    end

    // Main always block triggered by clock or reset
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all digits to 0
            hundreds_digit <= 0;
            tens_digit <= 0;
            ones_digit <= 0;
        end else if (clear) begin
            // Clear all digits to 0
            hundreds_digit <= 0;
            tens_digit <= 0;
            ones_digit <= 0;
        end else if (score_trigger) begin
            // Increment score
            if (ones_digit == 9) begin
                ones_digit <= 0;
                if (tens_digit == 9) begin
                    tens_digit <= 0;
                    if (hundreds_digit == 9) begin
                        hundreds_digit <= 0;
                    end else begin
                        hundreds_digit <= hundreds_digit + 1;
                    end
                end else begin
                    tens_digit <= tens_digit + 1;
                end
            end else begin
                ones_digit <= ones_digit + 1;
            end
        end
    end

endmodule
