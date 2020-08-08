#!/usr/bin/env ruby
# frozen_string_literal: true

$VERBOSE = 1

actions = []
(1..5).each { |i| actions << ->{ puts "#{i} squared is #{i**2}." } }
actions.each &:call
