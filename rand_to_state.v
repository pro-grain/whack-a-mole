`timescale 1ns / 1ps

module rand_to_state(
    input [4:0] rand,
    output reg [4:0] state
    );

    always @(rand) begin
        state <= rand;
    end

endmodule
