`timescale 1ns / 1ps

module tb_flatten_layer();

    parameter SIZE_MATRIX  = 4;
    parameter WIDTH        = 8;
    parameter SIZE_IMAGE   = 64;
    parameter WIDTH_OUT    = WIDTH + 4;
    parameter NUM_FILTERS  = 4;
    parameter POOL_SIZE    = 2;
    parameter STRIDE       = 2;
    parameter CONV_SIZE    = SIZE_IMAGE - SIZE_MATRIX + 1;
    parameter SIZE_OUT     = (CONV_SIZE - POOL_SIZE)/STRIDE + 1;
    parameter FLATTEN_SIZE = SIZE_OUT * SIZE_OUT * NUM_FILTERS;

    logic [WIDTH_OUT-1:0] pooling_matrix_o [0:NUM_FILTERS-1][0:SIZE_OUT-1][0:SIZE_OUT-1];
    logic [WIDTH_OUT-1:0] flatten_vector_o [0:FLATTEN_SIZE-1];

    flatten_layer #(
        .SIZE_MATRIX  (SIZE_MATRIX),
        .WIDTH        (WIDTH),
        .SIZE_IMAGE   (SIZE_IMAGE),
        .WIDTH_OUT    (WIDTH_OUT),
        .NUM_FILTERS  (NUM_FILTERS),
        .POOL_SIZE    (POOL_SIZE),
        .STRIDE       (STRIDE),
        .CONV_SIZE    (CONV_SIZE),
        .SIZE_OUT     (SIZE_OUT),
        .FLATTEN_SIZE (FLATTEN_SIZE)
    ) dut (
        .pooling_matrix_o (pooling_matrix_o),
        .flatten_vector_o (flatten_vector_o)
    );

    integer f, y, x;

    initial begin
        for (f = 0; f < NUM_FILTERS; f = f + 1) begin
            for (y = 0; y < SIZE_OUT; y = y + 1) begin
                for (x = 0; x < SIZE_OUT; x = x + 1) begin
                    pooling_matrix_o[f][y][x] = f*100 + y*10 + x;
                end
            end
        end

        #20;
        $stop;
    end

endmodule