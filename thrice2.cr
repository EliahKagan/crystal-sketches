def thrice(first, second, third)
  yield first
  yield second
  yield third
end

thrice("Alice", "Bob", "Cassidy") do |name|
  puts "Hello, #{name}!"
end
