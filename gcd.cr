def gcd(a, b)
  until b.zero?
    q = a // b # Not needed for this version of the algorithm.
    r = a % b
    a = b
    b = r
  end

  a
end

a, b = ARGV.map(&.to_i64)
puts gcd(a, b)
