a, b = ARGV.map(&.to_i64)
#a, b = b, a if a < b

until b.zero?
  q = a // b
  r = a % b
  puts "#{a} = #{q} * #{b} + #{r}"
  a = b
  b = r
end

puts a
