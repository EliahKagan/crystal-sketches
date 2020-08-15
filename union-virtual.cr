# Example from:
# https://crystal-lang.org/reference/syntax_and_semantics/union_types.html#union-of-classes-and-structs-under-the-same-hierarchy
# This does not seem to work the way that says it should.

class Foo
end

class Bar < Foo
end

class Baz < Foo
end

bar = Bar.new
baz = Baz.new

foo = rand < 0.5 ? bar : baz
pp typeof(foo) # Prints Foo, not Foo+
pp typeof(foo) == Foo # Prints false
