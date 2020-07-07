def collatz(n)
  yield n
  while n != 1
    n = (n.even? ? n // 2 : n * 3 + 1)
    yield n
  end
end

collatz(101) { |n| puts n }
