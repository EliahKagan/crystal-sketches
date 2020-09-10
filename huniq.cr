# huniq - hash uniq - Print input line-by-line, but only print each line once.

history = Set(String).new

ARGF.each_line do |line|
  next if history.includes?(line)
  history << line
  puts line
end
