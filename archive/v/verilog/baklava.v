module main;
  integer i, j, numSpaces, numStars;
  initial begin
    for (i = -10; i <= 10; i += 1) begin
      numSpaces = i;
      if (numSpaces < 0) begin
        numSpaces = -numSpaces;
      end

      for (j = 0; j < numSpaces; j += 1) begin
        $write(" ");
      end

      numStars = 21 - 2 * numSpaces;
      for (j = 0; j < numStars; j += 1) begin
        $write("*");
      end

      $write("\n");
    end
    $finish(0);
  end
endmodule
