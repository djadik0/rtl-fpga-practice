
module ALU(
    input                 clk,
    input   logic  [3:0]  A,
    input   logic  [3:0]  B,
    input   logic  [2:0]  F,
    
    output  logic  [3:0]  Y
    );
    
    always_ff @( posedge clk ) begin
              case ( F ) 
                  3'b000: Y <= A & B;
                  3'b001: Y <= A | B;
                  3'b010: Y <= A + B;
                  3'b100: Y <= A ^ B;
                  3'b101: Y <= A - B;
                  3'b110: Y <= A | ( ~B );
                  3'b111: Y <= ~A;
                  default: Y <= '0;
              endcase
     end
    
endmodule
