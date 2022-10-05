unit UBubbleSort;

interface

type
  // data type
  TItemBubbleSort=integer;

procedure BubbleSort( var a: array of TItemBubbleSort );


implementation

procedure swap( var a, b:TItemBubbleSort );
var
  temp : TItemBubbleSort;
begin
  temp := a;
  a := b;
  b := temp;
end;


procedure BubbleSort( var a: array of TItemBubbleSort );
var
  n, newn, i:integer;
begin
  n := high( a );
  repeat
    newn := 0;
    for i := 1 to n   do
      begin
        if a[ i - 1 ] > a[ i ] then
          begin
            swap( a[ i - 1 ], a[ i ]);
            newn := i ;
          end;
      end ;
    n := newn;
  until n = 0;
end;

end.
