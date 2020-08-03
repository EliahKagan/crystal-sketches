print "Enter a number to square: "
line = gets

if line.nil?
  puts "\nGot end-of-input."
  exit
end

n = line.to_i?
if n.nil?
  puts "I can't square that."
else
  puts "That squares to #{n**2}."
end
