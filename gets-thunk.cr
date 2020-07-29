# Just reports type and value.
def no_capture(n : Int32?)
  if n.nil?
    puts "Got nil."
  else
    puts "Got #{n}, static type #{typeof(n)}."
  end

  ->{ puts "This one never captures." }
end

# Creates a proc that, when called, prints a value and its type.
def capture_param(n : Int32?)
  if n.nil?
    puts "Got nil."
    ->{ puts "No capture." }
  else
    puts "Got #{n}, static type #{typeof(n)}."
    ->{ puts "Captured #{n}, static type #{typeof(n)}." }
  end
end

# Same, but manages more specific typing.
def capture_copy(n : Int32?)
  if n.nil?
    puts "Got nil."
    ->{ puts "No capture." }
  else
    puts "Got #{n}, static type #{typeof(n)}."
    copy = n
    ->{ puts "Captured #{copy}, static type #{typeof(copy)}." }
  end
end

if ARGV.empty?
  puts "You must pass an argument."
  exit 1
end

n = ARGV[0].to_i?

f = no_capture(n)
f.call

puts
g = capture_param(n)
g.call

puts
h = capture_copy(n)
h.call
