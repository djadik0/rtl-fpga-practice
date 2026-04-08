module cofe_top(

    input   logic         clk,
    input   logic         rst,
    input   logic         one_coin,
    input   logic         two_coin,
    input   logic         five_coin,
    input   logic         ten_coin,
    input   logic         select,
    
    output  logic  [4:0]  cashback,
    output  logic         coffe, 
    output  logic         coffe_with_milk  

    );

    logic  [5:0]  summ;

    always_ff @(posedge clk or negedge rst) begin
        if ( !rst ) begin 
            summ             <=  0;
            coffe            <=  0;
            coffe_with_milk  <=  0;
            cashback         <=  0;
        end
        else begin 
            coffe            <=  0;
            coffe_with_milk  <=  0;
            cashback         <=  0;
            if ( one_coin )
                summ  <=  summ + 1;
            else if ( two_coin )
                summ  <=  summ + 2;
            else if ( five_coin )
                summ  <=  summ + 5;
            else if ( ten_coin )
                summ  <=  summ + 10;
            else if ( summ >= 27 && select == 0 ) begin
                coffe     <=  1;
                cashback  <=  summ - 27;
                summ      <=  0;
            end else if ( summ >= 33 && select == 1 ) begin 
                        coffe_with_milk  <=  1;
                        cashback         <=  summ - 33;
                        summ             <=  0;
            end 
        end
    end

endmodule
