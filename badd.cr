def badly_add(m : UInt32, n : UInt32)
  if n.zero?
    m
  else
    badly_add(m + 1, n - 1)
  end
end

x, y = ARGV.map(&.to_u32)
puts badly_add(x, y)
