puts "There are #{<<-STOP.count &.whitespace?} whitespace characters."
  one two three
  four five six
  seven eight nine
STOP

puts "There are #{<<-STOP.count &.whitespace?} whitespace characters."
  one two three
  four five six
  seven eight nine
  STOP

