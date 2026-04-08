module binary_coded(
    input   logic  clk,
    input   logic  rst,
    input   logic  CE,
    input   logic  L,
    input   logic  D0,
    input   logic  D1,
    input   logic  D2,
    input   logic  D3,
    
    output  logic  Q0,
    output  logic  Q1,
    output  logic  Q2,
    output  logic  Q3,
    output  logic  TC

    );
    
    
    logic  [3:0]  counter; 

    always_ff @( posedge clk or posedge rst ) begin
        if ( rst ) begin
            counter  <=  4'b0;
        end else if ( L ) begin
                counter  <=  { D3, D2, D1, D0 };
        end else if ( CE )  begin
            if ( counter == 4'b1001 ) 
                counter  <=  '0;
            else 
                counter  <= counter + 1;
            end
    end
    
    
    assign  TC                  =  ( counter == 4'b1001 );
    assign  { Q3, Q2, Q1, Q0 }  =  counter;
    
endmodule