`timescale 1ns / 1ps
/////////////////////////////////////
// state machine that controls the game when global_state == START
// the states are RESET -> STOP -> LOAD -> START
//
// clk - system clock
// rst_n - active low reset
// enable - active high enable, same as global_state == START
// button - active high pulse
// score_trigger - active high pulse
// board_state - active high state
//////////////////////////////////////
module board(
    // control
    input clk,
    input rst_n,
    input enable,
    // input
    input [4:0] button,
    // output
    output score_trigger,
    output [4:0] board_state
    );
    
    /// state parameters and constants ///
    
    reg [3:0] state;
    parameter RESET = 2'd0;
    parameter STOP = 2'd1;
    parameter LOAD = 2'd2;
    parameter START = 2'd3;
    parameter EMPTY_BOARD_STATE = 5'b00000;
    parameter STOP_TIME = 28'd2_000_000; // 0.2s
    parameter START_TIME = 28'd20_000_000; // 2s
    
    /// module connection ///
    
    wire [4:0] rand_state; // feeds to board_state.loadval
    
    rand_state U0(
    // module control
        .clk            (clk),
        .rst_n          (rst_n),
    // output
        .rand_state     (rand_state)
    );
    
    board_state U1(
    // module control
        .clk            (clk),
        .rst_n          (rst_n),
        .load           (state[RESET] | state[LOAD]),
        .loadval        (state[RESET] ? EMPTY_BOARD_STATE : rand_state),
    // input
        .button         (button), // from top module
    // output
        .score_trigger  (score_trigger),
        .board_state    (board_state) // to top module
    );
    
    wire time_trigger; // feeds to state machine
    
    board_timer U2(
    // module control
        .clk            (clk),
        .rst_n          (rst_n),
        .load           (state[RESET] | state[LOAD]),
        .loadval        (state[RESET] ? STOP_TIME : START_TIME),
    // output
        .time_trigger   (time_trigger)
    );

    /// one hot state machine ///
    
    reg [3:0] next_state;
    // state register (sequential)
    always @(posedge clk) begin
        if (!rst_n) begin
            state <= 4'b0000;
            state[RESET] <= 1'b1;
        end else if (!enable) begin
            state <= 4'b0000;
            state[RESET] <= 1'b1;
        end else begin
            state <= next_state;
        end
    end
    // next_state logic (combinational)
    always @(*) begin
        next_state = 4'b0000;
        case (1'b1)
            state[RESET]: begin
                next_state[STOP] = 1'b1;
            end
            state[STOP]: begin
                if (time_trigger) begin
                    next_state[LOAD] = 1'b1;
                end else begin
                    next_state[STOP] = 1'b1;
                end
            end
            state[LOAD]: begin
                next_state[START] = 1'b1;
            end
            state[START]: begin
                // RESET if "times up" OR "player hit all moles"
                if (time_trigger || board_state == EMPTY_BOARD_STATE) begin
                    next_state[RESET] = 1'b1;
                end else begin
                    next_state[START] = 1'b1;
                end
            end
        endcase
    end 
endmodule
