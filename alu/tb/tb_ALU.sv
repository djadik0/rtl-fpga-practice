`timescale 1ns / 1ps

module tb_ALU();

    logic       clk;
    logic [3:0] A;
    logic [3:0] B;
    logic [2:0] F;
    logic [3:0] Y;

    ALU dut (
        .clk (clk),
        .A   (A),
        .B   (B),
        .F   (F),
        .Y   (Y)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        A = 4'b0000;
        B = 4'b0000;
        F = 3'b000;

        #10;
        A = 4'b1100;
        B = 4'b1010;
        F = 3'b000;

        #10;
        A = 4'b1100;
        B = 4'b1010;
        F = 3'b001;

        #10;
        A = 4'd5;
        B = 4'd3;
        F = 3'b010;

        #10;
        A = 4'd7;
        B = 4'd2;
        F = 3'b011;

        #10;
        A = 4'b1100;
        B = 4'b1010;
        F = 3'b100;

        #10;
        A = 4'd9;
        B = 4'd4;
        F = 3'b101;

        #10;
        A = 4'b0101;
        B = 4'b0011;
        F = 3'b110;

        #10;
        A = 4'b0101;
        B = 4'b0000;
        F = 3'b111;

        #20;
        $stop;
    end

endmodule