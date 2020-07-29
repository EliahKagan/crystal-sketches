iterator = ARGV.each
while (item = iterator.next) != Iterator::Stop
  last = item
end

puts "#{last} : #{typeof(last)} (#{last.class})"
