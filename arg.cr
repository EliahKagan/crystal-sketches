def die(message)
  STDERR.puts "#{PROGRAM_NAME}: error: #{message}"
  exit 1
end

begin
  n = ARGV[0].to_i
  puts "#{n} squared is #{n**2}."
rescue IndexError
  die "too few arguments"
rescue ArgumentError
  die %[can't square "#{ARGV[0]}"]
end
