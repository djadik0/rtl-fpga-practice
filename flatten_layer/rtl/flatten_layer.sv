
module flatten_layer#(
    parameter SIZE_MATRIX     =  4,
    parameter WIDTH           =  8,
    parameter SIZE_IMAGE      =  64,
    parameter WIDTH_OUT       =  WIDTH+4,
    parameter NUM_FILTERS     =  4,
    parameter POOL_SIZE       =  2,
    parameter STRIDE          =  2,  
    parameter CONV_SIZE       =  SIZE_IMAGE - SIZE_MATRIX + 1,
    parameter SIZE_OUT        =  (CONV_SIZE - POOL_SIZE)/STRIDE + 1,
    parameter FLATTEN_SIZE    =  SIZE_OUT*SIZE_OUT*NUM_FILTERS
)
(
    input   logic  [WIDTH_OUT-1:0]         pooling_matrix_o   [0:NUM_FILTERS-1][0:SIZE_OUT-1][0:SIZE_OUT-1],

    output  logic  [WIDTH_OUT-1:0]         flatten_vector_o   [0:FLATTEN_SIZE-1]

    );

    int t;

    always_comb begin  
        t  =  0;
         for (int f=0; f < NUM_FILTERS; f++ ) begin
            for ( int y=0; y < SIZE_OUT; y++ ) begin
                for ( int x=0; x < SIZE_OUT; x++ ) begin
                    flatten_vector_o[t]  =  pooling_matrix_o[f][y][x];
                    t                    =  t + 1;
                end
            end
         end
    end


endmodule
