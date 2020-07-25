#!/usr/bin/env ruby
# frozen_string_literal: true

$VERBOSE = 1

# Extensions for objects that are sequences of integers.
class Object
  def evens
    self.select(&:even?)
  end

  def each_even(&block)
    evens.each { |x| block.call x }
  end
end

if __FILE__ == $PROGRAM_NAME
  (1..76).each_even { |x| p x }
end
