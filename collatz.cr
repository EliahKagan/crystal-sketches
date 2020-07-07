def collatz(n)
  yield n
  while n != 1
    n = (n.even? ? n // 2 : n * 3 + 1)
    yield n
  end
end


extra_newline = false

ARGV.map(&.to_i).each do |arg|
  puts if extra_newline
  collatz(arg) { |n| puts n }
  extra_newline = true
end
