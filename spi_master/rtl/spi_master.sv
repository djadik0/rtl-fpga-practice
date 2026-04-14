module spi_master#(
    parameter CLK_FREQ = 50_000_000,
    parameter SCLK_FREQ = 1_000_000,
    parameter CLKS_PER_HALF_SCLK = CLK_FREQ / (2*SCLK_FREQ)
)(
  input  logic        clk,
  input  logic        rst,

  input  logic        start,
  input  logic [7:0]  tx_data,

  output logic [7:0]  rx_data,
  output logic        busy,
  output logic        done,

  output logic        sclk,
  output logic        mosi, // провод от master к slave
  input  logic        miso, // провод от slave к master 
  output logic        cs_n

);

  logic  [$clog2(CLKS_PER_HALF_SCLK)-1:0]  clk_cnt;
  logic  [7:0]                             tx_data_ff;
  logic  [7:0]                             rx_data_ff;
  logic  [3:0]                             data_cnt;




  enum {
    IDLE,
    START,
    TRANSFER,
    DONE
  } state;

  always_ff @( posedge clk or negedge rst ) begin
    if ( !rst ) begin 
          state       <=  IDLE;
          cs_n        <=  1;
          sclk        <=  0;
          busy        <=  0;
          data_cnt    <=  '0;
          done        <=  0;
          tx_data_ff  <=  '0;
          rx_data_ff  <=  '0;
          clk_cnt     <=  '0;
          mosi        <=  0;
    end
    else case ( state )
            IDLE: begin
              cs_n      <=  1;
              sclk      <=  0;
              busy      <=  0;
              done      <=  0;
              data_cnt  <=  0;
              if ( start )
                state  <= START;
            end

            START: begin
              cs_n        <=  0;
              busy        <=  1;
              tx_data_ff  <=  tx_data;
              mosi        <=  tx_data[7];
              clk_cnt     <=  '0;
              data_cnt    <=  '0;
              sclk        <=  0;
              done        <=  0;
              state       <=  TRANSFER; 
            end

            TRANSFER: begin 
                if (clk_cnt == CLKS_PER_HALF_SCLK-1) begin
                  clk_cnt <= '0;

                if (sclk == 0) begin
                    sclk <= 1;
                    rx_data_ff[7 - data_cnt] <= miso;
                end
                else begin
                    sclk <= 0;

                    if (data_cnt == 7) begin
                      state <= DONE;
                    end
                    else begin
                      data_cnt <= data_cnt + 1;
                      mosi <= tx_data_ff[7 - (data_cnt + 1)];
                    end
                end
                end
                else begin
                  clk_cnt <= clk_cnt + 1;
                end
            end

            DONE: begin 
              cs_n   <=  1;
              busy   <=  0;
              done   <=  1;
              state  <= IDLE;
            end

    endcase 
  end


  assign rx_data  =  rx_data_ff;


endmodule