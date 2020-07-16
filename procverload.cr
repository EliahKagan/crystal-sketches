def apply(arg : T, &block : Proc(T, Nil)) forall T
  yield arg
end

def apply(&block : Proc(T, Nil) forall T)
  yield 42
end

apply(17) { |x| puts x * x }
apply { |x| puts x * x }
