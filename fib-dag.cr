INDENT = "    "

raise "wrong number of arguments" if ARGV.size != 1
n = ARGV[0].to_i

puts "digraph G {"

0.upto(n - 2) do |src|
  (src + 1).upto(src + 2) { |dest| puts "#{INDENT} #{src} -> #{dest}" }
end

puts "}"
