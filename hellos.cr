if ARGV.size != 0 && ARGV[0]
  name = ARGV[0]
else
  name = "whoever you are"
end

puts "Hello, #{name}!"
print "Hello, #{name}!\n"
printf "Hello, %s!\n", name
