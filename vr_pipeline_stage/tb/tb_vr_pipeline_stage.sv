`timescale 1ns / 1ps

module tb_vr_pipeline_stage();

    logic       clk_i;
    logic       rstn_i;

    logic       s_valid_i;
    logic [7:0] s_data_i;
    logic       s_ready_o;

    logic       m_valid_o;
    logic [7:0] m_data_o;
    logic       m_ready_i;

    vr_pipeline_stage #(
        .DATA_W(8)
    ) dut (
        .clk_i    (clk_i),
        .rstn_i   (rstn_i),
        .s_valid_i(s_valid_i),
        .s_data_i (s_data_i),
        .s_ready_o(s_ready_o),
        .m_valid_o(m_valid_o),
        .m_data_o (m_data_o),
        .m_ready_i(m_ready_i)
    );

    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i;
    end

    initial begin
        rstn_i   = 0;
        s_valid_i = 0;
        s_data_i  = 0;
        m_ready_i = 0;

        #10;
        rstn_i = 1;
        #10;

        s_valid_i = 1;
        s_data_i  = 8'h15;
        m_ready_i = 1;
        #10;

        s_valid_i = 0;
        s_data_i  = 8'h00;
        #10;

        s_valid_i = 1;
        s_data_i  = 8'h2A;
        m_ready_i = 0;
        #10;

        s_valid_i = 0;
        #20;

        m_ready_i = 1;
        #10;

        s_valid_i = 1;
        s_data_i  = 8'h3C;
        #10;

        s_valid_i = 0;
        #20;

        $stop;
    end

endmodule