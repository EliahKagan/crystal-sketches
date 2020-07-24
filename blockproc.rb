#!/usr/bin/env ruby

$VERBOSE = 1

class Object
  def evens
    self.select(&:even?)
  end
  
  def each_even(&block)
    evens.each { |x| block.call x }
  end
end

(1..76).each_even { |x| p x }
