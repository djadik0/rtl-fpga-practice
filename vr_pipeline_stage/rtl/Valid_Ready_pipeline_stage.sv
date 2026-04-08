module vr_pipeline_stage #(
    parameter int DATA_W = 8
) 
(
  input  logic                clk_i,
  input  logic                rstn_i,

  input  logic                s_valid_i,
  input  logic  [DATA_W-1:0]  s_data_i,
  output logic                s_ready_o,

  output logic                m_valid_o,
  output logic  [DATA_W-1:0]  m_data_o,
  input  logic                m_ready_i
); 

    logic                handshake_s;
    logic                handshake_m;
    logic  [DATA_W-1:0]  m_data_ff;
    logic                valid_reg;

    assign  handshake_s  =  s_ready_o & s_valid_i;
    assign  handshake_m  =  m_valid_o & m_ready_i;

    always_ff @( posedge clk_i or negedge rstn_i ) begin
      if ( !rstn_i ) 
        m_data_ff  <=  0;
      else if ( handshake_s )
        m_data_ff  <=  s_data_i;    
    end

    always_ff @( posedge clk_i or negedge rstn_i ) begin
        if ( !rstn_i )
          valid_reg  <=  0;
        else if ( handshake_s )
          valid_reg  <=  s_valid_i;
        else if ( handshake_m)
          valid_reg  <=  0;
    end

    assign  m_valid_o  =  valid_reg;
    assign  s_ready_o  =  !valid_reg | m_ready_i;
    assign  m_data_o   =  m_data_ff;

endmodule