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

    // Handle the reset logic in a separate always block
    always@(negedge rst_n) begin
        if (!rst_n) begin
            //rand <= 0;
        end
    end

    // Handle the clocking and counting logic in another always block
    always@(posedge clk) begin
        //if (rst_n) begin
            rand <= count_up;
            count_up <= (count_up == 5'b11110) ? 5'b00001 : count_up + 1;
        //end
    end
endmodule
