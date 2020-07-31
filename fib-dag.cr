INDENT = "   "

raise "wrong number of arguments" if ARGV.size != 1
n = ARGV[0].to_i

puts "digraph G {"

n.downto(2) do |src|
  {src - 2, src - 1}.each { |dest| puts "#{INDENT} #{src} -> #{dest}" }
end

puts "}"
