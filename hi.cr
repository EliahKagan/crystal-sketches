def greetable_name(name)
  if name.nil?
    "whoever you are"
  else
    name = name.strip
    name.size == 0 ? "unnamed person" : name
  end
end


print "Who are you?  "
puts "Hello, #{greetable_name gets}!"
