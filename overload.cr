# As stated in:
#
# https://crystal-lang.org/reference/syntax_and_semantics/blocks_and_procs.html
#
# "The difference between using `do ... end` and `{ ... }` is that `do ... end`
#  binds to the left-most call, while `{ ... }` binds to the right-most call"


# This f accepts: one argument + a block.
def f(x)
  puts "Called f(#{x}) with a block."
  yield x
end

# This f accepts: one argument.
def f(x)
  puts "Called f(#{x}), no block."
end

# This g accepts: nothing.
def g
  puts "Called g(), no block."
end

# This g accepts: a block.
def g
  puts "Called g() with a block."
  yield
end


f g do
  puts "...in a do-end block."
end

puts

f g { puts "...in a braced block." }
