module axi_stream_width_converter_32_to_8(
  input  logic        clk,
  input  logic        rst,

  input  logic [31:0] s_axis_tdata,
  input  logic        s_axis_tvalid,
  output logic        s_axis_tready,

  output logic [7:0]  m_axis_tdata,
  output logic        m_axis_tvalid,
  input  logic        m_axis_tready
);

  logic  [31:0]  s_axis_tdata_ff;
  logic  [7:0]   m_axis_tdata_ff;

  enum{
    IDLE,
    DATA,
    DATA1,
    DATA2,
    DATA3
  } state;

  always_ff @( posedge clk or negedge rst ) begin 
    if ( !rst ) begin 
        state             <=  IDLE;
        m_axis_tdata_ff   <=  '0;
        s_axis_tdata_ff   <=  '0; 
        s_axis_tready     <=  1;
    end
    else begin case ( state )
                  IDLE: begin
                    if (s_axis_tvalid & s_axis_tready) begin
                        s_axis_tdata_ff   <=  s_axis_tdata;
                        state             <=  DATA;
                        m_axis_tdata_ff   <=  s_axis_tdata[7:0];
                    end 
                  end

                  DATA: begin 
                    if ( m_axis_tready & m_axis_tvalid  ) begin
                      state             <=  DATA1;
                      m_axis_tdata_ff   <=  s_axis_tdata_ff[15:8];
                    end
                  end

                  DATA1: begin 
                    if ( m_axis_tready & m_axis_tvalid  ) begin
                      m_axis_tdata_ff   <=  s_axis_tdata_ff[23:16];
                      state             <=  DATA2;
                    end
                  end

                  DATA2: begin 
                    if ( m_axis_tready & m_axis_tvalid ) begin
                      m_axis_tdata_ff   <=  s_axis_tdata_ff[31:24];
                      state             <=  DATA3;
                    end
                  end

                  DATA3: begin 
                    if ( m_axis_tready & m_axis_tvalid  ) begin
                      state             <=  IDLE;
                      m_axis_tdata_ff   <=  '0;
                    end
                  end

        endcase
    end
  end




  assign  s_axis_tready  =  ( state == IDLE );
  assign  m_axis_tvalid  =  ( state == DATA ) |  ( state == DATA1  ) |  ( state == DATA2  ) |  ( state == DATA3 ) ;
  assign  m_axis_tdata   =  m_axis_tdata_ff;


endmodule