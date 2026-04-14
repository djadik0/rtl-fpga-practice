module tb_axi_stream_width_converter_32_to_8;

  logic        clk;
  logic        rst;

  logic [31:0] s_axis_tdata;
  logic        s_axis_tvalid;
  logic        s_axis_tready;

  logic [7:0]  m_axis_tdata;
  logic        m_axis_tvalid;
  logic        m_axis_tready;

  axi_stream_width_converter_32_to_8 dut (
    .*
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 0;

    s_axis_tdata  = 0;
    s_axis_tvalid = 0;
    m_axis_tready = 0;

    #20;
    rst = 1;
    #20;

    // TEST 1: обычная передача 32'h11223344
    m_axis_tready = 1;

    s_axis_tdata  = 32'h11223344;
    s_axis_tvalid = 1;

    #10;
    s_axis_tvalid = 0;
    s_axis_tdata  = 0;

    #60;

    // TEST 2: ещё одно слово
    s_axis_tdata  = 32'hAABBCCDD;
    s_axis_tvalid = 1;

    #10;
    s_axis_tvalid = 0;
    s_axis_tdata  = 0;

    #60;

    // TEST 3: пауза на выходе через m_axis_tready
    s_axis_tdata  = 32'hDEADBEEF;
    s_axis_tvalid = 1;

    #10;
    s_axis_tvalid = 0;
    s_axis_tdata  = 0;

    #15;
    m_axis_tready = 0;

    #30;
    m_axis_tready = 1;

    #80;

    $stop;
  end

endmodule