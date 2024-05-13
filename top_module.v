`timescale 1ns / 1ps

module top_module(
    input clk,
    input rst_n,
    input [4:0] raw_button, // from button
    output [4:0] led, // from board
    output [7:0] svn_seg_disp, // from display (contains scoreboard and timer)
    output [7:0] disp_enable
    );
    
    /// state parameters ///
    
    reg [2:0] state;
    parameter STOP = 2'd0;
    parameter LOAD = 2'd1;
    parameter START = 2'd2;
    
    /// module declaration ///
    
    wire [4:0] button; // to board and state machine
    five_button U0(
    // module control
        .clk                (clk),
        .rst_n              (rst_n),
    // input
        .raw_button         (raw_button),
    // output
        .button             (button)
    );
    
    wire score_trigger; // to scoreboard
    board U1(
    // module control
        .clk                (clk),
        .rst_n              (rst_n),
        .enable             (state[START]),
    // input
        .button             (button), // from five_button
    // output
        .score_trigger      (score_trigger),
        .board_state        (led) // to top module
    );
    
    wire [3:0] score_hundreds_digit; // to display
    wire [3:0] score_tens_digit;
    wire [3:0] score_ones_digit;
    scoreboard U2(
    // module control
        .clk                (clk),
        .rst_n              (rst_n),
        .clear              (state[LOAD]), // might change to load later
    // input
        .score_trigger      (score_trigger), // from board
    // output
        .hundreds_digit     (score_hundreds_digit),
        .tens_digit         (score_tens_digit),
        .ones_digit         (score_ones_digit)
    );
    
    wire [3:0] timer_tens_digit; // to display
    wire [3:0] timer_ones_digit;
    timer U3(
    // module control
        .clk                (clk),
        .rst_n              (rst_n),
        .load               (state[STOP] | state[LOAD]),
    // input
        .load_tens_digit    (state[STOP] ? 4'd0 : 4'd6),
        .load_ones_digit    (state[STOP] ? 4'd0 : 4'd0),
    // output
        .tens_digit         (timer_tens_digit),
        .ones_digit         (timer_ones_digit)
    );
    
    parameter NO_DISPLAY = 4'd15;
    display U4(
        .clk                (clk),
        .rst_n              (rst_n),
        .display7           (NO_DISPLAY),
        .display6           (score_hundreds_digit),
        .display5           (score_tens_digit),
        .display4           (score_ones_digit),
        .display3           (NO_DISPLAY),
        .display2           (NO_DISPLAY),
        .display1           (timer_tens_digit),
        .display0           (timer_ones_digit),
        .segment            (svn_seg_disp), // to top module
        .enable             (disp_enable)
        );
    
    /// one hot state machine ///
    
    reg [2:0] next_state;
    // state register
    always @(posedge clk) begin
        if (!rst_n) begin
            state <= 3'b000;
            state[STOP] <= 1'b1;
        end else begin
            state <= next_state;
        end
    end
    // next state logic
    always @(*) begin
        next_state = 3'b000;
        case (1'b1)
            state[STOP]: begin
                if (button != 5'b00000) begin // press any button to start
                    next_state[START] = 1'b1;
                end else begin
                    next_state[STOP] = 1'b1;
                end
            end
            state[LOAD]: begin
                next_state[START] = 1'b1;
            end
            state[START]: begin // if timer == 00
                if (timer_tens_digit == 4'd0 && timer_ones_digit == 4'd0) begin
                    next_state[STOP] = 1'b1;
                end else begin
                    next_state[START] = 1'b1;
                end
            end
        endcase
    end
endmodule
