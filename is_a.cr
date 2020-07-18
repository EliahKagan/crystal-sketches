a = ["foo", "bar", 20, "baz", 30, 40, "quux", 50]
p a.map &.is_a?(String)
