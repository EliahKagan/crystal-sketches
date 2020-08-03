def die(message)
  STDERR.puts "#{PROGRAM_NAME}: error: #{message}"
  exit 1
end

arg = ARGV[0]?
die "too few arguments" if arg.nil?
n = arg.to_i?
die %[can't square #{ARGV[0]}] if n.nil?
puts "#{n} squared is #{n**2}."
