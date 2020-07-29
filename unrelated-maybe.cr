x = 42
puts "#{x} : #{typeof(x)}"

x = ARGV[0] unless ARGV.empty?
puts "#{x} : #{typeof(x)}"
