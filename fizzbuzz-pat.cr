# Crystal FizzBuzz program, pattern-matching style.

1.upto(100) do |i|
  case {i % 3, i % 5}
  when {0, 0}
    puts "FizzBuzz"
  when {0, _}
    puts "Fizz"
  when {_, 0}
    puts "Buzz"
  when {_, _}
    puts i
  end
end
