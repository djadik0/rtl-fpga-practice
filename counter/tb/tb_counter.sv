`timescale 1ns / 1ps

module tb_counter();

    logic       clk;
    logic       rst;
    logic [2:0] out;

    counter uut (
        .clk (clk),
        .rst (rst),
        .out (out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;

        #10;
        rst = 0;
        #10;
        rst = 1;

        #100;

        #10;
        rst = 0;
        #10;
        rst = 1;

        #50;
        $stop;
    end

endmodule