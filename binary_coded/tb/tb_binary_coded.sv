`timescale 1ns / 1ps

module tb_binary_coded();

    logic clk;
    logic rst;
    logic CE;
    logic L;
    logic D0;
    logic D1;
    logic D2;
    logic D3;

    logic Q0;
    logic Q1;
    logic Q2;
    logic Q3;
    logic TC;

    binary_coded dut (
        .clk (clk),
        .rst (rst),
        .CE  (CE),
        .L   (L),
        .D0  (D0),
        .D1  (D1),
        .D2  (D2),
        .D3  (D3),
        .Q0  (Q0),
        .Q1  (Q1),
        .Q2  (Q2),
        .Q3  (Q3),
        .TC  (TC)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 0;
        CE  = 0;
        L   = 0;
        D0  = 0;
        D1  = 0;
        D2  = 0;
        D3  = 0;

        #10;
        rst = 1;
        #10;
        rst = 0;

        #10;
        L  = 1;
        D3 = 0;
        D2 = 1;
        D1 = 0;
        D0 = 1;
        #10;
        L  = 0;

        CE = 1;
        #60;

        CE = 0;
        #10;
        L  = 1;
        D3 = 1;
        D2 = 0;
        D1 = 0;
        D0 = 1;
        #10;
        L  = 0;

        CE = 1;
        #20;

        CE = 0;
        #20;
        $stop;
    end

endmodule