`timescale 1ns / 1ps

module tb_waveform();

    logic clock;
    logic input_signal;
    logic output_signal;

    waveform uut (
        .clock        (clock),
        .input_signal (input_signal),
        .output_signal(output_signal)
    );

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        input_signal = 0;

        #12;
        input_signal = 1;
        #10;
        input_signal = 0;

        #50;
        input_signal = 1;
        #10;
        input_signal = 0;


        #20;
        input_signal = 1;
        #10;
        input_signal = 0;

        #60;
        $stop;
    end

endmodule