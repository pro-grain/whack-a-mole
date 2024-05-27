`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////
// displays 8 BCD digits on FPGA 7-segment display
//
// clk - system clock
// rst_n - active low reset
// display7 ~ display0 - BCD digit, displayed from left to right
// segment - bit7 ~ bit0 represents abcdefg., active low
// enable - bit7 ~ bit0 represents CA~DP, active low
////////////////////////////////////////////////////////////////////////
module display(
    input clk,
    input rst_n,
    input [3:0] display7,
    input [3:0] display6,
    input [3:0] display5,
    input [3:0] display4,
    input [3:0] display3,
    input [3:0] display2,
    input [3:0] display1,
    input [3:0] display0,
    output reg [7:0] segment,
    output reg [7:0] enable
    );

    reg [3:0] current_digit;
    reg [2:0] count;
    wire nclk;

    // Clock divider instance
    clk_div U0 (.clk(clk), .nclk(nclk));

    // Sequential logic for count and enabling digits
    always @(posedge nclk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 3'b000;
        end else begin
            count <= (count == 3'b111) ? 3'b000 : count + 1;
        end
    end

    // Combinational logic for enabling digits
    always @(*) begin
        case (count)
            3'b000: enable = 8'b11111110;
            3'b001: enable = 8'b11111101;
            3'b010: enable = 8'b11111011;
            3'b011: enable = 8'b11110111;
            3'b100: enable = 8'b11101111;
            3'b101: enable = 8'b11011111;
            3'b110: enable = 8'b10111111;
            3'b111: enable = 8'b01111111;
            default: enable = 8'b11111111;
        endcase
    end

    // Combinational logic for selecting the current digit
    always @(*) begin
        case (count)
            3'b000: current_digit = display0;
            3'b001: current_digit = display1;
            3'b010: current_digit = display2;
            3'b011: current_digit = display3;
            3'b100: current_digit = display4;
            3'b101: current_digit = display5;
            3'b106: current_digit = display6;
            3'b107: current_digit = display7;
            default: current_digit = 4'b0000;
        endcase
    end

    // Combinational logic for segment decoding
    always @(*) begin
        case (current_digit)
            4'd0: segment = 8'b00000011; // 0
            4'd1: segment = 8'b10011111; // 1
            4'd2: segment = 8'b00100101; // 2
            4'd3: segment = 8'b00001101; // 3
            4'd4: segment = 8'b10011001; // 4
            4'd5: segment = 8'b01001001; // 5
            4'd6: segment = 8'b01000001; // 6
            4'd7: segment = 8'b00011111; // 7
            4'd8: segment = 8'b00000001; // 8
            4'd9: segment = 8'b00001001; // 9
            default: segment = 8'b11111111; // Off
        endcase
    end

endmodule
