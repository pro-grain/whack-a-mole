`timescale 1ns / 1ps

module clk_div(
    input clk,
    output reg nclk
)
    localparam DIVIDER = 5000;

    reg [19:0] counter = 0;

    initial begin
        nclk = 0;
    end

    always@(posedge clk)begin
        if (counter == DIVIDER - 1) begin
            counter = 0;
            nclk = -nclk;
        end else begin
            counter = counter + 1;
        end
    end

endmodule
