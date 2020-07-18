def multapply(arg : T, &block : Proc(T, T)) forall T
  puts "First version called."
  yield arg
end

def multapply(arg : T, &block : Proc(T, T, T)) forall T
  puts "Second version called."
  yield arg, arg
end

puts multapply(7) { |x| x * 2 }    # Calls the second version!!
puts multapply(7) { |x, y| x * y } # Calls the second version.
