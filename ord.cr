while line = gets
  puts line.chars.map { |ch| " %02X" % ch.ord }.join
end
