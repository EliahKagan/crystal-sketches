#!/usr/bin/env ruby
# frozen_string_literal: true
$VERBOSE = 1

class Horse
  def initialize(name)
    @name = name
  end

  # def to_s(io)
  #   io << "A horse, #{@name}."
  # end

  def to_s
    "A horse, #{@name}."
  end
end

h = Horse.new("Bob")
puts h
