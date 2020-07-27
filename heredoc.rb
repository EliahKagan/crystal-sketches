#!/usr/bin/env ruby
# frozen_string_literal: true

$VERBOSE = 1

# Convenience extensions for strings.
class String
  def chomped_lines
    lines.map(&:chomp!)
  end
end

<<-'EOF'.chomped_lines.zip(<<-'EOF'.chomped_lines) { |a, b| puts "#{a} #{b}" }
'Twas brillig, and
Did gyre and
All mimsy were
And the
EOF
the slithy toves
gimble in the wabe
the borogroves,
mome raths outgrabe.
EOF
