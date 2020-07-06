if line = gets
  line.each_char { |ch| printf " %X", ch.ord }
  puts
end
