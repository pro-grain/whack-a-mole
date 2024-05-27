`timescale 1ns / 1ps
////////////////////////////////////////////////////
// Count-down timer that keeps track of game time
//
// Input clk - system clock
// Input rst_n - active low reset
// input load - active high load
// input [3:0] load_tens_digit - BCD input for tens digit
// input [3:0] load_ones_digit - BCD input for ones digit
// output reg [3:0] tens_digit - BCD output for tens digit
// output reg [3:0] ones_digit - BCD output for ones digit
////////////////////////////////////////////////////
module timer(
    input clk,
    input rst_n,
    input load,
    input [3:0] load_tens_digit,
    input [3:0] load_ones_digit,
    output reg [3:0] tens_digit,
    output reg [3:0] ones_digit
    );

    // Parameters for a 1-second clock divider (assuming a 100 MHz input clock)
    parameter CLOCK_FREQ = 100_000_000; // 100 MHz
    parameter ONE_SEC_COUNT = CLOCK_FREQ - 1; // One second count
    
    reg [26:0] clock_divider; // Enough bits for the clock divider
    reg one_sec_pulse;

    // Clock divider to generate 1 Hz signal
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            clock_divider <= 27'b0;
            one_sec_pulse <= 1'b0;
        end else begin
            if (clock_divider == ONE_SEC_COUNT) begin
                clock_divider <= 27'b0;
                one_sec_pulse <= 1'b1;
            end else begin
                clock_divider <= clock_divider + 1;
                one_sec_pulse <= 1'b0;
            end
        end
    end

    // Countdown logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tens_digit <= 4'b0000;
            ones_digit <= 4'b0000;
        end else if (load) begin
            tens_digit <= load_tens_digit;
            ones_digit <= load_ones_digit;
        end else if (one_sec_pulse) begin
            if (ones_digit == 4'b0000) begin
                if (tens_digit != 4'b0000) begin
                    tens_digit <= tens_digit - 1;
                    ones_digit <= 4'b1001; // Set ones to 9
                end
            end else begin
                ones_digit <= ones_digit - 1;
            end
        end
    end

endmodule
