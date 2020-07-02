def greetable_name(name)
  if name.nil?  # on end-of-input (e.g., Ctrl+D)
    "whoever you were"
  elsif (stripped_name = name.strip).size == 0
    "unnamed person"
  else
    stripped_name
  end
end


print "Who are you?  "
puts "Hello, #{greetable_name gets}!"
