a = ["foo", "bar", 20, "baz", 30, 40, "quux", 50]

p a.select &.is_a?(Int32)
   .map { |n| n // 10 } # compile error
