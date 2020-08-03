n = ARGV[0].to_i?

if n.nil?
  STDERR.puts %[#{PROGRAM_NAME}: error: can't square #{ARGV[0]}]
  #exit 1
end

puts "#{n} squared is #{n**2}."
