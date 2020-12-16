loop do
  lines = ARGF.each_line.map(&.rstrip).take_while { |line| !line.empty? }.to_a
  break if lines.empty?
  lines.each { |line| puts line }
end
