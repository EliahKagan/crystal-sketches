x = 10
puts "Have #{x}, static type #{typeof(x)}."
#f = ->{ puts "Captured #{x}, static type #{typeof(x)}." }
#f.call
x = "foo"
puts "Have #{x}, static type #{typeof(x)}."
#f.call
