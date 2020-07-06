while line = gets
  line.each_char { |ch| printf " %02X", ch.ord }
  puts
end
