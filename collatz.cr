def collatz(seed)
  yield seed
  while seed != 1
    seed = (seed.even? ? seed // 2 : seed * 3 + 1)
    yield seed
  end
end


extra_newline = false

ARGV.map(&.to_i).each do |seed|
  puts if extra_newline
  collatz(seed) { |value| puts value }
  extra_newline = true
end
