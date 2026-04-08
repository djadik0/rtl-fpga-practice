module counter(
    input   logic  clk,
    input   logic  rst,
    
    output  logic  [2:0]  out
    );
    
    enum { sost_plus1,
    sost_plus2,
    sost_min } state;
    
    
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            out    <=  '0;
            state  <=  sost_plus1;
        end
        else begin case (state)
                        sost_plus1: begin
                            out    <=  out + 1;
                            state  <=  sost_plus2;
                        end

                        sost_plus2: begin
                            out    <=  out + 1;
                            state  <=  sost_min;
                        end

                        sost_min: begin
                            out    <=  out - 1;
                            state  <=  sost_plus1;
                        end
                        
                        default: begin
                            out    <= '0;
                            state  <= sost_plus1;
                        end 
                    endcase
            end
    end
    
endmodule
