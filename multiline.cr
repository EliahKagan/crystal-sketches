lines = ["123 -> x", "456 -> y", "", " x AND y -> d  ", "  \t ", "\ty RSHIFT\t2 ->\tg  "]

lines.map(&.strip)
     .reject(&.empty?)
     .map(&.split(/\s+->\s+/))
     .tap { |thing| pp thing }
     .each { |thing| pp thing }
    #.tap { |tokens| raise "malformed expression" unless tokens.size == 2 }
    #.each { |tokens| puts "(#{tokens[0]}, #{tokens[1]})" }
