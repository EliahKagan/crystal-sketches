def f
  puts "No block."
end

def f(&block : Proc(T)) forall T # never called
  puts
  puts "Passing 0 arguments to a block."
  result = yield
  puts "The nullary block returned #{result}, a #{result.class}."
end

def f(&block : Proc(String, T)) forall T # never called
  puts
  puts "Passing 1 argument to a block."
  arg = "Owls!"
  result = yield arg
  puts "The unary block returned #{result}, a #{result.class}."
end

def f(&block : Proc(String, String, T)) forall T # compile error :(
  puts
  puts "Passing 2 arguments to a block."
  arg1 = "Weasels!"
  arg2 = "Ferrets!"
  result = yield arg1, arg2
  puts "The binary block returned #{result}, a #{result.class}."
end

f
f { 42 }
f { |arg| arg.upcase }
f { |arg1, arg2| {arg1, arg2} }
