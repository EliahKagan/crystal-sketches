line = gets
puts "typeof(line) == #{typeof(line)}"

if line.nil?
  puts "Failed to read a line."
  puts "typeof(line) == #{typeof(line)}"
  exit
end

puts "Successfully read a line."
puts "typeof(line) == #{typeof(line)}"
