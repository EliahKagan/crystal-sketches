a = ["foo", "bar", "baz", Iterator::Stop.new, "quux", "foobar"]
a.each { |x| puts x }
puts
a.each.each { |x| puts x }
puts
a.each_with_index { |x, i| puts "#{i}: #{x}" }
puts
a.each.each_with_index { |x, i| puts "#{i}: #{x}" }
