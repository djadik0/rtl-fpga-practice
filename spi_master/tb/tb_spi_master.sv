module tb_spi_master;

  logic        clk;
  logic        rst;

  logic        start;
  logic [7:0]  tx_data;

  logic [7:0]  rx_data;
  logic        busy;
  logic        done;

  logic        sclk;
  logic        mosi;
  logic        miso;
  logic        cs_n;

  spi_master #(
    .CLK_FREQ(50_000_000),
    .SCLK_FREQ(5_000_000)
  ) dut (
    .*
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst     = 0;
    start   = 0;
    tx_data = 0;
    miso    = 0;

    #20;
    rst = 1;
    #20;

    tx_data = 8'hA5;
    start   = 1;
    #10;
    start   = 0;

    wait (cs_n == 0);

    miso = 0;
    @(negedge sclk); miso = 0;
    @(negedge sclk); miso = 1;
    @(negedge sclk); miso = 1;
    @(negedge sclk); miso = 1;
    @(negedge sclk); miso = 1;
    @(negedge sclk); miso = 0;
    @(negedge sclk); miso = 0;

    wait (done == 1);

    $display("TEST 1");
    $display("tx_data = %h", tx_data);
    $display("rx_data = %h", rx_data);

    #50;

    tx_data = 8'h5A;
    start   = 1;
    #10;
    start   = 0;

    wait (cs_n == 0);

    miso = 1;
    @(negedge sclk); miso = 1;
    @(negedge sclk); miso = 0;
    @(negedge sclk); miso = 0;
    @(negedge sclk); miso = 1;
    @(negedge sclk); miso = 0;
    @(negedge sclk); miso = 1;
    @(negedge sclk); miso = 0;

    wait (done == 1);

    $display("TEST 2");
    $display("tx_data = %h", tx_data);
    $display("rx_data = %h", rx_data);

    #50;

    $stop;
  end

endmodule