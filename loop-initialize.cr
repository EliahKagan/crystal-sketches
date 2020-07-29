iterator = ARGV.each
while (item = iterator.next).is_a?(String)
  last = item
end

puts "#{last} : #{typeof(last)} (#{last.class})"
