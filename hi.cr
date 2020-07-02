def greetable_name(raw_name)
  if raw_name.nil?  # on end-of-input (e.g., Ctrl+D)
    "whoever you were"
  elsif (stripped_name = raw_name.strip).empty?
    "unnamed person"
  else
    stripped_name
  end
end


print "Who are you?  "
name = greetable_name gets
puts "Hello, #{name}!"
