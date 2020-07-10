#!/usr/bin/env ruby
# frozen_string_literal: true

# Unlike Crystal, Ruby doesn't support overloading. But it does support
# optional blocks via block_given?. This program tests if the major non-obvious
# syntactic difference between do ... end and { ... } style blocks in Crystal
# also appears in Ruby. (It does.) See overload.cr.

$VERBOSE = 1


def f(x)
  if block_given?
    puts "Called f(#{x}) with a block."
    yield x
  else
    puts "Called f(#{x}), no block."
  end
end

def g
  if block_given?
    puts 'Called g() with a block.'
    yield
  else
    puts 'Called g(), no block.'
  end
end

if __FILE__ == $PROGRAM_NAME
  f g do
    puts '...in a do-end block.'
  end

  puts

  f g { puts '...in a braced block.' }
end
