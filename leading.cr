count0 = <<-STOP.count &.whitespace?
  one two three
  four five six
  seven eight nine
STOP
puts "There are #{count0} whitespace characters with an unindented delimiter."

count1 = <<-STOP.count &.whitespace?
  one two three
  four five six
  seven eight nine
 STOP
puts "There are #{count1} whitespace characters with a slighly indented delimiter."

count2 = <<-STOP.count &.whitespace?
  one two three
  four five six
  seven eight nine
  STOP
puts "There are #{count2} whitespace characters with a more indented delimiter."
