def f
  10.times { yield }
end

def g(&block)
  10.times { yield }
end

f do |i|
  break if i == 5
  puts i
end

puts

g do |i|
  break if i == 5
  puts i
end
