#!/usr/bin/env ruby
# frozen_string_literal: true

$VERBOSE = 1

class Enumerator
  def take_until
    take_while { |item| !yield(item) }
  end
end

if __FILE__ == $PROGRAM_NAME
  loop do
    lines = ARGF.each_line.lazy.map(&:rstrip).take_until(&:empty?).to_a
    break if lines.empty?
    lines.each { |line| puts line }
  end
end
