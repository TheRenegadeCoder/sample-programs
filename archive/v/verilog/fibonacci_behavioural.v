//Verilog code Listing first 25 Fibonacci numbers till

module Fibonacci();

integer previous_value = 0;
integer current_value = 1;
integer clk = 0;

always #1 
    clk = ~clk;

always @(posedge clk)
begin
    current_value <= current_value + previous_value;
    previous_value <= current_value;
    $display("%0d", current_value);
end

initial #50 //Prints 25 fibonacci numbers as values change at POSEDGE of clock
    $finish;

endmodule

