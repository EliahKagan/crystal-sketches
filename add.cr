def add(x : T, y : U) forall T, U
  puts "x : #{T}"
  puts "y : #{U}"
  x + y
end

p add(1, 2)
p add(0.1, 0.2)
