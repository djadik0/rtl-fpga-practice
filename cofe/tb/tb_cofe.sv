`timescale 1ns / 1ps

module tb_cofe();

    logic        clk;
    logic        rst;
    logic        one_coin;
    logic        two_coin;
    logic        five_coin;
    logic        ten_coin;
    logic        select;

    logic [4:0]  cashback;
    logic        coffe;
    logic        coffe_with_milk;

    cofe_top dut (
        .clk             (clk),
        .rst             (rst),
        .one_coin        (one_coin),
        .two_coin        (two_coin),
        .five_coin       (five_coin),
        .ten_coin        (ten_coin),
        .select          (select),
        .cashback        (cashback),
        .coffe           (coffe),
        .coffe_with_milk (coffe_with_milk)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst             = 1;
        one_coin        = 0;
        two_coin        = 0;
        five_coin       = 0;
        ten_coin        = 0;
        select          = 0;

        #10;
        rst = 0;
        #10;
        rst = 1;

        ten_coin = 1;
        #10;
        ten_coin = 0;
        #10;

        ten_coin = 1;
        #10;
        ten_coin = 0;
        #10;

        five_coin = 1;
        #10;
        five_coin = 0;
        #10;

        two_coin = 1;
        #10;
        two_coin = 0;
        #20;

        select = 1;

        ten_coin = 1;
        #10;
        ten_coin = 0;
        #10;

        ten_coin = 1;
        #10;
        ten_coin = 0;
        #10;

        ten_coin = 1;
        #10;
        ten_coin = 0;
        #10;

        five_coin = 1;
        #10;
        five_coin = 0;
        #20;

        select = 0;

        five_coin = 1;
        #10;
        five_coin = 0;
        #10;

        two_coin = 1;
        #10;
        two_coin = 0;
        #20;

        #100;
        $stop;
    end

endmodule