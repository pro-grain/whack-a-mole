`timescale 1ns / 1ps
//////////////////////////////////////////
// count-down timer that regulates board's state machine
// 
// clk - system clock
// rst_n - active low reset
// load - active high load
// loadval - time = loadval * 10ns
// time_trigger - active high pulse, triggered if timer == 0
/////////////////////////////////////////
module board_timer(
    input clk,
    input rst_n,
    input load,
    input [27:0] loadval,
    output reg time_trigger
    );
    
    reg [27:0] counter;

    // Initial block to set initial values
    initial begin
        time_trigger = 0;
        counter = 0;
    end

    // Sequential always block triggered on clock edge or reset
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Active low reset
            counter <= 28'd0;
            time_trigger <= 1'b0;
        end else if (load) begin
            // Load the counter with the load value
            counter <= loadval;
            time_trigger <= 1'b0;
        end else if (counter > 0) begin
            // Decrement the counter
            counter <= counter - 1;
            time_trigger <= 1'b0;
        end else begin
            // When the counter reaches zero, trigger the time_trigger signal
            time_trigger <= 1'b1;
        end
    end

endmodule
