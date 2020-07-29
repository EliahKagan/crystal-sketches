#!/usr/bin/env ruby
# frozen_string_literal: true

$VERBOSE = 1

for arg in ARGV
  last = arg
end

puts "#{last} (#{last.class})"
