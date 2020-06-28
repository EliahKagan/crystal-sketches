# Crystal FizzBuzz program.

1.upto(100) do |i|
  fizz = i % 3 == 0
  buzz = i % 5 == 0

  if fizz && buzz
    puts "FizzBuzz"
  elsif fizz
    puts "Fizz"
  elsif buzz
    puts "Buzz"
  else
    puts i
  end
end
