`timescale 1ns / 1ps

module rand_gen(
    input clk,
    input rst_n,
    output reg [4:0] rand
    );

    reg [4:0] count_up;

    initial begin
        rand = 0;
        count_up = 5'b00001;
    end

    always@(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rand <= 0;
        end else begin
            rand <= count_up;
        end
        count_up <= (count_up == 5'b11110) ? 5'b00001 : count_up + 1;
    end
endmodule
