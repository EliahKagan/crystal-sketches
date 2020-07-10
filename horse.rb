#!/usr/bin/env ruby
# frozen_string_literal: true

$VERBOSE = 1

# A simple class, to demonstrate how Ruby string interpolation allows both
# {@attribute} and #@attribute.
class Horse
  def initialize(name)
    @name = name
  end

  def to_s
    "A horse, #@name." # Ruby supports omitting { } here.
  end
end

if __FILE__ == $PROGRAM_NAME
  h = Horse.new('Bob')
  puts h
end
