print "> "
line = gets
exit if line.nil?
puts line.gsub('\\', %q{\\})
