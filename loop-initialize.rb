#!/usr/bin/env ruby
# frozen_string_literal: true

$VERBOSE = 1

ARGV.each { |arg| last = arg }
puts "#{last} : #{typeof(last)} (#{last.class})"
