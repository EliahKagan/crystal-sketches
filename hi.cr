def greetable_name(name)
  if name.nil?
    "whoever you were"  # on end-of-input (e.g., Ctrl+D)
  else
    stripped_name = name.strip
    stripped_name.size == 0 ? "unnamed person" : stripped_name
  end
end


print "Who are you?  "
puts "Hello, #{greetable_name gets}!"
