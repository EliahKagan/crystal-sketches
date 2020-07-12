#ARGF.each_line { |line| pp line }
#p ARGF.gets_to_end
pp ARGF.each_line.map(&.rstrip).map(&.chars).to_a
