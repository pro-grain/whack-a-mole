`timescale 1ns / 1ps

module clk_div(
    input clk,
    output reg nclk
);
    localparam DIVIDER = 5000;

    reg [19:0] counter;

    // Initialize the counter and nclk
    initial begin
        counter = 0;
        nclk = 0;
    end

    // Clock divider logic
    always @(posedge clk) begin
        if (counter == DIVIDER - 1) begin
            counter <= 0;
            nclk <= ~nclk; // Toggle nclk
        end else begin
            counter <= counter + 1;
        end
    end

endmodule
