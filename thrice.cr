def thrice
  yield
  yield
  yield
end

thrice do
  puts "Hello, world!"
end
