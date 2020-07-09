input = String.build do |io|
  while line = gets
    io.puts line
  end
end

STDERR.puts
STDERR.puts "Got #{input.size} characters."
STDERR.puts

print input
