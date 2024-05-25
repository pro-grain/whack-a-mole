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
    output reg score_trigger,
    output reg [4:0] board_state
    );

    wire [4:0] hit = 5'b00000;

    integer i;

    initial begin
        board_state = 5'b00000;
        score_trigger = 0;
    end

    five_button U1(
        .clk        (clk),
        .rst_n      (rst_n),
        .raw_button (button),
        .button     (hit)
    );

    always@(posedge clk or negedge rst_n)begin
        if (load) begin
            board_state = loadval;
        end

        for (i = 0; i < 5; i = i + 1)begin
            if (hit[i] && board_state[i])begin
                board_state[i] = 0;
                score_trigger = 1;
            end
        end

        if (hit = 5'b00000)begin
            score_trigger = 0;
        end

        if(!rst_n)begin
            score_trigger = 0;
            board_state = 5'b00000;
        end
    end

endmodule
