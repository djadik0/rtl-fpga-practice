
create_clock -name clk -period 3 [get_ports clk] 
set_clock_latency 0.7 -source -max [get_clocks clk]
set_clock_latency 0.3 -max [get_clocks clk]
set_clock_uncertainty 0.29 -setup [get_clocks clk]
set_clock_transition 0.12 [get_clocks clk]

set_input_delay 2.2 -clock clk -max [get_ports {data1 data2}]
set_input_delay 1.4 -clock clk -max [get_ports sel]

set_output_delay 0.5 -clock clk -max [get_ports out1]
set_output_delay 0.81 -clock clk -max [get_ports out2]
set_output_delay 0.4 -clock clk -max [get_ports out3]

set_max_delay 2.45 -from [get_ports {Cin1 Cin2}] -to [get_ports Cout]
