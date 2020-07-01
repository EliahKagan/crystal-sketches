def seq(first, last)
  first.to(last) { |i| puts i }
end

case ARGV.size
when 1
  seq 1, ARGV[0].to_i
when 2
  seq ARGV[0].to_i, ARGV[1].to_i
end
