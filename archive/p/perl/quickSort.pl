@sortedList = quicksort(3, 2, 6, 7, 4, 8, 9, 1, 5);
   foreach my $variable (@sortedList) 
   {
     print "$variable ";
   }
 print "\n";
 
 sub quicksort 
  {
    my @list = @_;
    if($#list < 1)
    {
      return @list;
    }
    my $pivotNumber = pop(@list);
    my @smallerNumbers; 
    my @biggerNumbers;
    foreach my $variable (@list) 
    {
      if ($variable < $pivotNumber)
      {
        push(@smallerNumbers, $variable);
      } 
      else 
      {
        push(@biggerNumbers, $variable);
      }
    }
    return quicksort(@smallerNumbers), $pivotNumber, quicksort(@biggerNumbers);
 }
