print "> "
line = gets
exit if line.nil? || line.empty?
puts line.gsub('\\', %q{\\})
