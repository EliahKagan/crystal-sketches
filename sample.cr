require "random"

def sample(size)
  STDERR.puts "Entered sample()."
  Array.new(size) { Random.rand }
end

ARGV.each.map(&.to_i).map { |size| sample(size) }.each do |vals|
  pp vals
  puts
end
