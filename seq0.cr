def seq(first, last)
  if last < first
    first.downto(last) { |i| puts i }
  else
    first.upto(last) { |i| puts i }
  end
end

case ARGV.size
when 1
  seq 1, ARGV[0].to_i
when 2
  seq ARGV[0].to_i, ARGV[1].to_i
end
