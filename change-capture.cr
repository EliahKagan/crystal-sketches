x = 10
f = ->{ puts "Got #{x}, static type #{typeof(x)}." }
f.call
x = "foo"
f.call
