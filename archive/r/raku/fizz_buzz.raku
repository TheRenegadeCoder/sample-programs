for 1..100 -> $i {
    if $i % 3 == 0 && $i % 5 == 0 {
        say "FizzBuzz"
    }
    elsif $i % 5 == 0 {
        say "Buzz"
    }
    elsif $i % 3 == 0 {
        say "Fizz"
    }
    else {
        say $i
    }
}