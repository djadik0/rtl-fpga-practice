module waveform(
    input   logic  clock,
    input   logic  input_signal,
    
    output  logic  output_signal
    );
    
    logic  [1:0]  cnt;
    logic         en;
    
    always_ff @( posedge clock ) begin
        if ( input_signal ) begin 
            en             <=  1;
            output_signal  <=  1;
            cnt            <=  '0;
        end else if ( cnt == 2 ) begin
            output_signal  <=  0;
            en             <=  0;
            cnt            <=  '0;
        end else if ( en ) begin
            output_signal  <=  1;
            cnt            <=  cnt + 1;
        end else 
            output_signal  <=  0;
    end
    
    
endmodule
