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


    integer i;

    // Initial block to set initial values
    initial begin
        board_state = 5'b00000;
        score_trigger = 0;
    end

    // Sequential always block triggered on clock edge or reset
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Active low reset
            board_state <= 5'b00000;
            score_trigger <= 0;
        end else if (load) begin
            // Load new board state
            board_state <= loadval;
            score_trigger <= 0;  // Clear score_trigger on load
        end else begin
            // Default to 0, will be set to 1 if hit detected
            score_trigger <= 0;
            for (i = 0; i < 5; i = i + 1) begin
                if (button[i] && board_state[i]) begin
                    board_state[i] <= 0;
                    score_trigger <= 1;
                end
            end
        end
    end

endmodule
