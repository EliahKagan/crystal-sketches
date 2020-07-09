def thrice(first, second, third)
  yield first
  yield second
  yield third
end

thrice("Alice", "Bob", "Cassidy") { |name| puts "Hello, #{name}!" }
