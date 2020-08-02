# Is the multi-line braced block style allowed in Crystal?

1.upto(100) { |i|
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
}
