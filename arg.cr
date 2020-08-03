begin
  n = ARGV[0].to_i
  puts "#{n} squared is #{n**2}."
rescue ArgumentError
  STDERR.puts %[#{PROGRAM_NAME}: error: can't square "#{ARGV[0]}"]
  exit 1
end
