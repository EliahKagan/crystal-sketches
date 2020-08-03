def die(message)
  STDERR.puts "#{PROGRAM_NAME}: error: #{message}"
  exit 1
end

arg = ARGV[0]?
puts "arg : #{typeof(arg)}"
die "too few arguments" if arg.nil?
puts "arg : #{typeof(arg)}"
n = arg.to_i?
puts "n : #{typeof(n)}"
die %[can't square #{ARGV[0]}] if n.nil?
puts "n : #{typeof(n)}"
puts "#{n} squared is #{n**2}."
